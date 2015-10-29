#!/usr/bin/env sh

(
  IFS=$'\n'

  CURRENT_DIR="$(pwd)"

  DOTFILES_DIR='dots'

  DOTFILES_PATH="${CURRENT_DIR}/${DOTFILES_DIR}"

  DOTFILES=($( \
    find "${DOTFILES_DIR}" -name '*' -maxdepth 1 | \
    sed -e "s|^${DOTFILES_DIR}/||g"              | \
    grep -v "^${DOTFILES_DIR}$"                  | \
    grep -v '^\.gitignore$'                      | \
    grep -v '^\.gitkeep$'                        | \
    grep -v '.*~$'                               | \
    grep -v '.*\.swp$'                           | \
    grep -v '.*\.bak$'                             \
  ))

  # --------

  force_ln=0
  dest_dir="${HOME}"

  # --------

  show_help_message() {
    echo 'Usage: ./install.sh [arguments] [destination]'
    echo
    echo 'Arguments:'
    echo '    -h  or  --help   Print help message and exit.'
    echo '    -f  or  --force  Force create symlinks of dotfiles.'
  }

  show_unknown_message() {
    echo "Unknown option argument: \"${1}\""
    echo 'More info with: "./install.sh -h"'
  }

  confirm_yes_or_no() {
    while true; do
      echo "${1} [Y/n] >\c"
      read user_input
      case "${user_input}" in
        [Yy][Ee][Ss])
          return 0
          ;;
        [Yy])
          return 0
          ;;
        [Nn][Oo])
          return 1
          ;;
        [Nn])
          return 1
          ;;
      esac
      echo
    done
  }

  get_ignored_dotfiles() {
    GLOBIGNORE=*
    ignores=($( \
      cat '.gitignore' | \
      tr -d '\r' | \
      sed -e '/^[ 	]*$/d' -e '/^#.*$/d'\
    ))
    unset GLOBIGNORE

    result=()
    for ignore in ${ignores[@]}; do
      r=$(ls -a ${ignore} 2>/dev/null)
      if [ ! -z "${r}" ]; then
        result=("${result[*]}" "${r}")
      fi
    done
    echo "${result[*]}"
    return
  }

  is_ignored_dotfile() {
    ignored_dotfiles=$(get_ignored_dotfiles)
    for ignored in ${ignored_dotfiles[@]}; do
      if [ "${1}" = "${ignored}" ]; then
        return 0
      fi
    done

    return 1
  }

  is_dotfile() {
    case "${1}" in
      \.*)
        return 0
        ;;
    esac
    return 1
  }

  # --------

  while (( $# > 0 )); do
    succeeded=0
    case "${1}" in
      --*)
        if [ "${1}" == '--help' ]; then
          succeeded=1
          show_help_message
          exit 0
        elif [ "${1}" == '--force' ]; then
          succeeded=1
          force_ln=1
        fi
        ;;
      -*)
        if [[ "${1}" =~ 'f' ]]; then
          succeeded=$(expr ${succeeded} + 1)
          force_ln=1
        fi
        if [[ "${1}" =~ 'h' ]]; then
          succeeded=$(expr ${succeeded} + 1)
          show_help_message
          exit 0
        fi
        if [ ${succeeded} -ne $(expr ${#1} - 1) ]; then
          show_unknown_message "${1}"
          exit 1
        fi
        ;;
      *)
        succeeded=1
        dest_dir="${1}"
        ;;
    esac

    if [ ${succeeded} -eq 0 ]; then
      show_unknown_message "${1}"
      exit 1
    fi
    shift
  done

  echo '---'
  echo "Current directory: ${CURRENT_DIR}/"
  echo "Dotfiles directory: ${DOTFILES_PATH}"
  echo "Destination: ${dest_dir}/"
  echo '---'

  confirm_yes_or_no 'is it OK?'
  if [ $? -ne 0 ]; then
    echo 'user cancelled.'
    exit 1
  fi

  for dotfile in ${DOTFILES[@]}; do
    is_ignored_dotfile "${dotfile}"
    if [ $? -ne 0 ]; then
      src_dotfile="${DOTFILES_PATH}/${dotfile}"
      dst_dotfile="${dest_dir}/${dotfile}"
      is_dotfile "${dotfile}"
      if [ $? -ne 0 ]; then
        dst_dotfile="${dest_dir}/.${dotfile}";
      fi
      echo "Creating a symbolic link of \"${src_dotfile}\" ..."
      if [ ${force_ln} -eq 1 ]; then
        ln -snf "${src_dotfile}" "${dst_dotfile}"
      else
        ln -sni "${src_dotfile}" "${dst_dotfile}"
      fi
      if [ $? -eq 0 ]; then
        echo "  -> OK! (dst: \"${dst_dotfile}\")"
      else
        echo "  -> Failed... (dst: \"${dst_dotfile}\")"
      fi
    fi
  done
)


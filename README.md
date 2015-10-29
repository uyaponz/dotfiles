# uyaponz/dotfiles

My dotfiles for OS X / GNU/Linux.

## Usage

### Installation

Put your dotfiles or dotdirectories into "dots" directory, and run this command in the terminal:

```
$ ./install.sh
```

Now you can create symbolic links of these dotfiles in "${HOME}" directory.

If you want to change destination of symlinks,
add an option and run like this:

```
$ ./install.sh [destination]
```

### More command options

```
$ ./install.sh -h
Usage: ./install.sh [arguments] [destination]

Arguments:
    -h  or  --help   Print help message and exit.
    -f  or  --force  Force create symlinks of dotfiles.
```

## Copyright and License

ISC License (see [`LICENSE`] file).

[`LICENSE`]: /LICENSE

(defconst buffer-name-distro-info "*BufferDistroInfo*")

;;; フォント設定(新)
(defun set-my-font-frame-alist (deffont mbfont)
  (setq l-deffont
        (concat (car deffont)
                "-"
                (number-to-string (cdr deffont))
                ":weight=normal:slant=normal"))
  (create-fontset-from-ascii-font l-deffont nil "myFontSet")
  (set-fontset-font "fontset-myFontSet"
                    'unicode
                    (font-spec :family (car mbfont) :size (cdr mbfont))
                    nil 'append)
   (add-to-list 'default-frame-alist '(font . "fontset-myFontSet"))
  )

;;; フォント設定(旧)
(defun set-my-font (deffont fsfont)
  (if deffont (set-default-font deffont))
  (if fsfont
      (progn
        (set-fontset-font (frame-parameter nil 'font)
                          'japanese-jisx0208 (cons fsfont "unicode-bmp"))
        (set-fontset-font (frame-parameter nil 'font)
                          'japanese-jisx0212 (cons fsfont "unicode-bmp"))
        ;(set-fontset-font (frame-parameter nil 'font)
        ;                  'japanese-jisx0213 (cons fsfont "unicode-bmp"))
        (set-fontset-font (frame-parameter nil 'font)
                          'katakana-jisx0201 (cons fsfont "unicode-bmp"))
        ))
  ) ;defun

;;; Linuxのディストリ情報を引数 buf(バッファ) に出力する
(defun get-linux-distro-to (buf)
  (set-buffer (get-buffer-create buf))
  (erase-buffer)
  (call-process "cat" nil (list (get-buffer buf) "/dev/null") t "/etc/issue"))

;;; Linuxのディストリ情報に name が含まれているか
(defun is-linux-distro (name)
  (if (not (get-buffer buffer-name-distro-info))
      (get-linux-distro-to buffer-name-distro-info))
  (set-buffer buffer-name-distro-info)
  (goto-char 0)
  (if (search-forward name nil t) t nil))

;;; ディストリ情報を出力したバッファを削除する
(defun kill-buffer-linux-distro ()
  (if (get-buffer  buffer-name-distro-info)
      (kill-buffer buffer-name-distro-info)))

;;; システムが name か
(defun is-system (name)
  (if (string-match name system-configuration) t nil))

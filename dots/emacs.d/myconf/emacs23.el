;;;
;;; emacs23.el - Emacs23用の設定
;;;

;;; ###### 共通設定 ######

;;; 行番号の表示 (linum.el)
(if show-line-number
    (if (not (is-system "apple-darwin"))
        (load "~/.emacs.d/util/linum/linum.el")
      (global-linum-mode t)
      (setq linum-format "%5d")))

;;; (for ubuntu) メニューバー右端のバグ回避
(if (is-linux-distro "Ubuntu")
    (progn
      (global-set-key [menu-bar dummy]
                      (cons (make-string 100 ?_) (make-sparse-keymap)))
      (nconc menu-bar-final-items '(dummy))))

;;;====================================
;;; フォント(等幅)設定など
;;;全角スペースとかに色を付ける
;;;====================================
(defface my-face-b-1 '((t (:background "medium aquamarine"))) nil)
(defface my-face-b-1 '((t (:background "dark turquoise"))) nil)
(defface my-face-b-2 '((t (:background "cyan"))) nil)
(defface my-face-b-2 '((t (:background "SeaGreen"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
            (font-lock-add-keywords
                 major-mode
                    '(
                           ("　" 0 my-face-b-1 append)
                           ("\t" 0 my-face-b-2 append)
                           ("[ ]+$" 0 my-face-u-1 append)
          )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
(add-hook 'find-file-hooks '(lambda ()
                             (if font-lock-mode
                               nil
                               (font-lock-mode t))))

;;; ###### OS毎の見栄え設定 ######
(cond ((is-system "apple-darwin") (load "~/.emacs.d/myconf/disp23/OSX.el"))
      ((is-system "linux")        (load "~/.emacs.d/myconf/disp23/Linux.el")))

;;;
;;; disp23/Linux.el - Emacs23 for Linux用の画面設定
;;;

;;; X固有の設定
(if (eq window-system 'x)
    (progn

      ;; 個別設定
      (cond ((is-linux-distro "Ubuntu 12.04")
             (setq deffont '("Takaoゴシック" . 10))
             (setq mbfont  '("Takaoゴシック" . 14))
;             (setq deffont '("Takaoゴシック" . 9))
;             (setq mbfont  '("Takaoゴシック" . 12))
             (set-my-font-frame-alist deffont mbfont))

            ((is-linux-distro "Ubuntu 10.04")
             (setq deffont '("TakaoGothic" . 10))
             (setq mbfont  '("TakaoGothic" . 14))
             (set-my-font-frame-alist deffont mbfont))

            ((is-linux-distro "Debian")
             (add-to-list 'default-frame-alist '(font . "RictyDiscord-9"))
             (set-default-font "RictyDiscord-9")
             (set-fontset-font (frame-parameter nil 'font)
                               'japanese-jisx0208
                               '("RictyDiscord-9" . "unicode-bmp"))
            )
;             (add-to-list 'default-frame-alist '(font . "VL Gothic-9"))
;             (set-default-font "VL Gothic-9")
;             (set-fontset-font (frame-parameter nil 'font)
;                               'japanese-jisx0208
;                               '("VL Gothic-9" . "unicode-bmp"))
;            )

            ((is-linux-distro "Vine")
             (setq vine-default-faces nil)
             (setq deffont "VL Gothic-9") (setq fsfont "VL Gothic")
             (set-my-font deffont fsfont))
            )

      ) ;progn
)


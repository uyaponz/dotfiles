;;;
;;; emacs22.el - Emacs22の設定(ほとんどCarbon Emacs用)
;;;

;;; OS毎の設定を読み込む
(cond ((is-system "apple-darwin")
       ;;; ウィンドウシステム固有の設定
       (if (eq window-system 'mac)
           (progn

             ;; フォント設定
             (set-face-attribute 'default nil :family "Ricty" :height 120)
             (set-fontset-font "fontset-default" 'japanese-jisx0208 '("Ricty" . "iso10646-*"))
;             (setq fixed-width-use-QuickDraw-for-ascii t)
;             (setq mac-allow-anti-aliasing nil)
;             (setq my-font  "-*-*-medium-r-normal--10-*-*-*-*-*-fontset-hirakaku_w3")
;             (require 'carbon-font)
;             (set-default-font my-font)
;             (add-to-list 'default-frame-alist (cons 'font my-font))

             ) ;progn
         ) ;if
       )
      ) ;cond
;(cond ((is-system "apple-darwin")
;       ;;; ウィンドウシステム固有の設定
;       (if (eq window-system 'mac)
;           (progn
;
;             ;; フォント設定
;             (setq fixed-width-use-QuickDraw-for-ascii t)
;             (setq mac-allow-anti-aliasing nil)
;             (setq my-font  "-*-*-medium-r-normal--10-*-*-*-*-*-fontset-hirakaku_w3")
;             (require 'carbon-font)
;             (set-default-font my-font)
;             (add-to-list 'default-frame-alist (cons 'font my-font))
;
;             ) ;progn
;         ) ;if
;       )
;      ) ;cond

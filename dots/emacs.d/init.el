;;; ###### 定数 ######
;; 表示設定
(defvar my-window-width  100) ; ウィンドウ横サイズ
(defvar my-window-height  40) ; ウィンドウ縦サイズ
(defvar show-line-number t) ; 行番号を表示するか(t:表示, nil:非表示)

;; 配色1 - 通常の配色
(defvar my-background-color "white") ; 背景色
(defvar my-foreground-color "black") ; 文字色
(defvar my-cursor-color     "black") ; カーソル色

;; 配色2 - 背景が紺
;(defvar my-background-color "#000066")
;(defvar my-foreground-color "white")
;(defvar my-cursor-color     "white")

;; Ignore 'Ctrl+Z'
;(setq ignore-ctrl-z t)


(load "~/.emacs.d/myfunc.el")

;;; 共通設定
(load "~/.emacs.d/myconf/common.el")

;;; Emacsのバージョン毎の設定
(cond ((= emacs-major-version 24)
       (load "~/.emacs.d/myconf/emacs23.el"))
      ((= emacs-major-version 23)
       (load "~/.emacs.d/myconf/emacs23.el"))
      ((= emacs-major-version 22)
       (load "~/.emacs.d/myconf/emacs22.el"))
      )

;;; frame-alist関連
(setq-default initial-frame-alist default-frame-alist)


;;; ###### ユーザー定義設定ここから ######

;;; TeX用
;(set-language-environment "Japanese")
;(set-default-coding-systems 'euc-jp-unix)
;(set-terminal-coding-system 'euc-jp-unix)
;(set-keyboard-coding-system 'euc-jp-unix)
;(set-buffer-file-coding-system 'euc-jp-unix)


;;; メール(Wanderlust)設定
;(autoload 'wl "wl" "Wanderlust" t)


;;; navi2ch
;(autoload 'navi2ch "navi2ch" nil t)

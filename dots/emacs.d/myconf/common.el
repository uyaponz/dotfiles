;;;
;;; common.el - 異なるバージョン間のEmacsで共通の設定
;;;

;;; ###### 適当な設定 ######
;; キーバインドの変更
(global-set-key [?\C-2] 'set-mark-command)
(global-set-key [?\C-h] 'backward-delete-char)
(global-set-key [?\M-n] 'linum-mode) ; 行番号の表示切り替え
(if (boundp 'ignore-ctrl-z) (progn
  (if ignore-ctrl-z
    (global-set-key [?\C-z] nil)))) ; 間違ってCtrl+zでアンドゥしようとしても大丈夫なように。
;; 行・列番号の表示
(column-number-mode t)
(line-number-mode t)
;; 起動時の変なメッセージを消す
(setq-default inhibit-startup-screen t)
;; ツールバーを非表示にする
(setq-default tool-bar-mode 0)
;; 文字コード表示
(setq-default eol-mnemonic-dos  "(CRLF)")
(setq-default eol-mnemonic-mac  "(CR)")
(setq-default eol-mnemonic-unix "(LF)")
;; ファイル関連
(setq-default use-file-dialog   nil)
(setq-default auto-save-default nil)
(setq-default make-backup-files nil)
;; スクロール速度
(setq-default scroll-step 1)
;; リージョン表示
(setq-default transient-mark-mode nil)
;; emmet-mode
;(load "~/.emacs.d/util/emmet-mode/emmet-mode.el")
;(add-hook 'sgml-mode-hook 'emmet-mode)  ; マークアップ言語全部で使う
;(add-hook 'css-mode-hook  'emmet-mode)  ; CSSに使う
;(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 4)))  ; インデントの数
;(eval-after-load "emmet-mode" '(define-key emmet-mode-keymap (kbd "C-j") nil))  ; C-jのemmetキーマップを戻す
;(define-key emmet-mode-keymap (kbd "C-x e") 'emmet-expand-line)  ; C-x eで展開
;(define-key emmet-mode-keymap (kbd "C-3")   'emmet-expand-line)  ; C-3で展開
;; 行番号を左側に表示する
;(if (not (and (is-system "apple-darwin")
;              (>= emacs-major-version 23)))
;    (load "~/.emacs.d/util/linum/linum.el"))
;(setq-default linum-format "%5d")
;(if show-line-number (global-linum-mode t))
;; 言語設定
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
;; Shift+Arrow-Key で範囲選択
(setq pc-select-selection-keys-only t)
(if (not (>= emacs-major-version 24)) (pc-selection-mode 1))


;;; ###### 表示設定 ######
;; スクロールバーの位置
(setq-default set-scroll-bar-mode 'right)
;; 同一ファイル名のとき、ディレクトリも同時に表示
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")
;; ウィンドウタイトル
(setq frame-title-format (format "%%b - %s@%s" (invocation-name) (system-name)))
;; タブやスペースなどに色をつける
;(load "~/.emacs.d/util/jaspace/emacs_jaspace.el")
;; js2-modeを使用する
;(load "~/.emacs.d/util/js2_espresso/emacs_js2.el")
;; go-modeを使用する
;(add-to-list 'load-path "~/.emacs.d/util/go-mode" t)
;(require 'go-mode-load)
;; perlのとき、機能の高いcperlモードを使う
(setq perl-mode-hook '(lambda ()(cperl-mode) ))
;; 文字コードの設定
(set-default-coding-systems 'utf-8-unix)
;; カラー強調
(global-font-lock-mode t)
;; 対応するカッコを強調
(show-paren-mode t)
;; インデントにタブを使わない
(setq-default indent-tabs-mode nil)
;; タブ幅変更用関数 (http://masutaka.net/chalow/2009-07-10-4.html)
(defun set-aurora-tab-width (num &optional local redraw)
  (interactive "nTab Width: ")
  (when local
    (make-local-variable 'tab-width)
    (make-local-variable 'tab-stop-list)
    )
  (setq tab-width num)
  (setq tab-stop-list ())
  (while (<= num 256)
    (setq tab-stop-list `(,@tab-stop-list ,num))
    (setq num (+ num tab-width))
    )
  (when redraw (redraw-display)) tab-width)
;; タブ幅の変更
(setq-default tab-width 4)
(setq tab-width 4)
;; インデントの設定
(setq c-basic-offset 4)
(set-aurora-tab-width 4)
;; 個別設定
(setq sgml-basic-offset 4)
(setq cperl-indent-level 4)
(setq lisp-basic-offset 4)
;; jaspace有効化 + インデントにタブを使わない
(setq modelist '(lisp-mode-hook
                 yaml-mode-hook
                 perl-mode-hook
                 js-mode-hook
                 js2-mode-hook
                 javascript-mode-hook
                 python-mode-hook
                 ruby-mode-hook
                 php-mode-hook
                 xml-mode-hook
                 html-mode
                 css-mode-hook
                 text-mode-hook
                 tt-mode-hook
                 fundamental-mode-hook
                 go-mode-hook
                 scala-mode-hook
                 cperl-mode-hook
                 ))
(while (not(equal modelist nil))
  (add-hook (car modelist) 'jaspace-mode)
  (add-hook (car modelist) '(lambda () (setq-default tab-width 4)))
  (add-hook (car modelist) '(lambda () (setq tab-width 4)))
  (add-hook (car modelist) '(lambda () (setq indent-tabs-mode nil)))
  (setq modelist (cdr modelist)))
;; 言語別個別設定
; Rubyのインデントスタイル
(setq ruby-indent-level tab-width)
(defconst modified-stroustrup-style
  '(
    (c-basic-offset . 4)
    (c-comment-only-line-offset . 0)
    (c-offsets-alist
     (statement-block-intro . +)
     (substatement-open . 0)
     (label . 0)
     (statement-cont . +)
     (inline-open . nil))))
; Cのインデントスタイル
(add-hook 'c-mode-common-hook
          '(lambda ()
             (c-add-style "modified-stroustrup-style" modified-stroustrup-style t)
             (c-set-style "modified-stroustrup-style")
             ))
;; マウススクロールのスピードを調節する
(global-set-key [wheel-up]          '(lambda () "" (interactive) (scroll-down 1)))
(global-set-key [wheel-down]        '(lambda () "" (interactive) (scroll-up   1)))
(global-set-key [double-wheel-up]   '(lambda () "" (interactive) (scroll-down 1)))
(global-set-key [double-wheel-down] '(lambda () "" (interactive) (scroll-up   1)))
(global-set-key [triple-wheel-up]   '(lambda () "" (interactive) (scroll-down 2)))
(global-set-key [triple-wheel-down] '(lambda () "" (interactive) (scroll-up   2)))


;;; ###### 表示設定 ######
(if (or (eq window-system 'mac)
        (eq window-system 'ns)
        (eq window-system 'x))
    (progn
      ;; 配色の変更
      (add-to-list 'default-frame-alist (cons 'background-color my-background-color))
      (add-to-list 'default-frame-alist (cons 'foreground-color my-foreground-color))
      (add-to-list 'default-frame-alist (cons 'cursor-color my-cursor-color))
      ;; カーソル行を目立たせる
      (defface hlline-face
        '((((class color)
            (background dark))
           (:background "dark slate gray"))
          (((class color)
            (background light))
           (:background "LightCyan"))
          (t ()))
        "*Face used by hl-line.")
      (setq hl-line-face 'hlline-face)
      (global-hl-line-mode)
      ;; ウィンドウサイズ
      (add-to-list 'default-frame-alist (cons 'width  my-window-width))
      (add-to-list 'default-frame-alist (cons 'height my-window-height))
      ))

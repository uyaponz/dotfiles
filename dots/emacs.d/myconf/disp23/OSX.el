;;;
;;; disp23/OSX.el - Cocoa Emacs用の画面設定
;;;

;;; ウィンドウシステム固有の設定
(if (eq window-system 'ns)
    (progn

      ;; ¥の代わりにバックスラッシュを入力する
      (define-key global-map [?¥] [?\\])

      ;; フォント設定
      (create-fontset-from-ascii-font "Ricty-12:weight=normal:slant=normal"
                                      nil
                                      "myFontSet")
      (set-fontset-font "fontset-myFontSet"
                        'unicode
                        (font-spec :family "Ricty" :size 12)
                        nil
                        'append)
      (add-to-list 'default-frame-alist  '(font . "fontset-myFontSet"))

      ;; フォントのスケール変更
      ;(setq face-font-rescale-alist '((".*Hiragino.*" . 0.8) (".*Menlo.*" . 0.8)))

      ;; Command-Key and Option-Key
      (setq ns-command-modifier (quote meta))
      (setq ns-alternate-modifier (quote super))

      ;; D&Dしたときに、そのファイルを開く
      (define-key global-map [ns-drag-file] 'ns-find-file)

      ;; ウィンドウサイズの再調整
;      (add-to-list 'default-frame-alist (cons 'width  (/ my-window-width 2)))
      (add-to-list 'default-frame-alist (cons 'width     my-window-width))
      (add-to-list 'default-frame-alist (cons 'height    my-window-height))

      ) ;progn
  ) ;if

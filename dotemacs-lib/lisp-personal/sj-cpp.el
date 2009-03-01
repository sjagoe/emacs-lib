(setq-default c-basic-offset 4)

(defun my-c-mode-common-hook ()
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'arglist-intro 4)
  (c-set-offset 'topmost-intro-cont 4)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(require 'qt-pro)
(add-to-list 'auto-mode-alist '("\\.pr[io]$" . qt-pro-mode))

;; ============================ Programming ============================
;; =====================================================================
;; Qt Mode
;(load "~/.emacs-lib/qt-mode.el")
;; Highlight tab characters
;(require 'show-wspace)
;(add-hook 'python-mode-hook 'highlight-tabs)
;(add-hook 'font-lock-mode-hook 'highlight-trailing-whitespace)
;; Mark the 79th column
;(require 'column-marker)
;; (add-hook 'python-mode-hook
;;           (lambda () (interactive) (column-marker-2 79)))


;; switch between source and headers
(load-file "~/.emacs-lib/lisp/sourcepair.el")
(setq sourcepair-source-path '( "." "../src" ))
(setq sourcepair-header-path '( "." "../include" ))
(setq sourcepair-recurse-ignore '( ".bzr" "debug" "release" ))
(global-set-key (kbd "\C-x z") 'sourcepair-load)

(provide 'sj-cpp)
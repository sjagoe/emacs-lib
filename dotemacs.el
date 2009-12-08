;; Custom
(setq custom-file "~/.emacs-lib/dotemacs-custom.el")
(load custom-file)

;; Include paths
(add-to-list 'load-path (expand-file-name "~/.emacs-lib"))
(add-to-list 'load-path (expand-file-name "~/.emacs-lib/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs-lib/lisp/ecb-2.32"))
(add-to-list 'load-path (expand-file-name "~/.emacs-lib/lisp/yasnippet"))
(add-to-list 'load-path (expand-file-name "~/.emacs-lib/lisp-personal"))

;; Other's modules
(require 'intelligent-close)
;; (require 'yasnippet)
;; (yas/initialize)
;; (yas/load-directory "~/.emacs-lib/lisp/yasnippet/snippets")

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.pt$" . html-mode))

;; My modules
(require 'sj-misc-custom)
(require 'sj-paren)
(require 'sj-cpp)
(require 'sj-keys)
(require 'sj-org)
;;(require 'sj-ecb)

(setq line-move-visual nil)
(setq truncate-partial-width-windows t)
(setq indent-tabs-mode nil)

(desktop-save-mode t)

(menu-bar-mode nil)

;;(require 'sj-windows)

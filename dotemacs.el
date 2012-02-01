;; Custom
(setq custom-file "~/.emacs-lib/dotemacs-custom.el")
(load custom-file)

;; Include paths
(add-to-list 'load-path (expand-file-name "~/.emacs-lib"))
(add-to-list 'load-path (expand-file-name "~/.emacs-lib/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs-lib/lisp/ecb-snap"))
(add-to-list 'load-path (expand-file-name "~/.emacs-lib/lisp-personal"))

;; Other's modules
(require 'intelligent-close)
;; (require 'yasnippet)
;; (yas/initialize)
;; (yas/load-directory "~/.emacs-lib/lisp/yasnippet/snippets")

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.pt$" . html-mode))

;; My modules
(require 'sj-ediff)
(require 'sj-misc-custom)
(require 'sj-paren)
(require 'sj-cpp)
(require 'sj-keys)
(require 'sj-org)
(require 'sj-python)
(require 'sj-cython)
;;(require 'sj-ecb)

(setq line-move-visual nil)
(setq truncate-partial-width-windows t)
(setq indent-tabs-mode nil)

;; (desktop-save-mode t)

(menu-bar-mode nil)

(require 'sj-windows)

(require 'markdown-mode)
(require 'sj-markdown)

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; ;; CEDET
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (semantic-mode t)
;; (global-ede-mode t)

;; (setq semantic-default-submodes
;;       '(global-semanticdb-minor-mode
;;         global-semantic-idle-scheduler-mode
;;         global-semantic-idle-summary-mode
;;         global-semantic-idle-completions-mode
;;         global-semantic-decoration-mode
;;         global-semantic-highlight-func-mode
;;         global-semantic-stickyfunc-mode))

;; (if (boundp 'semantic-ia) (require 'semantic-ia))
;; (if (boundp 'semantic-gcc) (require 'semantic-gcc))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'ecb)

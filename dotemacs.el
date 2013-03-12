;; to work around an error causing ecb to not byte-compile
(setq filename nil)

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
;;(require 'sj-ecb)

(setq line-move-visual nil)
(setq truncate-partial-width-windows t)
(setq indent-tabs-mode nil)

(desktop-save-mode t)


;; (require 'sj-windows)

(require 'markdown-mode)
(require 'sj-markdown)

(require 'package)

;; require or autoload paredit-mode
(defun turn-on-paredit () (paredit-mode 1))
(add-hook 'clojure-mode-hook 'turn-on-paredit)


(defun count-words (start end)
  "Print number of words in the region."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region start end)
      (goto-char (point-min))
      (count-matches "\\sw+"))))

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
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


(defun increment-number-at-point ()
  (interactive)
  (skip-chars-backward "0123456789")
  (or (looking-at "[0123456789]+")
      (error "No number at point"))
  (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

(global-set-key (kbd "C-c +") 'increment-number-at-point)

(require 'sj-jabber)
(require 'sj-python)
(require 'sj-cython)

(setq-default display-buffer-reuse-frames t)

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

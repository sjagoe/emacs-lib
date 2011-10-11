
;; Colour Theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-deep-blue)

;; (add-to-list 'default-frame-alist '(font . "-outline-Courier New-normal-r-normal-normal-11-82-96-96-c-*-iso8859-1"))
;; (add-to-list 'default-frame-alist '(font . "-*-Monaco-normal-r-*-*-17-102-120-120-c-*-iso8859-1"))

;; ;; Add GnuWin32 to the PATH
;; (setq -gnu-bin "C:\\Documents and Settings\\I491294\\Applications\\gnuwin32\\bin")

;; (setenv
;;  "PATH"
;;  (concat
;;   -gnu-bin
;;   ";"
;;   (getenv "PATH")
;;   ))

;; (setq exec-path (cons -gnu-bin exec-path))

(setq this-is-w32
      (or (eq window-system 'w32)
	  (equal (string-match "^[A-Za-z]:[/\\]" default-directory) 0)))

(require 'powershell-mode)

(require 'tramp)
(setq tramp-auto-save-directory "c:\\dev\\tmp")
(setq tramp-default-method "plink")

(setq ediff-split-window-function 'split-window-horizontally)

(provide 'sj-windows)

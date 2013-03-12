
;; ;; Colour Theme
;; (require 'color-theme)
;; (color-theme-initialize)
;; (color-theme-deep-blue)

;; (add-to-list 'default-frame-alist '(font . "-outline-Courier New-normal-r-normal-normal-11-82-96-96-c-*-iso8859-1"))
;; (add-to-list 'default-frame-alist '(font . "-*-Monaco-normal-r-*-*-17-102-120-120-c-*-iso8859-1"))

(setq -software-prefix "C:\\Software")

;; Add GnuWin32 to the PATH
(setq -gnu-bin (concat -software-prefix "\\gnuwin32\\bin"))
(setq -git-bin (concat -software-prefix "\\Git\\bin"))
(setq -home-bin "C:\\Documents and Settings\\enthought-admin\\bin")
(setq -gnutls-bin "C:\\cygwin\\bin")
(setq -console-bin (concat -software-prefix "\\Console2"))


(setenv
 "PATH"
 (concat
  -gnu-bin ";"
  -git-bin ";"
  (getenv "PATH") ";"
  -gnutls-bin ";"
  -home-bin ";"
  -console-bin
  ))


(setq
 exec-path
 (cons
  -gnu-bin
  (cons
   -git-bin
   (append
    exec-path
    (cons
     -gnutls-bin
     (cons
      -home-bin
      (cons
       -console-bin
       nil)))))))


(setq this-is-w32
      (or (eq window-system 'w32)
	  (equal (string-match "^[A-Za-z]:[/\\]" default-directory) 0)))

(require 'powershell-mode)
(setq auto-mode-alist
      (append '(("\\.ps1$" . powershell-mode)) auto-mode-alist))


(require 'tramp)
(setq tramp-auto-save-directory "c:\\dev\\tmp")
(setq tramp-default-method "plink")

(setq ediff-split-window-function 'split-window-horizontally)

(set-default buffer-file-coding-system 'iso-latin-1-unix)
(set-default-coding-systems 'iso-latin-1-unix)
(prefer-coding-system 'iso-latin-1-unix)
(set-default default-buffer-file-coding-system 'iso-latin-1-unix)

;; vc-git is really slow in windows ...
;; (setq vc-handled-backends nil)

(provide 'sj-windows)

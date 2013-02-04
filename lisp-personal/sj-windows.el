
;; ;; Colour Theme
;; (require 'color-theme)
;; (color-theme-initialize)
;; (color-theme-deep-blue)

;; (add-to-list 'default-frame-alist '(font . "-outline-Courier New-normal-r-normal-normal-11-82-96-96-c-*-iso8859-1"))
;; (add-to-list 'default-frame-alist '(font . "-*-Monaco-normal-r-*-*-17-102-120-120-c-*-iso8859-1"))

;; Add GnuWin32 to the PATH
(setq -gnu-bin "C:\\Software\\gnuwin32\\bin")
(setq -git-bin "C:\\Software\\Git\\bin")
(setq -home-bin "C:\\Documents and Settings\\enthought-admin\\bin")
(setq -gnutls-bin "C:\\Software\\gnutls-3.0.9\\bin")

(setenv
 "PATH"
 (concat
  -gnu-bin ";"
  -git-bin ";"
  -gnutls-bin ";"
  -home-bin ";"
  (getenv "PATH")
  ))

(setq exec-path (cons -gnu-bin (cons -git-bin (cons -gnutls-bin (cons -home-bin exec-path)))))

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

;; vc-git is really slow in windows ...
;; (setq vc-handled-backends nil)

(provide 'sj-windows)

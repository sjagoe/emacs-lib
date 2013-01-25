;; Load ido-mode
(ido-mode)

;; visible bell
(setq visible-bell t)

;; line and column numbers 
(setq line-number-mode t)
(setq column-number-mode t)

(setq indent-tabs-mode nil)

(setq inhibit-splash-screen t)

;; (setq default-frame-alist
;;       '((width . 80) (height . 66)))

(add-to-list 'default-frame-alist '(width . 80))
(add-to-list 'default-frame-alist '(height . 66))

(setenv "PATH" (concat (getenv "PATH") ":/home/simon/bin"))
(setq exec-path (append exec-path '("/home/simon/bin")))

;; start the emacs server
(server-start)

(require 'etags-select)

(provide 'sj-misc-custom)

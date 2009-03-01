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
(add-to-list 'default-frame-alist '(font . "-outline-Courier New-normal-r-normal-normal-11-82-96-96-c-*-iso8859-1"))

;; start the emacs server
;(start-server)

(provide 'sj-misc-custom)
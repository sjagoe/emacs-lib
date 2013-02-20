;; Load ido-mode
(ido-mode t)

;; visible bell
(setq visible-bell t)

;; line and column numbers 
(setq line-number-mode t)
(setq column-number-mode t)

(setq indent-tabs-mode nil)

(setq inhibit-splash-screen t)

;; (setq default-frame-alist
;;       '((width . 80) (height . 66)))

;; (add-to-list 'default-frame-alist '(width . 80))
;; (add-to-list 'default-frame-alist '(height . 66))

;; start the emacs server
(server-start)

(require 'etags-select)


(require 'desktop)
(desktop-save-mode 1)
(defun my-desktop-save ()
  (interactive)
  ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
  (if (eq (desktop-owner) (emacs-pid))
      (desktop-save desktop-dirname)))
(add-hook 'auto-save-hook 'my-desktop-save)


(provide 'sj-misc-custom)

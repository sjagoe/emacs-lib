;; ========================== key bindings =============================
;; =====================================================================
(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "<f6>") 'new-frame)
(global-set-key (kbd "<f7>") 'intelligent-close)
(global-set-key (kbd "<f8>") 'previous-error)
(global-set-key (kbd "<f9>") 'next-error)
(global-set-key (kbd "<C-next>") 'next-buffer)
(global-set-key (kbd "<C-prior>") 'previous-buffer)
(global-set-key "\C-x\C-n" 'find-file-other-frame)
(global-set-key (kbd "<f11>") 'other-frame)
(global-set-key (kbd "C-x <f8>") 'ispell-buffer)
(global-set-key (kbd "C-c a") 'org-agenda)

(global-set-key (kbd "C-;") 'timeclock-change)
(global-set-key (kbd "C-'") 'timeclock-in)
(global-set-key (kbd "C-#") 'timeclock-out)

(global-set-key "\M-?" 'etags-select-find-tag)
(global-set-key "\M-." 'etags-select-find-tag-at-point)

(global-set-key "\C-xv\-" 'magit-status)

(provide 'sj-keys)

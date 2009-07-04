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

(global-set-key (kbd "C-;") 'timeclock-change)
(global-set-key (kbd "C-'") 'timeclock-in)
(global-set-key (kbd "C-#") 'timeclock-out)

(provide 'sj-keys)
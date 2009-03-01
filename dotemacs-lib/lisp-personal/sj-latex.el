;; =========================== LaTeX stuff =============================
;; =====================================================================
; View DVI with evince
;(setq tex-dvi-view-command "evince")
(setq auto-mode-alist (cons '("\\.tex$" . LaTeX-mode) auto-mode-alist))
(setq tex-mode-hook
   '(lambda ()
      (auto-fill-mode 1)
      ))

(setq latex-mode-hook
   '(lambda ()
      (auto-fill-mode 1)
      ))

(autoload 'reftex-mode    "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" t)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex) ; with AUCTeX LaTeX mode
;  (add-hook 'latex-mode-hook 'turn-on-reftex)) ; with Emacs latex mode

(setq reftex-enable-partial-scans t)
(setq reftex-save-parse-info t)
(setq reftex-use-multiple-selection-buffers t)

;; To integrate with AUCTeX, use 
(setq reftex-plug-into-AUCTeX t)

;; auctex
(setq TeX-auto-save t)
(setq TeX-parse-self t)

(provide 'sj-latex)
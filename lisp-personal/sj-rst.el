'(rst-mode-lazy nil)
(require 'rst)
(setq auto-mode-alist
      (append '(("\\.txt$" . rst-mode)
                ("\\.rst$" . rst-mode)
                ("\\.rest$" . rst-mode)) auto-mode-alist))

(add-hook 'rst-mode-hook 'whitespace-mode)
(add-hook 'rst-mode-hook 'flyspell-mode)

(provide 'sj-rst)
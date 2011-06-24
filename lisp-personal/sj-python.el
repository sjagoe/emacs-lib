; https://bitbucket.org/birkenfeld/cython/src/66700d1d92e2/Tools/cython-mode.el
;(require 'cython-mode)

(setq auto-mode-alist
      (append '(("\\.pyx$" . python-mode)
                ("\\.pxd$" . python-mode)
                ("\\.pxi$" . python-mode)) auto-mode-alist))

(add-hook 'python-mode-hook 'whitespace-mode)


;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)
;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))

(provide 'sj-python)

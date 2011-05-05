; https://bitbucket.org/birkenfeld/cython/src/66700d1d92e2/Tools/cython-mode.el
;(require 'cython-mode)

(setq auto-mode-alist
      (append '(("\\.pyx$" . python-mode)
                ("\\.pxd$" . python-mode)) auto-mode-alist))

(add-hook 'python-mode-hook 'whitespace-mode)

(provide 'sj-python)

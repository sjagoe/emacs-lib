; https://bitbucket.org/birkenfeld/cython/src/66700d1d92e2/Tools/cython-mode.el
;(require 'cython-mode)

(setq auto-mode-alist
      (append '(("\\.pyx$" . python-mode)
                ("\\.pxd$" . python-mode)
                ("\\.pxi$" . python-mode)) auto-mode-alist))

(add-hook 'python-mode-hook 'whitespace-mode)
(add-hook 'python-mode-hook 'flycheck-mode)

(require 'pyflakes)

(require 'gud)
(gud-def gud-break
         "break %d%f:%l"
         "\C-b" "Set breakpoint at current line.")
(gud-def gud-remove
         "clear %d%f:%l"
         "\C-d" "Remove breakpoint at current line")
(defun better-pdb (&optional command-line)
  (interactive)
  (let ((result (if command-line
		   (pdb command-line)
		 (call-interactively 'pdb command-line))))
    (gud-def gud-break  "break %d%f:%l"     "\C-b" "Set breakpoint at current line.")
    (gud-def gud-remove "clear %d%f:%l"     "\C-d" "Remove breakpoint at current line")
    result))

;; (condition-case err
;;     (require 'enaml))

;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)
;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))


(require 'sj-unittest-mode)


(require 'flycheck)


(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key
             (kbd "C-x t g")
             'flycheck-compile)))

(provide 'sj-python)

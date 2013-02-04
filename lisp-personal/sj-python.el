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


;; (add-hook 'python-mode-hook 'flymake-python-pyflakes-load)


(defun py-run-test ()
  (interactive)
  (if (string-match
       (rx bos "test_")
       (file-name-nondirectory (buffer-file-name)))
      (compile (concat "python " (concat "\"" (buffer-file-name) "\"")))
    (py-execute-buffer)))


;; (defun python-show-function-name ()
;;   "Message the name of the function the point is in"
;;   (interactive)
;;   (save-excursion
;;     (beginning-of-defun)
;;     (message (format "%s" (thing-at-point 'line)))))


(require 'magit)


(defun py-git-dir ()
  "Returns the top-level directory of a git repository"
  (file-name-directory (directory-file-name (magit-git-dir))))


(defun py-run-tests-in-directory (tests-dir)
  "Executes \"python -m unittest discover\" in the selected
  directory"
  (interactive (list (read-directory-name "Directory: " (py-git-dir))))
  (let ((default-directory tests-dir))
    (compile (concat "python -m unittest discover"))))


(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key
             (kbd "C-x t f")
             'py-run-test)))

(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key
             (kbd "C-x t d")
             'py-run-tests-in-directory)))


(provide 'sj-python)

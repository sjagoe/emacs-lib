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



;; (defun python-match-defun-name ()
;;   (save-excursion
;;     (beginning-of-defun)
;;     (let ((def-line (thing-at-point 'line)))
;;       (if (string-match
;;            (rx (and (submatch (0+ "    ")) (submatch (or "def" "class")) " "
;;                     (submatch (in "a-zA-Z_") (0+ (in "a-zA-Z_0-9"))) "("))
;;            def-line)
;;           def-line))))


;; (defun python-get-defun-name (def-line)
;;   (match-string-no-properties 3 def-line))


;; (defun python-defun-is-class (def-line)
;;   (string= (match-string-no-properties 2 def-line) "class"))


;; (defun python-defun-is-function (def-line)
;;   (string= (match-string-no-properties 2 def-line) "def"))


;; (defun python-get-class-function-name ()
;;   (let ((def-line (python-match-defun-name)))
;;     (if def-line
;;         (let ((function-name (python-get-defun-name def-line)))
;;           (let ((foo (message (format "fn-name: %s" function-name))))
;;             (if (python-defun-is-function def-line)
;;                 (save-excursion
;;                   (beginning-of-defun)
;;                   (beginning-of-line)
;;                   (let ((class-line (python-match-defun-name)))
;;                     (if class-line
;;                         (let ((class-name (python-get-defun-name class-line)))
;;                           (if class-name
;;                               (concat class-name "." function-name)
;;                             function-name))
;;                       function-name)))
;;               function-name))))))


;; (defun python-print-defun-name ()
;;   (interactive)
;;   (message (format "%s" (python-get-class-function-name))))
;;   ;; "Message the name of the function/class the point is in"
;;   ;; (interactive)
;;   ;; (let ((def-line (python-match-defun-name)))
;;   ;;   (if def-line
;;   ;;       (message (format "%s" (python-get-defun-name def-line))))))




(define-compilation-mode unittest-mode "unittest"
  "A compilation buffer for Python unittest")


(defun verbose-cmd (cmd verbose)
  "Returns the command used to execute unit tests"
  (let ((verbose-flag
         (if verbose
             " -v"
           "")))
    (concat cmd verbose-flag)))


(defun run-unittests-in-cmd-exe (command)
  (compilation-start
   (concat "cmd.exe /c \"" command "\"")
   'unittest-mode))


(defun py-get-test-file-name ()
  (let ((dirname (file-name-directory (buffer-file-name))))
    (let ((filename (file-name-nondirectory (buffer-file-name))))
      (let ((python-arg
             (if (string-match (rx bos "test_") filename)
                 (buffer-file-name)
               (concat dirname "tests/test_" filename))))
        python-arg))))


(defun py-run-test-case (verbose)
  (interactive "P")
  (let ((python-arg (py-get-test-file-name)))
    (run-unittests-in-cmd-exe
     (verbose-cmd (concat "python " (concat "\"" python-arg "\"")) verbose))))


;; (defun py-run-single-test (verbose)
;;   (interactive "P")
;;   (let ((python-arg (py-get-test-file-name)))
;;     (let ((test-cmd (verbose-cmd (concat "python " (concat "\"" python-arg "\"")) verbose)))
;;     (run-unittests-in-cmd-exe
;;      (concat test-cmd " " (python-get-class-function-name))))))


(require 'magit)


(defun py-git-dir ()
  "Returns the top-level directory of a git repository"
  (file-name-directory (directory-file-name (magit-git-dir))))


(defun py-unittest-discover-cmd (verbose)
  "Returns the command used to execute unit tests"
    (verbose-cmd "python -m unittest discover" verbose))


(defun py-run-tests-in-directory (tests-dir)
  "Executes \"python -m unittest discover\" in the selected
  directory"
  (interactive (list (read-directory-name "Run tests in: " (py-git-dir))))
  (let ((verbose current-prefix-arg)
        (default-directory tests-dir))
    (run-unittests-in-cmd-exe (py-unittest-discover-cmd verbose))))


(defun py-run-tests-in-current-directory (verbose)
  "Executes \"python -m unittest discover\" in the selected
  directory"
  (interactive "P")
  (let ((default-directory (file-name-directory (directory-file-name (buffer-file-name)))))
    (run-unittests-in-cmd-exe (py-unittest-discover-cmd verbose))))


(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key
             (kbd "C-x t f")
             'py-run-test-case)))


(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key
             (kbd "C-x t t")
             'py-run-tests-in-directory)))


(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key
             (kbd "C-x t d")
             'py-run-tests-in-current-directory)))


(require 'flycheck)


(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key
             (kbd "C-x t g")
             'flycheck-compile)))


(provide 'sj-python)

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



(defvar sj-python-indent-str "    ")


(defun sj-how-many-str (regexp str)
  (loop with start = 0
        for count from 0
        while (string-match regexp str start)
        do (setq start (match-end 0))
        finally return count))


(defun sj-python-match-defun-name ()
  (save-excursion
    (beginning-of-defun)
    (let ((def-line (thing-at-point 'line)))
      (if (string-match
           (rx (and (submatch (0+ "    ")) (submatch (or "def" "class")) " "
                    (submatch (in "a-zA-Z_") (0+ (in "a-zA-Z_0-9"))) "("))
           def-line)
          def-line))))


(defun sj-python-get-defun-name (def-line)
  (match-string-no-properties 3 def-line))


(defun sj-python-defun-is-class (def-line)
  (string= (match-string-no-properties 2 def-line) "class"))


(defun sj-python-defun-is-function (def-line)
  (string= (match-string-no-properties 2 def-line) "def"))


(defun -beg-def (indent outer-indent count inner)
  (message (format "-beg-def %s %s %s %s" indent outer-indent count inner))
  (beginning-of-defun))


(defun sj-python-get-enclosing-scope-name ()
  "FIXME: (Really) Dirty way of finding name of enclosing scope"
  (save-excursion
    (let ((this-scope-defun (sj-python-match-defun-name)))
      (if this-scope-defun
          (let ((indent-level (sj-how-many-str
                               sj-python-indent-str
                               (match-string-no-properties 1 this-scope-defun)))
                (outer-scope-defun this-scope-defun))
            (if (> indent-level 0)
                (loop for count from 0
                      while (and outer-scope-defun
                                 (<= indent-level (sj-how-many-str sj-python-indent-str
                                                                   outer-scope-defun)))
                      do (loop for inner-count from 0
                               while (>= count inner-count)
                               do (-beg-def indent-level (sj-how-many-str sj-python-indent-str outer-scope-defun) count inner-count)
                               finally return (setq outer-scope-defun (sj-python-match-defun-name)))
                      finally return (if outer-scope-defun
                                         (sj-python-get-defun-name outer-scope-defun)))))))))


;; (defun sj-python-print-enclosing-scope-name ()
;;   (interactive)
;;   (message (format "%s" (sj-python-get-enclosing-scope-name))))


(defun sj-python-get-class-function-name ()
  (let ((def-line (sj-python-match-defun-name)))
    (if def-line
        (let ((function-name (sj-python-get-defun-name def-line)))
          (if (sj-python-defun-is-function def-line)
              (let ((enclosing-scope (sj-python-get-enclosing-scope-name)))
                (if enclosing-scope
                    (if (string-match (rx bos "test_") function-name)
                        (concat enclosing-scope "." function-name)
                      enclosing-scope)
                  function-name))
            function-name)))))


;; (defun sj-python-print-defun-name ()
;;   (interactive)
;;   (message (format "%s" (sj-python-get-class-function-name))))



(define-compilation-mode unittest-mode "unittest"
  "A compilation buffer for Python unittest")



(defun verbose-cmd (cmd verbose)
  "Returns the command used to execute unit tests"
  (let ((verbose-flag
         (if verbose
             " -v"
           "")))
    (concat cmd verbose-flag)))


(defun run-in-cmd-exe (command &mode-arg)
  (let ((mode (if &mode-arg &mode-arg 'unittest-mode)))
    (compilation-start
     (concat "cmd.exe /c \"" command "\"")
     mode)))


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
    (run-in-cmd-exe
     (verbose-cmd (concat "python " python-arg ) verbose))))


(defun py-run-single-test (verbose)
  (interactive "P")
  (let ((python-arg (py-get-test-file-name)))
    (let ((test-cmd (verbose-cmd (concat "python " python-arg) verbose)))
    (run-in-cmd-exe
     (concat test-cmd " " (sj-python-get-class-function-name))))))


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
    (run-in-cmd-exe (py-unittest-discover-cmd verbose))))


(defun py-run-tests-in-current-directory (verbose)
  "Executes \"python -m unittest discover\" in the selected
  directory"
  (interactive "P")
  (let ((default-directory (file-name-directory (directory-file-name (buffer-file-name)))))
    (run-in-cmd-exe (py-unittest-discover-cmd verbose))))


(defun py-execute-current-file ()
  (interactive)
  (run-in-cmd-exe (buffer-file-name) nil))


(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key
             (kbd "C-x t r")
             'py-execute-current-file)))


(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key
             (kbd "C-x t f")
             'py-run-test-case)))


(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key
             (kbd "C-x t s")
             'py-run-single-test)))


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

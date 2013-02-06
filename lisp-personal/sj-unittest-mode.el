(require 'compile)

(require 'cl)


(defvar unittest-indent-str "    ")


(defun how-many-str (regexp str)
  (loop with start = 0
        for count from 0
        while (string-match regexp str start)
        do (setq start (match-end 0))
        finally return count))


(defun unittest-match-defun-name ()
  (save-excursion
    (beginning-of-defun)
    (let ((def-line (thing-at-point 'line)))
      (if (string-match
           (rx (and (submatch (0+ "    ")) (submatch (or "def" "class")) " "
                    (submatch (in "a-zA-Z_") (0+ (in "a-zA-Z_0-9"))) "("))
           def-line)
          def-line))))


(defun unittest-get-defun-name (def-line)
  (match-string-no-properties 3 def-line))


(defun unittest-defun-is-class (def-line)
  (string= (match-string-no-properties 2 def-line) "class"))


(defun unittest-defun-is-function (def-line)
  (string= (match-string-no-properties 2 def-line) "def"))


(defun unittest-get-enclosing-scope-name ()
  "FIXME: (Really) Dirty way of finding name of enclosing scope"
  (save-excursion
    (let ((this-scope-defun (unittest-match-defun-name)))
      (if this-scope-defun
          (let ((indent-level (how-many-str
                               unittest-indent-str
                               (match-string-no-properties 1 this-scope-defun)))
                (outer-scope-defun this-scope-defun))
            (if (> indent-level 0)
                (loop for count from 0
                      while (and outer-scope-defun
                                 (<= indent-level (how-many-str unittest-indent-str
                                                                   outer-scope-defun)))
                      do (loop for inner-count from 0
                               while (>= count inner-count)
                               do (beginning-of-defun)
                               finally return (setq outer-scope-defun (unittest-match-defun-name)))
                      finally return (if outer-scope-defun
                                         (unittest-get-defun-name outer-scope-defun)))))))))


;; (defun unittest-print-enclosing-scope-name ()
;;   (interactive)
;;   (message (format "%s" (unittest-get-enclosing-scope-name))))


(defun unittest-get-class-function-name ()
  (let ((def-line (unittest-match-defun-name)))
    (if def-line
        (let ((function-name (unittest-get-defun-name def-line)))
          (if (unittest-defun-is-function def-line)
              (let ((enclosing-scope (unittest-get-enclosing-scope-name)))
                (if enclosing-scope
                    (if (string-match (rx bos "test_") function-name)
                        (concat enclosing-scope "." function-name)
                      enclosing-scope)
                  function-name))
            function-name)))))


;; (defun unittest-print-defun-name ()
;;   (interactive)
;;   (message (format "%s" (unittest-get-class-function-name))))



(define-compilation-mode unittest-mode "unittest"
  "A compilation buffer for Python unittest")


(defun verbose-cmd (cmd verbose)
  "Returns the command used to execute unit tests"
  (let ((verbose-flag
         (if verbose
             " -v"
           "")))
    (concat cmd verbose-flag)))


(defvar shell-exec "bash -c")


(defun run-in-shell (command)
  (compilation-start
   (if shell-exec
       (concat shell-exec " \"" command "\"")
     command)
   'unittest-mode))


(defun unittest-get-test-file-name ()
  "Returns the full path the the test file for the current module"
  (let ((dirname (file-name-directory (buffer-file-name))))
    (let ((filename (file-name-nondirectory (buffer-file-name))))
      (let ((python-arg
             (if (string-match (rx bos "test_") filename)
                 (buffer-file-name)
               (concat dirname "tests/test_" filename))))
        python-arg))))


(defun unittest-run-test-case (verbose)
  "Executes a test case file"
  (interactive "P")
  (let ((python-arg (unittest-get-test-file-name)))
    (run-in-shell
     (verbose-cmd (concat "python " python-arg ) verbose))))


(defun unittest-run-single-test (verbose)
  "Executes the test under point. If point is not in a single
test, the test case will be executed. If point is not in a test,
all tests for the module are run."
  (interactive "P")
  (let ((python-arg (unittest-get-test-file-name)))
    (let ((test-cmd (verbose-cmd (concat "python " python-arg) verbose)))
    (run-in-shell
     (concat test-cmd " " (unittest-get-class-function-name))))))


(defun unittest-setup-py-directory ()
  "Returns the directory containing a setup.py file"
  (let ((directory (file-name-directory (buffer-file-name))))
    (loop while (not (file-exists-p (concat directory "setup.py")))
          do (setq directory (file-name-directory
                              (directory-file-name
                               (file-name-directory directory))))
          finally return directory)))


(defun unittest-unittest-discover-cmd (verbose)
  "Returns the command used to execute unit tests"
  (verbose-cmd "python -m unittest discover" verbose))


(defun unittest-run-tests-in-directory (tests-dir)
  "Executes \"python -m unittest discover\" in the selected directory"
  (interactive (list (read-directory-name "Run tests in: " (unittest-setup-py-directory))))
  (let ((verbose current-prefix-arg)
        (default-directory tests-dir))
    (run-in-shell (unittest-unittest-discover-cmd verbose))))


(defun unittest-run-tests-in-current-directory (verbose)
  "Executes \"python -m unittest discover\" in the current buffer's directory"
  (interactive "P")
  (let ((default-directory (file-name-directory (directory-file-name (buffer-file-name)))))
    (run-in-shell (unittest-unittest-discover-cmd verbose))))


(defun unittest-execute-current-file ()
  "Executes the current buffer"
  (interactive)
  (run-in-shell (concat "python " (buffer-file-name))))


(defun unittest-execute-module-file (module-file)
  "Takes a path to a python module, relative to the packages
directory, turns it into a dotted package name and executes with
'python -m'.

e.g. foo/bar will be executed as 'python -m foo.bar'"
  (let ((package-module (replace-regexp-in-string "/" "." module-file)))
    (run-in-shell (concat "python -m " package-module))))


(defun unittest-execute-current-module ()
  "Executes the current buffer as python -m package.module.

e.g. /home/simon/packages/some-package/foo/bar.py will be
executed as 'python -m foo.bar', assuming the sop-level is in
some-package (as determined by a setup.py file)"
  (interactive)
  (let ((top-level (unittest-setup-py-directory)))
    (let ((module-file (file-name-sans-extension
                        (file-relative-name (buffer-file-name)
                                            top-level))))
      (if (string= (file-name-nondirectory module-file) "__main__")
          (let ((package-directory (file-name-directory module-file)))
            (let ((module-file (directory-file-name package-directory)))
              (if (not (string= module-file ""))
                  (unittest-execute-module-file module-file)
                (error (concat "No python package found at " package-directory)))))
        (unittest-execute-module-file module-file)))))


(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key
             (kbd "C-x t r")
             'unittest-execute-current-file)))


(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key
             (kbd "C-x t m")
             'unittest-execute-current-module)))


(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key
             (kbd "C-x t f")
             'unittest-run-test-case)))


(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key
             (kbd "C-x t s")
             'unittest-run-single-test)))


(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key
             (kbd "C-x t t")
             'unittest-run-tests-in-directory)))


(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key
             (kbd "C-x t d")
             'unittest-run-tests-in-current-directory)))


(provide 'sj-unittest-mode)

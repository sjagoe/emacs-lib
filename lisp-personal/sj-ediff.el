(require 'ediff)


(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(defun ediff-current-buffer-revision () 
  "Run Ediff to diff current buffer's file against VC depot. Uses `vc.el' or `rcs.el' depending on `ediff-version-control-package'." 
  (interactive) 
  (let ((file (or (buffer-file-name) 
                  (error "Current buffer is not visiting a file")))) 
    (if (and (buffer-modified-p) 
             (y-or-n-p (message "Buffer %s is modified. Save buffer? " 
                                (buffer-name)))) 
        (save-buffer (current-buffer))) 
    (ediff-load-version-control) 
    (funcall 
     (intern (format "ediff-%S-internal" ediff-version-control-package)) 
     "" "" nil)))


(eval-after-load "vc-hooks"
  '(define-key vc-prefix-map "=" 'ediff-current-buffer-revision))


(provide 'sj-ediff)

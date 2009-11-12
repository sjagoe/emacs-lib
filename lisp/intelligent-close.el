;; courtesy of Benjamin Rutt
;; taken from http://www.dotemacs.de/dotfiles/BenjaminRutt.emacs.html
;;This method, when bound to C-x C-c, allows you to close an emacs frame the 
;;same way, whether it's the sole window you have open, or whether it's
;;a "child" frame of a "parent" frame.  If you're like me, and use emacs in
;;a windowing environment, you probably have lots of frames open at any given
;;time.  Well, it's a pain to remember to do Ctrl-x 5 0 to dispose of a child
;;frame, and to remember to do C-x C-x to close the main frame (and if you're
;;not careful, doing so will take all the child frames away with it).  This
;;is my solution to that: an intelligent close-frame operation that works in 
;;all cases (even in an emacs -nw session).
(defun intelligent-close ()
  "quit a frame the same way no matter what kind of frame you are on"
  (interactive)
  (if (eq (car (visible-frame-list)) (selected-frame))
      ;;for parent/master frame...
      (if (> (length (visible-frame-list)) 1)
          ;;close a parent with children present
   (delete-frame (selected-frame)))
;;         ;;close a parent with no children present
;;  (save-buffers-kill-emacs))
    ;;close a child frame
    (delete-frame (selected-frame))))

(provide 'intelligent-close)

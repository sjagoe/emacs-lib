(require 'cython-mode)


(fset 'cython-define-property
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([134217760 backspace 32 32 32 32 112 114 111 112 101 114 116 121 32 11 25 58 return tab 32 32 32 32 100 101 102 32 95 95 103 101 116 95 95 40 115 101 108 102 41 58 return tab 105 102 32 115 101 108 102 46 116 104 105 115 112 116 114 32 105 115 32 110 111 116 32 78 85 76 76 58 return tab 114 101 116 117 114 110 32 115 101 108 102 46 116 104 105 115 112 116 114 46 25 return 14] 0 "%d")) arg)))
(global-set-key "\C-x\C-k1" 'cython-define-property)

(fset 'cython-define-comparison
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("self. == other. and \\" 0 "%d")) arg)))
(global-set-key "\C-x\C-k2" 'cython-define-comparison)

(fset 'cython-define-dtype-element
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([tab 40 39 5 39 44 32 110 112 46 41 44 14 1] 0 "%d")) arg)))
(global-set-key "\C-x\C-k3" 'cython-define-dtype-element)


(provide 'sj-cython)

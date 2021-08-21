(defun move-line-up ()
  ;; moves current line up
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  ;; moves current line down
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key "\C-cn" 'move-line-up)
(global-set-key "\C-cm" 'move-line-down)

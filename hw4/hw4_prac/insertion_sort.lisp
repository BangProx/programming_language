(defun insert (item lst &optional (key #'<))
  (if (null lst)
    (list item)
    (if (funcall key item (car lst))
          (cons item lst) 
          (cons (car lst) (insert item (cdr lst) key)))))

(defun insertion-sort (lst &optional (key #'<))
  (if (null lst)
    lst
    (insert (car lst) (insertion-sort (cdr lst) key) key)))

(setq TC1 '(11 33 23 45 13 25 8 135))
(setq TC2 '(83 72 65 54 47 33 29 11))

(insertion-sort TC1)
(insertion-sort TC2)

(print TC1)
(print TC2)
(defun avg(a b c d) (/ (+ a b c d ) 4) )

(defun cmp ( tmp ) 
    (cond   ((> tmp 5) (print "5보다 크다")) 
            ((< tmp 5) (print "5보다 작다")) 
            ((print "5이다"))
    )
)

(setq tmp ( avg 1 4 6 9))
(print tmp)
(cmp tmp)

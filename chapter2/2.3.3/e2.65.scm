(load "as-binary-trees.scm")

(define (lookup tree value)
  (cond ((null? tree) #f)
	((= value (entry tree)) value)
	((> value (entry tree)) (lookup (right-branch tree) value))
	((< value (entry tree)) (lookup (left-branch tree) value))))

(define tree 
  '(5
    (3 (2 () ()) (4 () ()))
    (7 (6 () ()) (8 () ()))))

(lookup tree 6)
(lookup tree 5)
(lookup tree 3)
(lookup tree 0)

(define (square-tree tree)
  (map (lambda (sub-tree)
         (if (number? sub-tree) 
           (square sub-tree)
           (square-tree sub-tree)))
       tree))

(square-tree '(1 2 (4 5) 3))

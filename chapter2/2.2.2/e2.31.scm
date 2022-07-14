(define (square-tree tree) 
  (tree-map square tree))

(define (tree-map fun tree)
  (map (lambda (sub-tree)
         (if (number? sub-tree) 
           (fun sub-tree)
           (tree-map fun sub-tree)))
       tree))

(square-tree '(1 2 (4 5) 3))

(define (square-tree tree)
  (cond ((null? tree) '())
        ((number? tree) (square tree))
        (else (cons (square-tree (car tree)) 
                    (square-tree (cdr tree))))))

(square-tree '(1 2 (4 5) 3))
(square-tree '(1 2))

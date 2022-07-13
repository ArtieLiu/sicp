(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things)); consing list to item
                    answer))))
  (iter items '()))

(square-list (list 1 2 3))

(cons 1 (list 2 3))
(cons (list 2 3 ) 1)

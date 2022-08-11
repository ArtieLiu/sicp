(load "as-unordered-lists.scm")

(define (union-set s1 s2)
  (if (null? s1) 
    s2
    (adjoin-set (car s1)
                (union-set (cdr s1) s2))))

(union-set '(1 2)
           '(3 4))

(union-set '()
           '(3 4))

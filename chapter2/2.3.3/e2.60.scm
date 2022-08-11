(define (element-of-set? e s)
  (cond ((null? s) #f)
        ((equal? (car s) e) #t)
        (else (element-of-set? e (cdr s)))))
(element-of-set? '1 '(1 2 3))
(element-of-set? '1 '(2 3))
(element-of-set? '1 '(2 3 1))

(define (adjoin-set e s)
  (cons e s))
(adjoin-set '1 '(1 2))

(define (union-set s1 s2)
  (append s1 s2))
(union-set '(1 2 ) '(3 4))
(union-set '(1 2 ) '(1 2))


(define (intersectoin-set s1 s2)
  (cond ((null? s1) '())
        ((element-of-set? (car s1) s2) 
         (cons (car s1)
               (intersectoin-set (cdr s1) s2)))
        (else (intersectoin-set (cdr s1) 
                                s2))))

(intersectoin-set '(1 2 3) '(4 5))
(intersectoin-set '(1 2 3) '(1 4 5))
(intersectoin-set '() '(1 4 5))
(intersectoin-set '(1 2 3) '(1 2 3))



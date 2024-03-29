(define (equal? l1 l2)
  (cond ((and (null? l1) (null? l2)) #t)
        ((or (null? l2) (null? l1)) #f)
        ((and (list? (car l1)) (list? (car l2)))
         (equal? (car l1) (car l2)))
        ((not (eq? (car l1) (car l2))) #f)
        (else (equal? (cdr l1) (cdr l2)))))


(equal? '() '())
(equal? '(1) '(1))
(equal? '(1) '(2))
(equal? '(1) '(1 (2 3)))
(equal? '() '(1 (2 3)))
(equal? '(1 (2 3)) '())
(equal? '(1 (2 3)) '(1 (2 3)))
(equal? '(1 (4 3)) '(1 (2 3)))

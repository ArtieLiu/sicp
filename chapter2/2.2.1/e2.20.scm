(define (same-parity . l)
  (if (even? (car l)) 
    (filter even? l) 
    (filter odd? l)))

(define (filter desired-parity l)
  (cond ((null? l) '())
        ((desired-parity (car l)) 
         (cons (car l) 
               (filter desired-parity (cdr l))))
        (else (filter desired-parity (cdr l)))))

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)




(define (numer x) (car x))
(define (denom x) (cdr x))

(define (make-rat n d)
  (let ((sign (if (positive? (* n d)) 1 -1))
        (abs-n (abs n))
        (abs-d (abs d))
        (g (gcd n d))) 
    (cons (/ (* sign abs-n) g)
          (/ abs-d g))))


(make-rat 1 2)
(make-rat 1 -2)
(make-rat -1 2)
(make-rat -1 -2)

(define (double x) (+ x x)))
(define (halve x) (/ x 2)))

(define (* a b)
  (cond ((= 0 b) 0)
        ((= 1 b) a)
        ((odd? b) (+ a 
                     (* a (- b 1))))
        (else (* (double a) (halve b)))))

(* 10 0)

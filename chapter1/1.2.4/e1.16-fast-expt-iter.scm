(define (fast-expt b n)
	(fast-expt-iter b n 1))

(define (fast-expt-iter b n a)
	(cond ((= 0 n) a)
        ((even? n) (fast-expt-iter 
                     (square b) 
                     (/ n 2) 
                     a))
        (else (fast-expt-iter 
                (square b) 
                (/ (- n 1) 2) 
                (* a b)))))

(define (square x)
  (* x x))

(fast-expt 2 7)



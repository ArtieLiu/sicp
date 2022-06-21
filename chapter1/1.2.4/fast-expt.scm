(define (fast-expt b n) 
    (cond ((= 0 n) 1) 
          ((even? n) (square (fast-expt b (/ n 2)))) 
          (else (* b (fast-expt b (- n 1))))))

(define (square x) (* x x))

(fast-expt 2 3)

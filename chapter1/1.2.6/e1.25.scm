(define (expmod base exp m)
	(remainder (fast-expt base exp) m))


(define (fast-expt b n) 
    (cond ((= 0 n) 1) 
          ((even? n) (square (fast-expt b (/ n 2)))) 
          (else (* b (fast-expt b (- n 1))))))

(define (square x) 
	(display "square ") (display x) (newline) 
	(* x x))

(expmod 6 2 5)

(define state 0)
(define counter 0)

(define (f arg) 
  (set! counter (+ counter 1))
  (cond ((= counter 1) (begin (set! state arg)
			      state))
	(else 0)))

(+ (f 0) (f 1)) 
(+ (f 1) (f 0))

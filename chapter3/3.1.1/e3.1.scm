(define (make-accumulator total) 
  (lambda (to-add)
    (begin (set! total (+ total to-add))
	   total)))

(define A (make-accumulator 5))

(A 10)

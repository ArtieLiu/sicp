(load "stream.scm" )
(load "infinite-streams.scm")

(define (average a b) 
  (/ (+ a b) 2))

; compute square root of x
(define (sqrt-improve guess x) 
  (average guess (/ x guess)))

(define (sqrt-stream x) 
  (define guesses
    (cons-stream 1.0
		 (stream-map (lambda (guess)
			       (sqrt-improve guess x))
			     guesses)))
  guesses)

; -----------------  ----------------- 
	1st: (stream-car ...) -> 1
	2nd: (stream-map (lambda (guess)... ) guesses) -> 

	(cons-stream (lambda (stream-car guesses))
		     (stream-map (lambda (guess) (sqrt-improve guess x))
				 (stream-cdr guesses)))
	(cons-stream 1.5
		     (stream-map (lambda (guess) (sqrt-improve guess x))
				 (stream-cdr guesses)))
	3rd:
	(cons-stream ((lambda (guess) (sqrt-improve guess x)) (stream-car (stream-cdr guesses)))
		     (stream-map (lambda (guess) (sqrt-improve guess x))
				 (stream-cdr (stream-cdr guesses))))


; ---------------------------------------


(first-10-elements (sqrt-stream 2))


; compute pi 
(define (pi-summands n)
  (cons-stream (/ 1.0 n)
	       (stream-map - (pi-summands (+ n 2)))))

(define pi-stream 
  (scale-stream (partial-sums (pi-summands 1)) 4))

(first-10-elements pi-stream)

; -----------------  ----------------- 
	(define integers 
	  (cons-stream 1
		       (add-stream ones integers)))

	(stream-car integers) -> 1
	(stream-cdr integers) ->
	(force (add-stream ones integers)) ->
	(cons-stream (+ (stream-car ones)
			(stream-car integers))
		     (stream-map + (stream-cdr ones)
				 (stream-cdr integers)))
	(cons-stream 2
		     (stream-map + ones
				 (stream-cdr integers)))

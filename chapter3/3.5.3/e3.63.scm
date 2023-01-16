(load "stream.scm")
(load "infinite-streams.scm")

(define (sqrt-improve guess x) 
  (average guess (/ x guess)))

(define (average x y) (/ (+ x y) 2))

; ----------------- original ----------------- 
(define (sqrt-stream x) 
  (define guesses
    (cons-stream 1.0
		 (stream-map (lambda (guess)
			       (sqrt-improve guess x))
			     guesses)))
  guesses)

(define s1 (sqrt-stream 2))



; ----------------- louis's version ----------------- 
(define (sqrt-stream-louis x)
  (display "x= ") (display x) (newline)
  (cons-stream 1.0
	       (stream-map (lambda (guess)
			     (sqrt-improve guess x))
			   (sqrt-stream-louis x))))

(define s2 (sqrt-stream-louis 2))

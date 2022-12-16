(load "stream.scm")

(define (integers-starting-from n) 
  (cons-stream n 
	       (integers-starting-from (+ 1 n))))

(define integers (integers-starting-from 1))

(define (divisible? x y) (zero? (remainder x y)))

(define no-sevens (stream-filter (lambda(x) (not (divisible? x 7)))
				 integers))

(define (fibgen a b) 
  (cons-stream a (fibgen b (+ a b))))

(define fibs 
  (fibgen 0 1))

(define (sieve stream) 
  (cons-stream
    (stream-car stream)
    (sieve (stream-filter
	     (lambda(x) 
	       (not (divisible? x (stream-car stream))))
	     (stream-cdr stream)))))

(define primes (sieve (integers-starting-from 2)))

(define (scale-stream stream factor) 
  (stream-map (lambda(x) (* x factor))
	      stream))

(define (first-10-elements stream) 
  (define (iter n) 
    (if (< n 10)
      (begin (display (stream-ref stream n)) (newline)
	     (iter (+ 1 n)))))
  (iter 0))

(define (first-n-elements stream n) 
  (define (iter i) 
    (if (< i n)
      (begin (display (stream-ref stream i)) (newline)
	     (iter (+ 1 i)))))
  (iter 0))

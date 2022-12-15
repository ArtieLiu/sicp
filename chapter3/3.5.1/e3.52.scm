(load "stream.scm")

(define sum 0)

(define (accum x) 
  (set! sum (+ x sum))
  (display "added: ") (display x) (newline)
  sum)

(define seq (stream-map 
	      accum 
	      (stream-enumerate-interval 1 20)))

(define y (stream-filter even? seq))

(define z (stream-filter 
	    (lambda (x) (= (remainder x 5) 0)) 
	    seq))
(stream-car z)

(stream-ref y 7)
(display sum)

(display-stream z)


(load "square-root.scm")

(define (sqrt x tolerance) 
  (stream-limit (sqrt-stream x) tolerance))

(define (stream-limit stream tolerance) 
  (if (< (abs (- (stream-car stream)
		 (stream-car (stream-cdr stream))))
	 tolerance)
    (stream-car stream)
    (stream-limit (stream-cdr stream) tolerance)))


(sqrt 2 0.1)
(sqrt 2 0.01)
(sqrt 2 0.001)
(sqrt 2 0.0001)
(sqrt 2 0.00001)

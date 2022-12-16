(load "stream.scm")
(load "infinite-streams.scm" )

(define (merge s1 s2)
  (cond ((stream-null? s1) s2)
	((stream-null? s2) s1)
	(else
	  (let ((s1car (stream-car s1))
		(s2car (stream-car s2)))
	    (cond ((< s1car s2car)
		   (cons-stream s1car (merge (stream-cdr s1) s2)))
		  ((> s1car s2car)
		   (cons-stream s2car (merge s1 (stream-cdr s2))))
		  (else
		    (cons-stream s1car (merge (stream-cdr s1) 
					      (stream-cdr s2)))))))))


(define s2 (scale-stream integers 2))
(define s3 (scale-stream integers 3))
(define s5 (scale-stream integers 5))

(define S (cons-stream
	    1
	    (merge s2 
		   (merge s3 s5))))


(first-10-elements S)
(first-n-elements S 100)

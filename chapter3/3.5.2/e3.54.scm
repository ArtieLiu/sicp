(load "stream.scm")
(load "infinite-streams.scm" )

(define (mul-stream s1 s2) 
  (if (stream-null? s1)
    the-empty-stream
    (cons-stream (* (stream-car s1) 
		    (stream-car s2))
		 (mul-stream (stream-cdr s1)
			     (stream-cdr s2)))))

(define factorials (cons-stream 1 
				(mul-stream integers factorials)))

(stream-ref factorials 1)
(stream-ref factorials 2)
(stream-ref factorials 3)
(stream-ref factorials 4)

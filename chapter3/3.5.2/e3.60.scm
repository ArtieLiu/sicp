(load "stream.scm")
(load "infinite-streams.scm")

(define (integrate-series s) (stream-map / s integers))

(define sine-series (cons-stream 0 
				 (integrate-series consine-series)))

(define consine-series (cons-stream 1 
				    (stream-map - (integrate-series sine-series))))


(first-10-elements sine-series)
(first-10-elements consine-series)


(define (mul-series s1 s2) 
  (cons-stream 
    (* (stream-car s1) (stream-car s2))
    (add-streams (add-streams (scale-stream (stream-cdr s1) (stream-car s2))
			      (scale-stream (stream-cdr s2) (stream-car s1)))
		 (cons-stream 0 
			      (mul-series (stream-cdr s1)
					  (stream-cdr s2))))))


(first-10-elements
  (add-streams 
    (mul-series sine-series sine-series)
    (mul-series consine-series consine-series))
  )


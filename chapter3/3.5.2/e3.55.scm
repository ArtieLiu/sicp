(load "stream.scm")
(load "infinite-streams.scm" )

(define (partial-sums S) 
  (cons-stream 
    (stream-car S)
    (add-streams (stream-cdr S)
		 (partial-sums S))))

(define ps (partial-sums integers))


(stream-ref ps 0 )
(stream-ref ps 1 )
(stream-ref ps 2 )
(stream-ref ps 3 )

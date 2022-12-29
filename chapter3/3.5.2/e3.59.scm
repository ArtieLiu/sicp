(define integrate-series (stream-map / integers))

(define sine-series (cons-stream 0 
				 (integrate-series consine-series)))

(define consine-series (cons-stream 1 
				    (stream-map - (integrate-series sine-series))))



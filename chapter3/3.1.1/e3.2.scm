(define (make-monitored f) 
  (define counter 0)

  (define (reset-counter) 
    (set! counter 0))

  (define (increase-counter-by-one) 
    (set! counter (+ counter 1)))

  (define (call-f-on-arg-and-increase-counter arg) 
    (begin (increase-counter-by-one)
	   (f arg)))

  (define (mf arg) 
    (cond ((equal? arg "how-many-calls?") counter)
	  ((equal? arg "reset-counter") (reset-counter))
	  (else (call-f-on-arg-and-increase-counter arg))))
  mf)

(define (echo msg) 
  msg)

(define echo-counter (make-monitored echo))
(echo-counter "how-many-calls?")
(echo-counter "msg")
(echo-counter "how-many-calls?")
(echo-counter "reset-counter")

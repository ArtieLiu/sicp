(define (rand arg) 
  (define random-init 42)

  (define (produce-new-random-number) 
    (set! random-init (random-update random-init))
    random-init)

  (define (reset) 
    (set! random-init 42)
    "reset successful")
  
  (cond ((equal? arg 'generate) (produce-new-random-number))
	((equal? arg 'reset) (reset))
	(else "unknown arg provided")))


(define env '())

(define (put fun)
  (cons fun env))
(define (get)
  env)

(put '1)
(put '2)
(get)

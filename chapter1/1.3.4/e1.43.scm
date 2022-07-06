(define (repeated f times)
  (if (= 1 times)
    (lambda (x) (f x))
    (repeated (compose f f) (-1+ times))))

(define (compose f g)
  (lambda (x) (f (g x))))

((repeated square 1) 5)
((repeated square 2) 5)


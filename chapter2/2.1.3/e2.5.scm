(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (car n)
  (foo n 2 3 0))
(define (cdr n)
  (foo n 3 2 0))

(define (foo n b1 b2 result)
  (if (not (= 0 (modulo n b1)))
    result
    (foo (/ n b1) b1 b2 (1+ result))))

(car (cons '2 '3))
(cdr (cons '2 '3))

(car (cons '4 '3))
(cdr (cons '4 '3))

(car (cons '5 '3))
(cdr (cons '5 '3))

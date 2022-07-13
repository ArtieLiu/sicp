(define (fringe t)
  (cond ((null? t) '())
        ((number? t) (list t))
        (else (append (fringe (car t))
                      (fringe (cdr t))))))
(fringe '())
(fringe '(1 2))
(fringe '(1 (2 3) 4))


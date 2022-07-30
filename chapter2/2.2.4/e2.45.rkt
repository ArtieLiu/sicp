#lang sicp
(#%require sicp-pict)


(define (split op1 op2)
  (lambda (painter n)
    (if (zero? n)
      painter
      (let ((smaller ((split op1 op2) painter (- n 1))))
        (op1 painter
             (op2 smaller smaller))))))

(define right-split (split beside below))
(define up-split (split below beside))

(paint (right-split einstein 10))


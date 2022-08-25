(load "cartesian.scm")
(load "polar.scm")

(define (real-part z)
  (apply-generic 'real-part z))

(define (imag-part z)
  (apply-generic 'imag-part z))

(define (angle z)
  (apply-generic 'angle z))

(define (magnitude z)
  (apply-generic 'magnitude z))


(define (apply-generic op z)
  (let ((proc (get op (type z))))
    (if proc
      (apply proc (contents z))
      (proc (contents z))
      (display "no such operation installed for input"))))





;------------- test --------------
(define z '(rectangular 1 1))
(real-part z)
(imag-part z)

(define zz '(polar 2 3))
(real-part zz)
(imag-part zz)
;-------------------------------

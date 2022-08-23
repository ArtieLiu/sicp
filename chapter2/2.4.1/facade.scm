(load "cartesian.scm")
(load "polar.scm")

(define (real-part z)
  (cond ((eq? 'rectangular (type? z)) (real-part-rect z))
	((eq? 'polar (type? z)) (real-part-polar z))))

(define (imag-part z)
  (cond ((eq? 'rectangular (type? z)) (imag-part-rect z))
	((eq? 'polar (type? z)) (imag-part-polar z))))

(define (angle z)
  (cond ((eq? 'rectangular (type? z)) (angle-rect z))
	((eq? 'polar (type? z)) (angle-polar z))))

(define (magnitude z)
  (cond ((eq? 'rectangular (type? z)) (magnitude-rect z))
	((eq? 'polar (type? z)) (magnitude-polar z))))

(define (type? z)
  (car z))

;------------- test --------------
(define z '(rectangular 1 1))
(real-part z)
(imag-part z)

(define zz '(polar 2 3))
(real-part zz)
(imag-part zz)
;-------------------------------

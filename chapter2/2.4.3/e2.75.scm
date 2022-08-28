(define (make-from-mag-ang mag ang)
  (define (dispatch op)
    (cond ((eq? op 'real-part) (* mag (cos ang)))
	  ((eq? op 'imag-part) (* mag (sin ang)))
	  ((eq? op 'magnitude) mag)
	  ((eq? op 'angle) ang)
	  (else "unknown operation")))
  dispatch)

(define (apply-generic op arg) (arg op))

(define complex-number
  (make-from-mag-ang 1 3.14159))

(apply-generic 'real-part complex-number)
(apply-generic 'imag-part complex-number)
(apply-generic 'magnitude complex-number)
(apply-generic 'angle complex-number)

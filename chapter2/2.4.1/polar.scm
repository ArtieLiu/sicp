(define (make-from-mag-ang m a)
  (list 'polar m a))

(define (real-part-polar z)
  (if (eq? 'polar (car z))
   (* (magnitude-polar z) (cos (angle-polar z)))
   (display "Incorrect type")))
  
(define (imag-part-polar z)
  (if (eq? 'polar (car z))
    (* (magnitude-polar z) (sin (angle-polar z)))
    (display "Incorrect type")))

(define (angle-polar z)
  (cadr z))

(define (magnitude-polar z)
  (caddr z))

(define z-polar (make-from-mag-ang 1 1))
(magnitude-polar z-polar)
(angle-polar z-polar)

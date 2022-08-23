(define (make-from-real-imag x y)
  (list 'rectangular x y))

(define (real-part-rect z)
  (cadr z))

(define (imag-part-rect z)
  (caddr z))

(define (magnitude-rect z)
  (if (eq? 'rectangular (car z))
    (sqrt (+ (square (real-part-rect z))
	     (square (imag-part-rect z))))
    (display "Incorrect type")))

(define (angle-rect z)
  (if (eq? 'rectangular (car z))
    (atan (imag-part-rect z)
	  (real-part-rect z))
    (display "Incorrect type")))

(define z (make-from-real-imag 1 1))
(magnitude-rect z)
(angle-rect z)

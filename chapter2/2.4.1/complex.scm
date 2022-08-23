; -------- operations on complex numbers ----------
(define (add-complex z1 z2)
  (make-from-real-imag 
    (+ (real-part z1) (real-part z2))
    (+ (imag-part z1) (imag-part z2))))

(define (sub-complex z1 z2)
  (make-from-real-imag 
    (- (real-part z1) (real-part z2))
    (- (imag-part z1) (imag-part z2))))

(define (mul-complex z1 z2)
  (make-from-mag-ang 
    (* (magnitude z1) (magnitude z2))
    (+ (angle z1) (angle z2))))

(define (div-complex z1 z2)
  (make-from-mag-ang 
    (/ (magnitude z1) (magnitude z2))
    (- (angle z1) (angle z2))))
; -----------------------------------------------

;------------- Cartesian --------------
(define (make-from-real-imag x y)
  (cons x y))

(define (real-part z)
  (car z))

(define (imag-part z)
  (cadr z))

(define (magnitude z)
  (sqrt (+ (square (real-part z)
		   (imag-part z)))))

(define (angle z)
  (atan (imag-part z)
	(real-part z)))
;-------------------------------

;------------- Polar --------------
(define (make-from-mag-ang m a)
  (cons m a))

(define (real-part z)
  (* m (cos (angle z))))

(define (imag-part z)
  (* m (sin (angle z))))

(define (angle z)
  (cadr z))

(define (magnitude z)
  (car z))
;-------------------------------


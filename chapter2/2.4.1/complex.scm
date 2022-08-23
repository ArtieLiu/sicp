(load "facade.scm")

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

;------------- tests --------------
(define z1 (make-from-real-imag 1 1))
(define z2 (make-from-mag-ang 2 2))
(define zsum (add-complex z1 z2))
(define zdif (sub-complex z1 z2))
(define zmul (mul-complex z1 z2))
(define zdiv (div-complex z1 z2))

(type? z1)
(type? z2)
zsum
zdif
zmul
zdiv
;-------------------------------

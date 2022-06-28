(define tolerance 0.0001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2) (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
        next
        (try next))))
  (try first-guess))

;(fixed-point cos 1.0)

; this will not work:
;(define (sqrt x)
; (fixed-point (lambda (y) (/ x y))
;              1.0))



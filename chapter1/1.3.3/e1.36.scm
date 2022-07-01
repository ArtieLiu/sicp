(define tolerance 0.001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2) (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (display "trying ")(display guess)(newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
        next
        (try next))))
  (try first-guess))


; without average damping
(fixed-point (lambda (x) (/ (log 1000) (log x))) 
             10.0)

; with average damping
(fixed-point (lambda (x) (* 0.5 
                            (+ (/ (log 1000) (log x)) x)))
               10.0)

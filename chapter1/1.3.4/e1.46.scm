(define (average a b)
  (/ (+ a b) 2))

(define (iterative-improve good-enough? improve)
  (define (iter guess)
    (if (good-enough? guess)
      guess
      (iter (improve guess))))
  (lambda (guess) 
    (iter guess)))

(define (sqrt x)
  (define (improve guess)
    (average guess (/ x guess)))
  (define (good-enough? guess)
    (< (abs (- (square guess) 
               x)) 0.0001))

  ((iterative-improve good-enough? improve) 1.0))

;(sqrt 210)

(define (fixed-point f)
  (define (improve guess)
    (f guess))
  (define (good-enough? guess)
    (< (abs (- (f guess) 
               (f (f guess)))) 
       0.001))
  ((iterative-improve good-enough? improve) 1.0))

(fixed-point sin)

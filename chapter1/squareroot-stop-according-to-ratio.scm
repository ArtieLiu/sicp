; if previous root and current root is pretty close, stop the computation
(define (good-enough-by-ratio? previous current)
  (and (> (/ previous current) 0.9) 
       (< (/ previous current) 1.1)))

(define (sqrt-iter guess x)
  (if (good-enough-by-ratio? guess (improve guess x))
    guess
    (sqrt-iter (improve guess x)
               x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))




(sqrt-iter 0.1 0.001)


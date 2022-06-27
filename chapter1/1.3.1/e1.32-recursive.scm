;(define (product term a next b)
;  (if (> a b)
;    1
;    (* (term a)
;       (product term (next a) next b))))

;(define (sum term a next b)
;  (if (> a b)
;    0
;    (+ (term a)
;       (sum term (next a) next b))))

(define (accumulate combiner null-value term a next b) 
  (if (> a b)
    null-value
    (combiner (term a)
       (accumulate combiner null-value term (next a) next b))))

(define (add1 x) (+ x 1))
(define (identity x) x)

; 1 + 2 + 3
(accumulate + 0 identity 1 add1 3) ; => 6

; 1 * 2 * 3
(accumulate * 1 identity 1 add1 3) ; => 6



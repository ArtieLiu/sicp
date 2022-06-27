(define (product term a next b)
  (if (> a b)
    1
    (* (term a)
       (product term (next a) next b))))

(define (next a) (+ a 1))

(define (nth-term n)
  (/ (n-th-numerator n) 
     (n-th-denominator n)))

(define (n-th-numerator n)
  (cond ((odd? n) (+ n 1))
        ((even? n) (+ n 2))))

(define (n-th-denominator n)
  (cond ((odd? n) (+ n 2))
        ((even? n) (+ n 1))))

; to calculate pi:
(* 4 (exact->inexact (product nth-term 1 next 2000)))


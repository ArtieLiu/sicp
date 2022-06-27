(define (accumulate combiner null-value term a next b) 
  (accumulate-iter combiner term a next b null-value))

(define (accumulate-iter combiner term a next b start)
  (if (> a b)
    start
    (accumulate-iter combiner term (next a) next b (combiner start (term a)))))

(define (next a) (+ a 1))

(define (nth-term n)
  (cond ((odd? n) (/ (+ n 1) (+ n 2)))
        ((even? n) (/ (+ n 2) (+ n 1)))))

; to calculate pi:
(* 4 (exact->inexact (accumulate * 1 nth-term 1 next 20000)))

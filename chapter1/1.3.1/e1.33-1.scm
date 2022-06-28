(define (filter-accumulate combiner filter null-value term a next b)
  (if (> a b)
    null-value
    (combiner (choose? filter a null-value)
       (filter-accumulate combiner filter null-value term (next a) next b))))

(define (choose? filter a null-value)
  (if (filter a)
    a
    null-value))

; sum of prime numbers in range [1,10]
; sum(2 3 5 7) = 17
(filter-accumulate + prime? 0 identity 2 add1 10)


; ---------------- test primility ------------
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) 
         n)
        ((divides? test-divisor n) 
         test-divisor)
        (else (find-divisor 
               n 
               (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))
; --------------------------------------------

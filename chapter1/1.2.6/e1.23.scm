(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n) 
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (square x) (* x x))

(define (next n)
  (cond ((= n 2) 3)
        (else (+ n 2))))

(smallest-divisor 100) 
(smallest-divisor 101) 
(smallest-divisor 102) 
(smallest-divisor 103) 
(smallest-divisor 104) 
(smallest-divisor 105) 
(smallest-divisor 106) 
(smallest-divisor 107) 
(smallest-divisor 108) 
(smallest-divisor 109) 
(smallest-divisor 110) 
(smallest-divisor 111) 
(smallest-divisor 112) 
(smallest-divisor 113) 
(smallest-divisor 114) 
(smallest-divisor 115) 
(smallest-divisor 116) 
(smallest-divisor 117) 
(smallest-divisor 118) 
(smallest-divisor 119) 
(smallest-divisor 120)

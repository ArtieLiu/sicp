(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
      result 
      (iter (next a) (+ result (term a))))) 

  (iter a 0))

(define (add1 x) (+ x 1))
(sum square 1 add1 5)

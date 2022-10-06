(define (factorial n)
  (fact-iter 1 1 n))

(define (fact-iter product 
                   counter 
                   max-count)
  (newline)
  (display product) (display " ") (display counter) (display " ") (display max-count) (display " ")
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

(factorial 6)

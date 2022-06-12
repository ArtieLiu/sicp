(define (expt b n)
  (expt-iter b n 1))

(define (expt-iter b counter product)
  (if (= counter 0) 
    product 
    (expt-iter b 
               (- counter 1) 
               (* product b))))

(expt 2 3)
(expt 1 0)

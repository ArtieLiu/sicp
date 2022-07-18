(define (accumulate op init-value sequence)
  (if (null? sequence) 
    init-value
    (op (car sequence)
        (accumulate op 
                    init-value 
                    (cdr sequence)))))

(define 
  (horner-eval x coefficient-sequence)
  (accumulate 
    (lambda (this-coeff higher-terms) 
      (+ this-coeff 
         (* x higher-terms)))  
   0
   coefficient-sequence))

(horner-eval 2 (list 1 3 0 5 0 1))



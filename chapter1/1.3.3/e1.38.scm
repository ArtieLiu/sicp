(define (cont-frac-iter N D i result)
  (display result)(newline)
  (let ((updated (* 1.0 (/ (N i) (+ (D i) result)))))
    (if (close-enough? result updated)
      updated
      (if (< i 1)
        result
        (cont-frac-iter N D (- i 1) updated)))))

(define (close-enough? a b) (< (abs (- a b)) 0.0001))

(define (cont-frac N D k)
  (cont-frac-iter N D (- k 1) (/ (N k) (D k))))


(define (D i)
  (cond ((= 0 (modulo i 3) ) 1)
        ((= 1 (modulo i 3) ) 1)
        (else (* 2 (+ (quotient i 3) 1)))))
(define (N i) 1)

(+ 2 
   (* 1.0 (cont-frac N D 1000)))

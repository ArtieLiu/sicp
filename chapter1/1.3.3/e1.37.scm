; compute the value of the k-term finite continued fraction

; recurisve
;(define (cont-frac N D k)
;  (cont-frac-recur N D k 1))

(define (cont-frac-recur N D k term)
  (define (add1 i) (+ i 1))
  (let ((Ni (N term))
        (Di (D term))) 
    (if (< term k) 
      (/ Ni (+ Di (cont-frac-recur N D k (add1 term))))
      (/ Ni Di))))


; iterative

(define (cont-frac-iter N D i result)
  (display result)(newline)
  (let ((updated (/ (N i) (+ (D i) result))))
    (if (close-enough? result updated)
      updated 
      (if (< i 1) 
        result 
        (cont-frac-iter N D (- i 1) updated)))))

(define (cont-frac N D k)
  (cont-frac-iter N D (- k 1) (/ (N k) (D k))))

(define (close-enough? a b) (< (abs (- a b)) 0.0001))

(define (one i) 1.0)

(cont-frac one one 1000)

;1.3
(define (min2 x y)
  (if (< x y) x y))
(min2 1 2)

(define (min-of-list l) 
  (if (null? (cdr l))
    (car l)
    (min2 (car l) (min-of-list (cdr l)))))
(min-of-list '(1 2 3))

(define (square-sum-larger a b c)
  (- (+ (square a) 
        (square b) 
        (square c)) 
     (square (min-of-list (list a b c)))))

(square-sum-larger 1 2 0)

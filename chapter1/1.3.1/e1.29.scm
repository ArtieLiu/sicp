(define (integral f a b n) 
  (define h (/ (- b a) n))

  (define (kth-coeffecient k)
    (cond ((equal? k 0) 1)
          ((equal? k n) 1)
          ((even? k) 2)
          ((odd? k) 4)))

  (define (term k) 
    (* (kth-coeffecient k)
       (f (+ a (* h k)))))

  (define (next a)
    (+ a 1))

  (* (/ h 3) 
     (sum term 0 next n)))

(define (sum term a next b)
  (if (> a b)
    0
    (+ (term a)
       (sum term (next a) next b))))

(define (cube x) (* x x x))

(integral cube 0 1 1000)

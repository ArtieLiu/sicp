(define zero 
  (lambda (f) 
    (lambda (x) x)))

(define (add-1 n)
  (lambda (f) 
    (lambda (x) (f ((n f) x)))))

(define one (add-1 zero))
(define two (add-1 (add-1 zero)))

(add-1 zero)

(lambda (f) 
  (lambda (x) (f ((zero f) x))))

(lambda (f) 
  (lambda (x) 
    (f (((lambda (f) (lambda (x) x)) f) 
        x))))
; ------------- (add-1 zero) ------
(lambda (f) 
  (lambda (x) 
    (f x)))
; ---------------------------------

(add-1 (add-1 zero))
(add-1 (lambda (f) 
         (lambda (x) 
           (f x))))

(lambda (f) 
  (lambda (x) (f (((lambda (f) 
                     (lambda (x) 
                       (f x))) 
                   f) 
                  x))))

(lambda (f) 
  (lambda (x) (f ((lambda (x) (f x)) x))))

; ------------- (add-1 (add-1 zero)) ------
(lambda (f) 
  (lambda (x) 
    (f (f x))))
; -----------------------------------------

; ------------- sum of two lambdas  ------
(define (+ l1 l2)
  (lambda (f) 
    (lambda (x) 
      ((l2 f) 
       ((l1 f) x)))))


(define l1 (lambda (f) (lambda (x) (f x))))
((l1 1+) 0)

(define l2 (lambda (f) (lambda (x) (f (f x)))))
((l2 1+) 0)

((l2 1+) 
 ((l1 1+) 0))

(define l5 (lambda (f) (lambda (x) (f (f (f (f (f x))))))))
(((+ l1 l5) 1+) 0)

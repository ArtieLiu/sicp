(define (make-vect x y)
  (cons x y))

(define (xcor-vect v)
  (car v))
(define (ycor-vect v)
  (cdr v))

(define (add-vect v1 v2)
  (make-vect
    (op-x-component + v1 v2)
    (op-y-component + v1 v2)))

(define (sub-vect v1 v2)
  (make-vect
    (op-x-component - v1 v2)
    (op-y-component - v1 v2)))

(define (op-x-component op v1 v2)
  (op (xcor-vect v1)
      (xcor-vect v2)))

(define (op-y-component op v1 v2)
  (op (ycor-vect v1)
      (ycor-vect v2)))

(define (scale-vect vect scalar)
  (make-vect 
    (* scalar (xcor-vect vect))
    (* scalar (ycor-vect vect))))


;----- testing ---
(define v1 (make-vect 1 1))
(define v2 (make-vect 2 2))
(add-vect v1 v2)
(sub-vect v1 v2)
(scale-vect v1 3)

(provide make-vect)
(provide add-vect)
(provide sub-vect)
(provide scale-vect)


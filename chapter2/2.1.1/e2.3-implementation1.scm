(load "e2.2.scm")

(define (make-rectangle a-seg b-seg)
  (cons a-seg b-seg))

(define (a-seg rectangle) (car rectangle))
(define (b-seg rectangle) (cdr rectangle))

(define (perimeter rectangle)
  (* (+ (length (a-seg rectangle))
        (length (b-seg rectangle)))
     2))

(define (area rectangle)
  (* (length (a-seg rectangle))
     (length (b-seg rectangle))))

;---------- a -----------
(define a1 (make-point 0 0))
(define a2 (make-point 2 0))
(define a (make-segment a1 a2))

;---------- b -----------
(define b1 (make-point 0 2))
(define b2 (make-point 2 2))
(define b (make-segment b1 b2))

;---------- rect -----------
(define rect (make-rectangle a b))

;---------- compute -----------
(area rect)
(perimeter rect)

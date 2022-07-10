(load "e2.2.scm")

(define (make-rectangle base offset)
  (cons base offset))

(define (get-base rectangle) 
  (car rectangle))

(define (get-offset rectangle)
  (cdr rectangle))

(define (perimeter rectangle)
  (* 2
     (+ (length (get-base rectangle))
        (abs (get-offset rectangle)))))

(define (area rectangle)
  (* (length (get-base rectangle))
     (abs (get-offset rectangle))))

;---------- base -----------
(define a1 (make-point 0 0))
(define a2 (make-point 2 0))
(define a (make-segment a1 a2))

;---------- offset -----------
(define offset 1)

;---------- rect -----------
(define rect (make-rectangle a offset))

;---------- compute -----------
(area rect)
(perimeter rect)

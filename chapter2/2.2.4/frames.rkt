(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
      (origin-frame frame)
      (add-vect 
        (scale-vect (xcor-vect v) (edge1-frame frame))
        (scale-vect (ycor-vect v) (edge2-frame frame))))))

; ----------- vect --------------
(define (make-vect x y) (cons x y))

(define (xcor-vect v) (car v))
(define (ycor-vect v) (cdr v))

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
; -----------------------------

; -------------- frame -----------
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (get-origin frame)
  (car frame))

(define (get-edge1 frame)
  (car (cdr frame)))

(define (get-edge2 frame)
  (car (cdr (cdr frame))))
; -----------------------------

(define (add-interval x y)
  (make-interval (+ (lower-bound x) 
                    (lower-bound y))
                 (+ (upper-bound x) 
                    (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) 
               (lower-bound y)))
        (p2 (* (lower-bound x) 
               (upper-bound y)))
        (p3 (* (upper-bound x) 
               (lower-bound y)))
        (p4 (* (upper-bound x) 
               (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (spans-zero? y)
    (error "divide by an interval that spans zero"))
  (mul-interval x 
                (make-interval 
                 (/ 1.0 (upper-bound y)) 
                 (/ 1.0 (lower-bound y)))))
(define (spans-zero? i)
  (negative? (lower-bound i)))

(define (display-interval i)
  (display "(") 
  (display (lower-bound i))
  (display ",")
  (display (upper-bound i))
  (display ")"))

;------------ e2.7 -------------
(define (make-interval x y) (cons x y))
(define (lower-bound i) (min (car i) (cdr i)))
(define (upper-bound i) (max (car i) (cdr i)))
; -------------------------------

;------------ e2.8 -------------
(define (sub-interval x y) 
  (make-interval (- (upper-bound x)
                    (lower-bound y))
                 (- (lower-bound x)
                    (upper-bound y))))
; -------------------------------

(define i1 (make-interval 10 9))
(define i2 (make-interval 1 2))
(display-interval (sub-interval i1 i2))

(define (width-interval i)
  (/ (- (upper-bound i)
        (lower-bound i))
     2.0))

(width-interval (add-interval i1 i2))
(width-interval (sub-interval i1 i2))
(width-interval (mul-interval i1 i2))
(width-interval (div-interval i1 i2))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) 
        (upper-bound i)) 
     2))

(define (width i)
  (/ (- (upper-bound i) 
        (lower-bound i)) 
     2))

; ---------- point ----------------
(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (add-points p1 p2)
  (cons (+ (x-point p1) 
           (x-point p2))
        (+ (y-point p1)
           (y-point p2))))

(define (average a b) (/ (+ a b) 2))
(define (mid-point p1 p2)
  (let ((mid-x (average (x-point p1) (x-point p2)))
        (mid-y (average (y-point p1) (y-point p2))))
  (cons mid-x mid-y)))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))
; ---------- end point ----------------

; ---------- segment ----------------
(define (make-segment start-point end-point)
  (cons start-point end-point))

(define (start-segment segment) (car segment))
(define (end-segment segment) (cdr segment))

(define (midpoint-segment segment)
  (mid-point (start-segment segment)
             (end-segment segment)))

(define (length segment)
  (let ((delta-x (- (x-point (start-segment segment)) (x-point (end-segment segment))))
        (delta-y (- (y-point (start-segment segment)) (y-point (end-segment segment)))))
  (sqrt (+ (square delta-x) 
           (square delta-y)))))
; ---------- end segment ----------------

(define p1 (make-segment 1 1))
(define p2 (make-segment 2 2))
(define s (make-segment p1 p2))

(print-point (midpoint-segment s))

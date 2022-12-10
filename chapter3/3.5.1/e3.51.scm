(define (show x) 
  (display-line x)
  x)

(define (display-line x) 
  (display x))

; ------------
(define x (stream-map show (stream-enumerate-interval 0 10)))

(cons-stream 0
	     (stream-enumerate-interval 1 10))
; 0




; ------------
(stream-ref x 5)
; 12345


; ------------
(stream-ref x 7)
; 67

(define () 
  ())



(define (cons-stream x y) 
  (cons x
	(delay y)))

(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

(cons-stream 1 2)
(define the-empty-stream '())
(define (stream-null? s) (null? s))


(define s (cons-stream 1 (cons-stream 2 3)))
(stream-car s)
(stream-cdr s)



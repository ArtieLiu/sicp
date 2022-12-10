(load "stream.scm")

(define sum 0)
; 0

(define (accum x)
  (set! sum (+ x sum))
  (display "added: ") (display x) (newline)
  sum)
; 0

(define seq 
  (stream-map 
   accum 
   (stream-enumerate-interval 1 20)))
; stream-map maps procedure to all elements of a stream, in this case all 20 numbers are accumulated  
; 210

(display sum)
(display seq)

(define y (stream-filter even? seq))

(define z 
  (stream-filter 
   (lambda (x) 
     (= (remainder x 5) 0)) seq))

(to-list seq)

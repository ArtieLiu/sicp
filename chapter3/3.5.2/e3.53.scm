(load "stream.scm")

(define (add-streams s1 s2) 
  (stream-map + s1 s2))

(define s (cons-stream 1
		       (add-streams s s)))

; new stream element is computed by adding previous element to itself.
; the resulting stream represents power of 2, where the nth element is 2^n.

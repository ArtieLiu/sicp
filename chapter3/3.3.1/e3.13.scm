(define (make-circle x) 
  (set-cdr! (last-pair x) x)
  x)

; creates a list that is a loop.

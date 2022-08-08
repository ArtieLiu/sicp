(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
      (lambda (segment)
        (draw-line
          ((frame-coord-map frame) (start-segment segment))
          ((frame-coord-map frame) (end-segment segment))))
      segment-list)))

(define outline-segments
  (list (make-segment (make-vect 0 0) (make-vect 0 1))
        (make-segment (make-vect 0 1) (make-vect 1 1))
        (make-segment (make-vect 1 1) (make-vect 1 0))
        (make-segment (make-vect 1 0) (make-vect 0 0))))

(define cross-segments
  (list (make-segment (make-vect 0 0) (make-vect 1 1))
        (make-segment (make-vect 0 1) (make-vect 1 0))))

(define diamond-segments
  (list (make-segment (make-vect 0.5 0) 
                      (make-vect 1 0.5))
        (make-segment (make-vect 0 0.5) 
                      (make-vect 0.5 0))
        (make-segment (make-vect 1 0.5) 
                      (make-vect 0.5 1))
        (make-segment (make-vect 0 0.5) 
                      (make-vect 0.5 1))))

((segments->painter outline) frame)

; note: to display the painter in https://www.biwascheme.org/demo/pictlang.html, 
; you need to drop the frame,
; for example, instead of 
; ((segments->painter outline) frame)
; just use: 
; (segments->painter outline)

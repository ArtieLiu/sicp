#lang sicp
(#%require sicp-pict)

(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) 
                       (tr painter)))
          (bottom (beside (bl painter) 
                          (br painter))))
      (below bottom top))))

(define (flipped-pairs painter)
  (let ((combine4
          (square-of-four identity
                          flip-vert
                          identity
                          flip-vert)))
    (combine4 painter)))

(paint (flipped-pairs einstein))

(define (square-limit painter n)
  (let ((combine4
          (square-of-four flip-horiz identity
                          rotate180 filp-vert)))
    (combine4 (corner-split painter n))))

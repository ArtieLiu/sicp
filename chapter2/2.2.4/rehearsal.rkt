#lang racket
(require sicp-pict)

(define wave einstein)

;(paint wave)
(define wave2 (beside wave wave))
;(paint wave2)

(define wavesquare (below wave2 wave2))
;(paint wavesquare)

(define (right-split painter n)
  (if (= 0 n)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter
                (below smaller smaller)))))
;(paint (right-split wave 10))

(define (up-split painter n)
  (if (= 0 n)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter
               (beside smaller smaller)))))
;(paint (up-split wave 10))


(define (corner-split painter n)
  (if (zero? n)
    painter
    (let ((tl (beside (up-split painter (- n 1))
                      (up-split painter (- n 1))))
          (tr (corner-split painter (- n 1)))
          (bl painter)
          (br (below (right-split painter (- n 1))
                     (right-split painter (- n 1)))))
      (beside (below bl tl)
              (below br tr)))))
;(paint (corner-split wave 10))

(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter)
                       (tr painter)))
          (bottom (beside (bl painter)
                          (br painter))))
      (below bottom top))))

(define (square-limit painter n)
  (let ((combine4 (square-of-four flip-horiz 
                                  identity
                                  rotate180 
                                  flip-vert)))
    (combine4 (corner-split painter n))))


(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
      (origin-frame frame)
      (add-vect 
        (scale-vect (xcor-vect v) (edge1-frame frame))
        (scale-vect (ycor-vect v) (edge2-frame frame))))))

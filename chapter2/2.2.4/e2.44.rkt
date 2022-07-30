#lang sicp
(#%require sicp-pict)

(define (flipped-pairs painter)
  (let ((painter2
          (beside painter
                  (flip-vert painter))))
    (below painter2 painter2)))

(define (right-split painter n)
  (if (zero? n)
    painter
    (let ((smaller (right-split painter (- n 1)))) 
      (beside painter
              (below smaller smaller)))))

(paint (flipped-pairs einstein))
(paint (right-split einstein 10))

(define (up-split painter n)
  (if (zero? n)
    painter
    (let ((smaller (up-split painter (- n 1))))
      (below painter
             (beside smaller smaller)))))
(paint (up-split einstein 10))


(define (corner-split painter n)
  (if (zero? n)
    painter
    (let ((up (up-split painter (- n 1)))
          (right (right-split painter (- n 1))))
      (let ((top-left (beside up up))
            (bottom-right (below right right))
            (corner (corner-split painter (- n 1))))
        (beside (below painter top-left)
                (below bottom-right corner))))))

(paint (corner-split einstein 10))
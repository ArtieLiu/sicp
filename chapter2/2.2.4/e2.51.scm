(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-top (transform-painter painter2
                                        split-point
                                        (make-vect 1.0 0.5)
                                        (make-vect 0 1.0)))
          (paint-down (transform-painter painter1
                                         (make-vect 0.0 0.0)
                                         (make-vect 1.0 0)
                                         split-point)))
      (lambda (frame)
        (paint-top frame)
        (paint-down frame)))))

(define below (flip-vert (rotate270 (beside 
                                      (rotate270 %image)
                                      (rotate270 %image)))))

; --------------- utils ----------------
(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter (make-frame new-origin
                             (sub-vect (m corner1) new-origin)
                             (sub-vect (m corner2) new-origin)))))))

(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left  (transform-painter 
                         painter1
                         (make-vect 0.0 0.0)
                         split-point
                         (make-vect 0.0 1.0)))
          (paint-right (transform-painter
                         painter2
                         split-point
                         (make-vect 1.0 0.0)
                         (make-vect 0.5 1.0))))
      (lambda (frame) 
        (paint-left frame) 
        (paint-right frame)))))

(define (rotate270 painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))

(define (flip-vert painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)   
                     (make-vect 1.0 1.0)   
                     (make-vect 0.0 0.0)))

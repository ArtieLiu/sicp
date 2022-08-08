(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (get-origin frame)
  (car frame))

(define (get-edge1 frame)
  (car (cdr frame)))

(define (get-edge2 frame)
  (car (cdr (cdr frame))))


; ------------ testing ---------
(define f (make-frame 1 2 3))

(get-origin f)
(get-edge1 f)
(get-edge2 f)



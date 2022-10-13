#lang racket

(require pict)
(require sdraw)

(define (save-pict the-pict name kind)
  (define bm 
    (pict->bitmap the-pict))
  (send bm save-file name kind))

(save-pict (sdraw '(a b))
	   "t1.png"
	   'png)


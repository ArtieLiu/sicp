(load "e2.68.scm")
(load "e2.69.scm")

(define p '((A 2) (NA 16) (BOOM 1) (SHA  3) (GET  2) (YIP  9) (JOB  2) (WAH  1)))


(define msg 	'(Get a job
		  Sha na na na na na na na na

		  Get a job
		  Sha na na na na na na na na

		  Wah yip yip yip yip 
		  yip yip yip yip yip
		  Sha boom))

(encode msg (generate-huffman-tree p))

; encoded: 
'(1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 1 1)

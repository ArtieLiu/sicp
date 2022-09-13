(define (div-terms L1 L2)
  (if (empty-termlist? L1)
    (list (the-empty-termlist) (the-empty-termlist))
    (let ((t1 (first-term L1))
	  (t2 (first-term L2)))
      (if (> (order t2) (order t1))
	(list (the-empty-termlist) L1)
	(let ((new-c (/ (coeff t1) (coeff t2)))
	      (new-o (- (order t1) (order t2))))
	  (let ((rest-of-result
		  (sub L1
		       (mul-term-by-all-terms (make-term new-c new-o)
					      L2))))
	    (list (adjoin-term (make-term new-c new-o)
			       (get-result (div-terms (rest-terms L1)
						      L2)))
		  (get-remainder (div-terms rest-of-result L2)))))))))

(define get-result car)
(define get-remainder cadr)

;     5 4 3 2 1 0
; L1 (1 0 0 0 0 -1)
; L2 (      1 0 -1)

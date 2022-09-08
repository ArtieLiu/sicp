(define (sub-poly p1 p2)
  (add-poly p1
	    (negate-poly p2)))

(define (negate-poly p)
  (define (negate-terms terms)
    (if (empty-termlist? terms)
      (the-empty-termlist)
      (let ((t (first-term terms)))
	(adjoin-term (negate-term t)
		     (negate-terms (rest-terms terms))))))
  (define (negate-term t)
    (make-term (negate (coeff t))
	       (order t)))

  (make-poly (variable p)
	     (negate-terms (term-list p))))

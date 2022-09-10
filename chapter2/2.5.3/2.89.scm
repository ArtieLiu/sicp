;------------- add --------------
(define (add-terms L1 L2)
    (cond ((empty-termlist? L1) L2)
	  ((empty-termlist? L2) L1)
	  (else
	    (let ((t1 (first-term L1)) 
		  (t2 (first-term L2)))
	      (cond ((> (order t1) (order t2))
		     (adjoin-term t1 
				  (add-terms (rest-terms L1) L2)))
		    ((< (order t1) (order t2)) 
		     (adjoin-term t2 
				  (add-terms L1 (rest-terms L2))))
		    (else
		      (adjoin-term
			(make-term (add (coeff t1) (coeff t2)) 
				   (order t1))
			(add-terms (rest-terms L1) 
				   (rest-terms L2)))))))))

(define (adjoin-term compact-term termlist)
  (if (null? termlist) 
    (expand compact-term)
    (let ((o1 (order compact-term))
	  (o2 (order (first-term termlist))))
      (cond ((= o1 o2)
	     (cons (add (coeff compact-term)
			(coeff (first-term termlist)))
		   (cdr termlist)))
	    ((< o1 o2)
	     (cons (coeff (first-term termlist))
		   (adjoin-term compact-term
				(cdr termlist))))
	    ((> o1 o2)
	     (adjoin-term compact-term
			  (raise-order termlist)))))))

(define (expand compact-term)
  (define (zeros-of-order order)
    (if (= 0 order)
      '()
      (cons 0 (zeros-of-order (- order 1)))))
  (let ((order (order compact-term))
	(coeff (coeff compact-term)))
    (cons coeff
	  (zeros-of-order order))))

(define (make-term coeff order) (list coeff order))
(define coeff car)
(define order cadr)

(define (first-term L) 
  (let ((order (length (cdr L)))
	(coeff (car L)))
    (list coeff order)))

(define (empty-termlist? L) (null? L))
(define (empty-termlist) '())

(define (rest-terms L) (cdr L))

(define (raise-order termlist)
  (cons 0 termlist))
(define add + )

;------------- test add --------------
(add-terms '() 
	   '())
(add-terms '(  2 1 0) 
	   '(3 2 1 0))
(add-terms '(3 2 1 0)
	   '(  2 1 0))
(add-terms '(3 2 1 0)
	   '(3 2 1 0))

;------------- mul --------------
(define (mul-terms L1 L2)
  (if (empty-termlist? L1)
    (empty-termlist)
    (add-terms 
      (mul-term-by-all-terms (first-term L1) L2)
      (mul-terms (rest-terms L1) L2))))

(define (mul-term-by-all-terms term L)
  (if (empty-termlist? L)
    (empty-termlist)
    (let ((t2 (first-term L)))
      (adjoin-term (make-term (mul (coeff term)
				   (coeff t2))
			      (+ (order term)
				 (order t2)))
		   (mul-term-by-all-terms term 
					  (rest-terms L))))))
(define mul *)

;------------- test mul --------------

(mul-terms '(1 1 1 1 1) 
	   '(1 1 1 1 1))

(mul-terms '()
	   '(1 2))

(mul-terms '()
	   '())


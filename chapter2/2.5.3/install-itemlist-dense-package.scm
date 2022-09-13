(define (install-itemlist-dense-package)

  (define (tag itemlist)
    (cons 'dense itemlist))

  (define (make-termlist itemlist) (list itemlist))

  (define (first-term L) 
    (let ((order (length (cdr L)))
	  (coeff (car L)))
      (list coeff order)))
  (define (rest-terms itemlist)    (cdr itemlist))

  (define (empty-termlist? termlist) (null? termlist))
  (define (the-empty-termlist) '())

  (define (make-term coeff order) (list coeff order))
  (define (coeff term) (car term))
  (define (order term) (cadr term))

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

  (define (raise-order termlist)
    (cons 0 termlist))

  (define (expand compact-term)
    (define (zeros-of-order order)
      (if (= 0 order)
	'()
	(cons 0 (zeros-of-order (- order 1)))))
    (let ((order (order compact-term))
	  (coeff (coeff compact-term)))
      (cons coeff
	    (zeros-of-order order))))

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

  (define (sub-terms L1 L2)
    (add-terms L1 
	       (negate-terms L2)))

  (define negate -)
  (define (negate-term t)
    (make-term (negate (coeff t))
	       (order t)))

  (define (negate-terms terms)
    (if (empty-termlist? terms)
      (the-empty-termlist)
      (let ((t (first-term terms)))
	(adjoin-term (negate-term t)
		     (negate-terms (rest-terms terms))))))

  (define (mul-terms L1 L2)
    (if (empty-termlist? L1)
      (the-empty-termlist)
      (add-terms 
	(mul-term-by-all-terms (first-term L1) L2)
	(mul-terms (rest-terms L1) L2))))

  (define (mul-term-by-all-terms term L)
    (if (empty-termlist? L)
      (the-empty-termlist)
      (let ((t2 (first-term L)))
	(adjoin-term (make-term (mul (coeff term)
				     (coeff t2))
				(+ (order term)
				   (order t2)))
		     (mul-term-by-all-terms term 
					    (rest-terms L))))))

  (put 'make 'dense 
       (lambda (itemlist) 
	 (tag itemlist)))

  (put 'adjoin 'dense 
       (lambda (term termlist) 
	 (tag (adjoin-term term termlist))))

  (put 'add-terms '(dense dense)
       (lambda (L1 L2)
	 (tag (add-terms L1 L2))))

  (put 'sub-terms '(dense dense)
       (lambda (L1 L2)
	 (tag (sub-terms L1 L2))))

  (put 'negate-terms '(dense) 
       (lambda (terms)
	 (tag (negate-terms terms))))

  (put 'mul-terms '(dense dense)
       (lambda (L1 L2)
	 (tag (mul-terms L1 L2))))

  'done)

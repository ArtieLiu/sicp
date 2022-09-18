(define (install-itemlist-sparse-package)
  (define (tag itemlist)
    (cons 'sparse itemlist))

  (define (make-termlist itemlist) (list itemlist))
  (define (first-term itemlist)    (car itemlist))
  (define (rest-terms itemlist)    (cdr itemlist))

  (define (empty-termlist? termlist) (null? termlist))
  (define (the-empty-termlist) '())

  (define (make-term coeff order) (list coeff order))
  (define (coeff term) (car term))
  (define (order term) (cadr term))

  (define (adjoin-term term termlist) 
    (if (=zero? (coeff term))
      termlist
      (cons term termlist)))
  (define (=zero? coeff)
    (equal? coeff
	    (add coeff coeff)))

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

  (put 'make 'sparse 
       (lambda (itemlist) 
	 (tag itemlist)))

  (put 'adjoin 'sparse 
       (lambda (term termlist) 
	 (tag (adjoin-term term termlist))))

  (put 'add-terms '(sparse sparse)
       (lambda (L1 L2)
	 (tag (add-terms L1 L2))))

  'done)

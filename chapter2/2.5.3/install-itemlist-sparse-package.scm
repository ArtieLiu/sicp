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

  (put 'make 'sparse 
       (lambda (itemlist) 
	 (tag itemlist)))

  (put 'adjoin 'sparse 
       (lambda (term termlist) 
	 (tag (adjoin-term term termlist))))

  (put 'add-terms '(sparse sparse)
       (lambda (L1 L2)
	 (tag (add-terms L1 L2))))

  (put 'sub-terms '(sparse sparse)
       (lambda (L1 L2)
	 (tag (sub-terms L1 L2))))

  (put 'negate-terms '(sparse) 
       (lambda (terms)
	 (tag (negate-terms terms))))

  (put 'mul-terms '(sparse sparse)
       (lambda (L1 L2)
	 (tag (mul-terms L1 L2))))

  'done)

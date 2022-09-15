(define (install-itemlist-dense-package)

  (define (make-term coeff order) (list coeff order))
  (define (coeff term) (car term))
  (define (order term) (cadr term))

  (define (tag itemlist)
    (cons 'dense itemlist))

  (define (first-term L) 
    (let ((order (length (cdr L)))
	  (coeff (car L)))
      (list coeff order)))
  (define (rest-terms itemlist)    (cdr itemlist))


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

  (put 'make-term ' 
       (lambda (itemlist) 
	 (tag itemlist)))

  (put 'first-term '(dense)
       (lambda (termlist) 
	 (tag (first-term termlist))))

  (put 'rest-terms '(dense)
       (lambda (termlist) 
	 (tag (rest-terms termlist))))

  (put 'adjoin-term 'dense 
       (lambda (term termlist) 
	 (tag (adjoin-term term termlist))))

  'done)

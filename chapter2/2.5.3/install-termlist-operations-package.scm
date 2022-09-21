(load "install-itemlist-dense-package.scm")
(load "install-itemlist-sparse-package.scm")

(install-itemlist-dense-package)
(install-itemlist-sparse-package)

(define (install-termlist-operations-package)

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
      (the-empty-termlist terms)
      (let ((t (first-term terms)))
	(adjoin-term (negate-term t)
		     (negate-terms (rest-terms terms))))))

  (define (mul-terms L1 L2)
    (if (empty-termlist? L1)
      (the-empty-termlist L1)
      (add-terms 
	(mul-term-by-all-terms (first-term L1) L2)
	(mul-terms (rest-terms L1) L2))))

  (define (mul-term-by-all-terms term L)
    (if (empty-termlist? L)
      (the-empty-termlist L)
      (let ((t2 (first-term L)))
	(adjoin-term (make-term (mul (coeff term)
				     (coeff t2))
				(+ (order term)
				   (order t2)))
		     (mul-term-by-all-terms term 
					    (rest-terms L))))))

  (define (div-terms L1 L2)
    (if (empty-termlist? L1)
      (list (the-empty-termlist L1) (the-empty-termlist L2))
      (let ((t1 (first-term L1))
	    (t2 (first-term L2)))
	(if (> (order t2) (order t1))
	  (list (the-empty-termlist L1) L1)
	  (let ((new-c (/ (coeff t1) (coeff t2)))
		(new-o (- (order t1) (order t2))))
	    (let ((rest-of-result
		    (sub-terms L1
			       (mul-term-by-all-terms (make-term new-c new-o) L2))))
	      (list (adjoin-term (make-term new-c new-o)
				 (get-result (div-terms rest-of-result L2)))
		    (get-remainder (div-terms rest-of-result L2)))))))))

  
  (define get-result car)
  (define get-remainder cadr)

  (define (tag termlist)
    (cons 'termlist termlist))

  (put 'add-terms '(termlist termlist) (lambda (L1 L2) (tag (add-terms L1 L2))))
  (put 'sub-terms '(termlist termlist) (lambda (L1 L2) (tag (sub-terms L1 L2))))
  (put 'mul-terms '(termlist termlist) (lambda (L1 L2) (tag (mul-terms L1 L2))))
  (put 'div-terms '(termlist termlist) (lambda (L1 L2) (tag (div-terms L1 L2))))
  (put 'negate-terms '(termlist) (lambda (L1) (tag (negate-terms L1))))

  (put 'make 'termlist 
       (lambda (termlist)
	 (tag termlist)))
  'done)


(define (make-term coeff order) (apply-generic 'make-term coeff order))
(define (coeff term) (apply-generic 'coeff term))
(define (order term) (apply-generic 'order term))

(define (empty-termlist? L) (apply-generic 'empty-termlist? L))
(define (first-term L) (apply-generic 'first-term L))
(define (rest-terms L) (apply-generic 'rest-terms L))
(define (adjoin-term term termlist) (apply-generic 'adjoin-term term termlist))

(define (make-termlist termlist) ((get 'make 'termlist) termlist))

(define (the-empty-termlist termlist) 
  (apply-generic 'the-empty-termlist termlist))

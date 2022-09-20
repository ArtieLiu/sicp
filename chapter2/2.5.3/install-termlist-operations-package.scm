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

  (define (tag termlist)
    (cons 'termlist termlist))

  (put 'add-terms '(termlist termlist)
       (lambda (L1 L2)
	 (tag (add-terms L1 L2))))

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

(load "tag.scm")
(load "put-get.scm")

(load "install-itemlist-dense-package.scm")
(install-itemlist-dense-package)

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
	 (tag (add-terms L1 L2)))))


(define (make-term coeff order) (apply-generic 'make-term coeff order))
(define (coeff term) (apply-generic 'coeff term))
(define (order term) (apply-generic 'order term))

(define (empty-termlist? L) (apply-generic 'empty-termlist? L))
(define (first-term L) (apply-generic 'first-term L))
(define (rest-terms L) (apply-generic 'rest-terms L))
(define (adjoin-term term termlist) (apply-generic 'adjoin-term term termlist))


; ------------- testing ----------
(install-termlist-operations-package)

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	(apply proc (map contents args))
	(error
	  "No method for these types: 
	  APPLY-GENERIC"
	  (list op type-tags))))))
(define add +)

(define L0 (cons 'termlist (cons 'termlist-dense '())))
(define L1 (cons 'termlist (cons 'termlist-dense '(3 2 1 0))))
(define L2 (cons 'termlist (cons 'termlist-dense '(2 1 0))))

(apply-generic 'add-terms L0 L0)
(apply-generic 'add-terms L1 L0)
(apply-generic 'add-terms L1 L2)
(apply-generic 'add-terms L1 L1)
(apply-generic 'add-terms L2 L2)

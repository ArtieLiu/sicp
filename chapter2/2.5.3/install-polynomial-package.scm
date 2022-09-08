(define (install-polynomial-package)
  (define (make-poly variable term-list)
    (cons variable term-list))

  (define (variable p)  (car p))
  (define (term-list p) (cdr p))

  (define (same-variable? v1 v2) (eq? v1 v2))

  ;------------- terms --------------
  (define (make-term coeff order) (list coeff order))
  (define (order term) (cadr term))
  (define (coeff term) (car term))

  (define (first-term termlist) (car termlist))
  (define (rest-terms termlist) (cdr termlist))

  (define (empty-termlist? termlist) (null? termlist))
  (define (the-empty-termlist) '())

  (define (adjoin-term term termlist) 
    (if (=zero? (coeff term))
      term-list
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

  (define (mul-terms L1 L2)
    (if (empty-termlist? L1)
      (the-empty-termlist)
      (add-terms 
	(mul-term-by-all-terms (first-term L1) L2)
	(mul-terms (rest-terms L1) L2))))

  (define (mul-term-by-all-terms t1 L)
    (if (empty-termlist? L)
      (the-empty-termlist)
      (let ((t2 (first-term L)))
	(adjoin-term (make-term (mul (coeff t1) (coeff t2))
				(+ (order t1) (order t2)))
		     (mul-term-by-all-terms t1 
					    (rest-terms L))))))
  ;-------------------------------

  (define (add-poly p1 p2)
    (if (same-variable? (variable p1)
			(variable p2))
      (make-poly (variable p1)
		 (add-terms (term-list p1)
			    (term-list p2)))
      (error "Polys not in same var: ADD-POLY" (list p1 p2))))

  (define (sub-poly p1 p2)
    (add-poly p1
	      (negate p2)))

  (define (negate p)
    (make-poly (variable p)
	       (negate-terms (term-list p))))

  (define (negate-terms terms)
    (if (empty-termlist? terms)
      (the-empty-termlist)
      (let ((t (first-term terms)))
	(adjoin-term (negate-term t)
		     (negate-terms (rest-terms terms))))))

  (define (negate-term t)
    (make-term (- (coeff t))
	       (order t)))

  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1)
			(variable p2))
      (make-poly (variable p1)
		 (mul-terms (term-list p1)
			    (term-list p2)))
      (error "Polys not in same var: MUL-POLY" (list p1 p2))))

  ;; interface to rest of the system
  (define (tag p) (attach-tag 'polynomial p))

  (put 'add  '(polynomial polynomial) (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put 'sub  '(polynomial polynomial) (lambda (p1 p2) (tag (sub-poly p1 p2))))
  (put 'mul  '(polynomial polynomial) (lambda (p1 p2) (tag (mul-poly p1 p2))))
  (put 'negate '(polynomial) (lambda (p) (tag (negate p))))

  (put 'make 'polynomial              (lambda (var terms) (tag (make-poly var terms))))

  'done)

(define (make-polynomial var terms) 
  ((get 'make 'polynomial) var terms))


; example: 
; (define p1 (make-polynomial 'x (list '(2 2) '(1 1)))) 

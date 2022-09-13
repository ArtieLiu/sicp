(load "put-get.scm")
(load "tag.scm")

(load "install-itemlist-sparse-package.scm")
(load "install-itemlist-dense-package.scm")

(install-itemlist-sparse-package)
(install-itemlist-dense-package)

(define (install-polynomial-package)

  (define (make-poly var terms) (cons var terms))
  (define (variable p) (car p))
  (define (term-list p) (cdr p))
  (define (same-variable? v1 v2) (equal? v1 v2))

  (define (add-poly p1 p2)
    (if (same-variable? (variable p1)
			(variable p2))
      (make-poly (variable p1)
		 (add-terms (term-list p1)
			    (term-list p2)))
      (error "Polys not in same var: ADD-POLY" (list p1 p2))))

  (define (sub-poly p1 p2)
    (if (same-variable? (variable p1)
			(variable p2))
      (make-poly (variable p1)
		 (sub-terms (term-list p1)
			    (term-list p2)))
      (error "Polys not in same var: SUB-POLY" (list p1 p2))))

  (define (negate-poly p)
    (make-poly (variable p)
	       (negate-terms (term-list p))))

  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1)
			(variable p2))
      (make-poly (variable p1)
		 (mul-terms (term-list p1)
			    (term-list p2)))
      (error "Polys not in same var: MUL-POLY" (list p1 p2))))

  (define (tag poly) (cons 'polynomial poly))

  (put 'add  '(polynomial polynomial) (lambda (p1  p2)    (tag (add-poly p1 p2))))
  (put 'sub  '(polynomial polynomial) (lambda (p1  p2)    (tag (sub-poly p1 p2))))
  (put 'mul  '(polynomial polynomial) (lambda (p1  p2)    (tag (mul-poly p1 p2))))
  (put 'make 'polynomial-sparse       (lambda (var terms) (tag (make-poly var terms))))
  (put 'make 'polynomial-dense        (lambda (var terms) (tag (make-poly var terms))))

  'done)

(define (add-terms termlist1 termlist2)
  (apply-generic 'add-terms termlist1 termlist2))

(define (sub-terms termlist1 termlist2)
  (apply-generic 'sub-terms termlist1 termlist2))

(define (negate-terms terms)
  (apply-generic 'negate-terms terms))

(define (mul-terms termlist1 termlist2)
  (apply-generic 'mul-terms termlist1 termlist2))

(define (make-sparse-polynomial var sparse-items)
  ((get 'make 'polynomial-sparse) var 
				  ((get 'make 'sparse) sparse-items)))

(define (make-dense-polynomial var dense-items)
  ((get 'make 'polynomial-dense) var 
				 ((get 'make 'dense) dense-items)))

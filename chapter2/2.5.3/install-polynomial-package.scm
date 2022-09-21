(load "install-termlist-operations-package.scm")

(install-termlist-operations-package)

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

  (define (div-poly p1 p2)
    (if (same-variable? (variable p1)
			(variable p2))
      (make-poly (variable p1)
		 (div-terms (term-list p1)
			    (term-list p2)))
      (error "Polys not in same var: DIV-POLY" (list p1 p2))))

  (define (tag poly) (cons 'polynomial poly))

  (put 'add  '(polynomial polynomial) (lambda (p1  p2)    (tag (add-poly p1 p2))))
  (put 'sub  '(polynomial polynomial) (lambda (p1  p2)    (tag (sub-poly p1 p2))))
  (put 'mul  '(polynomial polynomial) (lambda (p1  p2)    (tag (mul-poly p1 p2))))
  (put 'div  '(polynomial polynomial) (lambda (p1  p2)    (tag (div-poly p1 p2))))
  (put 'make 'polynomial              (lambda (var terms) (tag (make-poly var terms))))

  'done)

(define (add-terms termlist1 termlist2) (apply-generic 'add-terms termlist1 termlist2))
(define (sub-terms termlist1 termlist2) (apply-generic 'sub-terms termlist1 termlist2))
(define (mul-terms termlist1 termlist2) (apply-generic 'mul-terms termlist1 termlist2))
(define (div-terms termlist1 termlist2) (apply-generic 'div-terms termlist1 termlist2))

(define (make-polynomial var termlist)
  ((get 'make 'polynomial) var termlist))

(define (make-sparse-polynomial var sparse-termlist) 
  (make-polynomial var (make-termlist (make-termlist-sparse sparse-termlist))))

(define (make-dense-polynomial var dense-termlist) 
  (make-polynomial var (make-termlist (make-termlist-dense dense-termlist))))

(load "put-get.scm")
(load "tag.scm")

(load "install-sparse-itemlist-package")
(load "install-scheme-number-package.scm" )

(install-scheme-number-package)
(install-sparse-itemlist-package)

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


  (define (tag poly) (cons 'polynomial poly))

  (put 'add  '(polynomial polynomial) (lambda (p1  p2)    (tag (add-poly p1 p2))))
  (put 'make 'polynomial-sparse       (lambda (var terms) (tag (make-poly var terms))))

  'done)

(define (add-terms termlist1 termlist2)
  (apply-generic 'add-terms termlist1 termlist2))

(define (make-sparse-polynomial var sparse-items) 
  ((get 'make 'polynomial-sparse) var sparse-items))

(define (make-dense-polynomial var dense-items)
  ((get 'make 'polynomial-dense) var dense-items))


;------------- testing --------------
(install-polynomial-package)

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	(apply proc (map contents args))
	(error
	  "No method for these types: 
	  APPLY-GENERIC"
	  (list op type-tags))))))

(define (add x y) (apply-generic 'add x y))
;-------------  --------------

(define make-sparse (get 'make 'sparse))
(define L1 (make-sparse '((100 100) (10 10))))
(define L2 (make-sparse '((1 1))))
(apply-generic 'add-terms L1 L2)

(define P1 (make-sparse-polynomial 'x L1)) 
(define P2 (make-sparse-polynomial 'x L2)) 
(add P1 P2)
(add P1 P1)

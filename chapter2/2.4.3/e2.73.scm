(define get 2d-get)
(define put 2d-put!)

(define (deriv exp var)
  (cond ((number? exp) 0)
	((variable? exp) 
	 (if (same-variable? exp var) 
	   1 
	   0))
	(else ((get 'deriv (operator exp)) 
	       (operands exp) 
	       var))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
(define (variable? exp) (symbol? exp))
(define (same-variable? exp var) (eq? exp var))

; Question1:
; Explain what was done above. Why can’t we assimilate the predicates number? and variable? into the data-directed dispatch?

; A: if so, we will have the following code:
; (get 'number? exp)
; in order for this to work, for every possible expression, 
; there should be a corresponding exp in the table,
; this is not possible


; Question2:
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

(define (install-derivative-package)

  (define (sum-deriv exp var)
    (make-sum (deriv (addend exp) var)
	      (deriv (augend exp) var)))

  (define (addend exp) (car exp))
  (define (augend exp) (cadr exp))

  (define (prod-deriv exp var)
    (make-sum
      (make-product 
	(multiplier exp)
	(deriv (multiplicand exp) var))
      (make-product 
	(deriv (multiplier exp) var)
	(multiplicand exp))))

  (define (multiplier exp) (cadr exp))
  (define (multiplicand exp) (cddr exp))

  (define (make-sum a1 a2)
    (cond ((= a1 0) a2)
	  ((= a2 0) a1)
	  ((and (number? a1) (number? a2))
	   (+ a1 a2))
	  (else (list a1 '+ a2))))

  (define (make-product a1 a2)
    (cond 
      ((=number? a1 0) 0)
      ((=number? a2 0) 0)
      ((=number? a1 1) a2)
      ((=number? a2 1) a1)
      ((and (number? a1) (number? a2)) (* a1 a2))
      (else (list '* a1 a2))))
  (put 'deriv '* prod-deriv)
  (put 'deriv '+ sum-deriv)

  'done)

(install-derivative-package)

(deriv '(+ 1 1) 'x)
(deriv '(+ 1 x) 'x)

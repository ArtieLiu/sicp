(define (deriv exp var)
  (cond ((number? exp) 0)
	((variable? exp) 
	 (if (same-variable? exp var) 
	   1 
	   0))
	((sum? exp)
	 (make-sum (deriv (addend exp) var)
		   (deriv (augend exp) var)))
	(else (display "something goes wrong"))))

(define (sum? exp) (eq? '+ (car exp)))
(define (variable? exp) (symbol? exp))

(define (same-variable? exp var) (eq? exp var))
(define (addend exp) (car exp))
(define (augend exp) (cadr exp))

(define (make-sum a1 a2)
  (list '+ a1 a2))

(define (sum-deriv exp var)
  (make-sum (deriv (addend exp) var)
	    (deriv (augend exp) var)))

(list '+ 1 1 1)
(deriv '(+ 1 1 1) 'x)

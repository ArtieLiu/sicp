(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) 
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum 
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (multiplicand exp)
                         (deriv (multiplier exp) var))))
        ((exponentiation? exp)
         (make-product 
           (make-product (exponent exp)
                         (deriv (base exp) var))
           (make-exponentiation (base exp)
                                (- (exponent exp) 1))))
        (else (error "unknown expression type -- DERIV" exp))))

(deriv '(** x 0) 'x)
(deriv '(** x 1) 'x)
(deriv '(** x 2) 'x)

; ------------ exponent ------------
(define (exponentiation? exp)
  (and (pair? exp)
       (eq? '** (car exp))))

(define base cadr)
(define exponent caddr )

(define (make-exponentiation base exponent)
  (cond ((= 0 exponent) 1)
        ((= 1 exponent) base)
        (else (list '** base exponent))))


; ------------ utils ----------
(define variable? symbol?)

(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2))
         (+ a1 a2))
        (else (list '+ a1 a2))))

(define (make-product a1 a2)
  (cond 
    ((=number? a1 0) 0)
    ((=number? a2 0) 0)
    ((=number? a1 1) a2)
    ((=number? a2 1) a1)
    ((and (number? a1) (number? a2)) (* a1 a2))
    (else (list '* a1 a2))))

(define (sum? exp)
  (and (pair? exp) 
       (eq? '+ (car exp))))

(define addend cadr)
(define augend caddr)

(define (product? x)
  (and (pair? x)
       (eq? (car x) '*)))

(define multiplier cadr)
(define multiplicand caddr)

(define (=number? a1 a2)
  (and (number? a1) (eq? a1 a2)))
; ------------------------------------------

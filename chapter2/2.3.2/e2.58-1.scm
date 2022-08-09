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
        (else (error "unknown expression type -- DERIV" exp))))

(deriv '(x * y) 'x)
(deriv '((x + 3) + (x * y)) 'x)

; ============ utils ==========
(define (=number? a1 a2)
  (and (number? a1) (eq? a1 a2)))

(define variable? symbol?)

; --------- sum --------------
(define (sum? exp)
  (and (pair? exp) 
       (eq? '+ (cadr exp))))
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2))
         (+ a1 a2))
        (else (list a1 '+ a2))))

(define addend car)
(define augend caddr)

; tests
(car '(1 + 2))
(cadr '(1 + 2))
(caddr '(1 + 2))

(sum? '(1 + 2))
(sum? '((1 + 2) + 3))
(sum? '((1 + 2) + (3 + 4)))

(deriv '(x + 1) 'x)
(deriv '((x + 2) + 1) 'x)
(deriv '((x + 2) + (x + 1)) 'x)
; -----------------------------

; -------- prd ----------------
(define (product? x)
  (and (pair? x)
       (eq? '* (cadr x))))

(define multiplier car)
(define multiplicand caddr)

(define (make-product a1 a2)
  (cond 
    ((=number? a1 0) 0)
    ((=number? a2 0) 0)
    ((=number? a1 1) a2)
    ((=number? a2 1) a1)
    ((and (number? a1) (number? a2)) (* a1 a2))
    (else (list a1 '* a2))))

(car '(1 * 2))
(cadr '(1 * 2))
(caddr '(1 * 2))

(product? '(1 * 2))
(product? '((1 * 2) * 3))
(product? '((1 + 2) * (3 * 4)))

(deriv '(x * 1) 'x)
(deriv '((x * 2) * 1) 'x)
(deriv '((x * 2) * (x * 1)) 'x)
; -----------------------------

(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))


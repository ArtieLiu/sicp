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
(deriv '(x + 3 * (x + y + 2)) 'x)
(deriv '(1 + x + 3 * y + 4 * ( x + (2 * x))) 'x)
(deriv '(x * x * x) 'x)

; ============ utils ==========
(define (=number? a1 a2)
  (and (number? a1) (eq? a1 a2)))

(define variable? symbol?)

; --------- sum --------------
(define (sum? exp)
  (and (pair? exp) 
       (has+? exp)))

(define (has+? exp)
  (if (null? exp) 
    #f
    (or (eq? '+ (car exp))
        (has+? (cdr exp)))))
(sum? '(1 + 2 * 3))
(sum? '(1 + (2 * 3)))
(sum? '(1 * (2 * 3)))
(sum? '(1 * (2 + 3)))
(sum? '(x + 3 * (x + y + 2)))

(define addend car)
(addend '(x + 3 * (x + y + 2)))
(addend '((x + 2) + 3 * (x + y + 2)))

(define (augend exp)
  (let ((right+ (cdr (cdr exp))))
    (if (= 1 (length right+))
      (car right+)
      right+)))
(augend '(x + 3))
(augend '(x + 3 * (x + y + 2)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2))
         (+ a1 a2))
        (else (list a1 '+ a2))))

; tests
(deriv '(x + 1) 'x)
(deriv '((x + 2) + 1) 'x)
(deriv '((x + 2) + (x + 1)) 'x)
(deriv '(x + x) 'x)
(deriv '(x + x + x) 'x)
(deriv '(x + x + (x + x)) 'x)
(deriv '((x + x) + (x + x)) 'x)
; -----------------------------

; -------- prd ----------------
(define (product? exp)
  (and (pair? exp)
       (has-only* exp)))

(define (has-only* exp)
  (cond ((null? exp) #t)
        ((eq? '+ (car exp)) #f)
        (else (has-only* (cdr exp)))))
(product? '(2 * 3))
(product? '(2 * (1 + 3)))
(product? '(2 * 1 + 3))
(product? '(2 * 1 + 3 * 4))
(product? '((2 * 1) + (3 * 4)))
(product? '((2 * 1) * (3 * 4)))

(define multiplier car)

(define (multiplicand exp)
  (let ((remaining (cdr (cdr exp))))
    (if (= 1 (length remaining))
      (car remaining)
      remaining)))
(multiplicand '(2 * 3))
(multiplicand '(2 * (1 + 3)))
(multiplicand '((2 * 1) * (3 * 4)))


(define (make-product a1 a2)
  (cond 
    ((=number? a1 0) 0)
    ((=number? a2 0) 0)
    ((=number? a1 1) a2)
    ((=number? a2 1) a1)
    ((and (number? a1) (number? a2)) (* a1 a2))
    (else (list a1 '* a2))))


(deriv '(x * 1) 'x)
(deriv '((x * 2) * 1) 'x)
(deriv '((x * 2) * (x * 1)) 'x)
; -----------------------------

(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))


(define (scheme-number->scheme-number n) n)
(define (complex->complex z) z)

(put-coercion 'scheme-number 'scheme-number
              scheme-number->scheme-number)

(put-coercion 'complex 'complex 
	      complex->complex)

;------------- question 1 --------------
(define (exp x y)
  (apply-generic 'exp x y))

(define z1 (make-complex ...))
(define z2 (make-complex ...))

(apply-generic 'exp z1 z2)

proc -> (get 'exp '(complex complex)) ; returns nothing
type1 -> 'complex
type2 -> 'complex
a1 -> z1
a2 -> z2

t1->t2 (get-coercion 'complex 'complex)
(t1->t2 a1) -> z1
(t2->t1 a2) -> z1

(apply-generic op (t1->t2 a1) a2) -> (apply-generic op a1 a2)
(apply-generic op a1 (t2->t1 a2)) -> (apply-generic op a1 a2)

result: infinite recursion
;-------------------------------

;------------- question 2 --------------
If passed in two arguments of the same type but the type does not exist, apply-generic will try to coerce the types. 
;-------------------------------

;------------- question 3 --------------
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	(apply proc (map contents args))
	(if (= (length args) 2)
	  (let ((type1 (car type-tags))
		(type2 (cadr type-tags))
		(a1 (car args))
		(a2 (cadr args)))
	    (if (equal? type1 type2)
	      (error "No method for these types" 
		     (list op type-tags))
	      (let ((t1->t2 (get-coercion type1 type2))
		    (t2->t1 (get-coercion type2 type1)))
		(cond (t1->t2 (apply-generic op (t1->t2 a1) a2))
		      (t2->t1 (apply-generic op a1 (t2->t1 a2)))
		      (else
			(error 
			  "No method for these types" (list op type-tags)))))))
	  (error 
	    "No method for these types" (list op type-tags)))))))

two cases:
	1. if the type is known, then it should be found
	2. if the type is unknow, no need to try coercion
;-------------------------------

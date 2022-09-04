(load "put-get.scm")
(load "tag.scm")

(load "install-scheme-number-package.scm")
(load "install-rational-package.scm")
(load "install-complex-package.scm")
(load "install-equ?-package.scm")
(load "install-=zero?-package.scm")

(install-complex-package)
(install-rational-package)
(install-scheme-number-package)
(install-equ?-package)
(install-=zero?-package)

; Show how to generalize apply-generic to handle coercion in the general case of multiple arguments. 
; One strategy is to attempt to coerce all the arguments to the type of the first argument, then to the type of the second argument, and so on. 
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
	    (let ((t1->t2 (get-coercion type1 type2))
		  (t2->t1 (get-coercion type2 type1)))
	      (cond (t1->t2 (apply-generic op (t1->t2 a1) a2))
		    (t2->t1 (apply-generic op a1 (t2->t1 a2)))
		    (else
		      (error 
			"No method for these types" (list op type-tags))))))
	    (error 
	      "No method for these types" (list op type-tags)))))))

;------------- utilities --------------
(define (get-coercion type1 type2) 

  (define (rational->complex r)
    (let ((num&denom (contents r)))
      (let ((num (car num&denom))
	    (denom (cdr num&denom)))
	(make-complex-from-real-imag (/ num denom) 0))))

  (define (number->complex n)
    (let ((number (contents n)))
      (make-complex-from-real-imag number 0)))
  ; (rational->complex (make-rational 1 2))
  ; (number->complex (make-scheme-number 1))

  (cond 
    ((and (eq? type1 'rational) (eq? type2 'complex)) rational->complex)
    ((and (eq? type1 'scheme-number) (eq? type2 'complex)) number->complex)
    (else #f)))
;-------------------------------

(define (apply-generic-multi op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	(apply proc (map contents args))
	(let ((args-of-unified-type (unify-types args)))
	  (if (null? args-of-unified-type)
	    (error "no method found")
	    (display "successfully converted")))))))

;------------- unify --------------
(define (unify-types args)
  (unify args (map type-tag args)))

(define (unify args types)
  (if (null? types) 
    '()
    (let ((converted (convert-args-to-type args (car types))))
      (if (null? converted)
	(unify args (cdr types))
	(cons converted 
	      (unify args (cdr types)))))))

(define (convert-args-to-type args type)
  (define (convert-arg-to-type type)
    (lambda (arg)
      (if (eq? (type-tag arg) type)
	arg
	(let ((proc (get-coercion (type-tag arg) type)))
	  (if proc
	    (proc arg)
	    #f)))))
  (let ((converted-args (map (convert-arg-to-type type) args)))
    (if (ok? converted-args)
      converted-args
      '())))

(define (ok? l)
  (cond ((null? l) #t)
	((eq? #f (car l)) #f)
	(else (ok? (cdr l)))))

;------------- testing --------------
(define z (make-complex-from-real-imag 1 1))
(define n (make-scheme-number 1))
(define r (make-rational 1 2))

(convert-args-to-type (list z n) 'complex)

(define types (map type-tag (list z n)))
(unify-types (list z n))
(unify (list z n) '(complex scheme-number))

(unify-types (list r r z))
(unify-types (list r '(unknown 123) z))
; ----------------------------------- 

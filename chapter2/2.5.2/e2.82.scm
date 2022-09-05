(load "put-get.scm")
(load "tag.scm")
(load "coercion.scm")

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

;------------- apply-generic --------------
(define (apply-generic op . args)
  (let ((args-of-unified-type (unify-types args)))
    (if (null? args-of-unified-type)
      (error "cannot unify types of the arguments")
      (let ((type-tags (map type-tag args-of-unified-type)))
	(let ((proc (get op type-tags)))
	  (if proc
	    (apply proc (map contents args-of-unified-type))
	    (error "no operation found for type-tags: " type-tags)))))))

;------------- unify types --------------
(define (unify-types args)
  (unify args 
	 (remove-duplicates (map type-tag args))))

(define (unify args types)
  (if (null? types) 
    '()
    (let ((converted (convert-args-to-type args (car types))))
      (if (null? converted)
	(unify args (cdr types))
	converted))))

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

;------------- remove duplicates --------------
(define (remove-duplicates l)
  (define (in? a lat)
    (cond ((null? lat) #f)
	  ((eq? a (car lat)) #t)
	  (else (in? a (cdr lat)))))
  (cond ((null? l) '())
	((in? (car l) (cdr l)) (remove-duplicates (cdr l)))
	(else (cons (car l) 
		    (remove-duplicates (cdr l))))))
;-------------------------------

;------------- testing --------------
(define z (make-complex-from-real-imag 1 1))
(define n (make-scheme-number 1))
(define r (make-rational 1 2))

(apply-generic 'add z r r)
(apply-generic 'add n n )
(apply-generic 'add n r )
(apply-generic 'add n z )
(apply-generic 'add z z )
; ----------------------------------- 

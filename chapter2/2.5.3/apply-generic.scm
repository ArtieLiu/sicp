(load "tag.scm")
(load "put-get.scm")
(load "install-polynomial-package.scm")
(load "install-scheme-number-package.scm")

(install-polynomial-package)
(install-scheme-number-package)

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
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
(define (negate x) (apply-generic 'negate x))

;------------- testing --------------
(define make-dense-polynomial (get 'make 'polynomial-dense))
(define make-dense            (get 'make 'dense))

(define P-dense1 (make-sparse-polynomial 'x (make-dense '(3 2 1 0))))

(add P-dense1 P-dense1)

(define make-sparse-polynomial (get 'make 'polynomial-sparse))
(define make-sparse            (get 'make 'sparse))

(define P-sparse1 (make-sparse-polynomial 'x 
					  (make-sparse '((100 100) (10 10)))))
(add P-sparse1 P-sparse1)

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
(define (negate x) (apply-generic 'negate x))


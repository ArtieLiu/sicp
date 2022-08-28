(load "put-get.scm")
(load "tag.scm")

(load "install-scheme-number-package.scm")
(load "install-rational-package.scm")
(load "install-complex-package.scm")


(install-complex-package)
(install-rational-package)
(install-scheme-number-package)

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	(apply proc (map contents args))
	(error "No method for these types: APPLY-GENERIC" (list op type-tags))))))

(define a (make-scheme-number 1))

(add a a)
(map type-tag (list a a))
(get 'add (map type-tag (list a a)))
(get 'add '(scheme-number scheme-number))


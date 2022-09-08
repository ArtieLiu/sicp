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
(make-polynomial 'x (list '(2 2) '(1 1)))
(define l2 (list '(1 2) '(2 4)))

(define p1 (make-polynomial 'x (list '(2 2) '(1 1))))
(define p2 (make-polynomial 'x (list '(3 3) '(2 2))))

(add p1 p2)
(mul p1 p2)

(define py (make-polynomial 'y (list '(1 1))))
(define px (make-polynomial 'x (list '(1 1))))
(define phybrid (make-polynomial 'x (list (list py 1))))

(add phybrid phybrid)
(add px phybrid)
(add py phybrid)

(negate p1)

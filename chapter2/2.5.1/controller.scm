(load "put-get.scm")
(load "tag.scm")

(load "install-scheme-number-package.scm")
(load "install-rational-package.scm")
(load "install-complex-package.scm")
(load "install-equ?-package.scm")

(install-complex-package)
(install-rational-package)
(install-scheme-number-package)
(install-equ?-package)

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
(define (equ? x y) (apply-generic 'equ? x y))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	(apply proc (map contents args))
	(error "No method for these types: APPLY-GENERIC" (list op type-tags))))))

;------------- scheme number --------------
(define a (make-scheme-number 1))
(add a a)
;-------------------------------

;------------- complex number --------------
(define z1 (make-complex-from-real-imag 1 0))
(define z2 (make-complex-from-mag-ang 1 0))

(magnitude z1)
(magnitude z2)
;-------------------------------

;------------- equ? --------------
(equ? z1 z2)
(equ? z1 z1)

(define a (make-scheme-number 1))
(define b (make-scheme-number 2))

(equ? b a)
(equ? a a)

(define r1 (make-rational 1 2))
(define r2 (make-rational 2 4))
(define r3 (make-rational 1 3))
(equ? r1 r2)
(equ? r1 r3)
;-------------------------------


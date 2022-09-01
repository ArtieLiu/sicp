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

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
(define (equ? x y) (apply-generic 'equ? x y))
(define (=zero? x) (apply-generic '=zero? x))

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

;------------- rational number --------------
(define r1 (make-rational 1 1))
(define r2 (make-rational 2 1))
(sub r1 r2)
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

;------------- =zero? --------------
(define z-rect (make-complex-from-real-imag 1 0))
(define z-angu (make-complex-from-mag-ang 1 0))
(define n (make-scheme-number 1))
(define r (make-rational 1 1))
(=zero? z-rect)
(=zero? z-angu)
(=zero? n)
(=zero? r)

(define z-rect-0 (make-complex-from-real-imag 0 0))
(define z-angu-0 (make-complex-from-mag-ang 0 0))
(define n-0 (make-scheme-number 0))
(define r-0 (make-rational 0 3))
(=zero? z-rect-0)
(=zero? z-angu-0)
(=zero? n-0)
(=zero? r-0)
;-------------------------------

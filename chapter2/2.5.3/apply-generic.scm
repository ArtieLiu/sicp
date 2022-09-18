; (load "tag.scm")
; (load "put-get.scm")
; (load "install-polynomial-package.scm")
; (load "install-scheme-number-package.scm")

; (install-polynomial-package)
; (install-scheme-number-package)

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

;;------------- testing --------------
;(define P-dense (make-dense-polynomial 'x '(3 2 1 0)))
;(add P-dense P-dense)
;(sub P-dense P-dense)
;(mul P-dense P-dense)

;(define P-sparse (make-sparse-polynomial 'x '((100 100) (10 10))))
;(define P-sparse1 (make-sparse-polynomial 'x '((100 100) (1 1))))
;(add P-sparse P-sparse1)
;(sub P-sparse P-sparse1)
;(mul P-sparse P-sparse)

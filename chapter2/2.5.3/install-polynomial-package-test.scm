(load "tag.scm")
(load "put-get.scm")

(load "install-polynomial-package.scm")
(install-polynomial-package)

; ----------------- testing ----------------- 

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	(apply proc (map contents args))
	(error
	  "No method for these types: 
	  APPLY-GENERIC"
	  (list op type-tags))))))


(define ls1 (make-sparse-polynomial 'x '((2 2) (1 1))))
(define ls2 (make-sparse-polynomial 'x '((1 1))))
(apply-generic 'add ls1 ls2)
(apply-generic 'sub ls1 ls2)


(define ld1 (make-dense-polynomial 'x '(2 1 0)))
(define ld2 (make-dense-polynomial 'x '(1 0)))

(apply-generic 'add ld1 ld2)
(apply-generic 'sub ld1 ld2)

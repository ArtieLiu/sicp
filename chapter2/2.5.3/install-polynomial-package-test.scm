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


(define l1 (make-sparse-polynomial 'x '((2 2) (1 1))))
(apply-generic 'add l1 l1)


(define l2 (make-dense-polynomial 'x '(2 1 0)))
(display l2)
(apply-generic 'add l2 l2)

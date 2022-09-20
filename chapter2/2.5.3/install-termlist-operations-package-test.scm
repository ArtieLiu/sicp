(load "put-get.scm")
(load "tag.scm")

(load "install-termlist-operations-package.scm")

(install-termlist-operations-package)

(define (apply-generic op . args)
  (display op) (newline)
  (display args) (newline)
  (newline)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	(apply proc (map contents args))
	(error
	  "No method for these types: 
	  APPLY-GENERIC"
	  (list op type-tags))))))

(define add +)

; ----------------- sparse ----------------- 
(define L0 (make-termlist (make-termlist-sparse '())))
(define L1 (make-termlist (make-termlist-sparse '((2 2)(0 0)))))
(define L2 (make-termlist (make-termlist-sparse '((3 3)))))

(apply-generic 'add-terms L0 L0)
(apply-generic 'add-terms L1 L0)
(apply-generic 'add-terms L1 L1)
(apply-generic 'add-terms L1 L2)
(apply-generic 'add-terms L2 L2)

; ----------------- dense ----------------- 
(define L3 (make-termlist (make-termlist-dense '())))
(define L4 (make-termlist (make-termlist-dense '(1))))
(define L5 (make-termlist (make-termlist-dense '(2 1 0))))

(apply-generic 'add-terms L3 L3)
(apply-generic 'add-terms L4 L3)
(apply-generic 'add-terms L4 L4)
(apply-generic 'add-terms L4 L5)
(apply-generic 'add-terms L5 L5)

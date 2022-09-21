(load "put-get.scm")
(load "tag.scm")

(load "install-termlist-operations-package.scm")

(install-termlist-operations-package)

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	(apply proc (map contents args))
	(error
	  "No method for these types: 
	  APPLY-GENERIC"
	  (list op type-tags))))))

(define add +)
(define mul *)
(define sub -)

; ----------------- sparse ----------------- 
(define L0 (make-termlist (make-termlist-sparse '())))
(define L1 (make-termlist (make-termlist-sparse '((2 2)(0 0)))))
(define L2 (make-termlist (make-termlist-sparse '((3 3)))))

(apply-generic 'add-terms L0 L0)
(apply-generic 'add-terms L1 L0)
(apply-generic 'add-terms L1 L1)
(apply-generic 'add-terms L1 L2)
(apply-generic 'add-terms L2 L2)

(apply-generic 'negate-terms L1)

(apply-generic 'sub-terms L0 L0)
(apply-generic 'sub-terms L1 L0)
(apply-generic 'sub-terms L1 L1)
(apply-generic 'sub-terms L1 L2)
(apply-generic 'sub-terms L2 L2)

(apply-generic 'mul-terms L1 L2)
(apply-generic 'mul-terms L2 L2)

(define Ls1 (make-termlist (make-termlist-sparse '((1 5) (-1 0)))))
(define Ls2 (make-termlist (make-termlist-sparse '((1 2) (-1 0)))))
(apply-generic 'div-terms Ls1 Ls2)

; ----------------- dense ----------------- 
(define L3 (make-termlist (make-termlist-dense '())))
(define L4 (make-termlist (make-termlist-dense '(1))))
(define L5 (make-termlist (make-termlist-dense '(2 1 0))))

(apply-generic 'add-terms L3 L3)
(apply-generic 'add-terms L4 L3)
(apply-generic 'add-terms L4 L4)
(apply-generic 'add-terms L4 L5)
(apply-generic 'add-terms L5 L5)

(apply-generic 'negate-terms L5)

(apply-generic 'sub-terms L3 L3)
(apply-generic 'sub-terms L4 L3)
(apply-generic 'sub-terms L4 L4)
(apply-generic 'sub-terms L4 L5)
(apply-generic 'sub-terms L5 L5)

(apply-generic 'mul-terms L4 L5)
(apply-generic 'mul-terms L5 L5)

(define Ldn (make-termlist (make-termlist-dense '(1 0 0 0 0 -1))))
(define Ldd (make-termlist (make-termlist-dense '(1 0 -1))))
(apply-generic 'div-terms Ldn Ldd)

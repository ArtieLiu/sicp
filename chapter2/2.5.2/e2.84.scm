(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	(apply proc (map contents args))
	(if (= (length args) 2)
	  (apply-generic op (match-levels args))
	  (error 
	    "No method for these types" (list op type-tags)))))))

(define (match-levels a1 a2)
  (cond ((on-same-level? a1 a2) (list a1 a2))
	((is-higher? a1 a2) (match-levels a1 (raise a2)))
	((is-lower? a1 a2) (match-levels (raise a1) a2))
	(else (error "unkown type"))))

(define (on-same-level? a1 a2)
  (let ((type1 (type-tag a1))
	(type2 (type-tag a2)))
    (eq? type1 type2)))

; suppose we have a table that stores the order of a type, like the following:
;      complex       1
;      real          2
;      rational      3
;      scheme-number 4
(define (is-higher? a1 a2)
  (let ((order1 (get-order (type-tag a1)))
	(order2 (get-order (type-tag a2))))
    (> order1 order2)))

(define (is-lower? a1 a2)
  (let ((order1 (get-order (type-tag a1)))
	(order2 (get-order (type-tag a2))))
    (< order1 order2)))

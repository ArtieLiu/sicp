(define (install-itemlist-dense-package)

  (define (make-termlist itemlist) (list itemlist))
  (define (first-term L) 
    (let ((order (length (cdr L)))
	  (coeff (car L)))
      (list coeff order)))
  (define (rest-terms itemlist)    (cdr itemlist))

  (define (empty-termlist? L) (null? L))

  (define (make-term coeff order) (list coeff order))
  (define (coeff term) (car term))
  (define (order term) (cadr term))

  (define (adjoin-term compact-term termlist)
    (if (null? termlist) 
      (expand compact-term)
      (let ((o1 (order compact-term))
	    (o2 (order (first-term termlist))))
	(cond ((= o1 o2)
	       (cons (add (coeff compact-term)
			  (coeff (first-term termlist)))
		     (cdr termlist)))
	      ((< o1 o2)
	       (cons (coeff (first-term termlist))
		     (adjoin-term compact-term
				  (cdr termlist))))
	      ((> o1 o2)
	       (adjoin-term compact-term
			    (raise-order termlist)))))))

  (define (raise-order termlist)
    (cons 0 termlist))

  (define (expand compact-term)
    (define (zeros-of-order order)
      (if (= 0 order)
	'()
	(cons 0 (zeros-of-order (- order 1)))))
    (let ((order (order compact-term))
	  (coeff (coeff compact-term)))
      (cons coeff
	    (zeros-of-order order))))

  (define (tag-list termlist) (cons 'termlist-dense termlist))
  (define (tag-term term) (cons 'term term))

  (put 'adjoin-term '(term termlist-dense)
       (lambda (term termlist) 
	 (tag-list (adjoin-term term termlist))))

  (put 'empty-termlist? '(termlist-dense)
       (lambda (L)
	 (empty-termlist? L)))

  (put 'rest-terms '(termlist-dense)
       (lambda (termlist)
	 (tag-list (rest-terms termlist))))

  (put 'first-term '(termlist-dense)
       (lambda (termlist)
	 (tag-term (first-term termlist))))

  (put 'make-term '(scheme-number scheme-number)
       (lambda (coeff order)
	 (tag-term (make-term coeff order))))

  (put 'coeff '(term) (lambda (term) (coeff term)))
  (put 'order '(term) (lambda (term) (order term)))

  (put 'make 'termlist-dense
       (lambda (termlist)
	 (tag-list termlist)))
  'done)

(define (make-termlist-dense termlist) ((get 'make 'termlist-dense) termlist))

; ----------------- test ----------------- 
; (load "tag.scm")
; (load "put-get.scm")
; (define add + )

; (define (apply-generic op . args)
;   (let ((type-tags (map type-tag args)))
;     (let ((proc (get op type-tags)))
;       (if proc
; 	(apply proc (map contents args))
; 	(error
; 	  "No method for these types: 
; 	  APPLY-GENERIC"
; 	  (list op type-tags))))))

; (install-itemlist-dense-package)

; (define L '(termlist-dense 3 2 1 0))
; (apply-generic 'first-term L)
; (apply-generic 'rest-terms L)
; (apply-generic 'adjoin-term '(term 1 0) L)
; (apply-generic 'adjoin-term '(term 3 3) L)
; (apply-generic 'adjoin-term '(term 4 4) L)

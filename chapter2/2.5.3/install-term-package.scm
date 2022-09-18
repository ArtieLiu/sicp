; (define (install-term-package) 
;   (define (make-term coeff order) (list coeff order))
;   (define (coeff term) (car term))
;   (define (order term) (cadr term))

;   (define (tag term) (cons 'term term))

;   (put 'make-term '(scheme-number scheme-number)
;        (lambda (coeff order)
; 	 (tag (make-term coeff order))))

;   (put 'coeff '(term) (lambda (term) (coeff term)))
;   (put 'order '(term) (lambda (term) (order term))))

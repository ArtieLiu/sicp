(define (install-itemlist-sparse-package)

  (define (make-termlist itemlist) (list itemlist))
  (define (first-term itemlist)    (car itemlist))
  (define (rest-terms itemlist)    (cdr itemlist))

  (define (empty-termlist? termlist) (null? termlist))
  (define (the-empty-termlist) '())

  (define (make-term coeff order) (list coeff order))
  (define (coeff term) (car term))
  (define (order term) (cadr term))

  (define (adjoin-term term termlist) 
    (if (=zero? (coeff term))
      termlist
      (cons term termlist)))

  (define (=zero? coeff)
    (equal? coeff
	    (add coeff coeff)))

  (define (tag-list termlist) (cons 'termlist-sparse termlist))
  (define (tag-term term) (cons 'term term))

  (put 'adjoin-term '(term termlist-sparse)
       (lambda (term termlist) 
	 (tag-list (adjoin-term term termlist))))

  (put 'empty-termlist? '(termlist-sparse)
       (lambda (L)
	 (empty-termlist? L)))

  (put 'rest-terms '(termlist-sparse)
       (lambda (termlist)
	 (tag-list (rest-terms termlist))))

  (put 'first-term '(termlist-sparse)
       (lambda (termlist)
	 (tag-term (first-term termlist))))

  (put 'make-term '(scheme-number scheme-number)
       (lambda (coeff order)
	 (tag-term (make-term coeff order))))

  (put 'coeff '(term) (lambda (term) (coeff term)))
  (put 'order '(term) (lambda (term) (order term)))

  (put 'make 'termlist-sparse 
       (lambda (termlist)
	 (tag-list termlist)))

  (put 'the-empty-termlist '(termlist-sparse) 
       (lambda (termlist)
	 (tag-list '())))

  'done)

(define (make-termlist-sparse termlist) ((get 'make 'termlist-sparse) termlist))

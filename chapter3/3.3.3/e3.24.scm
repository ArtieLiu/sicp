(define (make-table) 
  (define local-table (list '*table*))
  (define lookup-method equal?)

  (define (assoc key records) 
    (cond ((null? records) #f)
	  ((lookup-method key (caar records)) (car records))
	  (else (assoc key (cdr records)))))

  (define (insert! key value) 
    (let ((record (assoc key (cdr local-table))))
      (if record
	(set-cdr! record value)
	(set-cdr! local-table
		  (cons (cons key value) (cdr local-table)))))
    'ok)

  (define (lookup same-key? key) 
    (set! lookup-method same-key?)
    (let ((record (assoc key (cdr local-table))))
      (if record
	(cdr record)
	#f)))

  (define (dispatch msg) 
    (cond ((equal? msg 'insert!-proc) insert!)
	  ((equal? msg 'lookup-proc) lookup)))
  dispatch)


(define tab (make-table))
(define put (tab 'insert!-proc))
(define get (tab 'lookup-proc))

(define (roughly-equal? a b) (< (abs (- a b)) 0.5))
(define (exactly-equal? a b) (equal? a b))

(put 1 'a)
(put 2 'b)

(get roughly-equal? 1.1)
(get exactly-equal? 1)

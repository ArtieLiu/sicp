; ----------------- record ----------------- 
(define (make-record key value) (cons (cons key value)
				      (cons '() '())))
(define (key record) (caar record))
(define (value record) (cdar record))

(define (record-of-smaller-key record) (cadr record))
(define (record-of-larger-key record) (cddr record))
(define (empty-record? record) (null? record))

(define (add-record-of-smaller-key! record record-to-add) (set-car! (cdr record) record-to-add))
(define (add-record-of-larger-key!  record record-to-add) (set-cdr! (cdr record) record-to-add))

(define (look-up-record target-key record) 
  (if (null? record) 
    #f
    (let ((left-record (record-of-smaller-key record))
	  (right-record (record-of-larger-key record)))
      (cond ((= target-key (key record)) (value record))
	    ((< target-key (key record)) (look-up-record target-key left-record))
	    ((> target-key (key record)) (look-up-record target-key right-record))))))

(define (insert-record! record record-to-insert) 
  (let ((key-to-insert (key record-to-insert))
	(current-key (key record))
	(left-record (record-of-smaller-key record))
	(right-record (record-of-larger-key record)))
    (cond ((and (< key-to-insert current-key)
		(empty-record? left-record))
	   (add-record-of-smaller-key! record record-to-insert))

	  ((and (> key-to-insert current-key)
		(empty-record? right-record))
	   (add-record-of-larger-key! record record-to-insert))

	  ((< key-to-insert current-key) (insert-record! left-record record-to-insert))
	  ((> key-to-insert current-key) (insert-record! right-record record-to-insert))
	  ((= key-to-insert current-key) (set-cdr! (car record) (value record-to-insert))))))

; ----------------- table ----------------- 
(define (make-table) (cons '*table* '()))

(define (insert! key value table) 
  (if (null? (cdr table))
    (set-cdr! table (make-record key value))
    (insert-record! (cdr table)
		    (make-record key value)))
  'ok)

(define (lookup key table)
  (look-up-record key (cdr table)))


; ----------------- test ----------------- 
(define t (make-table))

(insert! 10 '10 t)
(lookup 10 t)

(insert! 100 '100 t)
(lookup 100 t)

(insert! 1 '1 t)
(lookup 1 t)

t 

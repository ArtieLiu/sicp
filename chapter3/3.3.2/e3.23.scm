; ----------------- piece ----------------- 
(define (make-piece item) 
  (cons item
	(cons '() '())))

(define (data piece) (car piece))
(define (link piece) (cdr piece))

(define (frontend-ptr piece) (car (link piece)))
(define (rearend-ptr  piece) (cdr (link piece)))

(define (previous-piece piece) (frontend-ptr piece))
(define (next-piece     piece) (rearend-ptr  piece))

(define (set-frontend-ptr p1 p2) (set-car! (link p1) p2))
(define (set-rearend-ptr  p1 p2) (set-cdr! (link p1) p2))

(define (connect-piece piece neighbor) 
  (set-frontend-ptr neighbor piece)
  (set-rearend-ptr piece neighbor))

(define (remove-frontend-neighbor piece) (set-car! (link piece) '()))
(define (remove-rearend-neighbor  piece) (set-cdr! (link piece) '()))

(define (has-no-frontend-neighbor? piece) (null? (frontend-ptr piece)))
(define (has-no-rearend-neighbor?  piece) (null? (rearend-ptr piece)))

; ----------------- deque ----------------- 
(define (make-deque) 
  (cons '() '()))

(define (empty-deque? deque) 
  (equal? deque (cons '() '())))

(define (front-ptr deque) (car deque))
(define (rear-ptr  deque) (cdr deque))

(define (set-front-ptr! deque piece) (set-car! deque piece))
(define (set-rear-ptr!  deque piece) (set-cdr! deque piece))

(define (front-piece deque) (front-ptr deque))
(define (rear-piece  deque) (rear-ptr  deque))

(define (front-deque-data deque) (data (front-ptr deque)))
(define (rear-deque-data  deque) (data (rear-ptr  deque)))

; -----------------  operations ----------------- 
(define (front-insert-deque! item deque) 
  (let ((piece (make-piece item)))
    (cond ((empty-deque? deque) (set-front-ptr! deque piece)
				(set-rear-ptr! deque piece))
	  (else (connect-piece piece (front-piece deque))
		(set-front-ptr! deque piece)))))

(define (rear-insert-deque! item deque) 
  (let ((piece (make-piece item)))
    (cond ((empty-deque? deque) (set-front-ptr! deque piece)
				(set-rear-ptr! deque piece))
	  (else (connect-piece (rear-piece deque) piece)
		(set-rear-ptr! deque piece)))))
    
(define (front-delete-deque! deque)
  (cond ((has-no-rearend-neighbor? (front-piece deque)) (set-car! deque '())
							(set-cdr! deque '()))
	(else (set-front-ptr! deque (next-piece (front-piece deque)))
	      (remove-frontend-neighbor (front-piece deque)))))

(define (rear-delete-deque! deque) 
  (cond ((has-no-frontend-neighbor? (rear-piece deque)) (set-car! deque '())
							(set-cdr! deque '()))
	(else (set-rear-ptr! deque (previous-piece (rear-piece deque)))
	      (remove-rearend-neighbor (rear-piece deque)))))

(define (get-all-data piece) 
  (if (null? piece)
    '()
    (cons (data piece)
	  (get-all-data (next-piece piece)))))

; -----------------  test ----------------- 
(define deque (make-deque))
(empty-deque? deque)

(front-insert-deque! 1 deque)
(front-insert-deque! 0 deque)
(rear-insert-deque! 2 deque)
(rear-insert-deque! 3 deque)
(get-all-data (car deque))

(front-delete-deque! deque)
(get-all-data (car deque))

(rear-delete-deque! deque)
(get-all-data (car deque))

(front-delete-deque! deque)
(get-all-data (car deque))

(rear-delete-deque! deque)
(get-all-data (car deque))
(empty-deque? deque)

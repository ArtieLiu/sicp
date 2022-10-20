(define (make-queue)
  (let ((front-ptr '())
	(rear-ptr '()))

    (define (insert e)
      (let ((temp (cons e '()))) 
	(cond ((null? front-ptr)
	       (set! front-ptr temp) 
	       (set! rear-ptr temp) 
	       e)
	      (else (set-cdr! rear-ptr temp)
		    (set! rear-ptr temp)
		    e))))

    (define (front) 
      (cond ((null? front-ptr)
	     (error "FRONT called with an empty queue"))
	    (else (car front-ptr))))

    (define (delete) 
      (cond ((null? front-ptr)
	     (error "Delete aclled with an empty queue"))
	    (else (let ((result (car front-ptr)))
		    (set! front-ptr (cdr front-ptr))
		    result))))

    (define (show) front-ptr)

    (define (dispatch m) 
      (cond ((equal? m 'make) make-queue)
	    ((equal? m 'insert) insert)
	    ((equal? m 'front) front)
	    ((equal? m 'delete) delete)
	    ((equal? m 'show) show)))

    dispatch))


(define (insert-queue! queue e) ((queue 'insert) e))
(define (display-queue queue) ((queue 'show)))
(define (delete-queue queue) ((queue 'delete)))
(define (front-queue queue) ((queue 'front)))

; ----------------- test ----------------- 
(define q (make-queue))

(insert-queue! q 1)
(insert-queue! q 2)
(insert-queue! q 3)
(insert-queue! q 4)
(insert-queue! q 5)
(display-queue q)

(front-queue q)

(delete-queue q)


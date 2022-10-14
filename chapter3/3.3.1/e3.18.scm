(define tracked '(start))

(define (track l) 
  (set-cdr! (last-pair tracked) (list l)))

(define (last-pair l) 
    (if (null? (cdr l))
      l
      (last-pair (cdr l))))

(define (tracked? l) 
  (define (tracked?-iter l tracked) 
    (if (null? tracked)
      #f
      (if (eq? (car tracked) l)
	#t
	(tracked?-iter l (cdr tracked)))))

  (tracked?-iter l tracked))


(define (has-cycle? x)
  (cond ((not (pair? x)) #f)
	((tracked? x) #t)
	(else (track x)
	      (or (has-cycle? (car x))
		   (has-cycle? (cdr x))))))

(define l '(1 2 3))
(set-cdr! (cdr (cdr l)) l)
(has-cycle? l)

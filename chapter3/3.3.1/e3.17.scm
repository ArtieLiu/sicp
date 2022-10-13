(define tracked '(start))
(define l (list 1 2 3))

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


(define (count-pairs x)
  (cond ((not (pair? x)) 0)
	((tracked? x) 0)
	(else (track x)
	      (+ (count-pairs (car x))
		 (count-pairs (cdr x))
		 1))))


(define l '(1 2 3))
(set-cdr! (cdr (cdr l)) l)
(count-pairs l)

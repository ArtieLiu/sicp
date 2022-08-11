(load "as-ordered-lists.scm")
(load "e2.61.scm")

; not working solution
(define (union-set s1 s2)
  (cond ((null? s1) s2)
	((null? s2) s1)
	(else (union-set (cdr s1)
			 (adjoin-set (car s1) s2)))))

(define (union-set s1 s2)
  (cond ((null? s1) s2)
	((null? s2) s1)
	(else (cond ((< (car s1) (car s2)) 
		     (cons (car s1) 
			   (union-set (cdr s1) s2)))
		    ((= (car s1) (car s2))
		     (union-set (cdr s1) s2))
		    ((> (car s1) (car s2))
		     (cons (car s2)
			   (union-set s1 (cdr s2))))))))

(union-set '(1 3 5)
	   '(2 4 6))

(union-set '()
	   '())

(union-set '()
	   '(1 2))

(union-set '(1 2)
	   '())


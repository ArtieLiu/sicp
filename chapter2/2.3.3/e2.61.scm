(load "as-ordered-lists.scm")

(define (adjoin-set e set)
  (cond ((null? set) (cons e set))
	((< e (car set)) (cons e set))
	((= e (car set)) set)
	(else (cons (car set)
		    (adjoin-set e (cdr set))))))

(adjoin-set '1 '())
(adjoin-set '1 '(2 3))
(adjoin-set '2 '(2 3))
(adjoin-set '1 '(0 2 3))
(adjoin-set '1 '(0 1 2 3))

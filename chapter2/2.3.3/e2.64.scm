(load "as-binary-trees.scm")

(define (list->tree elements)
  (car (partial-tree elements 
		     (length elements))))

; (define (partial-tree elts n)
;   (if (= n 0)
;     (cons '() elts)

;     (let ((left-size (quotient (- n 1) 2)))

;       (let ((left-result (partial-tree elts left-size)))

; 	(let ((left-tree (car left-result))
; 	      (non-left-elts (cdr left-result))
; 	      (right-size (- n (+ left-size 1))))

; 	  (let ((this-entry (car non-left-elts))
; 		(right-result (partial-tree (cdr non-left-elts) 
; 					    right-size)))
; 	    (let ((right-tree (car right-result))
; 		  (remaining-elts (cdr right-result)))

; 	      (cons (make-tree this-entry 
; 			       left-tree 
; 			       right-tree)
; 		    remaining-elts))))))))

; (list->tree '(1 3 5 7 9 11))
; (partial-tree '(1 3 5 7 9 11) 3)

(define (partial-tree2 elements n)
  (if (zero? n)
    (cons '() elements)
    (let ((left-size (quotient (- n 1) 2)))
      (let ((left-result (partial-tree2 elements left-size)))
	(let ((left-tree (car left-result))
	      (non-left-elements (cdr left-result))
	      (right-size (- (- n left-size) 1)))
	  (let ((entry (car non-left-elements))
		(right-result (partial-tree2 (cdr non-left-elements) right-size)))
	    (let ((right-tree (car right-result))
		  (remaining-elements (cdr right-result)))
	      (cons (make-tree entry
			       left-tree
			       right-tree)
		    remaining-elements))))))))

(partial-tree2 '(1 2 3 4 5) 4)

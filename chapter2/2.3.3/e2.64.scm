(load "as-binary-trees.scm")

(define (list->tree elements)
  (car (partial-tree elements 
		     (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
    (cons '() elts)

    (let ((left-size (quotient (- n 1) 2)))

      (let ((left-result (partial-tree elts left-size)))

	(let ((left-tree (car left-result))
	      (non-left-elts (cdr left-result))
	      (right-size (- n (+ left-size 1))))

	  (let ((this-entry (car non-left-e lts))
		(right-result (partial-tree (cdr non-left-elts) 
					    right-size)))
	    (let ((right-tree (car right-result))
		  (remaining-elts (cdr right-result)))

	      (cons (make-tree this-entry 
			       left-tree 
			       right-tree)
		    remaining-elts))))))))

(list->tree '(1 3 5 7 9 11))
(partial-tree '(1 3 5 7 9 11) 3)


; Given a list of elements and a number n, partial-tree builds a balanced tree from the first n elements of the list, 
; the tree is stored in a list along with all the elements that are not in the tree.
;
; If the list is empty, the tree built will be empty and it returns an empty tree with the list:
;	(() input-list)
; Otherwise, we need to evalute the values of the following variables:
; 	left-tree 
; 	entry
; 	right-tree
;
; By wishful thinking, we already have a procedure that builds a tree from first n elements of a list,
; so the left tree can be built by calling the procedure: 
;	(partial-tree elements left-size), 
; left-size is calculated by:
;	(quotient (- n 1) 2)	
; this returns left tree and elements that are not in the left tree.
;
; The entry is the first element of the remains.
;
; To build the right tree, we need to know its size, it is calculated by:
; 	(- (- n left-size) 1)
; then the right tree is given by: 
; 	(partial-tree non-left-elements right-size)
; this returns right tree and elements that are not in the right tree.
;
; finally, the tree is constructed from:
;	 (make-tree entry 
;		    left-tree 
;		    right-tree)

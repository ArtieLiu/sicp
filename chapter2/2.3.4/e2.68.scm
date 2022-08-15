(load "huffman-tree.scm")
(load "decode.scm")

(define (encode message tree)
  (if (null? message)
    '()
    (append 
      (encode-symbol (car message) 
		     tree)
      (encode (cdr message) 
	      tree))))

(define (encode-symbol symbol tree)
  (let ((left-tree (left-branch tree))
	(right-tree (right-branch tree)))
    (cond ((leaf? tree) '())
	  ((in? symbol left-tree)  (cons '0 (encode-symbol symbol left-tree)))
	  ((in? symbol right-tree) (cons '1 (encode-symbol symbol right-tree)))
	  (else "Invalid symbol"))))

(define (in? symbol left-tree)
  (if (contains symbol (symbols left-tree))
    #t
    #f))

(define (contains e l)
  (cond ((null? l) #f)
	((eq? e (car l)) #t)
	(else (contains e (cdr l)))))

(define tree
  (make-code-tree 
   (make-leaf 'A 4)
   (make-code-tree
    (make-leaf 'B 2)
    (make-code-tree 
     (make-leaf 'D 1)
     (make-leaf 'C 1)))))

(encode-symbol 'A tree)
(encode-symbol 'B tree)
(encode-symbol 'C tree)
(encode-symbol 'D tree)

(encode '(A B C D) tree)

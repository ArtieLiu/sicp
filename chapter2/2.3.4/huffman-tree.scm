; ----------- leaf --------------
(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (symbol-leaf leaf)
  (cadr leaf))

(define (weight-leaf leaf)
  (caddr leaf))

(make-leaf 'a 1)
(leaf? '(leaf a 1))
(symbol-leaf '(leaf a 1))
(weight-leaf '(leaf a 1))
; -------------------------------

; ----------- tree --------------
(define (make-code-tree left right)
  (list left
	right
	(append (symbols left)
		(symbols right))
	(+ (weight left)
	   (weight right))))

(define (left-branch tree)
  (car tree))

(define (right-branch tree)
  (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
    (weight-leaf tree)
    (cadddr tree)))
; -------------------------------

(define (adjoin-set x set)
  (cond ((null? set) (list x))
	((< (weight x) (weight (car set))) 
	 (cons x set))
	(else 
	  (cons (car set)
		(adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
    '()
    (let ((pair (car pairs)))
      (adjoin-set 
	(make-leaf (car pair)    ; symbol
		   (cadr pair))  ; frequency
	(make-leaf-set (cdr pairs))))))

(make-leaf-set '((A 4) (B 2) (C 1) (D 1)))
(make-leaf-set '((A 4)))
(make-leaf-set '((A 4)(B 2)))
; -------------------------------


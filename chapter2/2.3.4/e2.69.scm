(load "huffman-tree.scm")
(load "decode.scm")

(define (generate-huffman-tree pairs)
  (successive-merge 
   (make-leaf-set pairs)))

(define (successive-merge set)
  (if (= 2 (length set)) 
    (merge (car set)
	   (cadr set))
    (let ((first (car set))
	  (second (cadr set))
	  (remaining (cdr (cdr set))))
      (successive-merge (adjoin-set (merge first second)
				    remaining)))))

(define (merge leaf1 leaf2)
  (make-code-tree leaf1 leaf2))

(define pairs '((A 8) (B 3) (C 1) (D 1) (E 1) (F 1) (G 1) (H 1)))

(generate-huffman-tree pairs)

; result:
'((leaf a 8) 

 ((((leaf h 1) 
    (leaf g 1) 
    (h g) 2) 
   ((leaf f 1) 
    (leaf e 1) 
    (f e) 2) 
   (h g f e) 4) 

  (((leaf d 1) 
    (leaf c 1) 
    (d c) 2) 
   (leaf b 3) 
   (d c b) 5) 

  (h g f e d c b) 9)

 (a h g f e d c b) 17)


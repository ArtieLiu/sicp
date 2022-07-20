; ------------------------
(define (accumulate op init-value sequence)
  (if (null? sequence) 
    init-value
    (op (car sequence)
        (accumulate op 
                    init-value 
                    (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

; ---------- dot product ------------
(define (dot-product v w)
  (accumulate + 
              0 
              (map * v w)))

; ---------- matrix vector product --
(define (matrix-*-vector m v)
  (map (lambda (vm)
         (dot-product vm v)) 
       m))

(define vector '(1 2 3 4))
(define m '((1 2 3 4) 
            (4 5 6 6) 
            (6 7 8 9)))

(matrix-*-vector m vector) ;returns (30 56 80)

; ------------- transpose ---------------------
(define (transpose mat)
  (accumulate-n cons '() mat))

; ------------- matrix matrix product ----------
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (v)
           (matrix-*-vector m v)) 
         cols)))

(define m '((1 2 3 4) 
            (4 5 6 6) 
            (6 7 8 9)))

(define n '((1 4 6) 
            (2 5 7) 
            (3 6 8) 
            (4 6 9)))

(matrix-*-matrix m n)
; returns '((30 56 80) 
;           (56 113 161) 
;           (80 161 230))

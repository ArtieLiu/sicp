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

(matrix-*-vector m vector)
; -----------------------------------
(define (transpose mat)
  (accumulate-n cons '() mat))
(transpose m)

; ------------------------
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (v1 v2) 
           (total (map * v1 v2)))
         m
         cols)))
(matrix-*-matrix m n)

(define n '((1 2 3 4) 
            (4 5 6 6) 
            (6 7 8 9)))

(lambda (v1 v2)
  (map * v1 v2))
'((1 2 3 4) '((1 4 6) 
  (4 5 6 6)   (2 5 7) 
  (6 7 8 9))  (3 6 8) 
              (4 6 9))



'((1 4 6) '((1 2 3 4) 
  (2 5 7)   (4 5 6 6) 
  (3 6 8)   (6 7 8 9))
  (4 6 9))

(define (total v)
  (if (null? v)
    0
    (+ (car v)
       (total (cdr v)))))
(total '(1 2))

(map (lambda (v1 v2)
       (total v1)) m m)

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (v1 cols) 
           ())
         m)))

(define (reverse l)
  (if (= 1 (length l))
    l
    (cons (reverse (cdr l)) 
          (car l))))

(display (reverse (list 1 2 3)))

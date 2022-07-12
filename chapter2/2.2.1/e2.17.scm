(define (last-pair l)
  (if (has-next? l)
    (last-pair (cdr l))
    (car l))))

(define (has-next? l)
  (not (null? (cdr l))))

(last-pair (list 1 2 3 4))

(define nil '())

(define (square-list items)
  (if (null? items)
      nil
      (cons (square (car items)) 
            (square-list (cdr items)))))

(define (square-list-map items)
  (map square items))

(square-list (list 1 2 3))
(square-list-map (list 1 2 3))

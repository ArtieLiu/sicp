(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(define (fold-right op initial sequence)
  (if (null? sequence) 
    initial
    (op (car sequence)
        (fold-right op 
                    initial 
                    (cdr sequence)))))


(fold-right / 1 (list 1 2 3 4 5))
(fold-left  / 1 (list 1 2 3 4 5))

(fold-right list '() (list 1 2 3))
(fold-left  list '() (list 1 2 3))
(5/(4/(3/2)))


(iter 1 '(1 2 3 4 5))

;(iter (/ 1 1) '(2 3 4 5))
(iter 1 '(2 3 4 5))

;(iter (/ 1 2) '(3 4 5))
(iter 1/2 '(3 4 5))

;(iter (/ 1/2 3) '(4 5))
(iter 1/6 '(4 5))

;(iter (/ 1/6 4) '(5))
(iter 1/24 '(5))

;(iter (/ 1/24 5) '())
(iter 1/120 '())
1/120

(fold-right + 0 (list 1 2 3))
(fold-left  + 0 (list 1 2 3))

; result from operation should be symmetric, i.e.
; (op e1 e2) and (op e2 e1) should have exact the same result,
; in this way, fold-right and fold-left would have same result.

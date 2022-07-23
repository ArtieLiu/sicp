(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
    '()
    (cons low 
          (enumerate-interval (+ low 1) high))))

(define pairs-with-upperbound
  (lambda (n)
    (map (lambda (m)
           (list m n))
         (enumerate-interval 1 (-1+ n)))))

(define (unique-pairs n)
  (flatmap pairs-with-upperbound
           (enumerate-interval 1 n)))

(proc 5)
(unique-pairs 5)

'((1 2) 
 (1 3) (2 3)
 (1 4) (2 4) (3 4)
 (1 5) (2 5) (3 5) (4 5))


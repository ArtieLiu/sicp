(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

(define (enumerate-interval low high)
  (if (> low high)
    '()
    (cons low 
          (enumerate-interval (+ low 1)
                              high))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (prime-sum? pair) 
  (prime? (+ (car pair) 
             (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) 
        (cadr pair) 
        (+ (car pair) (cadr pair))))

(define pairs-with-upperbound
  (lambda (n)
    (map (lambda (m)
           (list m n))
         (enumerate-interval 1 (-1+ n)))))

(define (unique-pairs n)
  (flatmap pairs-with-upperbound
           (enumerate-interval 1 n)))

(define (prime-sum-pairs n)
  (map make-pair-sum 
       (filter prime-sum? 
               (unique-pairs n))))

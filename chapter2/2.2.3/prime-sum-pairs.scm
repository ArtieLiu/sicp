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

(define l '(1 2 3 4 5))

(map (lambda (i)
       (map (lambda (j) (list i j))
            (enumerate-interval 1 (- i 1))))
     (enumerate-interval 1 10))

(accumulate 
  append 
  '() 
  (map (lambda (i) 
         (map (lambda (j) (list i j)) 
              (enumerate-interval 1 (- i 1)))) 
       (enumerate-interval 1 10)))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (prime-sum? pair) 
  (prime? (+ (car pair) 
             (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) 
        (cadr pair) 
        (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
  (map make-pair-sum 
       (filter prime-sum? 
               (flatmap (lambda (i) 
                          (map (lambda (j) (list i j)) 
                               (enumerate-interval 1 (- i 1)))) 
                        (enumerate-interval 1 n)))))

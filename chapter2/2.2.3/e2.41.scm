(define (triple-has-sum-in-interval desired-sum upper-bound)
  (filter (has-sum desired-sum) 
          (unique-triples-with-upper-bound upper-bound)))

(define (filter predicate sequence)
  (cond ((null? sequence) '())
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate 
                       (cdr sequence))))
        (else  (filter predicate 
                       (cdr sequence)))))

(define (has-sum desired-sum)
  (lambda (triple)
    (if (= desired-sum (total triple)) 
      #t
      #f)))

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op 
                    initial 
                    (cdr sequence)))))
(define (total l)
  (accumulate +
              0
              l))

(define (unique-triples-with-upper-bound upper-bound)
  (flatten (map (lambda (i) 
                  (map (lambda (j) 
                         (map (lambda (k) (list i j k))
                              (enumerate-interval 1 (- j 1)))) 
                       (enumerate-interval 1 (- i 1))))
                (enumerate-interval 1 upper-bound))))

(define (enumerate-interval low high)
  (if (> low high)
    '()
    (cons low 
          (enumerate-interval (+ low 1) high))))

(define (flatten t)
  (cond ((null? t) '())
        ((is-triple? t) (list t))
        (else (append (flatten (car t)) 
                      (flatten (cdr t))))))
(define (is-triple? p)
  (cond ((null? p) #f) 
        ((and (number? (car p)) (number? (car (cdr p)))) #t)
        (else #f)))

(triple-has-sum-in-interval 10 10)

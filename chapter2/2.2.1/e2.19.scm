(define (cc amount coin-values)
  (cond ((= amount 0) 
         1)
        ((or (< amount 0) 
             (no-more? coin-values)) 
         0)
        (else
         (+ (cc amount (except-first-denomination coin-values))
            (cc (- amount 
                   (first-denomination coin-values)) 
                coin-values)))))

(define us-coins 
  (list 50 10 1 25 5))

(define uk-coins 
  (list 100 50 20 10 5 2 1 0.5))

(define (no-more? coin-values)
  (null? coin-values))

(define (except-first-denomination coin-values)
  (cdr coin-values))

(define (first-denomination coin-values)
  (car coin-values))

(cc 100 us-coins)

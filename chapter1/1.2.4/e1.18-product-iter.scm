#lang racket/base
(require racket/trace)

(define (product a b)
  (prd-iter a b 0))

(define (prd-iter a b c)
  (cond ((= 0 b) c)
        ((even? b) (prd-iter (double a) 
                             (halve b)
                             c))
        (else (prd-iter (double a)
                        (halve (- b 1))
                        (+ a c)))))

(define (double x) (+ x x))
(define (halve x) (/ x 2))

(trace prd-iter)
(product 10 99)

(load "put-get.scm")
(load "tag.scm")

(define (install-scheme-number-package)

  ;; interface to rest of the system
  (define (tag x)
    (attach-tag 'scheme-number x))

  (put 'add '(scheme-number scheme-number) 
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number) 
       (lambda (x y) (tag (* x y))))
  (put 'div '(scheme-number scheme-number) 
       (lambda (x y) (tag (/ x y))))
  (put 'make 'scheme-number
       (lambda (x) (tag x)))

'done)

(install-scheme-number-package)
(get 'make 'scheme-number)
(get 'add '(scheme-number scheme-number))

; to make:
(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))

(define a (make-scheme-number 1))
(define a (make-scheme-number 1))



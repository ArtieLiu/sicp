(define (install-scheme-number-package)

  ;; interface to rest of the system
  (define (tag x)
    (attach-tag 'scheme-number x))

  (put 'add '(scheme-number scheme-number) +)
  (put 'sub '(scheme-number scheme-number) -)
  (put 'mul '(scheme-number scheme-number) *)
  (put 'div '(scheme-number scheme-number) /)
  (put 'make 'scheme-number                (lambda (x) (tag x)))

'done)

; to make:
(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))




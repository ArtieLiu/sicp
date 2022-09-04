(define (install-equ?-package)

  ; real part and imag part
  (define (equal-complex? z1 z2)
    (if (and (eq? (real-part z1) (real-part z2))
	     (eq? (imag-part z1) (imag-part z2)))
      #t
      #f))


  (define (equal-scheme-number? n1 n2)
    (if (= n1 n2)
      #t
      #f))

  (define (equal-rational? r1 r2)
    (if (equal? r1 r2)
      #t
      #f))

  (put 'equ? '(complex complex) equal-complex?)
  (put 'equ? '(scheme-number scheme-number) equal-scheme-number?)
  (put 'equ? '(rational rational) equal-rational?)
  'done)


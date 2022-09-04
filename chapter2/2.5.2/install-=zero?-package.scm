(define (install-=zero?-package)
  (define (=zero?-complex complex)
    (and (= 0 (real-part complex))
	 (= 0 (imag-part complex))))

  (define (=zero?-scheme-number scheme-number) 
    (= 0 scheme-number))

  (define (=zero?-rational rational) 
    (= 0  (car rational)))

  (put '=zero? '(complex) =zero?-complex) 
  (put '=zero? '(scheme-number) =zero?-scheme-number)
  (put '=zero? '(rational) =zero?-rational)
'done)

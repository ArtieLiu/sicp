(define (get-coercion type1 type2) 

  (define (rational->complex r)
    (let ((num&denom (contents r)))
      (let ((num (car num&denom))
	    (denom (cdr num&denom)))
	(make-complex-from-real-imag (/ num denom) 0))))

  (define (number->complex n)
    (let ((number (contents n)))
      (make-complex-from-real-imag number 0)))
  ; (rational->complex (make-rational 1 2))
  ; (number->complex (make-scheme-number 1))

  (cond 
    ((and (eq? type1 'rational) (eq? type2 'complex)) rational->complex)
    ((and (eq? type1 'scheme-number) (eq? type2 'complex)) number->complex)
    (else #f)))

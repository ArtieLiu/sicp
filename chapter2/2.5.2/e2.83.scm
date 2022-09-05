(apply-generic 'raise n)

; in install-scheme-number-package:
(put 'raise 'scheme-number 
     (lambda (number) 
       (make-rational number 1)))

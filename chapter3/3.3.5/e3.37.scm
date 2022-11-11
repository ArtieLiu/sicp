(load "probe.scm")
(load "connector.scm")
(load "adder.scm")
(load "constant.scm")
(load "multiplier.scm")

(define (c+ x y)
  (let ((z (make-connector)))
    (adder x y z)
    z))

(define (c- x y)
  (let ((z (make-connector)))
    (adder z y x)
    z))

(define (cv value) 
  (let ((c (make-connector)))
    (constant value c)
    c))

(define (c/ x y)
  (let ((z (make-connector)))
    (multiplier z y x)
    z))

(define (c* x y) 
  (let ((z (make-connector)))
    (multiplier x y z)
    z))

(define (celsius-fahrenheit-converter x)
  (c+ (c* (c/ (cv 9) (cv 5))
          x)
      (cv 32)))

(define C (make-connector))
(define F (celsius-fahrenheit-converter C))

(define x (make-connector))
(define y (celsius-fahrenheit-converter x))

(probe 'on-x x)
(probe 'on-y y)

(set-value! x 100 'user)
(forget-value! x 'user)

(set-value! y 212 'user)
(forget-value! x 'user)

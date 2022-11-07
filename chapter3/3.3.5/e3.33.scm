(load "connector.scm")
(load "adder.scm")
(load "constant.scm")
(load "multiplier.scm")
(load "probe.scm")

(define (averager a b c) 
  (let ((const (make-connector))
	(link (make-connector)))
    (adder a b link)
    (multiplier const c link)
    (constant 2 const)
    'ok))

(define a (make-connector))
(define b (make-connector))
(define c (make-connector))
(averager a b c)

(forget-value! a 'a)
(forget-value! b 'b)

(set-value! a 100 'a)
(set-value! b 200 'b)

(probe "a" a)
(probe "b" b)
(probe "c" c)

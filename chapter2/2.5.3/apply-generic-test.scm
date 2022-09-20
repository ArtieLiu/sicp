(load "apply-generic.scm")

(define l1 (make-sparse-polynomial 'x '((2 2) (1 1))))
(add l1 l1)

(define l2 (make-dense-polynomial 'x '(2 1 0)))
(add l2 l2)

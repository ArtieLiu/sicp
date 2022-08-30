(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (cond ((pair? datum) (car datum))
	((number? datum) 'scheme-number)
	(else (error "Bad tagged datum: TYPE-TAG" datum))))

(define (contents datum)
  (cond ((pair? datum) (car datum))
	((number? datum) datum)
	(else (error "Bad tagged datum: 
		     CONTENTS" datum))))

; in controller:
(add 1 2)

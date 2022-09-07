(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  ; (if (pair? datum)
  ;     (car datum)
  ;     (error "Bad tagged datum: 
  ;             TYPE-TAG" datum))

  (cond ((pair? datum) (car datum))
	((number? datum) 'scheme-number)
	(else (error "Bad tagged datum: TYPE-TAG" datum))))

(define (contents datum)
  ; (if (pair? datum)
  ;     (cdr datum)
  ;     (error "Bad tagged datum: CONTENTS" datum))

  (cond ((pair? datum) (cdr datum))
	((number? datum) datum)
	(else (error "Bad tagged datum: CONTENTS" datum))))

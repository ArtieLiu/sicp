
; ----------- Explicit dispatch -------------
; Control logic:
define (add-complex z1 z2)
(make-from-real-imag 
  (+ (real-part z1) (real-part z2))
  (+ (imag-part z1) (imag-part z2))))

(define (sub-complex z1 z2)
  (make-from-real-imag 
    (- (real-part z1) (real-part z2))
    (- (imag-part z1) (imag-part z2))))

(define (mul-complex z1 z2)
  (make-from-mag-ang 
    (* (magnitude z1) (magnitude z2))
    (+ (angle z1) (angle z2))))

(define (div-complex z1 z2)
  (make-from-mag-ang 
    (/ (magnitude z1) (magnitude z2))
    (- (angle z1) (angle z2))))

; To add new type:
No need to change control logic, but need to:
	implement constructor of the new type,
	make new type conform to interface, 
	add new type to all the places that dispatch occurs

For example:
(define (real-part z)
  (cond ((rect? z) ...)
	((new-type? z) ...)))

(define (make-new-type ...))


; To add new operation:
add new operation to all existing types

For example:
(define (conjugate z)
  (make-conjugate z))		

(define (make-conjugate z)
  (dispatch-on-type-of-z))

(cond ((rect? z) (make-conjugate-rect z)))

; ------------ Data-directed style -----------
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	(apply proc (map contents args))
	(error "No method for these types: APPLY-GENERIC" (list op type-tags))))))

(define (install-rectangular-package)
  ;; internal procedures
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (make-from-real-imag x y) 
    (cons x y))
  (define (magnitude z)
    (sqrt (+ (square (real-part z))
             (square (imag-part z)))))
  (define (angle z)
    (atan (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a)) (* r (sin a))))
  ;; interface to the rest of the system
  (define (tag x) 
    (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle '(rectangular) angle)
  (put 'make-from-real-imag 'rectangular
       (lambda (x y) 
         (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular
       (lambda (r a) 
         (tag (make-from-mag-ang r a))))
  'done)

; To add new type: 
Create new type and install it.

; To add new operation:
Create new operation for all types and:
	install these operations to dispatch table, or:
	directly modify the packages of all types

; ----------- Message-passing style --------------
(define (make-from-mag-ang mag ang)
  (define (dispatch op)
    (cond ((eq? op 'real-part) (* mag (cos ang)))
	  ((eq? op 'imag-part) (* mag (sin ang)))
	  ((eq? op 'magnitude) mag)
	  ((eq? op 'angle) ang)
	  (else "unknown operation")))
  dispatch)

(define (apply-generic op arg) (arg op))

(define complex-number
  (make-from-mag-ang 1 3.14159))

(apply-generic 'real-part complex-number)

; To add new type:
create new type which contains all of its operations

; To add new operation:
add new operation to all types

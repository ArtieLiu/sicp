(define (count-pairs x)
  (if (not (pair? x))
    0
    (+ (count-pairs (car x))
       (count-pairs (cdr x))
       1)))

; ----------------- 3 ----------------- 
(count-pairs '( 1 2 3 ))
; -------------------------------------

; ----------------- 4 ----------------- 
(define p1 '(1))
(define p2 (append '(2) p1))
(define p3 (cons p2 p1))
(count-pairs p3) 
; -------------------------------------

; ----------------- 7 ----------------- 
(define a '(1))
(define b (append '(2) a))
(set-car! b a)
(define c (append '(3) b))
(set-car! c b)

(count-pairs c) 
; ---------------------------------------

; ----------------- never returns -------
(define l '(1 2 3))
(set-cdr! (cdr (cdr l)) l)
(count-pairs l)
; ---------------------------------------

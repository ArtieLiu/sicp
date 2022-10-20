(load "queue.scm")

(define (print-queue queue) 
  (cond ((empty-queue? queue) '())
	(else (front-ptr queue))))

; ----------------- tests ----------------- 
(define q1 (make-queue))
(print-queue q1)

(insert-queue! q1 'a)
(insert-queue! q1 'b)
(print-queue q1)

(delete-queue! q1)
(print-queue q1)

(delete-queue! q1)
(print-queue q1)

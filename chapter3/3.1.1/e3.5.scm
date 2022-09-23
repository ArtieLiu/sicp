; ----------------- utils ----------------- 
(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random (+ 0.0 range)))))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
	   (/ trials-passed trials))
	  ((experiment)
	   (iter (- trials-remaining 1) 
		 (+ trials-passed 1)))
	  (else
	    (iter (- trials-remaining 1) 
		  trials-passed))))
  (iter trials 0))
; ---------------------------------------

(define (estimate-integral P x1 x2 y1 y2 trials) 
  (* (area-of-rect x1 x2 y1 y2)
     (monte-carlo trials (experiment P x1 x2 y1 y2))))

(define (area-of-rect x1 x2 y1 y2) 
  (* (abs (- x1 x2))
     (abs (- y1 y2))))

(define (experiment P x1 x2 y1 y2) 
  (lambda ()
    (let ((random_x (random-in-range x1 x2))
	  (random_y (random-in-range y1 y2)))
      (in? random_x random_y P))))

(define (in? x y P) 
  (< y (P x)))

(define (P-circle x) 
  (sqrt (- 1 (square x))))

(* 4.0 (estimate-integral P-circle 0 1 0 1 10000))

(define (find-odds-between start end)
  (find-odds start end '()))

(define (find-odds start end l)
  (display l)
  (newline)
  (if (< start end)
    (if (odd? start)
      (find-odds (+ start 1) end (cons start l)) 
      (find-odds (+ start 1) end l))
    (display 'stop)))

(find-odds 1 11 '())

initial balance: 100$ 

1. 
; Peter: (set! balance (+ balance 10))
; Paul:  (set! balance (- balance 20))
; Mary:  (set! balance (- balance (/ balance 2)))
110 -> 90 -> 45

2. 
; Peter: (set! balance (+ balance 10))
; Mary:  (set! balance (- balance (/ balance 2)))
; Paul:  (set! balance (- balance 20))
100 -> 50 -> 30

3. 
; Paul:  (set! balance (- balance 20))
; Peter: (set! balance (+ balance 10))
; Mary:  (set! balance (- balance (/ balance 2)))
80 -> 90 -> 45

4. 
; Paul:  (set! balance (- balance 20))
; Mary:  (set! balance (- balance (/ balance 2)))
; Peter: (set! balance (+ balance 10))
80 -> 40 -> 50

5. 
; Mary:  (set! balance (- balance (/ balance 2)))
; Paul:  (set! balance (- balance 20))
; Peter: (set! balance (+ balance 10))
50 -> 20 -> 30

6. 
; Mary:  (set! balance (- balance (/ balance 2)))
; Peter: (set! balance (+ balance 10))
; Paul:  (set! balance (- balance 20))
50 -> 60 -> 30


In total, there are 3 possible outcomes, which are: 30$, 45$, 50$.

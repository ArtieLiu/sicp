(define (gcd a b)
  (if (= b 0)
    a 
    (gcd b (remainder a b))))

; if b = 0, the GCD is a
; or the GCD of a & b is the GCD of b & remainder of a/b

; applicative order
(gcd 206 40)
(gcd 40 6)
(gcd 6 4)
(gcd 4 2)
(gcd 2 0) ; 2

; normal order
(gcd 206 40) ;a=206 b=40
 
(if (= 40 0) ;false
    206  
    (gcd 40 
         (remainder 206 40)))

(if (= (remainder 206 40) 0) ;false
    40
    (gcd (remainder 206 40) 
         (remainder 40 (remainder 206 40))))

(if (= (remainder 40 (remainder 206 40)) 0) ;false
    (remainder 206 40) 
    (gcd (remainder 40 (remainder 206 40)) 
         (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))

(if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0) ;false
    (remainder 40 (remainder 206 40)) 
    (gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 
         (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))))

(if (= (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))) ;true
    (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
    (gcd (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 
         (remainder (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))



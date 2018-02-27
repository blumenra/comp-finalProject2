
    


(define conder 
   (lambda (x)
       (cond 
            ((number? x) 5)
           ((string? x) "maor")
            ((char? x) #\a)
       )
    )
)
(conder 7)

;; (define ifer (lambda (x y z) (if x y z)))
;; (ifer 1 2 3)
55
33/2
77
0

(define maor 'a)
(number? maor)
(number? #\a)
(number? "#t")
(number? #t)
(number? #f)
(number? 't)
(number? 'f)
(define maor 55)
(number? maor)
(define maor 0)
(number? maor)
(define minus -2)
(number? minus)
(number? 3000)
(number? -3000)
(define frac 7/12)
(number? frac)
(define maor "maor")
(number? maor)
(define maor #f)
(number? maor)
(number? 'maor)
(number? "\x53;")
(number? #\a)
(number? #\A)
(number? #\x53)
(number? #\newline)
(number? "\f")
(number? "\t")
(number? "\\")
(number? 53/17)
(number? -53/17)
(number? 0/1)
(number? 3/1)
(number? -3/1)
(number? -0/1)
(number? '())
(number? '(1 2))
(number? (and))
(number? (or))
(number? '#(1 2))

(define numberer 5/7)
(define checker (lambda (x) (lambda (y) (x y))))
((checker number?) "string")
((checker number?) 'symbol)
((checker number?) numberer) 
((checker number?) #t)
((checker number?) 555)
((checker number?) 5/7)
((checker number?) 3/1)
((checker number?) '())
((checker number?) '(1 2) )
((checker number?) '#(1 2 #t))
((checker number?) (begin 1 2 6/7))
((checker number?) (begin 6/7 1 2))

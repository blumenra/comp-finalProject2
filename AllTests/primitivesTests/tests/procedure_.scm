((lambda (x) x) 1)

(define maor 'a)
(procedure? maor)
(procedure? #\a)
(procedure? "#t")
(procedure? #t)
(procedure? #f)
(procedure? 't)
(procedure? 'f)
(define maor 55)
(procedure? maor)
(define maor 0)
(procedure? maor)
(define minus -2)
(procedure? minus)
(procedure? 0)
(define frac 7/12)
(procedure? frac)
(procedure? 0/1)
(procedure? -0/1)
(define maor "maor")
(procedure? maor)
(procedure? #\A)
(procedure? #\x53)
(procedure? #\newline)
(procedure? "\f")
(procedure? "\t")
(procedure? "\\")
(procedure? '())
(procedure? '(1 2))
(procedure? '(()))
(procedure? (and))
(procedure? (or))
(procedure? '#(1 2))

(procedure? boolean?)
(procedure? char?)
(procedure? eq?)
(procedure? integer?)
(procedure? not)
(procedure? null?)
(procedure? number?)
(procedure? pair?)
(procedure? procedure?)
(procedure? rational?)
(procedure? string?)
(procedure? symbol?)
(procedure? vector?)
(procedure? zero?)

(procedure? (lambda (x) x))
(define koko (lambda (y) (boolean? y)))
(procedure? koko)
(procedure? (procedure? procedure?))
(procedure? (lambda (x) (lambda (y) (lambda (z) (lambda (t) x y z t)))))

(define checker (lambda (x) (lambda (y) (x y))))
(define booleaner? boolean?)
((checker procedure?) boolean?)
((checker procedure?) "string")
((checker procedure?) 'symbol)
((checker procedure?) #t)
((checker procedure?) 555)
((checker procedure?) 5/7)
((checker procedure?) 3/1)
((checker procedure?) '())
((checker procedure?) '(1 2) )
((checker procedure?) '#(1 2 #t))
((checker procedure?) (begin 1 2 procedure?))
((checker procedure?) (begin procedure? 1 2))
(procedure? <)
(procedure? =)
(procedure? >)
(procedure? /)
(procedure? *)
(procedure? -)

(procedure? car)
(procedure? cdr)
(procedure? char->integer)
(procedure? car)
(procedure? cdr)
(procedure? char->integer)
(procedure? cons)
(procedure? denominator)
(procedure? integer->char)


(procedure? list)


(procedure? numerator)
(procedure? vector-length)
(procedure? vector-ref)
(procedure? remainder)
(procedure? string-length)
(procedure? string-ref)
(procedure? string-set!)

;tests that cannot work yet (because of impolementation issue and so on)
;; (procedure? +)
;; (procedure? string->symbol)
;; (procedure? symbol->string)
;; (procedure? make-string)
;; (procedure? make-vector)
;; (procedure? vector)


;(procedure? append)
;(procedure? apply)
;(procedure? map)
;(procedure? set-car!)
;(procedure? set-cdr!)
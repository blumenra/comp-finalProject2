(string-length "dassdsadadassdm")
(string-length "maor")
(string-length "")
(string-length "\t")
(string-length "\x53;")
(string-length "\f")
(string-length "\"")
(string-length " hh jj ")
(define stringer "string")
(string-length stringer)
(define checker (lambda (x) (string-length x)))
(checker stringer)


;Alon & Ziv: the same troublesome eq? and symbol->string
;; (eq? (checker stringer) 6)
;; (eq? (checker stringer) 18/3)
;; (eq? (checker stringer) 7)
(define stringer2 "strint")
;; (eq? (string-length stringer) (string-length stringer2))
;; (string-length (symbol->string 'maor))

;(string-length "\r")
;(string-length "\n")
#\a
(integer->char 99)
(char->integer #\a)
(char->integer (integer->char 105))
(integer->char (char->integer #\h))
(integer? (char->integer #\a))
(number? (char->integer #\b))
(char->integer #\m)
(char->integer #\return)
(char->integer #\tab)
(char->integer #\newline)
(char->integer #\x53)
(integer->char 65)
(integer->char 66)
(integer->char 97)
(integer->char 110)
(define koko (integer->char 69))
(char? koko)
(char->integer koko)
(char->integer (integer->char 100))
(integer->char (char->integer #\page))
(char? (integer->char (char->integer #\page)))
(integer? (integer->char (char->integer #\page)))
(char->integer (integer->char 10))
(integer->char (char->integer #\x65))
(define pnina (char->integer #\return))
(integer->char pnina)
(char? (integer->char pnina))
(integer? (integer->char pnina))
(define to-integer (lambda (x) (char->integer x)))
(to-integer #\c)
(define to-char (lambda (x) (integer->char x)))
(to-char 99)
(eq? (to-integer #\c) (to-char 99))
(define number? (lambda (x) (or (integer? x) (rational? x))))

(define list
    (lambda x x))


;; 	
;; (define cadr
;; 	(lambda (lst)
;; 		(car (cdr lst))))

;; (define map 
;;     (lambda (func lst)
;;        (if (null? lst)
;;            '()
;;            (cons (func (car lst)) (map func (cdr lst))))))
;; 		   

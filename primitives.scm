(define number? (lambda (x) (or (integer? x) (rational? x))))

(define list
    (lambda x x))
    
(define append
    (lambda (lst1 lst2)
      	(if (null? lst1)
            lst2
            (cons (car lst1) (append (cdr lst1) lst2)))))

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

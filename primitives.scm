(define number? (lambda (x) (or (integer? x) (rational? x))))

(define list
    (lambda x x))


;; 	
;; (define cadr
;; 	(lambda (lst)
;; 		(car (cdr lst))))

;; (define basic-map 
;;     (lambda (func lst)
;;        (if (null? lst)
;;            '()
;;            (cons (func (car lst)) (basic-map func (cdr lst))))))
;;          
;; ((1 2) (3 4) (5 6)) ==> ((1 3 5) (2 4 6)) ==> (cons (basic-map f (1 3 5)) (basic-map f (2 4 6)))
;; 
;; (define 
;; 
;; (define map
;;     (lambda lst
;;         (

;; (define map
;;     (lambda (f . s)
;;         (maplist f s)))
;;         
;; (define maplist
;;     (lambda (f . s)
;;         (if (null? (car s))
;;             '()
;;             (cons 
;;                 (apply f (map1 car s))
;;                 (maplist f (map1 cdr s))))))
                
(define map
    (lambda (f s)
        (if (null? s)
            '()
            (cons
                (f (car s))
                (map f (cdr s))))))
            
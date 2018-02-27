(load "ass1/sexpr-parser.scm")
(load "ass2/tag-parser.scm")
(load "ass3/semantic-analyzer.scm")
;(load "schemetest")

(define T_UNDEFINED 0)
(define T_VOID 1)
(define T_NIL 2)
(define T_INTEGER 3)
(define T_FRACTION 4)
(define T_BOOL 5)
(define T_CHAR 6)
(define T_STRING 7)
(define T_SYMBOL 8)
(define T_CLOSURE 9)
(define T_PAIR 10)
(define T_VECTOR 11)

(define consts-table '())
(define global-var-table '())
(define num_of_last_param 0)

(define pipeline
    (lambda (s)
        ((star <sexpr>)
        s 
        (lambda (m r)
            (map (lambda (e)
                (annotate-tc
                    (pe->lex-pe
                        (box-set
                            (remove-applic-lambda-nil (parse e))))))
            m))
        (lambda (f) 'fail))))
   
(define file->list
    (lambda (in-file)
        (let ((in-port (open-input-file in-file)))
            (letrec ((run (lambda ()
                (let ((ch (read-char in-port)))
                        (if (eof-object? ch)
                                (begin
                                        (close-input-port in-port)
                                        '())
                                        (cons ch (run)))))))
            (run)))))
        
(define basic-table `((0 312177220 (,T_UNDEFINED 0))
                    (1 ,(void) (,T_VOID 0)) 
                    (2 () (,T_NIL 0)) 
                    (3 #t (,T_BOOL 1))
                    (5 #f (,T_BOOL 0))))
				
(define address-count 7)

(define make-token-pred
    (lambda (tag)
        (lambda (exp)
            (and
                (list? exp)
                (not (null? exp))
                (equal? (car exp) tag)))))
                
(define const-token? (make-token-pred 'const))

;; input: const
;; output: list of all the components of const
;; examples: 5  ==>  '(5)
;;           '(1 2 3)  ==>  '(1 2 3 (3) (2 3) (1 2 3))
(define help
    (lambda (exp)
        (cond 
        ((null? exp) '())
        ((not (pair? exp))
            (cond 
                ((symbol? exp) (cons (symbol->string exp) `(,exp)))
                ((rational? exp) (append `(,(numerator exp)) `(,(denominator exp)) `(,exp)))
                (else `(,exp))))
        (else (append (help (car exp)) (help (cdr exp)) `(,exp))))))
        
;; input: list of sexprs
;; output: list of all constant values
;; example: ((define (fvar x) (const 1)) (applic (fvar +) ((fvar x) (const 1)))))
;;          ==> (1 1)
(define extract-consts
    (lambda (lst-sexp)
        (cond 
            ((or (null? lst-sexp) (not (pair? lst-sexp))) '())
            ((const-token? lst-sexp)
                (cond 
                    ((vector? (cadr lst-sexp)) 
                        (append (vector->list (cadr lst-sexp)) (cdr lst-sexp)))
                    ;((string? (cadr lst-sexp))
                     ;   (cons (string->symbol (cadr lst-sexp)) (cdr lst-sexp)))
                    (else (cdr lst-sexp))))
            (else (append (extract-consts (car lst-sexp)) 
                        (extract-consts (cdr lst-sexp)))))))
        
(define remove-dups
    (lambda (consts-list)
        (letrec ((inner-func (lambda (rvs)
            (cond ((null? rvs) '()) 
				((member (car rvs) (cdr rvs)) (inner-func (cdr rvs)))
                (else (cons (car rvs) (inner-func (cdr rvs))))))))
        (reverse (inner-func (reverse consts-list))))))
				
(define is-member 
    (lambda (arg table)
        (ormap (lambda (x) (equal? arg (cadr x))) table)))

(define find-address
    (lambda (arg table)
        (let ((expr (filter (lambda (x) (equal? (cadr x) arg)) table)))
            (car (car expr)))))
			
(define make-integer-const
	(lambda (const rest table)
            (let ((addr address-count))
		(set! address-count (+ address-count 2))
		(add-to-consts-table rest (append table (list `(,addr ,const (,T_INTEGER ,const))))))))

(define make-rational-const
	(lambda (const rest table)
             (let ((addr address-count))
		(set! address-count (+ address-count 3))
		(add-to-consts-table rest (append table (list `(,addr ,const (,T_FRACTION ,(find-address (numerator const) table) ,(find-address (denominator const) table)))))))))
		
(define make-pair-const
	(lambda (const rest table)
             (let ((addr address-count))
		(set! address-count (+ address-count 3))
		(add-to-consts-table 
		rest 
		(append table (list `(,addr ,const (,T_PAIR ,(find-address (car const) table) ,(find-address (cdr const) table)))))))))
		
(define make-vector-const
	(lambda (const rest table)
            (let ((addr address-count))
		(set! address-count (+ address-count (+ 2 (vector-length const))))
		(add-to-consts-table 
		rest 
		(append table (list `(,addr ,const (,T_VECTOR ,(vector-length const) 
                                                            ,@(map (lambda (elm) (find-address elm table)) (vector->list const))))))))))
													
(define make-string-const
	(lambda (const rest table)
             (let ((addr address-count))
		(set! address-count (+ address-count (+ 2 (string-length const))))
		(add-to-consts-table 
		rest 
		(append table (list `(,addr ,const (,T_STRING ,(string-length const) 
							,@(map (lambda (c) (char->integer c)) (string->list const))))))))))	

(define make-char-const
	(lambda (const rest table)
             (let ((addr address-count))
		(set! address-count (+ address-count 2))
		(add-to-consts-table rest (append table (list `(,addr ,const (,T_CHAR ,(char->integer const)))))))))
		
(define make-symbol-const
	(lambda (const rest table)
             (let ((addr address-count))
		(set! address-count (+ address-count 2))
		(add-to-consts-table rest (append table (list `(,addr ,const (,T_SYMBOL ,(find-address (symbol->string const) table)))))))))
	
(define add-to-consts-table
   (lambda (consts-list table)
        (if (null? consts-list) table
            (let ((const (car consts-list))
                (rest (cdr consts-list)))
                    (cond 
                        ((or (equal? (void) const)
                            (null? const)
                            (equal? const #f)
                            (equal? const #t))
                            (add-to-consts-table rest table))
                        ((is-member const table) (add-to-consts-table rest table))
                        ((integer? const) (make-integer-const const rest table)) 
                        ((rational? const) (make-rational-const const rest table))
                        ((pair? const) (make-pair-const const rest table))
                        ((vector? const) (make-vector-const const rest table))
                        ((string? const) (make-string-const const rest table))									
                        ((char? const) (make-char-const const rest table)) 
                        ((symbol? const) (make-symbol-const const rest table))							
                        (else 'error))))))

                        
(define fvar-token? (make-token-pred 'fvar))
    
(define extract-fvars
    (lambda (lst-sexp)
        (cond 
            ((or (null? lst-sexp) (not (pair? lst-sexp))) '())
            ((fvar-token? lst-sexp) (cdr lst-sexp))
            (else (append (extract-fvars (car lst-sexp)) 
                        (extract-fvars (cdr lst-sexp)))))))
                                            
(define add-to-global-var-table
    (lambda (fvars-list table)
        (if (null? fvars-list) table
            (let ((fvar (car fvars-list))
                (rest (cdr fvars-list))
                (addr address-count))
                (cond 
                    ((is-member fvar table) (add-to-global-var-table rest table))
                    (else (set! address-count (+ 1 address-count))
                    (add-to-global-var-table rest (append table (list `(,addr ,fvar (-1)))))))))))
    
(define primitive-funcs 
    (lambda (lst)
        (append 
            lst
            '(ass-plus-bin ass-minus-bin ass-smaller-then-bin ass-bigger-then-bin ass-equals-bin
            ass-div-bin ass-mul-bin
            append apply < = > + / * - boolean? car cdr char->integer 
            char? cons denominator integer? integer->char list make-string 
            make-vector map eq? not null? number? numerator pair? procedure? rational? 
            remainder set-car! set-cdr! string-length string-ref string-set! 
            string->symbol string? symbol? symbol->string vector vector-length 
            vector-ref vector-set! vector? zero?)))) 

(define initialize-tables-to-asm
    (lambda ()
        (string-append
            (initialize-consts-table-to-asm)
            (initialize-fvars-table-to-asm)
            ;(initialize-symbols-table-to-asm)
            )))

(define const-length
    (lambda (exp)
        (length (caddr exp))))

(define const-label-generator
    (lambda (n)
        (string-append "L_const" (number->string n)))) ; 3 ==> "L_const3")
        
(define split-lst
    (lambda (lst delimiter func)
    (if (null? (cdr lst))
    ""
        (let* ((rest (cdr lst))
                (rvs-rest              (reverse rest))  ;'(1 2 5) ==> '(5 2 1)
                (last-elm              (car rvs-rest))  ; 1
                (all-except-last-elm   (reverse (cdr rvs-rest))) ; '(2 5)
                (const-labels          (map func all-except-last-elm)) ; '(2 5) ==> '("L_const2" "L_const5" ...) except for last elm
                (last-const-label      (func last-elm))
                (complete-labels       (string-append
                                            (append-str-list-with const-labels delimiter)
                                            last-const-label)))
                 complete-labels))))
                    
                    
(define gen-const-label
    (lambda (const)
        (let*
            ((addr (car const))
            (literal (caddr const))
            (type (car literal))
            (value (cdr literal)))
            (string-append 
                "L_const" (number->string addr) ":\n"
                (cond 
                    ((or 
                        (equal? type T_UNDEFINED)
                        (equal? type T_VOID)
                        (equal? type T_NIL)
                        (equal? type T_INTEGER)
                        (equal? type T_BOOL)
                        (equal? type T_CHAR))
                        ;(equal? type T_SYMBOL))
                        (string-append 
                            "\t" "dq MAKE_LITERAL(" (number->string type) ", " (number->string (car value)) ")\n"))
                            
                    
                    ((equal? type T_SYMBOL)
                        (string-append 
                            "\t" "dq MAKE_LITERAL_SYMBOL(L_const" (number->string (car value)) ")\n"))
                    
                    ((equal? type T_FRACTION)
                        (let 
                            ((label-car (string-append "L_const" (number->string (car value))))
                            (label-cdr (string-append "L_const" (number->string (cadr value)))))
                            (string-append 
                                "\t" "dq MAKE_LITERAL_FRACTION(" label-car ", " label-cdr ")\n")))
                            
                    ((equal? type T_STRING)
                        (let ((str_elements (split-lst value ", " number->string)))
                            (string-append
                                (if (equal? str_elements "")
                                    "\t MAKE_LITERAL_STRING0 "
                                    (string-append "\t" "MAKE_LITERAL_STRING " str_elements))
                                
                                "\n")))

                    ((equal? type T_PAIR)
                        (let 
                            ((label-car (string-append "L_const" (number->string (car value))))
                            (label-cdr (string-append "L_const" (number->string (cadr value)))))
							
                        (string-append 
                                "\t" "dq MAKE_LITERAL_PAIR(" label-car ", " label-cdr ")\n")))
                     ((equal? type T_VECTOR)
                        (let ((vec_elements (split-lst value ", " const-label-generator)))
                            (string-append
                            
                                (if (equal? vec_elements "")
                                    "\t MAKE_LITERAL_VECTOR0 "
                                    (string-append "\t" "MAKE_LITERAL_VECTOR " vec_elements))
                                
                                "\n")))))))  )                               

(define gen-fvar-label
    (lambda (fvar)
        (let*
            ((addr (car fvar))
            (value (cadr fvar)))
            (string-append 
                "L_glob" (number->string addr) ":\n"
				"\t dq SOB_UNDEFINED \n"))))
       
    
(define initialize-consts-table-to-asm
    (lambda ()
;;         (let*
;;             ((table-size (apply + (map const-length consts-table))))
            (string-append 
                "consts_table:\n"
                (append-str-list (map gen-const-label consts-table))
                "\n")))
				
(define initialize-fvars-table-to-asm
    (lambda ()
        (string-append 
            "global_table:\n"
            (append-str-list (map gen-fvar-label global-var-table))
			
			"\n symbols_table:\n"
			"\t dq SOB_UNDEFINED \n"
			
            "\n")))

(define initialize-symbols-table-to-asm
    (lambda ()
        (let* 
			((sym-lst (filter (lambda (x) (equal? (caaddr x) T_SYMBOL)) consts-table)) ;all symbols
			(addr-str-lst (map (lambda (x) (cadr (caddr x))) sym-lst))) ;address of string of symbols
			(insert-symbols addr-str-lst))))
			
(define insert-symbols
    (lambda (lst)
		(string-append 
			(if (null? lst)
				"mov rax, L_const2 \n"
				(gen-symbols-table lst))
			"mov [symbols_table], rax \n"
            "\n")))
			
(define gen-symbols-table
    (lambda (lst)			
        (if (null? (cdr lst))
			(string-append
				"push qword L_const2 \n"
                "push qword L_const" (number->string (car lst)) "\n"
                "push 3 \n"				; push num of args
                "push L_const2 \n"		; push empty env (only to keep the form)
                "call L_cons \n"		; the return value will be stored in rax
                "add rsp, 8*4 \n")
				
			(string-append
				(gen-symbols-table (cdr lst))
				"push rax \n"
                "push qword L_const" (number->string (car lst)) "\n"
                "push 3 \n"				; push num of args
                "push L_const2 \n"		; push empty env (only to keep the form)
                "call L_cons \n"		; the return value will be stored in rax
                "add rsp, 8*4 \n"
				))))	
			   
(define print-macro-str
    (string-append
        "%include \"scheme.s\"\n\n"
            
        "%macro print 2 \n\n"
        "push rdi \n"
        "push rsi \n"
        "push rax \n"
        
        "mov rdi,%1 \n"
        "mov rsi,%2 \n"
        "mov rax,0 \n"
        "call printf \n"
        
        "pop rax \n"
        "pop rsi \n"
        "pop rdi \n\n"

        "%endmacro \n\n"))

(define load-primitive-funcs
    (lambda ()
        (string-append 
            (ass-pred? 'null? 'null "T_NIL")
            (ass-pred? 'boolean? 'boolean "T_BOOL")
            (ass-pred? 'char? 'char "T_CHAR")
            (ass-pred? 'integer? 'integer "T_INTEGER")
            (ass-pred? 'pair? 'pair "T_PAIR")
            (ass-pred? 'procedure? 'procedure "T_CLOSURE") 
            ;(ass-pred? 'rational? 'rational "T_FRACTION")
            (ass-pred? 'string? 'string "T_STRING")
            (ass-pred? 'symbol? 'symbol "T_SYMBOL")
            (ass-pred? 'vector? 'vector "T_VECTOR")
			(ass-rational?)
            (ass-car)
            (ass-cdr)
            (ass-integer-to-char)
            (ass-char-to-integer)
            (ass-cons)
            (ass-zero?)
            (ass-not)
            (ass-eq?)
            (ass-string-len)
            (ass-string-ref)
            (ass-make-string)
            (ass-string-set!)
            (ass-vector-len)
            (ass-vector-ref)
            (ass-vector-set!)
			(ass-make-vector)
			(ass-vector)
            (ass-set-car!)
            (ass-set-cdr!)
            (ass-remainder)
            (ass-smaller-then-bin)
            (ass-bigger-then-bin)
            (ass-equals-bin)
            (ass-plus-bin)
            (ass-minus-bin)
            (ass-mul-bin)
            (ass-div-bin)
            (ass-denominator)
            (ass-numerator)
            (ass-plus)
            (ass-minus)
            (ass-smaller)
            (ass-bigger)
            (ass-equal)
            (ass-div)
            (ass-mul)
			(ass-symbol-to-string)
			(ass-string-to-symbol)
            
                 
        )))
            
;; input: ??
;; output: string of the head code in assembly
(define make-prologue
    (lambda ()
        (string-append 
            print-macro-str
            (initialize-tables-to-asm)
            
            "global main\n"
            "section .text\n"
            "main:\n\n"
            "mov rax, malloc_pointer \n"
            "mov qword [rax], start_of_malloc \n\n"
            
			(initialize-symbols-table-to-asm)
            (load-primitive-funcs)
            )))
            
(define make-epilogue
    (lambda ()
        (string-append
            "remove_from_stack: \n"
            "cmp qword [rsp], L_const2 \n"
            "jne END_of_program \n"
            "add rsp, 8 \n"
            "jmp remove_from_stack \n"
            "END_of_program: \n"
            "\n"
            "ret\n"
            "\n\n"
            "section .rodata \n"
            "\t format_str: DB \"%s\", 10,0 \n"
            "\t format_num: DD \"%d\", 10,0 \n"
            "\t newline: DB 10, 0 \n"
            "\t error_msg: DB \"ERROR!!!\", 10, 0 \n"
            "\t error_num_args_msg: DB \"incorrect number of arguments\", 10, 0 \n"
            "\t error_type_msg: DB \"incorrect type\", 10, 0 \n\n"
            "\t error_division_by_0_msg: DB \"Error: Divided by 0\", 10, 0 \n\n"
            "L_error: \n"
            "	print format_str, error_msg \n"
            "   jmp L_END \n\n"
            "L_incorrect_num_of_args: \n"
            "	print format_str, error_num_args_msg \n"
            "   jmp L_END \n\n"
            "L_incorrect_type: \n"
            "	print format_str, error_type_msg \n"
            "   jmp L_END \n\n"
            "L_deivision_by_0_error: \n"
            "	print format_str, error_division_by_0_msg \n"
            "   jmp L_END \n\n"
            "L_END: \n"
            
            )))
        
(define write-sob-string
    (string-append 
        "push qword [rax]\n"
        "call write_sob_if_not_void\n"
        "add rsp, 1*8\n"))

(define compile-scheme-file 
    (lambda (src-file trg-file)
        (let* (
                (primitives-file (file->list "primitives.scm"))
                (lst-sexp (pipeline (append primitives-file (file->list src-file))))
                ;(lst-sexp (pipeline (file->list src-file)))
                (consts (remove-dups (fold-left append '() (map help (extract-consts lst-sexp)))))
                (const-table (add-to-consts-table consts basic-table)))
                (set! consts-table const-table)
                (set! global-var-table (add-to-global-var-table (remove-dups (primitive-funcs (extract-fvars lst-sexp))) '()))
                
                ;(display `(lst-sexp: ,lst-sexp))
		;		(code-gen (car lst-sexp))
                ;(newline)
                ;(display `(constlist: ,consts)) 
                ;(newline)
                ;(display `(const-table: ,consts-table))
                ;(newline)
                ;(initialize-consts-table-to-asm)
                ;(newline)
                ;(display `(global-table: ,global-var-table))
		;(newline)		
                (string->file 
                     trg-file 
                     (string-append 
                        (make-prologue)
                         (append-str-list (map (lambda (exp) (string-append (code-gen exp 0) write-sob-string)) lst-sexp)) ; not sure how to handle the env in this line yet
						 
                         (make-epilogue)))
                ;(string->file trg-file (append-str-list (map code-gen lst-sexp)))
        )))


(define make-lable-count
    (lambda (prefix)
      (lambda ()
        (let ((n 0))
            (lambda ()
                (set! n (+ n 1))
                (string-append prefix (number->string n)))))))
                    
(define make-gen-if3-else-lable (make-lable-count "L_if3_else"))
(define gen-if3-else-lable (make-gen-if3-else-lable))
(define make-gen-if3-done-lable (make-lable-count "L_if3_done"))
(define gen-if3-done-lable (make-gen-if3-done-lable))

(define make-gen-or-done-lable (make-lable-count "L_or_done"))
(define gen-or-done-lable (make-gen-or-done-lable)) 

(define make-gen-lambda-lable (make-lable-count "L_lambda_code"))
(define gen-lambda-lable (make-gen-lambda-lable))

(define make-gen-lambda-opt-start-lable (make-lable-count "L_lambda_opt_start_code"))
(define gen-lambda-opt-start-lable (make-gen-lambda-opt-start-lable))

(define make-gen-lambda-opt-end-lable (make-lable-count "L_lambda_opt_end_code"))
(define gen-lambda-opt-end-lable (make-gen-lambda-opt-end-lable))

(define make-gen-remove-nils-labels (make-lable-count "L_remove_nils"))
(define gen-remove-nils-lable (make-gen-remove-nils-labels)) 
        
(define code-gen-const
    (lambda (exp env)
        (let* 
            ((value (cadr exp))
            (address (find-address value consts-table)))
            (string-append 
                "mov rax, " (string-append "L_const" (number->string address)) " \n"))))

(define code-gen-if 
    (lambda (exp env)
        (let
            ((test (cadr exp))
            (dit (caddr exp))
            (dif (cadddr exp))
            (false-address (find-address #f consts-table))
            (L_else (gen-if3-else-lable))
            (L_done (gen-if3-done-lable)))
            (string-append 
                (code-gen test env) 
                "mov rax, [rax] \n"
                "cmp rax, [L_const" (number->string false-address) "] \n"
                "je " L_else "\n"
                (code-gen dit env)
                "jmp " L_done "\n"
                L_else ":\n"
                (code-gen dif env)
                L_done ":\n"))))

                
;; input: list of srtings
;; output: appended string
;; example: '("a" "bc" "d") ==> "abcd"
(define append-str-list-with
    (lambda (str-lst extra-str)
        (fold-left
                (lambda (acc-str str) (string-append acc-str str extra-str))
                ""
                str-lst)))
                
(define append-str-list
    (lambda (str-lst)
        (append-str-list-with str-lst "")))
                
(define code-gen-seq 
    (lambda (exp env)
        (let ((rest (cadr exp)))
            (append-str-list (map (lambda (exp) (code-gen exp env)) rest)))))
            
(define code-gen-or 
    (lambda (exp env)
        (let* 
            ((rest (cadr exp))
            (rvs-rest (reverse rest))
            (last-elm (car rvs-rest))
            (all-except-last-elm (reverse (cdr rvs-rest)))
            (false-address (find-address #f consts-table))
            (L_done (gen-or-done-lable)))
            (string-append
                (append-str-list-with 
                    (map (lambda (exp) (code-gen exp env)) all-except-last-elm) 
                    (string-append
                        "mov r13, [rax] \n"
                        "cmp r13, [L_const" (number->string false-address) "]\n"
                        "jne " L_done "\n"))
                (code-gen last-elm env)
                L_done ":\n"))))

(define params-code-gen
    (lambda (params-lst env)
        (if (null? params-lst)
            ""
            (string-append
                (params-code-gen (cdr params-lst) env)
                (code-gen (car params-lst) env)
                "push rax \n"))))
	
(define code-gen-applic
    (lambda (exp env)
        (let* ((func (cadr exp))
            (params (caddr exp))
            (num-of-params (length params))
            (proc (cadr exp)))
            (string-append
                "push L_const2 \n" ;push '() to stack
                (params-code-gen params env) ;push evaluated params reversely to stack
                "push " (number->string (+ 1 num-of-params)) "\n"
                (code-gen proc env)
                "mov rbx, [rax] \n"
                "TYPE rbx \n"
                "cmp rbx, T_CLOSURE \n"
                "jne L_error \n"
                "mov rbx, [rax] \n"
                "CLOSURE_ENV rbx \n"
                "push rbx \n"
                "mov rax, [rax] \n"
                "CLOSURE_CODE rax \n"
                "call rax \n"
                "mov rbx, qword [rsp + 8] \n"
                "add rbx, 2 \n"
                "shl rbx, 3 \n"
                "add rsp, rbx \n"
                (gen-remove-nils-lable) ": \n"
;;                 ".remove_from_stack: \n"
;;                 "cmp qword [rsp], L_const2 \n"
;;                 "jne .cont \n"
;;                 "add rsp, 8 \n"
;;                 ;"jmp .remove_from_stack \n"
;;                 ".cont: \n"
;;                 "\n"
                
                
                ))))


                
(define override-frame
    (lambda (index-reg)
        (string-append
            
            ".loop: \n"
                "cmp " index-reg ", 0 \n"
                "je .cont \n"
                "mov rcx, [r8] \n"
                "mov [r9], rcx \n"
                "sub r8 , 8 \n"
                "sub r9 , 8 \n"
                "dec " index-reg " \n"
                "jmp .loop \n"
                
                ".cont: \n"
        )))
                    
                    
(define code-gen-tc-applic
    (lambda (exp env)
        (let* ((params (caddr exp))
            (num-of-params (+ 1 (length params)))
            (proc (cadr exp)))
            (string-append
                "push L_const2              ;push '() to stack \n" 
                (params-code-gen params env) ;push evaluated params reversely to stack
                "push " (number->string num-of-params) "\n"
                (code-gen proc env)
                "mov rbx, [rax] \n"
                "TYPE rbx \n"
                "cmp rbx, T_CLOSURE \n"
                "jne L_error \n"
                "mov rbx, [rax] \n"
                "CLOSURE_ENV rbx \n"
                "push rbx \n"
                ; until here same as the regular applic

                "mov rdi, [rbp+8] \n"
                "push rdi \n"
                
               
                " \n"
                "mov r14, [rsp +8*2] \n"
                "mov r15, [rbp +8*3] \n"
                "mov r8, rbp \n"
                
                ;;;;;
                "mov r9, r8 \n"
                "sub r8 , 8 \n"
                "add r15, 3 \n" ;(number->string (+ 2 num-of-params))
                "shl r15, 3 \n"
                "add r9, r15 \n"
                
                
                "add r14, 3 \n"
;;                 (+ 3 num-of-params)
                (override-frame "r14") ; copy the following from new frame to old frame: null, num_of_args, env (4), n-args (num-of-params)
                "add r9 , 8 \n"
                ;;;;;
       
                "mov rsp, r9 \n"
                "mov rax, [rax] \n"
                "CLOSURE_CODE rax \n"
                "jmp rax \n"))))
                
(define code-gen-set
    (lambda (exp env)
        (let ((tag (caadr exp))
            (lst_var (cadr exp))
            (e (caddr exp)))
            (cond 
                ((equal? tag 'pvar)
                    (let ((minor (caddr lst_var)))
                        (string-append
                            (code-gen e env)
                            "mov qword [rbp + (4 + " (number->string minor) ") * 8], rax \n"
                            "mov rax, L_const1 \n")))
                ((equal? tag 'bvar)
                    (let ((major (caddr lst_var))
                        (minor (cadddr lst_var)))
                        (string-append
                            (code-gen e env)
                            "mov rbx, qword [rbp +  2 * 8] \n"
                            "mov rbx, qword [rbx + " (number->string major) " * 8] \n"
                            "mov qword [rbx + " (number->string minor) " * 8], rax \n"
                            "mov rax, L_const1 \n")))
                ((equal? tag 'fvar)
                    (let* ((value (cadr lst_var))
                        (address (find-address value global-var-table)))
                        (string-append
                            (code-gen e env)
                            "mov rbx, [rax] \n"
                            "mov rax, L_glob" (number->string address) "\n"
                            "mov [rax], rbx \n"
                            "mov rax, L_const1 \n")))))))

(define code-gen-box
    (lambda (exp env)
        (let ((minor (car (cddadr exp)))) 
            (string-append
                "mov rax, [malloc_pointer] \n"
                "my_malloc 8 \n"
                "mov rbx, qword [rbp + (4 + " (number->string minor) ") * 8] \n"
                "mov [rax], rbx \n" ))))
		
(define code-gen-box-get
    (lambda (exp env)
        (string-append
            (code-gen (cadr exp) env)
            "mov rax, [rax] \n")))
			
(define code-gen-box-set
    (lambda (exp env)
        (let 
            ((lst_var (cadr exp))
            (e (caddr exp)))
                (string-append 
                    (code-gen e env)
                    "mov rbx, rax \n"
                    (code-gen lst_var env)
                    "mov [rax], rbx \n"
                    "mov rax, L_const1 \n"))))
							
(define code-gen-pvar
    (lambda (exp env)
        (let ((minor (caddr exp)))
            (string-append 
                "mov rax, qword [rbp + (4 + " (number->string minor) ") * 8] \n"))))
	
(define code-gen-bvar
    (lambda (exp env)
        (let ((major (caddr exp))
            (minor (cadddr exp)))
                (string-append 
                    "mov rax, qword [rbp +  2 * 8] \n"
                    "mov rax, qword [rax + " (number->string major) " * 8] \n"
                    "mov rax, qword [rax + " (number->string minor) " * 8] \n"))))	   
	
(define code-gen-fvar	
    (lambda (exp env)
	(let* 
            ((value (cadr exp))
            (address (find-address value global-var-table)))
            (string-append 
                "mov rax, L_glob" (number->string address) " \n"))))

(define code-gen-def	
    (lambda (exp env)
        (let* ((value (cadadr exp))
            (address (find-address value global-var-table))
            (e (caddr exp)))
                (string-append
                    (code-gen e env)
                    "mov rax, [rax] \n"
                    "mov [L_glob" (number->string address) "], rax \n"
                    "mov rax, L_const1 \n"))))

(define copy-to-memory-params
	(lambda (num-of-params reg count)
            (if (zero? num-of-params)
                ""
                (string-append
                    ;"add " reg ", 8*" (number->string count) " \n"
                    "mov rdx,[rbp + (4 + " (number->string count) ")*8] \n"
                    "mov qword [" reg "], rdx \n" 
                    "add " reg ", 8 \n"
                    (copy-to-memory-params (- num-of-params 1) reg (+ 1 count))))))
                            
(define copy-to-memory-env
	(lambda (num-of-params reg count)
            (if (zero? num-of-params)
                ""
                (string-append
                    ;"add " reg ", 8*" (number->string count) " \n"
                    
                    "mov rdx, [r15 + 8*" (number->string count) "] \n"
                    "mov qword [" reg "], rdx \n" 
                    "add " reg ", 8 \n"
                    (copy-to-memory-env (- num-of-params 1) reg (+ 1 count))))))
				
(define code-gen-lambda-simple
    (lambda (exp env)
        (let* 
            ((params (cadr exp))                                    ; (x y z)
            (num-of-params (length params))                         ; 3
            (last-params num_of_last_param)                         ; 0 (initially)
            (body (cddr exp))                                       ; (e1 e1 ..)
            (code-lable (gen-lambda-lable))                         ; L_lambda_code75
            (end-lambda-lable (string-append "END_" code-lable)))   ; END_L_lambda_code75
                (set! num_of_last_param num-of-params)
                (string-append
                    "mov rax, [malloc_pointer] \n"
                    "my_malloc 16 \n"
                    "mov rbx, [malloc_pointer] \n"
                    "my_malloc (8*" (number->string (+ 1 env)) ") \n"
                    "mov rcx, [malloc_pointer] \n"
                    "my_malloc (8*" (number->string last-params) ") \n" ; maybe last-params should be last-params+1
                    "mov rsi, rbx \n"
                    "mov qword [rsi], rcx \n"
                    ;; At this point the environment for the lambda is ready with malloc. rax -> closure place
                                                                                        ; rbx -> env place
                                                                                        ; rcx = pointer for expanding the environment
                    
                    (copy-to-memory-params last-params "rcx" 0)
                    "add rsi, 8 \n"
                    "mov rdx,[rbp + 2*8] \n"
                    "mov r15, rdx \n"
                    (copy-to-memory-env env "rsi" 0)
                    "MAKE_LITERAL_CLOSURE rax, rbx, " code-lable "\n"
                    ;"mov rax, [rax] \n"
                    "jmp " end-lambda-lable "\n"
                    code-lable ": \n"
                    "push rbp \n"
                    "mov rbp, rsp \n"
                    (append-str-list 
                        (map (lambda (exp) (code-gen exp (+ 1 env))) body))
                    "leave \n"
                    "ret \n"
                    end-lambda-lable ": \n"))))

(define create_list_from_lambda_opt_params
    (lambda (i end)
        (let ((label-start (gen-lambda-opt-start-lable))
              (label-end (gen-lambda-opt-end-lable)))
            (string-append
                "mov rax, L_const2 ;Initialize rax with nil \n\n"
                ";If at this point " end " is 0, it means that there are no args in the list so we do nothing! \n"
                "cmp " end ", 0 \n"
                "je " label-end " \n"
                            
                
                "push " i " \n"
                "push " end " \n"
                
                "push qword L_const2   ; push nil to as first argument \n"
                "push qword [" i "]      ; push the first element of the iteration \n"
                "push 3            ; push num of args \n"
                "push L_const2     ; push empty env (only to keep the form) \n"
                "call L_cons       ; the return value will be stored in rax \n"
                "add rsp, 8*4 \n"

                "pop " end " \n"
                "pop " i " \n"
            
                label-start ": \n"
                "   sub " i ", 8 \n"
                "   sub " end ", 1 \n"
                "   cmp " end ", 0 \n"
                "   je " label-end " \n"
                "   \n"
                
                "   push " i " \n"
                "   push " end " \n"
                
                "   push rax          ; push the last created pair to be the cdr \n"
                "   push qword [" i "]      ; push next arg to be the car of the pair \n"
                "   push 3            ; push num of args (car and cdr) \n"
                "   push L_const2     ; push empty env (only to keep the form) \n"
                "   call L_cons       ; the return value will be stored in rax \n"
                "   add rsp, 8*4 \n"
                
                "   pop " end " \n"
                "   pop " i " \n"
                "   jmp " label-start " \n"
                
                label-end ": \n"
                ";At this point, the whole list is stored in rax \n"
            
        ))))

;start = pointer to the start of the new frame
(define rearrange_stack_lambda_opt
    (lambda (start end lst)
        (string-append
					
            "mov qword [" start "], " lst " ; copy the args list to the bottom of the new frame \n"
			
            ".L_start_rearrange_lambda_opt: \n"
            "   sub " start ", 8 \n"
            "   mov rsi, [rbp + 8*" end "] \n"
            "   mov qword [" start "], rsi \n"
            
            "   \n"
            "   sub " end ", 1 \n"
            "   cmp " end ", 0 \n"
            "   jge .L_start_rearrange_lambda_opt \n"
            "mov rsp, " start " ;update rsp to point to the top of the rearranged frame \n"
            "mov rbp, rsp \n"
        )))
        
        
(define code-gen-lambda-opt
    (lambda (exp env)
        (let* 
            ((params (cadr exp))
            (num-of-params (length params))
            (last-params num_of_last_param)
            (body (cddr exp))
            (code-lable (gen-lambda-lable))
            (end-lambda-lable (string-append "END_" code-lable)))
                (set! num_of_last_param num-of-params)
                (string-append
                    "mov rax, [malloc_pointer] \n"
                    "my_malloc 16 \n"
                    "mov rbx, [malloc_pointer] \n"
                    "my_malloc (8*" (number->string (+ 1 env)) ") \n"
                    "mov rcx, [malloc_pointer] \n"
                    "my_malloc (8*" (number->string last-params) ") \n"
                    "mov rsi, rbx \n"
                    "mov qword [rsi], rcx \n"
                    (copy-to-memory-params last-params "rcx" 0)
                    "add rsi, 8 \n"
                    "mov rdx,[rbp + 2*8] \n"
                    (copy-to-memory-env env "rsi" 0)
                    "MAKE_LITERAL_CLOSURE rax, rbx, " code-lable "\n"
                    ;"mov rax, [rax] \n"
                    "jmp " end-lambda-lable "\n"
                    code-lable ": \n"
                    "push rbp \n"
                    "mov rbp, rsp \n"
                    
                    "mov r12, rbp \n"
                    "add r12, 8*3 \n"
                    "mov r13, [r12]   ;store total num of params in r13 \n"
                    "mov r10, r13 \n"
                    "shl r10, 3  ; r10 = r13*8\n"
                    "add r12, r10 \n"
                    "mov r11, r12 ; In order to keep the initial point \n"
                    ;"add r11, 8  ; points to nil which is the first argument in any frame \n"
					
                    "sub r13, " (number->string (+ num-of-params 1)) " \n"
                    ;"cmp r13, 0 \n"
                    ;"jne continue \n"
                    ;"add r11, 8  ; points to nil which is the first argument in any frame \n"
                    ;"continue: \n"

                    "\n"
                    ";r12 = poinetr to last param (first index of iteration) \n"
                    ";r13 = num of params (only those from the list) \n"
                    ";r11 = nil which is the first argument in any frame \n"

                    "sub r12, 8 \n" ; r12 will point on the last element in order to start the iteration
                    
                    (create_list_from_lambda_opt_params "r12" "r13")
					
                    ;"mov r13, [rbp+ 8*3] \n"
                    ;"cmp r13, " (number->string num-of-params) " \n"
                    ;"je L_same_num_of_args \n"
                    "mov qword [rbp + 8*3], " (number->string (+ num-of-params 1)) " \n"
                    ;"L_same_num_of_args: \n"
                    "mov r12, " (number->string (+ num-of-params 3)) " \n"
                    
                    (rearrange_stack_lambda_opt "r11" "r12" "rax")

;;                     "cmp rax, L_const2 \n"
;;                     "jne continue \n"
;;                     "add r11, 8  ; points to nil which is the first argument in any frame \n"
;;                     "continue: \n"
                    (append-str-list 
                        (map (lambda (exp) (code-gen exp (+ 1 env))) body))
                    "leave \n"
                    "ret \n"
                    end-lambda-lable ": \n"))))
        

(define string->file
    (lambda (file-name str)
        (let 
            ((file (open-output-file file-name 'replace)))
            (display str file)
            (close-output-port file))))
        
(define code-gen 
    (lambda (exp env)
        (cond 
            ((or (null? exp) (not (pair? exp))) "")
            (else
                (let ((tag (car exp)))
                    (cond 
                        ((equal? tag 'const) (code-gen-const exp env))
                        ((equal? tag 'if3) (code-gen-if exp env))
                        ((equal? tag 'seq) (code-gen-seq exp env))
                        ((equal? tag 'or) (code-gen-or exp env))
                        ((equal? tag 'applic) (code-gen-applic exp env))
                        ((equal? tag 'tc-applic) (code-gen-tc-applic exp env))
                        ((equal? tag 'set) (code-gen-set exp env))
                        ((equal? tag 'box) (code-gen-box exp env))
                        ((equal? tag 'box-get) (code-gen-box-get exp env))
                        ((equal? tag 'box-set) (code-gen-box-set exp env))
                        ((equal? tag 'pvar) (code-gen-pvar exp env))
                        ((equal? tag 'bvar) (code-gen-bvar exp env))
                        ((equal? tag 'fvar) (code-gen-fvar exp env))
                        ((equal? tag 'define) (code-gen-def exp env))
                        ((equal? tag 'lambda-simple) (code-gen-lambda-simple exp env))
                        ((equal? tag 'lambda-opt) (code-gen-lambda-opt exp env))
       ))))))

(define ass-pred?
    (lambda (pred? pred str-type)      
        (let* 
            ((address (find-address pred? global-var-table))
            (str-pred (symbol->string pred?)))
            (string-append 
                "jmp L_make_" str-pred "\n"
                "L_" str-pred ": \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 1 \n"
                "mov rbx, [rbp + 8*4] \n"
                "mov rbx, [rbx] \n"
                "TYPE rbx \n"
                "cmp rbx, " str-type "\n"
                "jne L_" str-pred "_else \n "
                "mov rax, L_const3 \n"
                "jmp END_" str-pred "\n"
                "L_" str-pred "_else: \n"
                "mov rax, L_const5 \n" 
                "END_" str-pred ": \n"
                "leave \n"
                "ret \n"
                
                "L_make_" str-pred ": \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_" str-pred " \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))       
       
(define ass-rational?
    (lambda ()      
        (let* 
            ((address (find-address 'rational? global-var-table)))
            (string-append 
                "jmp L_make_rational \n"
                "L_rational: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 1 \n"
                "mov rbx, [rbp + 8*4] \n"
                "mov rbx, [rbx] \n"
                "TYPE rbx \n"
                "cmp rbx, T_FRACTION \n"
                "jne L_rational_maybe_int \n "
                "mov rax, L_const3 \n"
                "jmp END_rational \n"
				"L_rational_maybe_int: \n"
				"cmp rbx, T_INTEGER \n"
				"jne L_rational_else \n "
				"mov rax, L_const3 \n"
                "jmp END_rational \n"
				
                "L_rational_else: \n"
                "mov rax, L_const5 \n" 
                "END_rational: \n"
                "leave \n"
                "ret \n"
                
                "L_make_rational: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_rational \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))       
       
(define ass-car
    (lambda ()      
        (let* 
            ((address (find-address 'car global-var-table)))
            (string-append 
                "jmp L_make_car \n" 
                "L_car: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 1 \n"
                "mov rbx, [rbp + 8*4] \n"
				"mov rbx, [rbx] \n"
				"mov rax, rbx \n"
                "TYPE rbx \n"
                "cmp rbx, T_PAIR \n"
                "jne L_incorrect_type \n "
                "MY_CAR rax \n"
				
                "leave \n"
                "ret \n"
                
                "L_make_car: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_car \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" )))) 

(define ass-cdr
    (lambda ()      
        (let* 
            ((address (find-address 'cdr global-var-table)))
            (string-append 
                "jmp L_make_cdr \n" 
                "L_cdr: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 1 \n"
                "mov rbx, [rbp + 8*4] \n"
                "mov rbx, [rbx] \n"
                "mov rax, rbx \n"
                "TYPE rbx \n"
                "cmp rbx, T_PAIR \n"
                "jne L_incorrect_type \n "
                "MY_CDR rax \n"
                "leave \n"
                "ret \n"
                
                "L_make_cdr: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_cdr \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))

(define ass-integer-to-char
    (lambda ()      
        (let* 
            ((address (find-address 'integer->char global-var-table)))
            (string-append 
                "jmp L_make_integer_to_char \n" 
                "L_integer_to_char: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 1 \n"
                "mov rax, [rbp + 8*4] \n"
                "mov rax, [rax] \n"
                "mov rbx, rax \n"
                "TYPE rax \n"
                "cmp rax, T_INTEGER \n"
                "jne L_incorrect_type \n "
                "DATA rbx \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 8 \n"
                "mov qword [rax],  rbx \n"
                "shl qword [rax], 4 \n"
                "or qword [rax], T_CHAR \n"
                "leave \n"
                "ret \n"
                
                "L_make_integer_to_char: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_integer_to_char \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))
				
(define ass-char-to-integer
    (lambda ()      
        (let* 
            ((address (find-address 'char->integer global-var-table)))
            (string-append 
                "jmp L_make_char_to_integer \n" 
                "L_char_to_integer: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 1 \n"
                "mov rax, [rbp + 8*4] \n"
                "mov rax, [rax] \n"
                "mov rbx, rax \n"
                "TYPE rax \n"
                "cmp rax, T_CHAR \n"
                "jne L_incorrect_type \n "
                "DATA rbx \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 8 \n"
                "mov qword [rax],  rbx \n"
                "shl qword [rax], 4 \n"
                "or qword [rax], T_INTEGER \n"
                "leave \n"
                "ret \n"
                
                "L_make_char_to_integer: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_char_to_integer \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))
                
(define ass-cons
    (lambda ()      
        (let* 
            ((address (find-address 'cons global-var-table)))
            (string-append 
                "jmp L_make_cons \n"
                "L_cons: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                
                             
                "CHECK_ARG_NUM_CORRECTNESS 2 \n"
                "mov r8, [malloc_pointer] \n"
                "my_malloc 8 \n"
                "mov rbx,[rbp + 8*4] \n"
                "mov rbx, [rbx] \n"
                "mov [r8], rbx  ; here stored car \n"
                
                "mov r9, [malloc_pointer] \n"
                "my_malloc 8 \n"
                "mov rbx,[rbp + 8*5] \n"
                "mov rbx, [rbx] \n"
                "mov [r9], rbx ; here stored cdr \n"
                
                "\n;allocate memory for pair in heap in rax \n"
                "mov r10, [malloc_pointer] \n"
                "my_malloc 8 \n"
                "MAKE_MALLOC_LITERAL_PAIR r10, r8, r9\n"
                "mov rax, r10 \n"
           
           
                "leave \n"
                "ret \n\n"
                
                "L_make_cons: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_cons \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))
                
(define ass-zero?
    (lambda ()      
        (let* 
            ((address (find-address 'zero? global-var-table)))
            (string-append 
                "jmp L_make_zero \n" 
                "L_zero: \n"
                "push rbp \n"
                "mov rbp, rsp \n"

                "CHECK_ARG_NUM_CORRECTNESS 1 \n"
                
                "mov rbx, [rbp + 8*4] \n"
                "mov rbx, [rbx] \n"
 
                "DATA rbx \n"
                "cmp rbx, 0 \n"
                "jne not_zero \n"
                "mov rax, L_const3 \n"
                "jmp END_zero \n"
                "not_zero: \n"
                "mov rax, L_const5 \n"
                "END_zero: \n"
                "leave \n"
                "ret \n"
                
                "L_make_zero: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_zero \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))
                
(define ass-not
    (lambda ()      
        (let* 
            ((address (find-address 'not global-var-table)))
            (string-append 
                "jmp L_make_not \n" 
                "L_not: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 1 \n"
                "mov rbx, [rbp + 8*4] \n"
                "mov rbx, [rbx] \n"
                "mov rdx, rbx \n"
                "TYPE rdx \n"
                "DATA rbx \n"
                
                "cmp rdx, T_BOOL \n"
                "jne not_not \n"
                
                "cmp rbx, 0 \n"
                "jne not_not \n"
                
                "mov rax, L_const3 \n"
                "jmp END_not \n"
                "not_not: \n"
                "mov rax, L_const5 \n"
                "END_not: \n"
                "leave \n"
                "ret \n"
                
                "L_make_not: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_not \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))
                
(define ass-eq?
    (lambda ()      
        (let* 
            ((address (find-address 'eq? global-var-table)))
            (string-append 
                "jmp L_make_eq \n" 
                "L_eq: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 2 \n"
                "mov rbx, [rbp + 8*4] \n"
                "mov r8, [rbx] \n"
                "TYPE r8 \n"
                "mov rcx, [rbp + 8*5] \n"
                "mov r9, [rcx] \n"
                "TYPE r9 \n"
                "cmp r8, r9 \n"
                "jne not_eq \n"
                "cmp r8, T_SYMBOL \n"
                "jne .L_compare_addr \n"
                "mov rbx, [rbx] \n"
                "mov rcx, [rcx] \n"
                "DATA_SYM rbx \n"
                "DATA_SYM rcx \n"
                ".L_compare_addr: \n"
                "cmp rbx, rcx \n"
                "jne not_eq \n" 
                "mov rax, L_const3 \n"
                "jmp END_eq \n"
                "not_eq: \n"
                "mov rax, L_const5 \n"
                "END_eq: \n"
                "leave \n"
                "ret \n"
                
                "L_make_eq: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_eq \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))
				
(define ass-string-len
    (lambda ()      
        (let* 
            ((address (find-address 'string-length global-var-table)))
            (string-append 
                "jmp L_make_string_len \n" 
                "L_string_len: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 1 \n"
                "mov rax, [rbp + 8*4] \n"
                "mov rax, [rax] \n"
                "mov rbx, rax \n"
                "TYPE rax \n"
                "cmp rax, T_STRING \n"
                "jne L_incorrect_type \n "
                "STRING_LENGTH rbx \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 8 \n"
                "mov qword [rax],  rbx \n"
                "shl qword [rax], 4 \n"
                "or qword [rax], T_INTEGER \n"
                "leave \n"
                "ret \n"
                
                "L_make_string_len: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_string_len \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))

(define ass-string-ref
    (lambda ()      
        (let* 
            ((address (find-address 'string-ref global-var-table)))
            (string-append 
                "jmp L_make_string_ref \n" 
                "L_string_ref: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 2 \n"
                "mov rax, [rbp + 8*4] \n"
                "mov rax, [rax] \n"
                "mov rbx, rax \n"
                "TYPE rbx \n"
                "cmp rbx, T_STRING \n"
                "jne L_incorrect_type \n "
                "mov rcx, [rbp + 8*5] \n"
                "mov rcx, [rcx] \n"
                "mov rbx, rcx \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "jne L_incorrect_type \n "
                "DATA rcx \n"
                "mov rdx, 0 \n"
                "STRING_REF dl, rax, rcx \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 8 \n"
                "mov qword [rax],  rdx \n"
                "shl qword [rax], 4 \n"
                "or qword [rax], T_CHAR \n"
                "leave \n"
                "ret \n"
                
                "L_make_string_ref: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_string_ref \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))

(define ass-string-set!
    (lambda ()      
        (let* 
            ((address (find-address 'string-set! global-var-table)))
            (string-append 
                "jmp L_make_string_set \n" 
                "L_string_set: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 3 \n"
                "mov rax, [rbp + 8*4] \n"
                "mov rax, [rax] \n"
                "mov rbx, rax \n"
                "TYPE rbx \n"
                "cmp rbx, T_STRING \n"
                "jne L_incorrect_type \n "
                "mov rcx, [rbp + 8*5] \n"
                "mov rcx, [rcx] \n"
                "mov rbx, rcx \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "jne L_incorrect_type \n "
                "DATA rcx \n"
                "mov rdx, [rbp + 8*6] \n"
                "mov rdx, [rdx] \n"
                "mov rbx, rdx \n"
                "TYPE rbx \n"
                "cmp rbx, T_CHAR \n"
                "jne L_incorrect_type \n"
                "DATA rdx \n"
                "STRING_ELEMENTS rax \n"
                "add rax, rcx \n"
                "mov byte [rax], dl \n"
                "mov rax, L_const1 \n"
                "leave \n"
                "ret \n"
                
                "L_make_string_set: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_string_set \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))				

(define ass-make-string
    (lambda ()      
        (let* 
            ((address (find-address 'make-string global-var-table)))
            (string-append 
                "jmp L_make_make_string \n" 
                "L_make_string_new: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
				
				"mov r15, [rbp + 8*3] \n"
				"dec r15 \n"
				
                "mov rax, [rbp + 8*4] \n"
                "mov rax, [rax] \n"
                "mov rbx, rax \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "jne L_incorrect_type \n "
                "mov rbx, rax \n"
                "DATA rbx \n"
				
				"cmp r15, 1 \n"
				"je .L_default_string \n"
				
				"CHECK_ARG_NUM_CORRECTNESS 2 \n"
				
                "mov rcx, [rbp + 8*5] \n"
                "mov rcx, [rcx] \n"
                "mov rdx, rcx \n"
                "TYPE rdx \n"
                "cmp rdx, T_CHAR \n"
                "jne L_incorrect_type \n "
				
				"DATA rcx \n"
				"jmp .L_cont \n"
  
				".L_default_string: \n"
				"mov rax, [malloc_pointer] \n"
                "my_malloc 8 \n"
                "mov qword [rax],  0 \n"
                "shl qword [rax], 4 \n"
                "or qword [rax], T_CHAR \n"
				"mov rcx, rax \n"
				"mov rcx, [rcx] \n"
				"DATA rcx \n"
				
				".L_cont: \n"
                "mov r10, rbx  \n" 		;save the length
       
                "mov rax, [malloc_pointer] \n"
                "my_malloc r10 \n"
				"mov rdx, rax \n"
				
                "L_make_string_loop: \n"
                "cmp rbx, 0 \n"
                "je L_end_loop \n"
                "mov [rax],rcx \n"
                "add rax, 1 \n"
                "sub rbx, 1 \n"
                "jmp L_make_string_loop \n"
                "L_end_loop: \n"
                
				"mov rax, [malloc_pointer] \n"
                "my_malloc 8 \n"
				"mov [rax], r10 \n"
				
				"shl qword [rax], 34 \n"
				"sub rdx, start_of_data \n"
				"shl rdx, 4 \n"
				"or rdx, T_STRING \n"
				"or qword [rax], rdx \n"

                "leave \n"
                "ret \n"
                
                "L_make_make_string: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_make_string_new \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))				
				
(define ass-vector-len
    (lambda ()      
        (let* 
            ((address (find-address 'vector-length global-var-table)))
            (string-append 
                "jmp L_make_vector_len \n" 
                "L_vector_len: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 1 \n"
                "mov rax, [rbp + 8*4] \n"
                "mov rax, [rax] \n"
                "mov rbx, rax \n"
                "TYPE rax \n"
                "cmp rax, T_VECTOR \n"
                "jne L_incorrect_type \n "
                "VECTOR_LENGTH rbx \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 8 \n"
                "mov qword [rax],  rbx \n"
                "shl qword [rax], 4 \n"
                "or qword [rax], T_INTEGER \n"
                "leave \n"
                "ret \n"
                
                "L_make_vector_len: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_vector_len \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))
                
(define ass-vector-set!
    (lambda ()      
        (let* 
            ((address (find-address 'vector-set! global-var-table)))
            (string-append 
                "jmp L_make_vector_set \n" 
                "L_vector_set: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 3 \n"
                "mov rax, [rbp + 8*4] \n"
                "mov rax, [rax] \n"
                "mov rbx, rax \n"
                "TYPE rbx \n"
                "cmp rbx, T_VECTOR \n"
                "jne L_incorrect_type \n "
                "mov rcx, [rbp + 8*5] \n"
                "mov rcx, [rcx] \n"
                "mov rbx, rcx \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "jne L_incorrect_type \n "
                "DATA rcx \n"
                "mov rdx, [rbp + 8*6] \n"
                
                
                "VECTOR_ELEMENTS rax \n"
                "shl rcx, 3 \n"
                "add rax, rcx \n"
                "mov [rax], rdx \n"
                "mov rax, L_const1 \n"
                "leave \n"
                "ret \n"
                
                "L_make_vector_set: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_vector_set \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))
                
(define ass-vector-ref
    (lambda ()      
        (let* 
            ((address (find-address 'vector-ref global-var-table)))
            (string-append 
                "jmp L_make_vector_ref \n" 
                "L_vector_ref: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 2 \n"
                "mov rax, [rbp + 8*4] \n"
                "mov rax, [rax] \n"
                "mov rbx, rax \n"
                "TYPE rbx \n"
                "cmp rbx, T_VECTOR \n"
                "jne L_incorrect_type \n "
                "mov rcx, [rbp + 8*5] \n"
                "mov rcx, [rcx] \n"
                "mov rbx, rcx \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "jne L_incorrect_type \n "
                
                "DATA rcx \n"
                "VECTOR_ELEMENTS rax \n"
                "mov rax, [rax + rcx*8] \n"
                ;"VECTOR_REF rdx, rax, rcx \n"
                
                "leave \n"
                "ret \n"
                
                "L_make_vector_ref: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_vector_ref \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))
				
(define ass-make-vector
    (lambda ()      
        (let* 
            ((address (find-address 'make-vector global-var-table)))
            (string-append 
                "jmp L_make_make_vector \n" 
                "L_make_vector_new: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
				"mov r15, [rbp + 8*3] \n"
				"dec r15 \n"
				
                "mov rax, [rbp + 8*4] \n"
                "mov rax, [rax] \n"
                "mov rbx, rax \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "jne L_incorrect_type \n "
                "mov rbx, rax \n"
                "DATA rbx \n"
				"cmp r15, 1 \n"
				"je .L_default_vector \n"
				
				"CHECK_ARG_NUM_CORRECTNESS 2 \n"
                "mov rcx, [rbp + 8*5] \n"
				"jmp .L_cont \n"

				".L_default_vector: \n"
				"MAKE_MALLOC_INTEGER 0 \n"
				"mov rcx, rax \n"
				
				".L_cont: \n"
                "mov r10, rbx  \n" 		
				"mov r9, rbx  \n"	;save the length
                "shl r10, 3 \n"
       
                "mov rax, [malloc_pointer] \n"
                "my_malloc r10 \n"
				"mov rdx, rax \n"
				
                "L_make_vector_loop: \n"
                "cmp rbx, 0 \n"
                "je .L_end_loop \n"
                "mov qword [rax], rcx \n"
                "add rax, 8 \n"
                "sub rbx, 1 \n"
                "jmp L_make_vector_loop \n"
                ".L_end_loop: \n"
                
				"mov rax, [malloc_pointer] \n"
                "my_malloc 8 \n"
				"mov [rax], r9 \n"
				
				"shl qword [rax], 34 \n"
				"sub rdx, start_of_data \n"
				"shl rdx, 4 \n"
				"or rdx, T_VECTOR \n"
				"or qword [rax], rdx \n"

                "leave \n"
                "ret \n"
                
                "L_make_make_vector: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_make_vector_new \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))
				
(define ass-vector
    (lambda ()      
        (let* 
            ((address (find-address 'vector global-var-table)))
            (string-append 
                "jmp L_make_vector \n" 
                "L_vector_new: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
				"mov r15, [rbp + 8*3] \n" 
				"dec r15 \n"				
				
				"mov r10, r15  \n"
                "shl r10, 3 \n"
	   
                "mov rax, [malloc_pointer] \n"
                "my_malloc r10 \n"
				"mov rdx, rax \n"
				
				"mov r9, 0 \n"	;counter
				"mov r11,4 \n"

                "L_vector_loop: \n"
                "cmp r9, r15 \n"
                "je .L_end_loop \n"
				"mov r11, r9 \n"
				"add r11, 4 \n"
				"shl r11, 3 \n"
				"mov r11, [rbp + r11] \n"
                "mov qword [rax], r11 \n"
                "add rax, 8 \n"
                "add r9, 1 \n"
                "jmp L_vector_loop \n"
                ".L_end_loop: \n"
                
				"mov rax, [malloc_pointer] \n"
                "my_malloc 8 \n"
				"mov [rax], r15 \n"
				
				"shl qword [rax], 34 \n"
				"sub rdx, start_of_data \n"
				"shl rdx, 4 \n"
				"or rdx, T_VECTOR \n"
				"or qword [rax], rdx \n"

                "leave \n"
                "ret \n"
                
                "L_make_vector: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_vector_new \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))
				
(define ass-set-car!
    (lambda ()      
        (let* 
            ((address (find-address 'set-car! global-var-table)))
            (string-append 
                "jmp L_make_set_car \n" 
                "L_set_car: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 2 \n"
                "mov rax, [rbp + 8*4] \n"
				"mov rcx, [rbp + 8*5] \n"
				"mov rcx, [rcx] \n"
				"mov rax, [rax] \n"
				"mov rbx, rax \n"
				"TYPE rbx \n"
                "cmp rbx, T_PAIR \n"
                "jne L_incorrect_type \n "
				"MY_CAR rax \n"
				"mov qword [rax], rcx \n"
				"mov rax, L_const1 \n"
                "leave \n"
                "ret \n"
                
                "L_make_set_car: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_set_car \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))
				
(define ass-set-cdr!
    (lambda ()      
        (let* 
            ((address (find-address 'set-cdr! global-var-table)))
            (string-append 
                "jmp L_make_set_cdr \n" 
                "L_set_cdr: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 2 \n"
                "mov rax, [rbp + 8*4] \n"
				"mov rcx, [rbp + 8*5] \n"
				"mov rcx, [rcx] \n"
				"mov rax, [rax] \n"
				"mov rbx, rax \n"
				"TYPE rbx \n"
                "cmp rbx, T_PAIR \n"
                "jne L_incorrect_type \n "
				"MY_CDR rax \n"
				"mov qword [rax], rcx \n"
				"mov rax, L_const1 \n"
                "leave \n"
                "ret \n"
                
                "L_make_set_cdr: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_set_cdr \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))
                
(define ass-remainder
    (lambda ()      
        (let* 
            ((address (find-address 'remainder global-var-table)))
            (string-append 
                "jmp L_make_remainder \n" 
                "L_remainder: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 2 \n"
                "mov rax, [rbp + 8*4] \n"
                "mov rax, [rax] \n"
                "mov rbx, rax \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "jne L_incorrect_type \n "
                "mov rcx, [rbp + 8*5] \n"
                "mov rcx, [rcx] \n"
                "mov rbx, rcx \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "jne L_incorrect_type \n "
                
                "mov rdx, 0 \n"
                "DATA rax \n"
                "DATA rcx \n"
                "cmp rax, 0 \n"
                "jge L_CONT \n"
                "mov r8, rax \n"
                "sar rax, 31      ; -1 or 0 (sign of rax) \n"
                "xor r8, rax \n"
                "sub r8, rax \n"
                "mov rax, r8 \n"
                
                "idiv rcx \n"
                "mov r8, rdx \n"
                "mov rdx, 0 \n"
                "sub rdx, r8 \n"
                "jmp L_CONT2 \n"
                "L_CONT: \n"
                "idiv rcx \n"
                "L_CONT2: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 8 \n"
                "mov qword [rax],  rdx \n"
                "shl qword [rax], 4 \n"
                "or qword [rax], T_INTEGER \n"
                "leave \n"
                "ret \n"
                
                "L_make_remainder: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_remainder \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))
                
(define ass-smaller
    (lambda ()      
        (let* 
            ((address (find-address '< global-var-table)))
            (string-append 
                "jmp L_make_smaller \n" 
                "L_smaller: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                
                "mov r12, 0 \n"
                "MAKE_MALLOC_INTEGER r12 \n"
                "mov r15, rax \n" ;; accumulator
                
                "NUM_OF_ARGS rcx \n"
                
                ;; IF num of args is 0:
                "cmp rcx, 0 \n"
                "je L_incorrect_num_of_args \n"
                
                ;; IF num of args is 1:
                "cmp rcx, 1 \n"
                "jne .L_more_than_2_args \n"
                "mov rax, L_const3 \n"
                "jmp .L_smaller_done \n"
                
                ;; If num of args > 1:
                ".L_more_than_2_args: \n"
                "mov r10, 0 \n"
                "dec rcx \n"
                
                ;; rcx - limit
                ;; r8  - current arg
                ;; r10 - interator. 0 <= r10 < rcx

                ".while: \n"

                "TAKE_ARG r15, r10 \n"
                "inc r10 \n"
                "TAKE_ARG r8, r10 \n"
                
                "push rcx \n"
                "push r10 \n"

                "push r8 \n"
                "push r15 \n"
                "push 3 \n"
                "push L_const2 \n"
                "call L_smaller_then_bin \n" ;; r15 < r8
                "add rsp, 4*8 \n"
                
                "pop r10 \n"
                "pop rcx \n"
                
                "cmp rax, L_const5           ;;compare result with #f \n" 
                "je .L_smaller_done \n"
             
                "cmp r10, rcx \n"
                "je .L_smaller_done \n"
                
                "jmp .while \n"
    
                ".L_smaller_done: \n"
                
                "leave \n"
                "ret \n"
                
                "L_make_smaller: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_smaller \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" )))) 
                
(define ass-smaller-then-bin
    (lambda ()      
        (let* 
            ((address (find-address 'ass-smaller-then-bin global-var-table)))
            (string-append 
                "jmp L_make_smaller_then_bin \n" 
                "L_smaller_then_bin: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 2 \n"
                "mov rax, [rbp + 8*4] \n"
                "mov rax, [rax] \n"
                "mov rbx, rax \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "je L_make_frac1 \n "
                
                "cmp rbx, T_FRACTION \n"
                "jne L_incorrect_type \n "
                "mov rbx, rax \n"
                "CAR rax \n"
                "DATA rax \n"
                "mov r8, rax \n"
                "CDR rbx \n"
                "DATA rbx \n"
                "mov r9, rbx \n"
                "jmp L_next_arg1 \n "
                
                "L_make_frac1: \n"
                "DATA rax \n"
                "int_to_frac rax, r8, r9 \n"
                
                "L_next_arg1: \n"
                
                ";At this point the first argument is stored as fraction in r8, r9 \n"
                "mov rcx, [rbp + 8*5] \n"
                "mov rcx, [rcx] \n"
                "mov rbx, rcx \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "je L_make_frac12 \n "
                
                "cmp rbx, T_FRACTION \n"
                "jne L_incorrect_type \n "
                "mov rbx, rcx \n"
                "CAR rcx \n"
                "DATA rcx \n"
                "mov r10, rcx \n"
                "CDR rbx \n"
                "DATA rbx \n"
                "mov r11, rbx \n"
                "jmp L_start_smaller_then_bin \n "
                
                "L_make_frac12: \n"
                "DATA rcx \n"
                "int_to_frac rcx, r10, r11 \n"
               
                "L_start_smaller_then_bin: \n"
                ";At this point the first argument is stored as fraction in r8, r9 \n"
                ";At this point the second argument is stored as fraction in r10, r11 \n"
                
                "mov rax, r8 \n"
                "imul r11 \n"
                "mov r13, rdx \n"
                "mov r14, rax \n"
                
                "mov rax, r9 \n"
                "imul r10 \n"
                "mov rsi, rdx \n"
                "mov rdi, rax \n"
                
                "cmp r13, rsi \n"
                "jg L_smaller_then_bin_false \n"
                "cmp r13, rsi \n"
                "jl L_smaller_then_bin_true \n"
                
                "cmp r14, rdi \n"
                "jge L_smaller_then_bin_false \n"
                "cmp r14, rdi \n"
                "jl L_smaller_then_bin_true \n"
      
                "L_smaller_then_bin_false: \n"
                "mov rax, L_const5 \n"
                "jmp L_end_smaller_then_bin \n"
                
                "L_smaller_then_bin_true: \n"
                "mov rax, L_const3 \n"
                "jmp L_end_smaller_then_bin \n"
             
        
                "L_end_smaller_then_bin: \n"
                "leave \n"
                "ret \n"
                
                "L_make_smaller_then_bin: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_smaller_then_bin \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))

                
(define ass-bigger
    (lambda ()      
        (let* 
            ((address (find-address '> global-var-table)))
            (string-append 
                "jmp L_make_bigger \n" 
                "L_bigger: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                
                "mov r12, 0 \n"
                "MAKE_MALLOC_INTEGER r12 \n"
                "mov r15, rax \n" 
                
                "NUM_OF_ARGS rcx \n"
                
                ;; IF num of args is 0:
                "cmp rcx, 0 \n"
                "je L_incorrect_num_of_args \n"
                
                ;; IF num of args is 1:
                "cmp rcx, 1 \n"
                "jne .L_more_than_2_args \n"
                "mov rax, L_const3 \n"
                "jmp .L_bigger_done \n"
                
                ;; If num of args > 1:
                ".L_more_than_2_args: \n"
                "mov r10, 0 \n"
                "dec rcx \n"
                
                ;; rcx - limit
                ;; r8  - current arg
                ;; r10 - interator. 0 <= r10 < rcx

                ".while: \n"

                "TAKE_ARG r15, r10 \n"
                "inc r10 \n"
                "TAKE_ARG r8, r10 \n"
                
                "push rcx \n"
                "push r10 \n"

                "push r8 \n"
                "push r15 \n"
                "push 3 \n"
                "push L_const2 \n"
                "call L_bigger_then_bin \n" ;; r15 > r8
                "add rsp, 4*8 \n"
                
                "pop r10 \n"
                "pop rcx \n"
                
                "cmp rax, L_const5           ;;compare result with #f \n" 
                "je .L_bigger_done \n"
             
                "cmp r10, rcx \n"
                "je .L_bigger_done \n"
                
                "jmp .while \n"
    
                ".L_bigger_done: \n"
                
                "leave \n"
                "ret \n"
                
                "L_make_bigger: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_bigger \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" )))) 
                
(define ass-bigger-then-bin
    (lambda ()      
        (let* 
            ((address (find-address 'ass-bigger-then-bin global-var-table)))
            (string-append 
                "jmp L_make_bigger_then_bin \n" 
                "L_bigger_then_bin: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 2 \n"
                "mov rax, [rbp + 8*4] \n"
                "mov rax, [rax] \n"
                "mov rbx, rax \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "je L_make_frac2 \n "
                
                "cmp rbx, T_FRACTION \n"
                "jne L_incorrect_type \n "
                "mov rbx, rax \n"
                 "CAR rax \n"
                "DATA rax \n"
                "mov r8, rax \n"
                "CDR rbx \n"
                "DATA rbx \n"
                "mov r9, rbx \n"
                "jmp L_next_arg2 \n "
                
                "L_make_frac2: \n"
                "DATA rax \n"
                "int_to_frac rax, r8, r9 \n"
                
                "L_next_arg2: \n"
                
                ";At this point the first argument is stored as fraction in r8, r9 \n"
                "mov rcx, [rbp + 8*5] \n"
                "mov rcx, [rcx] \n"
                "mov rbx, rcx \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "je L_make_frac22 \n "
                
                "cmp rbx, T_FRACTION \n"
                "jne L_incorrect_type \n "
                "mov rbx, rcx \n"
                "CAR rcx \n"
                "DATA rcx \n"
                "mov r10, rcx \n"
                "CDR rbx \n"
                "DATA rbx \n"
                "mov r11, rbx \n"
                "jmp L_start_bigger_then_bin \n "
                
                "L_make_frac22: \n"
                "DATA rcx \n"
                "int_to_frac rcx, r10, r11 \n"
               
                "L_start_bigger_then_bin: \n"
                ";At this point the first argument is stored as fraction in r8, r9 \n"
                ";At this point the second argument is stored as fraction in r10, r11 \n"
                
                "mov rax, r8 \n"
                "imul r11 \n"
                "mov r13, rdx \n"
                "mov r14, rax \n"
                
                "mov rax, r9 \n"
                "imul r10 \n"
                "mov rsi, rdx \n"
                "mov rdi, rax \n"
                
                "cmp r13, rsi \n"
                "jg L_bigger_then_bin_true \n"
                "cmp r13, rsi \n"
                "jl L_bigger_then_bin_false \n"
                
                "cmp r14, rdi \n"
                "jg L_bigger_then_bin_true \n"
                "cmp r14, rdi \n"
                "jle L_bigger_then_bin_false \n"
                
      
                "L_bigger_then_bin_false: \n"
                "mov rax, L_const5 \n"
                "jmp L_end_bigger_then_bin \n"
                
                "L_bigger_then_bin_true: \n"
                "mov rax, L_const3 \n"
                "jmp L_end_bigger_then_bin \n"
             
        
                "L_end_bigger_then_bin: \n"
                "leave \n"
                "ret \n"
                
                "L_make_bigger_then_bin: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_bigger_then_bin \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))
                
                
(define ass-equal
    (lambda ()      
        (let* 
            ((address (find-address '= global-var-table))
            (start_label "L_equal")
            (make_label (string-append "L_make_" start_label))
            (end_label (string-append "." start_label "_done")))
            (string-append 
                "jmp " make_label " \n" 
                start_label ": \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                
                "mov r12, 0 \n"
                "MAKE_MALLOC_INTEGER r12 \n"
                "mov r15, rax \n" 
                
                "NUM_OF_ARGS rcx \n"
                
                ;; IF num of args is 0:
                "cmp rcx, 0 \n"
                "je L_incorrect_num_of_args \n"
                
                ;; IF num of args is 1:
                "cmp rcx, 1 \n"
                "jne .L_more_than_2_args \n"
                "mov rax, L_const3 \n"
                "jmp " end_label " \n"
                
                ;; If num of args > 1:
                ".L_more_than_2_args: \n"
                "mov r10, 0 \n"
                "dec rcx \n"
                
                ;; rcx - limit
                ;; r8  - current arg
                ;; r10 - interator. 0 <= r10 < rcx

                ".while: \n"

                "TAKE_ARG r15, r10 \n"
                "inc r10 \n"
                "TAKE_ARG r8, r10 \n"
                
                "push rcx \n"
                "push r10 \n"

                "push r8 \n"
                "push r15 \n"
                "push 3 \n"
                "push L_const2 \n"
                "call L_equals_bin \n" ;; r15 = r8
                "add rsp, 4*8 \n"
                
                "pop r10 \n"
                "pop rcx \n"
                
                "cmp rax, L_const5           ;;compare result with #f \n" 
                "je " end_label " \n"
             
                "cmp r10, rcx \n"
                "je " end_label " \n"
                
                "jmp .while \n"
    
                end_label ": \n"
                "leave \n"
                "ret \n"
                
                make_label ": \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, " start_label " \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" )))) 
                
(define ass-equals-bin
    (lambda ()      
        (let* 
            ((address (find-address 'ass-equals-bin global-var-table)))
            (string-append 
                "jmp L_make_equals_bin \n" 
                "L_equals_bin: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 2 \n"
                "mov rax, [rbp + 8*4] \n"
                "mov rax, [rax] \n"
                "mov rbx, rax \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "je L_make_frac3 \n "
                
                "cmp rbx, T_FRACTION \n"
                "jne L_incorrect_type \n "
                "mov rbx, rax \n"
                 "CAR rax \n"
                "DATA rax \n"
                "mov r8, rax \n"
                "CDR rbx \n"
                "DATA rbx \n"
                "mov r9, rbx \n"
                "jmp L_next_arg3 \n "
                
                "L_make_frac3: \n"
                "DATA rax \n"
                "int_to_frac rax, r8, r9 \n"
                
                "L_next_arg3: \n"
                
                ";At this point the first argument is stored as fraction in r8, r9 \n"
                "mov rcx, [rbp + 8*5] \n"
                "mov rcx, [rcx] \n"
                "mov rbx, rcx \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "je L_make_frac32 \n "
                
                "cmp rbx, T_FRACTION \n"
                "jne L_incorrect_type \n "
                "mov rbx, rcx \n"
                "CAR rcx \n"
                "DATA rcx \n"
                "mov r10, rcx \n"
                "CDR rbx \n"
                "DATA rbx \n"
                "mov r11, rbx \n"
                "jmp L_start_equals_bin \n "
                
                "L_make_frac32: \n"
                "DATA rcx \n"
                "int_to_frac rcx, r10, r11 \n"
               
                "L_start_equals_bin: \n"
                ";At this point the first argument is stored as fraction in r8, r9 \n"
                ";At this point the second argument is stored as fraction in r10, r11 \n"
                
                "mov rax, r8 \n"
                "imul r11 \n"
                "mov r13, rdx \n"
                "mov r14, rax \n"
                
                "mov rax, r9 \n"
                "imul r10 \n"
                "mov rsi, rdx \n"
                "mov rdi, rax \n"
                
                "cmp r13, rsi \n"
                "jne L_equals_false \n"
                "cmp r14, rdi \n"
                "je L_equals_true \n"
      
                "L_equals_false: \n"
                "mov rax, L_const5 \n"
                "jmp L_end_equals_bin \n"
                
                "L_equals_true: \n"
                "mov rax, L_const3 \n"
                "jmp L_end_equals_bin \n"
             
        
                "L_end_equals_bin: \n"
                "leave \n"
                "ret \n"
                
                "L_make_equals_bin: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_equals_bin \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))

(define ass-plus
    (lambda ()      
        (let* 
            ((address (find-address '+ global-var-table)))
            (string-append 
                "jmp L_make_plus \n" 
                "L_plus: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                
                "mov r12, 0 \n"
                "MAKE_MALLOC_INTEGER r12 \n"
                "mov r15, rax \n" ;; accumulator
                
                "NUM_OF_ARGS rcx \n"
                
                ;; IF num of args is 0:
                "cmp rcx, 0 \n"
                "je .L_plus_done \n"
                
                ;; If num of args > 0:
                "mov r10, 0 \n"
                                            
                ;; rcx - limit
                ;; r8  - current arg
                ;; r10 - interator. 0 <= r10 < rcx
                
                ".while: \n"
                "TAKE_ARG r8, r10 \n"

                
                "push rcx \n"
                "push r10 \n"

;;                 "mov rax, r8 \n"
;;                 write-sob-string
                
                "push r15 \n"
                "push r8 \n"
                "push 3 \n"
                "push L_const2 \n"
                "call L_plus_bin \n"
                "add rsp, 4*8 \n"
                
                "pop r10 \n"
                "pop rcx \n"
                
                
                "mov r15, rax           ;;save in r15 the sum result \n" 
                
                "inc r10 \n"
                "cmp r10, rcx \n"
                "je .L_plus_done \n"
                
                "jmp .while \n"
                
                
                
                ".L_plus_done: \n"
                
                "leave \n"
                "ret \n"
                
                "L_make_plus: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_plus \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))                
                
(define ass-plus-bin
    (lambda ()      
        (let* 
            ((address (find-address 'ass-plus-bin global-var-table)))
            (string-append 
                "jmp L_make_plus_bin \n" 
                "L_plus_bin: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                
            
                "CHECK_ARG_NUM_CORRECTNESS 2 \n"
                "mov rax, [rbp + 8*4] \n"
                "mov rax, [rax] \n"
                "mov rbx, rax \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "je L_make_frac4 \n "
                
                "cmp rbx, T_FRACTION \n"
                "jne L_incorrect_type \n "
                "mov rbx, rax \n"
                "CAR rax \n"
                "DATA rax \n"
                "mov r8, rax \n"
                "CDR rbx \n"
                "DATA rbx \n"
                "mov r9, rbx \n"
                "jmp L_next_arg4 \n "
                
                "L_make_frac4: \n"
                "DATA rax \n"
                "int_to_frac rax, r8, r9 \n" 
                
                "L_next_arg4: \n"
                
                ";At this point the first argument is stored as fraction in r8, r9 (3 ==> 3/1) \n"
                "mov rcx, [rbp + 8*5] \n"
                "mov rcx, [rcx] \n"
                "mov rbx, rcx \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "je L_make_frac42 \n "
                
                "cmp rbx, T_FRACTION \n"
                "jne L_incorrect_type \n "
                "mov rbx, rcx \n"
                "CAR rcx \n"
                "DATA rcx \n"
                "mov r10, rcx \n"
                "CDR rbx \n"
                "DATA rbx \n"
                "mov r11, rbx \n"
                "jmp L_start_plus_bin \n "
                
                "L_make_frac42: \n"
                "DATA rcx \n"
                "int_to_frac rcx, r10, r11 \n"
               
                "L_start_plus_bin: \n"
                ";At this point the first argument is stored as fraction in r8, r9 \n"
                ";At this point the second argument is stored as fraction in r10, r11 \n"
                
                ;; calc denominator until: r13 = r9*r11
                "mov rax, 0 \n"
                "mov rax, r9 \n"
                "imul r11 \n"
                "mov r13, rax \n"
                ;; At his point r13 holds the value of the denominator
                
                
                ;; calc nominator until: r14 = r8*r11
                ;;                       rsi = r9*r10
                "mov rax, 0 \n"
                "mov rax, r8 \n"
                "imul r11 \n"
                "mov r14, rax \n"
                
                "mov rax, 0 \n"
                "mov rax, r9 \n"
                "imul r10 \n"
                "mov rsi, rax \n"
                
                
                
                "add rsi, r14 \n"
                ;; At his point rsi holds the value of the nominator
                
                "push r13 \n"
                "push rsi \n"
                
                "push r13 \n"
                "push rsi \n"
                "call gcd \n"
                "add rsp, 8*2 \n"
                
                "pop rsi \n"
                "pop r13 \n"
                ;; At his point rax holds the value of the gcd of the nominator (rsi) and the denominator (r13)
                
                "mov rdi, rax \n" ;;save the gcd value in rdi
                "my_idiv r13, rdi \n"
                "mov r13, rax \n"
                
                "push r13 \n"
                "my_idiv rsi, rdi \n"
                "mov rsi, rax \n"
                "pop r13 \n"
                ;; At his point rsi holds the value of the reduced(!) nominator and r13 holds the value of the reduced(!) denomiantor
                
               
                "MAKE_MALLOC_INTEGER rsi \n"
                "mov rsi, rax \n"
                               
                "MAKE_MALLOC_INTEGER r13 \n"
                "mov r13, rax \n"
                
                ;; At his point rsi holds the pointer to the value of the reduced(!) nominator and r13 holds the pointer to the value of the reduced(!) denomiantor
                
                "mov rax, [malloc_pointer] \n"
                "my_malloc 8 \n"
                "mov r8, [r13] \n"
                "DATA r8 \n"
                "cmp r8, 1 \n"
                "je .L_make_integer \n"
                              
                "mov r10, rax \n"
                "MAKE_MALLOC_LITERAL_FRACTION r10, rsi, r13 \n"
                "mov rax, r10 \n"
                
                
                "jmp L_end_plus_bin \n"
                
                ".L_make_integer: \n"
                "mov rax, rsi \n"
                
                "L_end_plus_bin: \n"
                "leave \n"
                "ret \n"
                
                "L_make_plus_bin: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_plus_bin \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))
                

(define ass-minus
    (lambda ()      
        (let* 
            ((address (find-address '- global-var-table)))
            (string-append 
                "jmp L_make_minus \n" 
                "L_minus: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                
                "mov r12, 0 \n"
                "MAKE_MALLOC_INTEGER r12 \n"
                "mov r15, rax \n" ;; accumulator
                
                "NUM_OF_ARGS rcx \n"
                
                ;; IF num of args is 0:
                "cmp rcx, 0 \n"
                "je L_incorrect_num_of_args \n"
                
                ;; IF num of args is 1:
                "cmp rcx, 1 \n"
                "jne .L_more_than_2_args \n"
                
                "mov r10, 0 \n"
                                            
                "TAKE_ARG r8, r10 \n" ;; r8 = first arg
                
                "push rcx \n"
                "push r10 \n"

                
                "push r8 \n"
                "push r15 \n"
                "push 3 \n"
                "push L_const2 \n"
                "call L_minus_bin \n" ;; r15 - r8
                "add rsp, 4*8 \n"
                
                "pop r10 \n"
                "pop rcx \n"
                "jmp .L_minus_done \n"

                ;; If num of args > 1:
                ".L_more_than_2_args: \n"
                "mov r10, 0 \n"
                                            
                ;; rcx - limit
                ;; r8  - current arg
                ;; r10 - interator. 0 <= r10 < rcx
                
                "TAKE_ARG r15, r10 \n"
                "inc r10 \n"
                
                ".while: \n"

                "TAKE_ARG r8, r10 \n"
                                
                "push rcx \n"
                "push r10 \n"

                
                "push r8 \n"
                "push r15 \n"
                "push 3 \n"
                "push L_const2 \n"
                "call L_minus_bin \n" ;; r15 - r8
                "add rsp, 4*8 \n"
                
                "pop r10 \n"
                "pop rcx \n"
                
                
                "mov r15, rax           ;;save in r15 the sum result \n" 
                
                "inc r10 \n"
                "cmp r10, rcx \n"
                "je .L_minus_done \n"
                
                "jmp .while \n"
    
                ".L_minus_done: \n"
                
                "leave \n"
                "ret \n"
                
                "L_make_minus: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_minus \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))                

                
(define ass-minus-bin
    (lambda ()      
        (let* 
            ((address (find-address 'ass-minus-bin global-var-table)))
            (string-append 
                "jmp L_make_minus_bin \n" 
                "L_minus_bin: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 2 \n"
                "mov rax, [rbp + 8*4] \n"
                "mov rax, [rax] \n"
                "mov rbx, rax \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "je .L_make_frac \n "
                
                "cmp rbx, T_FRACTION \n"
                "jne L_incorrect_type \n "
                "mov rbx, rax \n"
                "CAR rax \n"
                "DATA rax \n"
                "mov r8, rax \n"
                "CDR rbx \n"
                "DATA rbx \n"
                "mov r9, rbx \n"
                "jmp .L_next_arg \n "
                
                ".L_make_frac: \n"
                "DATA rax \n"
                "int_to_frac rax, r8, r9 \n"
                
                ".L_next_arg: \n"
                
                ";At this point the first argument is stored as fraction in r8, r9 \n"
                "mov rcx, [rbp + 8*5] \n"
                "mov rcx, [rcx] \n"
                "mov rbx, rcx \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "je L_make_frac52 \n "
                
                "cmp rbx, T_FRACTION \n"
                "jne L_incorrect_type \n "
                "mov rbx, rcx \n"
                "CAR rcx \n"
                "DATA rcx \n"
                "mov r10, rcx \n"
                "CDR rbx \n"
                "DATA rbx \n"
                "mov r11, rbx \n"
                "jmp L_start_minus_bin \n "
                
                "L_make_frac52: \n"
                "DATA rcx \n"
                "int_to_frac rcx, r10, r11 \n"
               
                "L_start_minus_bin: \n"
                ";At this point the first argument is stored as fraction in r8, r9 \n"
                ";At this point the second argument is stored as fraction in r10, r11 \n"
                
                ;; calc denominator until: r13 = r9*r11
                "mov rax, r9 \n"
                "imul r11 \n"
                "mov r13, rax \n"
                ;; At his point r13 holds the value of the denominator
                
                
                ;; calc nominator until: rsi = r8*r11
                ;;                       r14 = r9*r10
                "mov rax, r8 \n"
                "imul r11 \n"
                "mov rsi, rax \n"
                
                "mov rax, r9 \n"
                "imul r10 \n"
                "mov r14, rax \n"
                
                
                "sub rsi, r14 \n"
                ;; At his point rsi holds the value of the nominator
                
                "push r13 \n"
                "push rsi \n"
                "push r13 \n"
                "push rsi \n"
                "call gcd \n"
                "add rsp, 8*2 \n"
                "pop rsi \n"
                "pop r13 \n"
                ;; At his point rax holds the value of the gcd of the nominator (rsi) and the denominator (r13)
                
                "mov rdi, rax \n" ;;save the gcd value in rdi
                "my_idiv r13, rdi \n"
                "mov r13, rax \n"
                
                "my_idiv rsi, rdi \n"
                "mov rsi, rax \n"
                ;; At his point rsi holds the value of the reduced(!) nominator and r13 holds the value of the reduced(!) denomiantor
                
                "MAKE_MALLOC_INTEGER rsi \n"
                "mov rsi, rax \n"
                
                "MAKE_MALLOC_INTEGER r13 \n"
                "mov r13, rax \n"
                ;; At his point rsi holds the pointer to the value of the reduced(!) nominator and r13 holds the pointer to the value of the reduced(!) denomiantor
                
                "mov rax, [malloc_pointer] \n"
                "my_malloc 8 \n"
                "mov r8, [r13] \n"
                "DATA r8 \n"
                "cmp r8, 1 \n"
                "je .L_make_integer \n"
                "mov r10, rax \n"
                "MAKE_MALLOC_LITERAL_FRACTION r10, rsi, r13 \n"
                "mov rax, r10 \n"
                "jmp L_end_minus_bin \n"
                
                ".L_make_integer: \n"
                "mov rax, rsi \n"
                
                "L_end_minus_bin: \n"
                "leave \n"
                "ret \n"
                
                "L_make_minus_bin: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_minus_bin \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))
                
(define ass-mul
    (lambda ()      
        (let* 
            ((address (find-address '* global-var-table))
            (start_label "L_mul")
            (make_label (string-append "L_make_" start_label))
            (end_label (string-append "." start_label "_done")))
            (string-append 
                "jmp " make_label " \n" 
                start_label ": \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                
                "mov r12, 1 \n"
                "MAKE_MALLOC_INTEGER r12 \n"
                "mov r15, rax \n" ;; accumulator
                
                "NUM_OF_ARGS rcx \n"
                
                ;; IF num of args is 0:
                "cmp rcx, 0 \n"
                "je " end_label " \n"
                
                ;; IF num of args is > 0:
                "mov r10, 0 \n"
                                            
                ;; rcx - limit
                ;; r8  - current arg
                ;; r10 - interator. 0 <= r10 < rcx
                
                ".while: \n"

                "TAKE_ARG r8, r10 \n"
                                
                "push rcx \n"
                "push r10 \n"

                "push r8 \n"
                "push r15 \n"
                "push 3 \n"
                "push L_const2 \n"
                "call L_mul_bin \n" ;; r15 / r8
                "add rsp, 4*8 \n"
                
                "pop r10 \n"
                "pop rcx \n"
                
                "mov r15, rax           ;;save in r15 the sum result \n" 
                
                "inc r10 \n"
                "cmp r10, rcx \n"
                "je " end_label " \n"
                
                "jmp .while \n"
    
                end_label ": \n"
                "leave \n"
                "ret \n"
                
                make_label ": \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, " start_label " \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))                     
                
(define ass-mul-bin
    (lambda ()      
        (let* 
            ((address (find-address 'ass-mul-bin global-var-table)))
            (string-append 
                "jmp L_make_mul_bin \n" 
                "L_mul_bin: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 2 \n"
                "mov rax, [rbp + 8*4] \n"
                "mov rax, [rax] \n"
                "mov rbx, rax \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "je .L_make_frac \n "
                
                "cmp rbx, T_FRACTION \n"
                "jne L_incorrect_type \n "
                "mov rbx, rax \n"
                "CAR rax \n"
                "DATA rax \n"
                "mov r8, rax \n"
                "CDR rbx \n"
                "DATA rbx \n"
                "mov r9, rbx \n"
                "jmp .L_next_arg \n "
                
                ".L_make_frac: \n"
                "DATA rax \n"
                "int_to_frac rax, r8, r9 \n"
                
                ".L_next_arg: \n"
                
                ";At this point the first argument is stored as fraction in r8, r9 \n"
                "mov rcx, [rbp + 8*5] \n"
                "mov rcx, [rcx] \n"
                "mov rbx, rcx \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "je .L_make_frac2 \n "
                
                "cmp rbx, T_FRACTION \n"
                "jne L_incorrect_type \n "
                "mov rbx, rcx \n"
                "CAR rcx \n"
                "DATA rcx \n"
                "mov r10, rcx \n"
                "CDR rbx \n"
                "DATA rbx \n"
                "mov r11, rbx \n"
                "jmp L_start_mul_bin \n "
                
                ".L_make_frac2: \n"
                "DATA rcx \n"
                "int_to_frac rcx, r10, r11 \n"
               
                "L_start_mul_bin: \n"
                ";At this point the first argument is stored as fraction in r8, r9 \n"
                ";At this point the second argument is stored as fraction in r10, r11 \n"
                
                ;; calc denominator until: r13 = r9*r11
                "mov rax, r9 \n"
                "imul r11 \n"
                "mov r13, rax \n"
                ;; At his point r13 holds the value of the denominator
                
                
                ;; calc nominator until: rsi = r8*r10
                ;;                       r13 = r9*r11
                "mov rax, r8 \n"
                "imul r10 \n"
                "mov rsi, rax \n"
                ;; At his point rsi holds the value of the nominator
                
                "push r13 \n"
                "push rsi \n"
                "push r13 \n"
                "push rsi \n"
                "call gcd \n"
                "add rsp, 8*2 \n"
                "pop rsi \n"
                "pop r13 \n"
                ;; At his point rax holds the value of the gcd of the nominator (rsi) and the denominator (r13)
                
                "mov rdi, rax \n" ;;save the gcd value in rdi
                "my_idiv r13, rdi \n"
                "mov r13, rax \n"
                
                "my_idiv rsi, rdi \n"
                "mov rsi, rax \n"
                ;; At his point rsi holds the value of the reduced(!) nominator and r13 holds the value of the reduced(!) denomiantor
                
                "mov rax, [malloc_pointer] \n"
                "my_malloc 8 \n"
                "mov qword [rax], rsi \n"
                "shl qword [rax], 4 \n"
                "or qword [rax], T_INTEGER \n"
                "mov rsi, rax \n"
                
                "mov rax, [malloc_pointer] \n"
                "my_malloc 8 \n"
                "mov qword [rax], r13 \n"
                "shl qword [rax], 4 \n"
                "or qword [rax], T_INTEGER \n"
                "mov r13, rax \n"
                ;; At his point rsi holds the pointer to the value of the reduced(!) nominator and r13 holds the pointer to the value of the reduced(!) denomiantor
                
                "mov rax, [malloc_pointer] \n"
                "my_malloc 8 \n"
                "mov r8, [r13] \n"
                "DATA r8 \n"
                "cmp r8, 1 \n"
                "je .L_make_integer \n"
                "mov r10, rax \n"
                "MAKE_MALLOC_LITERAL_FRACTION r10, rsi, r13 \n"
                "mov rax, r10 \n"
                "jmp L_end_mul_bin \n"
                
                ".L_make_integer: \n"
                "mov rax, rsi \n"
                
                "L_end_mul_bin: \n"
                "leave \n"
                "ret \n"
                
                "L_make_mul_bin: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_mul_bin \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))
                
(define ass-div
    (lambda ()      
        (let* 
            ((address (find-address '/ global-var-table))
            (start_label "L_div")
            (make_label (string-append "L_make_" start_label))
            (end_label (string-append "." start_label "_done")))
            (string-append 
                "jmp " make_label " \n" 
                start_label ": \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                
                "mov r12, 1 \n"
                "MAKE_MALLOC_INTEGER r12 \n"
                "mov r15, rax \n" ;; accumulator
                
                "NUM_OF_ARGS rcx \n"
                
                ;; IF num of args is 0:
                "cmp rcx, 0 \n"
                "je L_incorrect_num_of_args \n"
                
                ;; IF num of args is 1:
                "cmp rcx, 1 \n"
                "jne .L_more_than_2_args \n"
                
                "mov r10, 0 \n"
                                            
                "TAKE_ARG r8, r10 \n" ;; r8 = first arg
                
                "push rcx \n"
                "push r10 \n"
                
                "push r8 \n"
                "push r15 \n"
                "push 3 \n"
                "push L_const2 \n"
                "call L_div_bin \n" ;; r15 / r8
                "add rsp, 4*8 \n"
                
                "pop r10 \n"
                "pop rcx \n"
                
                "jmp " end_label " \n"

                ;; If num of args > 1:
                ".L_more_than_2_args: \n"
                "mov r10, 0 \n"
                                            
                ;; rcx - limit
                ;; r8  - current arg
                ;; r10 - interator. 0 <= r10 < rcx
                
                "TAKE_ARG r15, r10 \n"
                "inc r10 \n"
                
                ".while: \n"

                "TAKE_ARG r8, r10 \n"
                                
                "push rcx \n"
                "push r10 \n"

                
                "push r8 \n"
                "push r15 \n"
                "push 3 \n"
                "push L_const2 \n"
                "call L_div_bin \n" ;; r15 / r8
                "add rsp, 4*8 \n"
                
                "pop r10 \n"
                "pop rcx \n"
                
                "mov r15, rax           ;;save in r15 the sum result \n" 
                
                "inc r10 \n"
                "cmp r10, rcx \n"
                "je " end_label " \n"
                
                "jmp .while \n"
    
                end_label ": \n"
                "leave \n"
                "ret \n"
                
                make_label ": \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, " start_label " \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))               
 
(define ass-div-bin
    (lambda ()      
        (let* 
            ((address (find-address 'ass-div-bin global-var-table)))
            (string-append 
                "jmp L_make_div_bin \n" 
                "L_div_bin: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 2 \n"
                "mov rax, [rbp + 8*4] \n"
                "mov rax, [rax] \n"
                "mov rbx, rax \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "je .L_make_frac \n "
                
                "cmp rbx, T_FRACTION \n"
                "jne L_incorrect_type \n "
                "mov rbx, rax \n"
                "CAR rax \n"
                "DATA rax \n"
                "mov r8, rax \n"
                "CDR rbx \n"
                "DATA rbx \n"
                "mov r9, rbx \n"
                "jmp .L_next_arg \n "
                
                ".L_make_frac: \n"
                "DATA rax \n"
                "int_to_frac rax, r8, r9 \n"
                
                ".L_next_arg: \n"
                
                ";At this point the first argument is stored as fraction in r8, r9 \n"
                "mov rcx, [rbp + 8*5] \n"
                "mov rcx, [rcx] \n"
                "mov rbx, rcx \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "je .L_make_frac2 \n "
                
                "cmp rbx, T_FRACTION \n"
                "jne L_incorrect_type \n "
                "mov rbx, rcx \n"
                "CAR rcx \n"
                "DATA rcx \n"
                "mov r10, rcx \n"
                "CDR rbx \n"
                "DATA rbx \n"
                "mov r11, rbx \n"
                "jmp L_start_div_bin \n "
                
                ".L_make_frac2: \n"
                "DATA rcx \n"
                "cmp rcx, 0 \n"
                "je L_deivision_by_0_error \n "
                "int_to_frac rcx, r10, r11 \n"
               
                "L_start_div_bin: \n"
                ";At this point the first argument is stored as fraction in r8, r9 \n"
                ";At this point the second argument is stored as fraction in r10, r11 \n"

                "xchg r10, r11 \n"
                ;; calc denominator until: r13 = r9*r11
                "mov rax, r9 \n"
                "imul r11 \n"
                "mov r13, rax \n"
                ;; At his point r13 holds the value of the denominator
                
                
                ;; calc nominator until: rsi = r8*r10
                ;;                       r13 = r9*r11
                "mov rax, r8 \n"
                "imul r10 \n"
                "mov rsi, rax \n"
                ;; At his point rsi holds the value of the nominator
                
                "push r13 \n"
                "push rsi \n"
                "push r13 \n"
                "push rsi \n"
                "call gcd \n"
                "add rsp, 8*2 \n"
                "pop rsi \n"
                "pop r13 \n"
                ;; At his point rax holds the value of the gcd of the nominator (rsi) and the denominator (r13)
                
                "mov rdi, rax \n" ;;save the gcd value in rdi
                "my_idiv r13, rdi \n"
                "mov r13, rax \n"
                
                "my_idiv rsi, rdi \n"
                "mov rsi, rax \n"
                
                "cmp r13, 0 \n"
                "jge .L_cont \n"
                "neg r13 \n"
                "neg rsi \n"
                
                ".L_cont: \n"
 
                "cmp r13, 1 \n"
                "je .L_make_integer \n"
                
                "mov rax, [malloc_pointer] \n"
                "my_malloc 8 \n"
                "mov r10, rax \n"
                
                "MAKE_MALLOC_INTEGER rsi \n"
                "mov rsi, rax \n"
                
                "MAKE_MALLOC_INTEGER r13 \n"
                "mov r13, rax \n"
                
                "MAKE_MALLOC_LITERAL_FRACTION r10, rsi, r13 \n"
                "mov rax, r10 \n"
                "jmp L_end_div_bin \n"
                
                ".L_make_integer: \n"
                "MAKE_MALLOC_INTEGER rsi \n"
                "mov rsi, rax \n"

                "L_end_div_bin: \n"
                "leave \n"
                "ret \n"
                
                "L_make_div_bin: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_div_bin \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))
                
                
(define ass-numerator
    (lambda ()      
        (let* 
            ((address (find-address 'numerator global-var-table)))
            (string-append 
                "jmp L_make_numerator \n" 
                "L_numerator: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 1 \n"
                "mov rbx, [rbp + 8*4] \n"
                "mov rbx, [rbx] \n"
                "mov rax, rbx \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "je .L_cont \n "

                "cmp rbx, T_FRACTION \n"
                "jne L_incorrect_type \n "
                "MY_CAR rax \n"
                "jmp .L_done \n"
                
                ".L_cont: \n"
                "mov rax, [rbp + 8*4] \n"
                
                ".L_done: \n"
                "leave \n"
                "ret \n"
                
                "L_make_numerator: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_numerator \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" )))) 

(define ass-denominator
    (lambda ()      
        (let* 
            ((address (find-address 'denominator global-var-table)))
            (string-append 
                "jmp L_make_denominator \n" 
                "L_denominator: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 1 \n"
                "mov rbx, [rbp + 8*4] \n"
                "mov rbx, [rbx] \n"
                "mov rax, rbx \n"
                "TYPE rbx \n"
                "cmp rbx, T_INTEGER \n"
                "je .L_cont \n "

                "cmp rbx, T_FRACTION \n"
                "jne L_incorrect_type \n "
                "MY_CDR rax \n"
                "jmp .L_done \n"
                
                ".L_cont: \n"
                "MAKE_MALLOC_LITERAL_INTEGER 1 \n"
                
                ".L_done: \n"
                "leave \n"
                "ret \n"
                
                "L_make_denominator: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_denominator \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))
				
(define ass-symbol-to-string
    (lambda ()      
        (let* 
            ((address (find-address 'symbol->string global-var-table)))
            (string-append 
                "jmp L_make_symbol_to_string \n" 
                "L_symbol_to_string: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 1 \n"
                "mov rax, [rbp + 8*4] \n"
                "mov rax, [rax] \n"
                "mov rbx, rax \n"
                "TYPE rbx \n"
                "cmp rbx, T_SYMBOL \n"
                "jne L_incorrect_type \n "
                "DATA rax \n"
                "add rax, start_of_data \n"
				
                "leave \n"
                "ret \n"
                
                "L_make_symbol_to_string: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_symbol_to_string \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))

(define ass-string-to-symbol
    (lambda ()      
        (let* 
            ((address (find-address 'string->symbol global-var-table)))
            (string-append 
                "jmp L_make_string_to_symbol \n" 
                "L_string_to_symbol: \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 1 \n"
                "mov rdx, [rbp + 8*4] \n"
                ;"mov rax, [rax] \n"
                "mov rbx, [rdx] \n"
                "TYPE rbx \n"
                "cmp rbx, T_STRING \n"
                "jne L_incorrect_type \n "
                
                ;; rdx = pointer to input string
                "bla0: \n"
			
                "mov rbx, [symbols_table] \n"
                "mov rbx, [rbx] \n"
                
                "mov r15, rdx \n"
                
                "mov rax, [rdx] \n"
                ".L_string_to_symbol_loop: \n"
                "cmp rbx, [L_const2] \n"
                "je .L_end_string_to_symbol_loop \n"
                "mov rcx, rbx \n"
                "MY_CAR rcx \n"
                
                "mov r9, [rcx] \n" ;; r9 - current string literal            
                
                "push rcx, \n"
                "push rax, \n"
                
                "COMPARE_STRINGS r9, rax \n"
                
                "pop rax, \n"
                "pop rcx, \n"
        
                "cmp r11, 1 \n"
                "je .L_was_in_sym_table \n"
                "CDR rbx \n"
                "jmp .L_string_to_symbol_loop \n"
                                                
                ".L_was_in_sym_table: \n"
                "mov r15, rcx \n"
                "jmp .L_end_string_to_symbol \n"
                
                ".L_end_string_to_symbol_loop: \n"
                "push rdx \n"
                "push r15 \n"
                
                "push qword [symbols_table] \n"
                "push qword rdx \n"
                "push 3 \n"
                "push L_const2 \n"
                "call L_cons \n"
                "add rsp, 8*4 \n"

                "pop r15 \n"
                "pop rdx \n"

                "mov [symbols_table], rax \n"

                ".L_end_string_to_symbol:"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 8 \n"
		"sub r15, start_of_data \n"
                "mov qword [rax],  r15 \n"
                "shl qword [rax], 4 \n"
                "or qword [rax], T_SYMBOL \n"
		
                "leave \n"
                "ret \n"
                
                "L_make_string_to_symbol: \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, L_string_to_symbol \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))
                
                
(define ass-apply
    (lambda ()      
        (let* 
            ((address (find-address 'apply global-var-table))
            (start_label "L_apply")
            (make_label (string-append "L_make_" start_label))
            (end_label (string-append "." start_label "_done")))
            (string-append 
                "jmp " make_label " \n" 
                start_label ": \n"
                "push rbp \n"
                "mov rbp, rsp \n"
                "CHECK_ARG_NUM_CORRECTNESS 2 \n"
                "mov rbx, [rbp + 8*4] \n"
				"mov rbx, [rbx] \n"
				"mov rax, rbx \n"
                "TYPE rbx \n"
                "cmp rbx, T_PAIR \n"
                "jne L_incorrect_type \n "
                "MY_CAR rax \n"
				
                end_label ": \n"
                "leave \n"
                "ret \n"
                
                make_label ": \n"
                "mov rax, [malloc_pointer] \n"
                "my_malloc 16 \n"
                "MAKE_LITERAL_CLOSURE rax, L_const2, " start_label " \n"
                "mov rax, [rax] \n"
                "mov [L_glob" (number->string address) "], rax \n\n" ))))
                
                
                
                
                

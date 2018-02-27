%include "scheme.s"

%macro print 2 

push rdi 
push rsi 
push rax 
mov rdi,%1 
mov rsi,%2 
mov rax,0 
call printf 
pop rax 
pop rsi 
pop rdi 

%endmacro 

consts_table:
L_const0:
	dq MAKE_LITERAL(0, 0)
L_const1:
	dq MAKE_LITERAL(1, 0)
L_const2:
	dq MAKE_LITERAL(2, 0)
L_const3:
	dq MAKE_LITERAL(5, 1)
L_const5:
	dq MAKE_LITERAL(5, 0)
L_const7:
	dq MAKE_LITERAL(3, 0)
L_const9:
	dq MAKE_LITERAL(3, 1)
L_const11:
	dq MAKE_LITERAL(3, 129)

global_table:
L_glob13:
	 dq SOB_UNDEFINED 
L_glob14:
	 dq SOB_UNDEFINED 
L_glob15:
	 dq SOB_UNDEFINED 
L_glob16:
	 dq SOB_UNDEFINED 
L_glob17:
	 dq SOB_UNDEFINED 
L_glob18:
	 dq SOB_UNDEFINED 
L_glob19:
	 dq SOB_UNDEFINED 
L_glob20:
	 dq SOB_UNDEFINED 
L_glob21:
	 dq SOB_UNDEFINED 
L_glob22:
	 dq SOB_UNDEFINED 
L_glob23:
	 dq SOB_UNDEFINED 
L_glob24:
	 dq SOB_UNDEFINED 
L_glob25:
	 dq SOB_UNDEFINED 
L_glob26:
	 dq SOB_UNDEFINED 
L_glob27:
	 dq SOB_UNDEFINED 
L_glob28:
	 dq SOB_UNDEFINED 
L_glob29:
	 dq SOB_UNDEFINED 
L_glob30:
	 dq SOB_UNDEFINED 
L_glob31:
	 dq SOB_UNDEFINED 
L_glob32:
	 dq SOB_UNDEFINED 
L_glob33:
	 dq SOB_UNDEFINED 
L_glob34:
	 dq SOB_UNDEFINED 
L_glob35:
	 dq SOB_UNDEFINED 
L_glob36:
	 dq SOB_UNDEFINED 
L_glob37:
	 dq SOB_UNDEFINED 
L_glob38:
	 dq SOB_UNDEFINED 
L_glob39:
	 dq SOB_UNDEFINED 
L_glob40:
	 dq SOB_UNDEFINED 
L_glob41:
	 dq SOB_UNDEFINED 
L_glob42:
	 dq SOB_UNDEFINED 
L_glob43:
	 dq SOB_UNDEFINED 
L_glob44:
	 dq SOB_UNDEFINED 
L_glob45:
	 dq SOB_UNDEFINED 
L_glob46:
	 dq SOB_UNDEFINED 
L_glob47:
	 dq SOB_UNDEFINED 
L_glob48:
	 dq SOB_UNDEFINED 
L_glob49:
	 dq SOB_UNDEFINED 
L_glob50:
	 dq SOB_UNDEFINED 
L_glob51:
	 dq SOB_UNDEFINED 
L_glob52:
	 dq SOB_UNDEFINED 
L_glob53:
	 dq SOB_UNDEFINED 
L_glob54:
	 dq SOB_UNDEFINED 
L_glob55:
	 dq SOB_UNDEFINED 
L_glob56:
	 dq SOB_UNDEFINED 
L_glob57:
	 dq SOB_UNDEFINED 
L_glob58:
	 dq SOB_UNDEFINED 
L_glob59:
	 dq SOB_UNDEFINED 
L_glob60:
	 dq SOB_UNDEFINED 
L_glob61:
	 dq SOB_UNDEFINED 
L_glob62:
	 dq SOB_UNDEFINED 
L_glob63:
	 dq SOB_UNDEFINED 
L_glob64:
	 dq SOB_UNDEFINED 
L_glob65:
	 dq SOB_UNDEFINED 
L_glob66:
	 dq SOB_UNDEFINED 
L_glob67:
	 dq SOB_UNDEFINED 

 symbols_table:
	 dq SOB_UNDEFINED 

global main
section .text
main:

mov rax, malloc_pointer 
mov qword [rax], start_of_malloc 

mov rax, L_const2 
mov [symbols_table], rax 

jmp L_make_null?
L_null?: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 1 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
TYPE rbx 
cmp rbx, T_NIL
jne L_null?_else 
 mov rax, L_const3 
jmp END_null?
L_null?_else: 
mov rax, L_const5 
END_null?: 
leave 
ret 
L_make_null?: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_null? 
mov rax, [rax] 
mov [L_glob18], rax 

jmp L_make_boolean?
L_boolean?: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 1 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
TYPE rbx 
cmp rbx, T_BOOL
jne L_boolean?_else 
 mov rax, L_const3 
jmp END_boolean?
L_boolean?_else: 
mov rax, L_const5 
END_boolean?: 
leave 
ret 
L_make_boolean?: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_boolean? 
mov rax, [rax] 
mov [L_glob39], rax 

jmp L_make_char?
L_char?: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 1 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
TYPE rbx 
cmp rbx, T_CHAR
jne L_char?_else 
 mov rax, L_const3 
jmp END_char?
L_char?_else: 
mov rax, L_const5 
END_char?: 
leave 
ret 
L_make_char?: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_char? 
mov rax, [rax] 
mov [L_glob41], rax 

jmp L_make_integer?
L_integer?: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 1 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
TYPE rbx 
cmp rbx, T_INTEGER
jne L_integer?_else 
 mov rax, L_const3 
jmp END_integer?
L_integer?_else: 
mov rax, L_const5 
END_integer?: 
leave 
ret 
L_make_integer?: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_integer? 
mov rax, [rax] 
mov [L_glob14], rax 

jmp L_make_pair?
L_pair?: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 1 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
TYPE rbx 
cmp rbx, T_PAIR
jne L_pair?_else 
 mov rax, L_const3 
jmp END_pair?
L_pair?_else: 
mov rax, L_const5 
END_pair?: 
leave 
ret 
L_make_pair?: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_pair? 
mov rax, [rax] 
mov [L_glob50], rax 

jmp L_make_procedure?
L_procedure?: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 1 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
TYPE rbx 
cmp rbx, T_CLOSURE
jne L_procedure?_else 
 mov rax, L_const3 
jmp END_procedure?
L_procedure?_else: 
mov rax, L_const5 
END_procedure?: 
leave 
ret 
L_make_procedure?: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_procedure? 
mov rax, [rax] 
mov [L_glob51], rax 

jmp L_make_string?
L_string?: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 1 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
TYPE rbx 
cmp rbx, T_STRING
jne L_string?_else 
 mov rax, L_const3 
jmp END_string?
L_string?_else: 
mov rax, L_const5 
END_string?: 
leave 
ret 
L_make_string?: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_string? 
mov rax, [rax] 
mov [L_glob59], rax 

jmp L_make_symbol?
L_symbol?: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 1 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
TYPE rbx 
cmp rbx, T_SYMBOL
jne L_symbol?_else 
 mov rax, L_const3 
jmp END_symbol?
L_symbol?_else: 
mov rax, L_const5 
END_symbol?: 
leave 
ret 
L_make_symbol?: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_symbol? 
mov rax, [rax] 
mov [L_glob60], rax 

jmp L_make_vector?
L_vector?: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 1 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
TYPE rbx 
cmp rbx, T_VECTOR
jne L_vector?_else 
 mov rax, L_const3 
jmp END_vector?
L_vector?_else: 
mov rax, L_const5 
END_vector?: 
leave 
ret 
L_make_vector?: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_vector? 
mov rax, [rax] 
mov [L_glob66], rax 

jmp L_make_rational 
L_rational: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 1 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
TYPE rbx 
cmp rbx, T_FRACTION 
jne L_rational_maybe_int 
 mov rax, L_const3 
jmp END_rational 
L_rational_maybe_int: 
cmp rbx, T_INTEGER 
jne L_rational_else 
 mov rax, L_const3 
jmp END_rational 
L_rational_else: 
mov rax, L_const5 
END_rational: 
leave 
ret 
L_make_rational: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_rational 
mov rax, [rax] 
mov [L_glob15], rax 

jmp L_make_car 
L_car: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 1 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
mov rax, rbx 
TYPE rbx 
cmp rbx, T_PAIR 
jne L_incorrect_type 
 MY_CAR rax 
leave 
ret 
L_make_car: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_car 
mov rax, [rax] 
mov [L_glob20], rax 

jmp L_make_cdr 
L_cdr: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 1 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
mov rax, rbx 
TYPE rbx 
cmp rbx, T_PAIR 
jne L_incorrect_type 
 MY_CDR rax 
leave 
ret 
L_make_cdr: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_cdr 
mov rax, [rax] 
mov [L_glob21], rax 

jmp L_make_integer_to_char 
L_integer_to_char: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 1 
mov rax, [rbp + 8*4] 
mov rax, [rax] 
mov rbx, rax 
TYPE rax 
cmp rax, T_INTEGER 
jne L_incorrect_type 
 DATA rbx 
mov rax, [malloc_pointer] 
my_malloc 8 
mov qword [rax],  rbx 
shl qword [rax], 4 
or qword [rax], T_CHAR 
leave 
ret 
L_make_integer_to_char: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_integer_to_char 
mov rax, [rax] 
mov [L_glob43], rax 

jmp L_make_char_to_integer 
L_char_to_integer: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 1 
mov rax, [rbp + 8*4] 
mov rax, [rax] 
mov rbx, rax 
TYPE rax 
cmp rax, T_CHAR 
jne L_incorrect_type 
 DATA rbx 
mov rax, [malloc_pointer] 
my_malloc 8 
mov qword [rax],  rbx 
shl qword [rax], 4 
or qword [rax], T_INTEGER 
leave 
ret 
L_make_char_to_integer: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_char_to_integer 
mov rax, [rax] 
mov [L_glob40], rax 

jmp L_make_cons 
L_cons: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 2 
mov r8, [malloc_pointer] 
my_malloc 8 
mov rbx,[rbp + 8*4] 
mov rbx, [rbx] 
mov [r8], rbx  ; here stored car 
mov r9, [malloc_pointer] 
my_malloc 8 
mov rbx,[rbp + 8*5] 
mov rbx, [rbx] 
mov [r9], rbx ; here stored cdr 

;allocate memory for pair in heap in rax 
mov r10, [malloc_pointer] 
my_malloc 8 
MAKE_MALLOC_LITERAL_PAIR r10, r8, r9
mov rax, r10 
leave 
ret 

L_make_cons: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_cons 
mov rax, [rax] 
mov [L_glob19], rax 

jmp L_make_zero 
L_zero: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 1 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
DATA rbx 
cmp rbx, 0 
jne not_zero 
mov rax, L_const3 
jmp END_zero 
not_zero: 
mov rax, L_const5 
END_zero: 
leave 
ret 
L_make_zero: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_zero 
mov rax, [rax] 
mov [L_glob67], rax 

jmp L_make_not 
L_not: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 1 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
mov rdx, rbx 
TYPE rdx 
DATA rbx 
cmp rdx, T_BOOL 
jne not_not 
cmp rbx, 0 
jne not_not 
mov rax, L_const3 
jmp END_not 
not_not: 
mov rax, L_const5 
END_not: 
leave 
ret 
L_make_not: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_not 
mov rax, [rax] 
mov [L_glob48], rax 

jmp L_make_eq 
L_eq: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 2 
mov rbx, [rbp + 8*4] 
mov r8, [rbx] 
TYPE r8 
mov rcx, [rbp + 8*5] 
mov r9, [rcx] 
TYPE r9 
cmp r8, r9 
jne not_eq 
cmp r8, T_SYMBOL 
jne .L_compare_addr 
mov rbx, [rbx] 
mov rcx, [rcx] 
DATA_SYM rbx 
DATA_SYM rcx 
.L_compare_addr: 
cmp rbx, rcx 
jne not_eq 
mov rax, L_const3 
jmp END_eq 
not_eq: 
mov rax, L_const5 
END_eq: 
leave 
ret 
L_make_eq: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_eq 
mov rax, [rax] 
mov [L_glob47], rax 

jmp L_make_string_len 
L_string_len: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 1 
mov rax, [rbp + 8*4] 
mov rax, [rax] 
mov rbx, rax 
TYPE rax 
cmp rax, T_STRING 
jne L_incorrect_type 
 STRING_LENGTH rbx 
mov rax, [malloc_pointer] 
my_malloc 8 
mov qword [rax],  rbx 
shl qword [rax], 4 
or qword [rax], T_INTEGER 
leave 
ret 
L_make_string_len: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_string_len 
mov rax, [rax] 
mov [L_glob55], rax 

jmp L_make_string_ref 
L_string_ref: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 2 
mov rax, [rbp + 8*4] 
mov rax, [rax] 
mov rbx, rax 
TYPE rbx 
cmp rbx, T_STRING 
jne L_incorrect_type 
 mov rcx, [rbp + 8*5] 
mov rcx, [rcx] 
mov rbx, rcx 
TYPE rbx 
cmp rbx, T_INTEGER 
jne L_incorrect_type 
 DATA rcx 
mov rdx, 0 
STRING_REF dl, rax, rcx 
mov rax, [malloc_pointer] 
my_malloc 8 
mov qword [rax],  rdx 
shl qword [rax], 4 
or qword [rax], T_CHAR 
leave 
ret 
L_make_string_ref: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_string_ref 
mov rax, [rax] 
mov [L_glob56], rax 

jmp L_make_make_string 
L_make_string_new: 
push rbp 
mov rbp, rsp 
mov r15, [rbp + 8*3] 
dec r15 
mov rax, [rbp + 8*4] 
mov rax, [rax] 
mov rbx, rax 
TYPE rbx 
cmp rbx, T_INTEGER 
jne L_incorrect_type 
 mov rbx, rax 
DATA rbx 
cmp r15, 1 
je .L_default_string 
CHECK_ARG_NUM_CORRECTNESS 2 
mov rcx, [rbp + 8*5] 
mov rcx, [rcx] 
mov rdx, rcx 
TYPE rdx 
cmp rdx, T_CHAR 
jne L_incorrect_type 
 DATA rcx 
jmp .L_cont 
.L_default_string: 
mov rax, [malloc_pointer] 
my_malloc 8 
mov qword [rax],  0 
shl qword [rax], 4 
or qword [rax], T_CHAR 
mov rcx, rax 
mov rcx, [rcx] 
DATA rcx 
.L_cont: 
mov r10, rbx  
mov rax, [malloc_pointer] 
my_malloc r10 
mov rdx, rax 
L_make_string_loop: 
cmp rbx, 0 
je L_end_loop 
mov [rax],rcx 
add rax, 1 
sub rbx, 1 
jmp L_make_string_loop 
L_end_loop: 
mov rax, [malloc_pointer] 
my_malloc 8 
mov [rax], r10 
shl qword [rax], 34 
sub rdx, start_of_data 
shl rdx, 4 
or rdx, T_STRING 
or qword [rax], rdx 
leave 
ret 
L_make_make_string: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_make_string_new 
mov rax, [rax] 
mov [L_glob44], rax 

jmp L_make_string_set 
L_string_set: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 3 
mov rax, [rbp + 8*4] 
mov rax, [rax] 
mov rbx, rax 
TYPE rbx 
cmp rbx, T_STRING 
jne L_incorrect_type 
 mov rcx, [rbp + 8*5] 
mov rcx, [rcx] 
mov rbx, rcx 
TYPE rbx 
cmp rbx, T_INTEGER 
jne L_incorrect_type 
 DATA rcx 
mov rdx, [rbp + 8*6] 
mov rdx, [rdx] 
mov rbx, rdx 
TYPE rbx 
cmp rbx, T_CHAR 
jne L_incorrect_type 
DATA rdx 
STRING_ELEMENTS rax 
add rax, rcx 
mov byte [rax], dl 
mov rax, L_const1 
leave 
ret 
L_make_string_set: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_string_set 
mov rax, [rax] 
mov [L_glob57], rax 

jmp L_make_vector_len 
L_vector_len: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 1 
mov rax, [rbp + 8*4] 
mov rax, [rax] 
mov rbx, rax 
TYPE rax 
cmp rax, T_VECTOR 
jne L_incorrect_type 
 VECTOR_LENGTH rbx 
mov rax, [malloc_pointer] 
my_malloc 8 
mov qword [rax],  rbx 
shl qword [rax], 4 
or qword [rax], T_INTEGER 
leave 
ret 
L_make_vector_len: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_vector_len 
mov rax, [rax] 
mov [L_glob63], rax 

jmp L_make_vector_ref 
L_vector_ref: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 2 
mov rax, [rbp + 8*4] 
mov rax, [rax] 
mov rbx, rax 
TYPE rbx 
cmp rbx, T_VECTOR 
jne L_incorrect_type 
 mov rcx, [rbp + 8*5] 
mov rcx, [rcx] 
mov rbx, rcx 
TYPE rbx 
cmp rbx, T_INTEGER 
jne L_incorrect_type 
 DATA rcx 
VECTOR_ELEMENTS rax 
mov rax, [rax + rcx*8] 
leave 
ret 
L_make_vector_ref: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_vector_ref 
mov rax, [rax] 
mov [L_glob64], rax 

jmp L_make_vector_set 
L_vector_set: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 3 
mov rax, [rbp + 8*4] 
mov rax, [rax] 
mov rbx, rax 
TYPE rbx 
cmp rbx, T_VECTOR 
jne L_incorrect_type 
 mov rcx, [rbp + 8*5] 
mov rcx, [rcx] 
mov rbx, rcx 
TYPE rbx 
cmp rbx, T_INTEGER 
jne L_incorrect_type 
 DATA rcx 
mov rdx, [rbp + 8*6] 
VECTOR_ELEMENTS rax 
shl rcx, 3 
add rax, rcx 
mov [rax], rdx 
mov rax, L_const1 
leave 
ret 
L_make_vector_set: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_vector_set 
mov rax, [rax] 
mov [L_glob65], rax 

jmp L_make_make_vector 
L_make_vector_new: 
push rbp 
mov rbp, rsp 
mov r15, [rbp + 8*3] 
dec r15 
mov rax, [rbp + 8*4] 
mov rax, [rax] 
mov rbx, rax 
TYPE rbx 
cmp rbx, T_INTEGER 
jne L_incorrect_type 
 mov rbx, rax 
DATA rbx 
cmp r15, 1 
je .L_default_vector 
CHECK_ARG_NUM_CORRECTNESS 2 
mov rcx, [rbp + 8*5] 
jmp .L_cont 
.L_default_vector: 
MAKE_MALLOC_INTEGER 0 
mov rcx, rax 
.L_cont: 
mov r10, rbx  
mov r9, rbx  
shl r10, 3 
mov rax, [malloc_pointer] 
my_malloc r10 
mov rdx, rax 
L_make_vector_loop: 
cmp rbx, 0 
je .L_end_loop 
mov qword [rax], rcx 
add rax, 8 
sub rbx, 1 
jmp L_make_vector_loop 
.L_end_loop: 
mov rax, [malloc_pointer] 
my_malloc 8 
mov [rax], r9 
shl qword [rax], 34 
sub rdx, start_of_data 
shl rdx, 4 
or rdx, T_VECTOR 
or qword [rax], rdx 
leave 
ret 
L_make_make_vector: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_make_vector_new 
mov rax, [rax] 
mov [L_glob45], rax 

jmp L_make_vector 
L_vector_new: 
push rbp 
mov rbp, rsp 
mov r15, [rbp + 8*3] 
dec r15 
mov r10, r15  
shl r10, 3 
mov rax, [malloc_pointer] 
my_malloc r10 
mov rdx, rax 
mov r9, 0 
mov r11,4 
L_vector_loop: 
cmp r9, r15 
je .L_end_loop 
mov r11, r9 
add r11, 4 
shl r11, 3 
mov r11, [rbp + r11] 
mov qword [rax], r11 
add rax, 8 
add r9, 1 
jmp L_vector_loop 
.L_end_loop: 
mov rax, [malloc_pointer] 
my_malloc 8 
mov [rax], r15 
shl qword [rax], 34 
sub rdx, start_of_data 
shl rdx, 4 
or rdx, T_VECTOR 
or qword [rax], rdx 
leave 
ret 
L_make_vector: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_vector_new 
mov rax, [rax] 
mov [L_glob62], rax 

jmp L_make_set_car 
L_set_car: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 2 
mov rax, [rbp + 8*4] 
mov rcx, [rbp + 8*5] 
mov rcx, [rcx] 
mov rax, [rax] 
mov rbx, rax 
TYPE rbx 
cmp rbx, T_PAIR 
jne L_incorrect_type 
 MY_CAR rax 
mov qword [rax], rcx 
mov rax, L_const1 
leave 
ret 
L_make_set_car: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_set_car 
mov rax, [rax] 
mov [L_glob53], rax 

jmp L_make_set_cdr 
L_set_cdr: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 2 
mov rax, [rbp + 8*4] 
mov rcx, [rbp + 8*5] 
mov rcx, [rcx] 
mov rax, [rax] 
mov rbx, rax 
TYPE rbx 
cmp rbx, T_PAIR 
jne L_incorrect_type 
 MY_CDR rax 
mov qword [rax], rcx 
mov rax, L_const1 
leave 
ret 
L_make_set_cdr: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_set_cdr 
mov rax, [rax] 
mov [L_glob54], rax 

jmp L_make_remainder 
L_remainder: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 2 
mov rax, [rbp + 8*4] 
mov rax, [rax] 
mov rbx, rax 
TYPE rbx 
cmp rbx, T_INTEGER 
jne L_incorrect_type 
 mov rcx, [rbp + 8*5] 
mov rcx, [rcx] 
mov rbx, rcx 
TYPE rbx 
cmp rbx, T_INTEGER 
jne L_incorrect_type 
 mov rdx, 0 
DATA rax 
DATA rcx 
cmp rax, 0 
jge L_CONT 
mov r8, rax 
sar rax, 31      ; -1 or 0 (sign of rax) 
xor r8, rax 
sub r8, rax 
mov rax, r8 
idiv rcx 
mov r8, rdx 
mov rdx, 0 
sub rdx, r8 
jmp L_CONT2 
L_CONT: 
idiv rcx 
L_CONT2: 
mov rax, [malloc_pointer] 
my_malloc 8 
mov qword [rax],  rdx 
shl qword [rax], 4 
or qword [rax], T_INTEGER 
leave 
ret 
L_make_remainder: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_remainder 
mov rax, [rax] 
mov [L_glob52], rax 

jmp L_make_smaller_then_bin 
L_smaller_then_bin: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 2 
mov rax, [rbp + 8*4] 
mov rax, [rax] 
mov rbx, rax 
TYPE rbx 
cmp rbx, T_INTEGER 
je L_make_frac1 
 cmp rbx, T_FRACTION 
jne L_incorrect_type 
 mov rbx, rax 
CAR rax 
DATA rax 
mov r8, rax 
CDR rbx 
DATA rbx 
mov r9, rbx 
jmp L_next_arg1 
 L_make_frac1: 
DATA rax 
int_to_frac rax, r8, r9 
L_next_arg1: 
;At this point the first argument is stored as fraction in r8, r9 
mov rcx, [rbp + 8*5] 
mov rcx, [rcx] 
mov rbx, rcx 
TYPE rbx 
cmp rbx, T_INTEGER 
je L_make_frac12 
 cmp rbx, T_FRACTION 
jne L_incorrect_type 
 mov rbx, rcx 
CAR rcx 
DATA rcx 
mov r10, rcx 
CDR rbx 
DATA rbx 
mov r11, rbx 
jmp L_start_smaller_then_bin 
 L_make_frac12: 
DATA rcx 
int_to_frac rcx, r10, r11 
L_start_smaller_then_bin: 
;At this point the first argument is stored as fraction in r8, r9 
;At this point the second argument is stored as fraction in r10, r11 
mov rax, r8 
imul r11 
mov r13, rdx 
mov r14, rax 
mov rax, r9 
imul r10 
mov rsi, rdx 
mov rdi, rax 
cmp r13, rsi 
jg L_smaller_then_bin_false 
cmp r13, rsi 
jl L_smaller_then_bin_true 
cmp r14, rdi 
jge L_smaller_then_bin_false 
cmp r14, rdi 
jl L_smaller_then_bin_true 
L_smaller_then_bin_false: 
mov rax, L_const5 
jmp L_end_smaller_then_bin 
L_smaller_then_bin_true: 
mov rax, L_const3 
jmp L_end_smaller_then_bin 
L_end_smaller_then_bin: 
leave 
ret 
L_make_smaller_then_bin: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_smaller_then_bin 
mov rax, [rax] 
mov [L_glob28], rax 

jmp L_make_bigger_then_bin 
L_bigger_then_bin: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 2 
mov rax, [rbp + 8*4] 
mov rax, [rax] 
mov rbx, rax 
TYPE rbx 
cmp rbx, T_INTEGER 
je L_make_frac2 
 cmp rbx, T_FRACTION 
jne L_incorrect_type 
 mov rbx, rax 
CAR rax 
DATA rax 
mov r8, rax 
CDR rbx 
DATA rbx 
mov r9, rbx 
jmp L_next_arg2 
 L_make_frac2: 
DATA rax 
int_to_frac rax, r8, r9 
L_next_arg2: 
;At this point the first argument is stored as fraction in r8, r9 
mov rcx, [rbp + 8*5] 
mov rcx, [rcx] 
mov rbx, rcx 
TYPE rbx 
cmp rbx, T_INTEGER 
je L_make_frac22 
 cmp rbx, T_FRACTION 
jne L_incorrect_type 
 mov rbx, rcx 
CAR rcx 
DATA rcx 
mov r10, rcx 
CDR rbx 
DATA rbx 
mov r11, rbx 
jmp L_start_bigger_then_bin 
 L_make_frac22: 
DATA rcx 
int_to_frac rcx, r10, r11 
L_start_bigger_then_bin: 
;At this point the first argument is stored as fraction in r8, r9 
;At this point the second argument is stored as fraction in r10, r11 
mov rax, r8 
imul r11 
mov r13, rdx 
mov r14, rax 
mov rax, r9 
imul r10 
mov rsi, rdx 
mov rdi, rax 
cmp r13, rsi 
jg L_bigger_then_bin_true 
cmp r13, rsi 
jl L_bigger_then_bin_false 
cmp r14, rdi 
jg L_bigger_then_bin_true 
cmp r14, rdi 
jle L_bigger_then_bin_false 
L_bigger_then_bin_false: 
mov rax, L_const5 
jmp L_end_bigger_then_bin 
L_bigger_then_bin_true: 
mov rax, L_const3 
jmp L_end_bigger_then_bin 
L_end_bigger_then_bin: 
leave 
ret 
L_make_bigger_then_bin: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_bigger_then_bin 
mov rax, [rax] 
mov [L_glob29], rax 

jmp L_make_equals_bin 
L_equals_bin: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 2 
mov rax, [rbp + 8*4] 
mov rax, [rax] 
mov rbx, rax 
TYPE rbx 
cmp rbx, T_INTEGER 
je L_make_frac3 
 cmp rbx, T_FRACTION 
jne L_incorrect_type 
 mov rbx, rax 
CAR rax 
DATA rax 
mov r8, rax 
CDR rbx 
DATA rbx 
mov r9, rbx 
jmp L_next_arg3 
 L_make_frac3: 
DATA rax 
int_to_frac rax, r8, r9 
L_next_arg3: 
;At this point the first argument is stored as fraction in r8, r9 
mov rcx, [rbp + 8*5] 
mov rcx, [rcx] 
mov rbx, rcx 
TYPE rbx 
cmp rbx, T_INTEGER 
je L_make_frac32 
 cmp rbx, T_FRACTION 
jne L_incorrect_type 
 mov rbx, rcx 
CAR rcx 
DATA rcx 
mov r10, rcx 
CDR rbx 
DATA rbx 
mov r11, rbx 
jmp L_start_equals_bin 
 L_make_frac32: 
DATA rcx 
int_to_frac rcx, r10, r11 
L_start_equals_bin: 
;At this point the first argument is stored as fraction in r8, r9 
;At this point the second argument is stored as fraction in r10, r11 
mov rax, r8 
imul r11 
mov r13, rdx 
mov r14, rax 
mov rax, r9 
imul r10 
mov rsi, rdx 
mov rdi, rax 
cmp r13, rsi 
jne L_equals_false 
cmp r14, rdi 
je L_equals_true 
L_equals_false: 
mov rax, L_const5 
jmp L_end_equals_bin 
L_equals_true: 
mov rax, L_const3 
jmp L_end_equals_bin 
L_end_equals_bin: 
leave 
ret 
L_make_equals_bin: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_equals_bin 
mov rax, [rax] 
mov [L_glob30], rax 

jmp L_make_plus_bin 
L_plus_bin: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 2 
mov rax, [rbp + 8*4] 
mov rax, [rax] 
mov rbx, rax 
TYPE rbx 
cmp rbx, T_INTEGER 
je L_make_frac4 
 cmp rbx, T_FRACTION 
jne L_incorrect_type 
 mov rbx, rax 
CAR rax 
DATA rax 
mov r8, rax 
CDR rbx 
DATA rbx 
mov r9, rbx 
jmp L_next_arg4 
 L_make_frac4: 
DATA rax 
int_to_frac rax, r8, r9 
L_next_arg4: 
;At this point the first argument is stored as fraction in r8, r9 (3 ==> 3/1) 
mov rcx, [rbp + 8*5] 
mov rcx, [rcx] 
mov rbx, rcx 
TYPE rbx 
cmp rbx, T_INTEGER 
je L_make_frac42 
 cmp rbx, T_FRACTION 
jne L_incorrect_type 
 mov rbx, rcx 
CAR rcx 
DATA rcx 
mov r10, rcx 
CDR rbx 
DATA rbx 
mov r11, rbx 
jmp L_start_plus_bin 
 L_make_frac42: 
DATA rcx 
int_to_frac rcx, r10, r11 
L_start_plus_bin: 
;At this point the first argument is stored as fraction in r8, r9 
;At this point the second argument is stored as fraction in r10, r11 
mov rax, 0 
mov rax, r9 
imul r11 
mov r13, rax 
mov rax, 0 
mov rax, r8 
imul r11 
mov r14, rax 
mov rax, 0 
mov rax, r9 
imul r10 
mov rsi, rax 
add rsi, r14 
push r13 
push rsi 
push r13 
push rsi 
call gcd 
add rsp, 8*2 
pop rsi 
pop r13 
mov rdi, rax 
my_idiv r13, rdi 
mov r13, rax 
push r13 
my_idiv rsi, rdi 
mov rsi, rax 
pop r13 
MAKE_MALLOC_INTEGER rsi 
mov rsi, rax 
MAKE_MALLOC_INTEGER r13 
mov r13, rax 
mov rax, [malloc_pointer] 
my_malloc 8 
mov r8, [r13] 
DATA r8 
cmp r8, 1 
je .L_make_integer 
mov r10, rax 
MAKE_MALLOC_LITERAL_FRACTION r10, rsi, r13 
mov rax, r10 
jmp L_end_plus_bin 
.L_make_integer: 
mov rax, rsi 
L_end_plus_bin: 
leave 
ret 
L_make_plus_bin: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_plus_bin 
mov rax, [rax] 
mov [L_glob26], rax 

jmp L_make_minus_bin 
L_minus_bin: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 2 
mov rax, [rbp + 8*4] 
mov rax, [rax] 
mov rbx, rax 
TYPE rbx 
cmp rbx, T_INTEGER 
je .L_make_frac 
 cmp rbx, T_FRACTION 
jne L_incorrect_type 
 mov rbx, rax 
CAR rax 
DATA rax 
mov r8, rax 
CDR rbx 
DATA rbx 
mov r9, rbx 
jmp .L_next_arg 
 .L_make_frac: 
DATA rax 
int_to_frac rax, r8, r9 
.L_next_arg: 
;At this point the first argument is stored as fraction in r8, r9 
mov rcx, [rbp + 8*5] 
mov rcx, [rcx] 
mov rbx, rcx 
TYPE rbx 
cmp rbx, T_INTEGER 
je L_make_frac52 
 cmp rbx, T_FRACTION 
jne L_incorrect_type 
 mov rbx, rcx 
CAR rcx 
DATA rcx 
mov r10, rcx 
CDR rbx 
DATA rbx 
mov r11, rbx 
jmp L_start_minus_bin 
 L_make_frac52: 
DATA rcx 
int_to_frac rcx, r10, r11 
L_start_minus_bin: 
;At this point the first argument is stored as fraction in r8, r9 
;At this point the second argument is stored as fraction in r10, r11 
mov rax, r9 
imul r11 
mov r13, rax 
mov rax, r8 
imul r11 
mov rsi, rax 
mov rax, r9 
imul r10 
mov r14, rax 
sub rsi, r14 
push r13 
push rsi 
push r13 
push rsi 
call gcd 
add rsp, 8*2 
pop rsi 
pop r13 
mov rdi, rax 
my_idiv r13, rdi 
mov r13, rax 
my_idiv rsi, rdi 
mov rsi, rax 
MAKE_MALLOC_INTEGER rsi 
mov rsi, rax 
MAKE_MALLOC_INTEGER r13 
mov r13, rax 
mov rax, [malloc_pointer] 
my_malloc 8 
mov r8, [r13] 
DATA r8 
cmp r8, 1 
je .L_make_integer 
mov r10, rax 
MAKE_MALLOC_LITERAL_FRACTION r10, rsi, r13 
mov rax, r10 
jmp L_end_minus_bin 
.L_make_integer: 
mov rax, rsi 
L_end_minus_bin: 
leave 
ret 
L_make_minus_bin: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_minus_bin 
mov rax, [rax] 
mov [L_glob27], rax 

jmp L_make_mul_bin 
L_mul_bin: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 2 
mov rax, [rbp + 8*4] 
mov rax, [rax] 
mov rbx, rax 
TYPE rbx 
cmp rbx, T_INTEGER 
je .L_make_frac 
 cmp rbx, T_FRACTION 
jne L_incorrect_type 
 mov rbx, rax 
CAR rax 
DATA rax 
mov r8, rax 
CDR rbx 
DATA rbx 
mov r9, rbx 
jmp .L_next_arg 
 .L_make_frac: 
DATA rax 
int_to_frac rax, r8, r9 
.L_next_arg: 
;At this point the first argument is stored as fraction in r8, r9 
mov rcx, [rbp + 8*5] 
mov rcx, [rcx] 
mov rbx, rcx 
TYPE rbx 
cmp rbx, T_INTEGER 
je .L_make_frac2 
 cmp rbx, T_FRACTION 
jne L_incorrect_type 
 mov rbx, rcx 
CAR rcx 
DATA rcx 
mov r10, rcx 
CDR rbx 
DATA rbx 
mov r11, rbx 
jmp L_start_mul_bin 
 .L_make_frac2: 
DATA rcx 
int_to_frac rcx, r10, r11 
L_start_mul_bin: 
;At this point the first argument is stored as fraction in r8, r9 
;At this point the second argument is stored as fraction in r10, r11 
mov rax, r9 
imul r11 
mov r13, rax 
mov rax, r8 
imul r10 
mov rsi, rax 
push r13 
push rsi 
push r13 
push rsi 
call gcd 
add rsp, 8*2 
pop rsi 
pop r13 
mov rdi, rax 
my_idiv r13, rdi 
mov r13, rax 
my_idiv rsi, rdi 
mov rsi, rax 
mov rax, [malloc_pointer] 
my_malloc 8 
mov qword [rax], rsi 
shl qword [rax], 4 
or qword [rax], T_INTEGER 
mov rsi, rax 
mov rax, [malloc_pointer] 
my_malloc 8 
mov qword [rax], r13 
shl qword [rax], 4 
or qword [rax], T_INTEGER 
mov r13, rax 
mov rax, [malloc_pointer] 
my_malloc 8 
mov r8, [r13] 
DATA r8 
cmp r8, 1 
je .L_make_integer 
mov r10, rax 
MAKE_MALLOC_LITERAL_FRACTION r10, rsi, r13 
mov rax, r10 
jmp L_end_mul_bin 
.L_make_integer: 
mov rax, rsi 
L_end_mul_bin: 
leave 
ret 
L_make_mul_bin: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_mul_bin 
mov rax, [rax] 
mov [L_glob32], rax 

jmp L_make_div_bin 
L_div_bin: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 2 
mov rax, [rbp + 8*4] 
mov rax, [rax] 
mov rbx, rax 
TYPE rbx 
cmp rbx, T_INTEGER 
je .L_make_frac 
 cmp rbx, T_FRACTION 
jne L_incorrect_type 
 mov rbx, rax 
CAR rax 
DATA rax 
mov r8, rax 
CDR rbx 
DATA rbx 
mov r9, rbx 
jmp .L_next_arg 
 .L_make_frac: 
DATA rax 
int_to_frac rax, r8, r9 
.L_next_arg: 
;At this point the first argument is stored as fraction in r8, r9 
mov rcx, [rbp + 8*5] 
mov rcx, [rcx] 
mov rbx, rcx 
TYPE rbx 
cmp rbx, T_INTEGER 
je .L_make_frac2 
 cmp rbx, T_FRACTION 
jne L_incorrect_type 
 mov rbx, rcx 
CAR rcx 
DATA rcx 
mov r10, rcx 
CDR rbx 
DATA rbx 
mov r11, rbx 
jmp L_start_div_bin 
 .L_make_frac2: 
DATA rcx 
cmp rcx, 0 
je L_deivision_by_0_error 
 int_to_frac rcx, r10, r11 
L_start_div_bin: 
;At this point the first argument is stored as fraction in r8, r9 
;At this point the second argument is stored as fraction in r10, r11 
xchg r10, r11 
mov rax, r9 
imul r11 
mov r13, rax 
mov rax, r8 
imul r10 
mov rsi, rax 
push r13 
push rsi 
push r13 
push rsi 
call gcd 
add rsp, 8*2 
pop rsi 
pop r13 
mov rdi, rax 
my_idiv r13, rdi 
mov r13, rax 
my_idiv rsi, rdi 
mov rsi, rax 
cmp r13, 0 
jge .L_cont 
neg r13 
neg rsi 
.L_cont: 
cmp r13, 1 
je .L_make_integer 
mov rax, [malloc_pointer] 
my_malloc 8 
mov r10, rax 
MAKE_MALLOC_INTEGER rsi 
mov rsi, rax 
MAKE_MALLOC_INTEGER r13 
mov r13, rax 
MAKE_MALLOC_LITERAL_FRACTION r10, rsi, r13 
mov rax, r10 
jmp L_end_div_bin 
.L_make_integer: 
MAKE_MALLOC_INTEGER rsi 
mov rsi, rax 
L_end_div_bin: 
leave 
ret 
L_make_div_bin: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_div_bin 
mov rax, [rax] 
mov [L_glob31], rax 

jmp L_make_denominator 
L_denominator: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 1 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
mov rax, rbx 
TYPE rbx 
cmp rbx, T_INTEGER 
je .L_cont 
 cmp rbx, T_FRACTION 
jne L_incorrect_type 
 MY_CDR rax 
jmp .L_done 
.L_cont: 
MAKE_MALLOC_LITERAL_INTEGER 1 
.L_done: 
leave 
ret 
L_make_denominator: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_denominator 
mov rax, [rax] 
mov [L_glob42], rax 

jmp L_make_numerator 
L_numerator: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 1 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
mov rax, rbx 
TYPE rbx 
cmp rbx, T_INTEGER 
je .L_cont 
 cmp rbx, T_FRACTION 
jne L_incorrect_type 
 MY_CAR rax 
jmp .L_done 
.L_cont: 
mov rax, [rbp + 8*4] 
.L_done: 
leave 
ret 
L_make_numerator: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_numerator 
mov rax, [rax] 
mov [L_glob49], rax 

jmp L_make_plus 
L_plus: 
push rbp 
mov rbp, rsp 
mov r12, 0 
MAKE_MALLOC_INTEGER r12 
mov r15, rax 
NUM_OF_ARGS rcx 
cmp rcx, 0 
je .L_plus_done 
mov r10, 0 
.while: 
TAKE_ARG r8, r10 
push rcx 
push r10 
push r15 
push r8 
push 3 
push L_const2 
call L_plus_bin 
add rsp, 4*8 
pop r10 
pop rcx 
mov r15, rax           ;;save in r15 the sum result 
inc r10 
cmp r10, rcx 
je .L_plus_done 
jmp .while 
.L_plus_done: 
leave 
ret 
L_make_plus: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_plus 
mov rax, [rax] 
mov [L_glob36], rax 

jmp L_make_minus 
L_minus: 
push rbp 
mov rbp, rsp 
mov r12, 0 
MAKE_MALLOC_INTEGER r12 
mov r15, rax 
NUM_OF_ARGS rcx 
cmp rcx, 0 
je L_incorrect_num_of_args 
cmp rcx, 1 
jne .L_more_than_2_args 
mov r10, 0 
TAKE_ARG r8, r10 
push rcx 
push r10 
push r8 
push r15 
push 3 
push L_const2 
call L_minus_bin 
add rsp, 4*8 
pop r10 
pop rcx 
jmp .L_minus_done 
.L_more_than_2_args: 
mov r10, 0 
TAKE_ARG r15, r10 
inc r10 
.while: 
TAKE_ARG r8, r10 
push rcx 
push r10 
push r8 
push r15 
push 3 
push L_const2 
call L_minus_bin 
add rsp, 4*8 
pop r10 
pop rcx 
mov r15, rax           ;;save in r15 the sum result 
inc r10 
cmp r10, rcx 
je .L_minus_done 
jmp .while 
.L_minus_done: 
leave 
ret 
L_make_minus: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_minus 
mov rax, [rax] 
mov [L_glob25], rax 

jmp L_make_smaller 
L_smaller: 
push rbp 
mov rbp, rsp 
mov r12, 0 
MAKE_MALLOC_INTEGER r12 
mov r15, rax 
NUM_OF_ARGS rcx 
cmp rcx, 0 
je L_incorrect_num_of_args 
cmp rcx, 1 
jne .L_more_than_2_args 
mov rax, L_const3 
jmp .L_smaller_done 
.L_more_than_2_args: 
mov r10, 0 
dec rcx 
.while: 
TAKE_ARG r15, r10 
inc r10 
TAKE_ARG r8, r10 
push rcx 
push r10 
push r8 
push r15 
push 3 
push L_const2 
call L_smaller_then_bin 
add rsp, 4*8 
pop r10 
pop rcx 
cmp rax, L_const5           ;;compare result with #f 
je .L_smaller_done 
cmp r10, rcx 
je .L_smaller_done 
jmp .while 
.L_smaller_done: 
leave 
ret 
L_make_smaller: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_smaller 
mov rax, [rax] 
mov [L_glob34], rax 

jmp L_make_bigger 
L_bigger: 
push rbp 
mov rbp, rsp 
mov r12, 0 
MAKE_MALLOC_INTEGER r12 
mov r15, rax 
NUM_OF_ARGS rcx 
cmp rcx, 0 
je L_incorrect_num_of_args 
cmp rcx, 1 
jne .L_more_than_2_args 
mov rax, L_const3 
jmp .L_bigger_done 
.L_more_than_2_args: 
mov r10, 0 
dec rcx 
.while: 
TAKE_ARG r15, r10 
inc r10 
TAKE_ARG r8, r10 
push rcx 
push r10 
push r8 
push r15 
push 3 
push L_const2 
call L_bigger_then_bin 
add rsp, 4*8 
pop r10 
pop rcx 
cmp rax, L_const5           ;;compare result with #f 
je .L_bigger_done 
cmp r10, rcx 
je .L_bigger_done 
jmp .while 
.L_bigger_done: 
leave 
ret 
L_make_bigger: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_bigger 
mov rax, [rax] 
mov [L_glob35], rax 

jmp L_make_L_equal 
L_equal: 
push rbp 
mov rbp, rsp 
mov r12, 0 
MAKE_MALLOC_INTEGER r12 
mov r15, rax 
NUM_OF_ARGS rcx 
cmp rcx, 0 
je L_incorrect_num_of_args 
cmp rcx, 1 
jne .L_more_than_2_args 
mov rax, L_const3 
jmp .L_equal_done 
.L_more_than_2_args: 
mov r10, 0 
dec rcx 
.while: 
TAKE_ARG r15, r10 
inc r10 
TAKE_ARG r8, r10 
push rcx 
push r10 
push r8 
push r15 
push 3 
push L_const2 
call L_equals_bin 
add rsp, 4*8 
pop r10 
pop rcx 
cmp rax, L_const5           ;;compare result with #f 
je .L_equal_done 
cmp r10, rcx 
je .L_equal_done 
jmp .while 
.L_equal_done: 
leave 
ret 
L_make_L_equal: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_equal 
mov rax, [rax] 
mov [L_glob24], rax 

jmp L_make_L_div 
L_div: 
push rbp 
mov rbp, rsp 
mov r12, 1 
MAKE_MALLOC_INTEGER r12 
mov r15, rax 
NUM_OF_ARGS rcx 
cmp rcx, 0 
je L_incorrect_num_of_args 
cmp rcx, 1 
jne .L_more_than_2_args 
mov r10, 0 
TAKE_ARG r8, r10 
push rcx 
push r10 
push r8 
push r15 
push 3 
push L_const2 
call L_div_bin 
add rsp, 4*8 
pop r10 
pop rcx 
jmp .L_div_done 
.L_more_than_2_args: 
mov r10, 0 
TAKE_ARG r15, r10 
inc r10 
.while: 
TAKE_ARG r8, r10 
push rcx 
push r10 
push r8 
push r15 
push 3 
push L_const2 
call L_div_bin 
add rsp, 4*8 
pop r10 
pop rcx 
mov r15, rax           ;;save in r15 the sum result 
inc r10 
cmp r10, rcx 
je .L_div_done 
jmp .while 
.L_div_done: 
leave 
ret 
L_make_L_div: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_div 
mov rax, [rax] 
mov [L_glob37], rax 

jmp L_make_L_mul 
L_mul: 
push rbp 
mov rbp, rsp 
mov r12, 1 
MAKE_MALLOC_INTEGER r12 
mov r15, rax 
NUM_OF_ARGS rcx 
cmp rcx, 0 
je .L_mul_done 
mov r10, 0 
.while: 
TAKE_ARG r8, r10 
push rcx 
push r10 
push r8 
push r15 
push 3 
push L_const2 
call L_mul_bin 
add rsp, 4*8 
pop r10 
pop rcx 
mov r15, rax           ;;save in r15 the sum result 
inc r10 
cmp r10, rcx 
je .L_mul_done 
jmp .while 
.L_mul_done: 
leave 
ret 
L_make_L_mul: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_mul 
mov rax, [rax] 
mov [L_glob38], rax 

jmp L_make_symbol_to_string 
L_symbol_to_string: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 1 
mov rax, [rbp + 8*4] 
mov rax, [rax] 
mov rbx, rax 
TYPE rbx 
cmp rbx, T_SYMBOL 
jne L_incorrect_type 
 DATA rax 
add rax, start_of_data 
leave 
ret 
L_make_symbol_to_string: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_symbol_to_string 
mov rax, [rax] 
mov [L_glob61], rax 

jmp L_make_string_to_symbol 
L_string_to_symbol: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 1 
mov rdx, [rbp + 8*4] 
mov rbx, [rdx] 
TYPE rbx 
cmp rbx, T_STRING 
jne L_incorrect_type 
 bla0: 
mov rbx, [symbols_table] 
mov rbx, [rbx] 
mov r15, rdx 
mov rax, [rdx] 
.L_string_to_symbol_loop: 
cmp rbx, [L_const2] 
je .L_end_string_to_symbol_loop 
mov rcx, rbx 
MY_CAR rcx 
mov r9, [rcx] 
push rcx, 
push rax, 
COMPARE_STRINGS r9, rax 
pop rax, 
pop rcx, 
cmp r11, 1 
je .L_was_in_sym_table 
CDR rbx 
jmp .L_string_to_symbol_loop 
.L_was_in_sym_table: 
mov r15, rcx 
jmp .L_end_string_to_symbol 
.L_end_string_to_symbol_loop: 
push rdx 
push r15 
push qword [symbols_table] 
push qword rdx 
push 3 
push L_const2 
call L_cons 
add rsp, 8*4 
pop r15 
pop rdx 
mov [symbols_table], rax 
.L_end_string_to_symbol:mov rax, [malloc_pointer] 
my_malloc 8 
sub r15, start_of_data 
mov qword [rax],  r15 
shl qword [rax], 4 
or qword [rax], T_SYMBOL 
leave 
ret 
L_make_string_to_symbol: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_string_to_symbol 
mov rax, [rax] 
mov [L_glob58], rax 

mov rax, [malloc_pointer] 
my_malloc 16 
mov rbx, [malloc_pointer] 
my_malloc (8*1) 
mov rcx, [malloc_pointer] 
my_malloc (8*1) 
mov rsi, rbx 
mov qword [rsi], rcx 
mov rdx,[rbp + (4 + 0)*8] 
mov qword [rcx], rdx 
add rcx, 8 
add rsi, 8 
mov rdx,[rbp + 2*8] 
mov r15, rdx 
MAKE_LITERAL_CLOSURE rax, rbx, L_lambda_code4
jmp END_L_lambda_code4
L_lambda_code4: 
push rbp 
mov rbp, rsp 
push L_const2 
mov rax, qword [rbp + (4 + 0) * 8] 
push rax 
push 2
mov rax, L_glob14 
mov rbx, [rax] 
TYPE rbx 
cmp rbx, T_CLOSURE 
jne L_error 
mov rbx, [rax] 
CLOSURE_ENV rbx 
push rbx 
mov rax, [rax] 
CLOSURE_CODE rax 
call rax 
mov rbx, qword [rsp + 8] 
add rbx, 2 
shl rbx, 3 
add rsp, rbx 
L_remove_nils9: 
mov r13, [rax] 
cmp r13, [L_const5]
jne L_or_done2
push L_const2              ;push '() to stack 
mov rax, qword [rbp + (4 + 0) * 8] 
push rax 
push 2
mov rax, L_glob15 
mov rbx, [rax] 
TYPE rbx 
cmp rbx, T_CLOSURE 
jne L_error 
mov rbx, [rax] 
CLOSURE_ENV rbx 
push rbx 
mov rdi, [rbp+8] 
push rdi 
 
mov r14, [rsp +8*2] 
mov r15, [rbp +8*3] 
mov r8, rbp 
mov r9, r8 
sub r8 , 8 
add r15, 3 
shl r15, 3 
add r9, r15 
add r14, 3 
.loop: 
cmp r14, 0 
je .cont 
mov rcx, [r8] 
mov [r9], rcx 
sub r8 , 8 
sub r9 , 8 
dec r14 
jmp .loop 
.cont: 
add r9 , 8 
mov rsp, r9 
mov rax, [rax] 
CLOSURE_CODE rax 
jmp rax 
L_or_done2:
leave 
ret 
END_L_lambda_code4: 
mov rax, [rax] 
mov [L_glob13], rax 
mov rax, L_const1 
push qword [rax]
call write_sob_if_not_void
add rsp, 1*8
mov rax, [malloc_pointer] 
my_malloc 16 
mov rbx, [malloc_pointer] 
my_malloc (8*1) 
mov rcx, [malloc_pointer] 
my_malloc (8*1) 
mov rsi, rbx 
mov qword [rsi], rcx 
mov rdx,[rbp + (4 + 0)*8] 
mov qword [rcx], rdx 
add rcx, 8 
add rsi, 8 
mov rdx,[rbp + 2*8] 
MAKE_LITERAL_CLOSURE rax, rbx, L_lambda_code5
jmp END_L_lambda_code5
L_lambda_code5: 
push rbp 
mov rbp, rsp 
mov r12, rbp 
add r12, 8*3 
mov r13, [r12]   ;store total num of params in r13 
mov r10, r13 
shl r10, 3  ; r10 = r13*8
add r12, r10 
mov r11, r12 ; In order to keep the initial point 
sub r13, 1 

;r12 = poinetr to last param (first index of iteration) 
;r13 = num of params (only those from the list) 
;r11 = nil which is the first argument in any frame 
sub r12, 8 
mov rax, L_const2 ;Initialize rax with nil 

;If at this point r13 is 0, it means that there are no args in the list so we do nothing! 
cmp r13, 0 
je L_lambda_opt_end_code1 
push r12 
push r13 
push qword L_const2   ; push nil to as first argument 
push qword [r12]      ; push the first element of the iteration 
push 3            ; push num of args 
push L_const2     ; push empty env (only to keep the form) 
call L_cons       ; the return value will be stored in rax 
add rsp, 8*4 
pop r13 
pop r12 
L_lambda_opt_start_code1: 
   sub r12, 8 
   sub r13, 1 
   cmp r13, 0 
   je L_lambda_opt_end_code1 
   
   push r12 
   push r13 
   push rax          ; push the last created pair to be the cdr 
   push qword [r12]      ; push next arg to be the car of the pair 
   push 3            ; push num of args (car and cdr) 
   push L_const2     ; push empty env (only to keep the form) 
   call L_cons       ; the return value will be stored in rax 
   add rsp, 8*4 
   pop r13 
   pop r12 
   jmp L_lambda_opt_start_code1 
L_lambda_opt_end_code1: 
;At this point, the whole list is stored in rax 
mov qword [rbp + 8*3], 1 
mov r12, 3 
mov qword [r11], rax ; copy the args list to the bottom of the new frame 
.L_start_rearrange_lambda_opt: 
   sub r11, 8 
   mov rsi, [rbp + 8*r12] 
   mov qword [r11], rsi 
   
   sub r12, 1 
   cmp r12, 0 
   jge .L_start_rearrange_lambda_opt 
mov rsp, r11 ;update rsp to point to the top of the rearranged frame 
mov rbp, rsp 
mov rax, qword [rbp + (4 + 0) * 8] 
leave 
ret 
END_L_lambda_code5: 
mov rax, [rax] 
mov [L_glob16], rax 
mov rax, L_const1 
push qword [rax]
call write_sob_if_not_void
add rsp, 1*8
mov rax, [malloc_pointer] 
my_malloc 16 
mov rbx, [malloc_pointer] 
my_malloc (8*1) 
mov rcx, [malloc_pointer] 
my_malloc (8*0) 
mov rsi, rbx 
mov qword [rsi], rcx 
add rsi, 8 
mov rdx,[rbp + 2*8] 
mov r15, rdx 
MAKE_LITERAL_CLOSURE rax, rbx, L_lambda_code1
jmp END_L_lambda_code1
L_lambda_code1: 
push rbp 
mov rbp, rsp 
push L_const2 
mov rax, qword [rbp + (4 + 0) * 8] 
push rax 
push 2
mov rax, L_glob18 
mov rbx, [rax] 
TYPE rbx 
cmp rbx, T_CLOSURE 
jne L_error 
mov rbx, [rax] 
CLOSURE_ENV rbx 
push rbx 
mov rax, [rax] 
CLOSURE_CODE rax 
call rax 
mov rbx, qword [rsp + 8] 
add rbx, 2 
shl rbx, 3 
add rsp, rbx 
L_remove_nils5: 
mov rax, [rax] 
cmp rax, [L_const5] 
je L_if3_else1
mov rax, qword [rbp + (4 + 1) * 8] 
jmp L_if3_done1
L_if3_else1:
push L_const2              ;push '() to stack 
push L_const2 
mov rax, qword [rbp + (4 + 1) * 8] 
push rax 
push L_const2 
mov rax, qword [rbp + (4 + 0) * 8] 
push rax 
push 2
mov rax, L_glob21 
mov rbx, [rax] 
TYPE rbx 
cmp rbx, T_CLOSURE 
jne L_error 
mov rbx, [rax] 
CLOSURE_ENV rbx 
push rbx 
mov rax, [rax] 
CLOSURE_CODE rax 
call rax 
mov rbx, qword [rsp + 8] 
add rbx, 2 
shl rbx, 3 
add rsp, rbx 
L_remove_nils4: 
push rax 
push 3
mov rax, L_glob17 
mov rbx, [rax] 
TYPE rbx 
cmp rbx, T_CLOSURE 
jne L_error 
mov rbx, [rax] 
CLOSURE_ENV rbx 
push rbx 
mov rax, [rax] 
CLOSURE_CODE rax 
call rax 
mov rbx, qword [rsp + 8] 
add rbx, 2 
shl rbx, 3 
add rsp, rbx 
L_remove_nils3: 
push rax 
push L_const2 
mov rax, qword [rbp + (4 + 0) * 8] 
push rax 
push 2
mov rax, L_glob20 
mov rbx, [rax] 
TYPE rbx 
cmp rbx, T_CLOSURE 
jne L_error 
mov rbx, [rax] 
CLOSURE_ENV rbx 
push rbx 
mov rax, [rax] 
CLOSURE_CODE rax 
call rax 
mov rbx, qword [rsp + 8] 
add rbx, 2 
shl rbx, 3 
add rsp, rbx 
L_remove_nils2: 
push rax 
push 3
mov rax, L_glob19 
mov rbx, [rax] 
TYPE rbx 
cmp rbx, T_CLOSURE 
jne L_error 
mov rbx, [rax] 
CLOSURE_ENV rbx 
push rbx 
mov rdi, [rbp+8] 
push rdi 
 
mov r14, [rsp +8*2] 
mov r15, [rbp +8*3] 
mov r8, rbp 
mov r9, r8 
sub r8 , 8 
add r15, 3 
shl r15, 3 
add r9, r15 
add r14, 3 
.loop: 
cmp r14, 0 
je .cont 
mov rcx, [r8] 
mov [r9], rcx 
sub r8 , 8 
sub r9 , 8 
dec r14 
jmp .loop 
.cont: 
add r9 , 8 
mov rsp, r9 
mov rax, [rax] 
CLOSURE_CODE rax 
jmp rax 
L_if3_done1:
leave 
ret 
END_L_lambda_code1: 
mov rax, [rax] 
mov [L_glob17], rax 
mov rax, L_const1 
push qword [rax]
call write_sob_if_not_void
add rsp, 1*8
mov rax, [malloc_pointer] 
my_malloc 16 
mov rbx, [malloc_pointer] 
my_malloc (8*1) 
mov rcx, [malloc_pointer] 
my_malloc (8*2) 
mov rsi, rbx 
mov qword [rsi], rcx 
mov rdx,[rbp + (4 + 0)*8] 
mov qword [rcx], rdx 
add rcx, 8 
mov rdx,[rbp + (4 + 1)*8] 
mov qword [rcx], rdx 
add rcx, 8 
add rsi, 8 
mov rdx,[rbp + 2*8] 
mov r15, rdx 
MAKE_LITERAL_CLOSURE rax, rbx, L_lambda_code2
jmp END_L_lambda_code2
L_lambda_code2: 
push rbp 
mov rbp, rsp 
mov rax, [malloc_pointer] 
my_malloc 16 
mov rbx, [malloc_pointer] 
my_malloc (8*2) 
mov rcx, [malloc_pointer] 
my_malloc (8*1) 
mov rsi, rbx 
mov qword [rsi], rcx 
mov rdx,[rbp + (4 + 0)*8] 
mov qword [rcx], rdx 
add rcx, 8 
add rsi, 8 
mov rdx,[rbp + 2*8] 
mov r15, rdx 
mov rdx, [r15 + 8*0] 
mov qword [rsi], rdx 
add rsi, 8 
MAKE_LITERAL_CLOSURE rax, rbx, L_lambda_code3
jmp END_L_lambda_code3
L_lambda_code3: 
push rbp 
mov rbp, rsp 
push L_const2 
mov rax, L_const7 
push rax 
mov rax, qword [rbp + (4 + 0) * 8] 
push rax 
push 3
mov rax, L_glob24 
mov rbx, [rax] 
TYPE rbx 
cmp rbx, T_CLOSURE 
jne L_error 
mov rbx, [rax] 
CLOSURE_ENV rbx 
push rbx 
mov rax, [rax] 
CLOSURE_CODE rax 
call rax 
mov rbx, qword [rsp + 8] 
add rbx, 2 
shl rbx, 3 
add rsp, rbx 
L_remove_nils7: 
mov r13, [rax] 
cmp r13, [L_const5]
jne L_or_done1
push L_const2              ;push '() to stack 
push L_const2 
mov rax, L_const9 
push rax 
mov rax, qword [rbp + (4 + 0) * 8] 
push rax 
push 3
mov rax, L_glob25 
mov rbx, [rax] 
TYPE rbx 
cmp rbx, T_CLOSURE 
jne L_error 
mov rbx, [rax] 
CLOSURE_ENV rbx 
push rbx 
mov rax, [rax] 
CLOSURE_CODE rax 
call rax 
mov rbx, qword [rsp + 8] 
add rbx, 2 
shl rbx, 3 
add rsp, rbx 
L_remove_nils6: 
push rax 
push 2
mov rax, L_glob22 
mov rbx, [rax] 
TYPE rbx 
cmp rbx, T_CLOSURE 
jne L_error 
mov rbx, [rax] 
CLOSURE_ENV rbx 
push rbx 
mov rdi, [rbp+8] 
push rdi 
 
mov r14, [rsp +8*2] 
mov r15, [rbp +8*3] 
mov r8, rbp 
mov r9, r8 
sub r8 , 8 
add r15, 3 
shl r15, 3 
add r9, r15 
add r14, 3 
.loop: 
cmp r14, 0 
je .cont 
mov rcx, [r8] 
mov [r9], rcx 
sub r8 , 8 
sub r9 , 8 
dec r14 
jmp .loop 
.cont: 
add r9 , 8 
mov rsp, r9 
mov rax, [rax] 
CLOSURE_CODE rax 
jmp rax 
L_or_done1:
leave 
ret 
END_L_lambda_code3: 
mov rax, [rax] 
mov [L_glob23], rax 
mov rax, L_const1 
push L_const2 
mov rax, qword [rbp + (4 + 0) * 8] 
push rax 
push 2
mov rax, L_glob23 
mov rbx, [rax] 
TYPE rbx 
cmp rbx, T_CLOSURE 
jne L_error 
mov rbx, [rax] 
CLOSURE_ENV rbx 
push rbx 
mov rax, [rax] 
CLOSURE_CODE rax 
call rax 
mov rbx, qword [rsp + 8] 
add rbx, 2 
shl rbx, 3 
add rsp, rbx 
L_remove_nils8: 
mov rax, [rax] 
cmp rax, [L_const5] 
je L_if3_else2
mov rax, L_const5 
jmp L_if3_done2
L_if3_else2:
mov rax, L_const3 
L_if3_done2:
leave 
ret 
END_L_lambda_code2: 
mov rax, [rax] 
mov [L_glob22], rax 
mov rax, L_const1 
push qword [rax]
call write_sob_if_not_void
add rsp, 1*8
push L_const2 
mov rax, L_const11 
push rax 
push 2
mov rax, L_glob22 
mov rbx, [rax] 
TYPE rbx 
cmp rbx, T_CLOSURE 
jne L_error 
mov rbx, [rax] 
CLOSURE_ENV rbx 
push rbx 
mov rax, [rax] 
CLOSURE_CODE rax 
call rax 
mov rbx, qword [rsp + 8] 
add rbx, 2 
shl rbx, 3 
add rsp, rbx 
L_remove_nils1: 
push qword [rax]
call write_sob_if_not_void
add rsp, 1*8
remove_from_stack: 
cmp qword [rsp], L_const2 
jne END_of_program 
add rsp, 8 
jmp remove_from_stack 
END_of_program: 

ret


section .rodata 
	 format_str: DB "%s", 10,0 
	 format_num: DD "%d", 10,0 
	 newline: DB 10, 0 
	 error_msg: DB "ERROR!!!", 10, 0 
	 error_num_args_msg: DB "incorrect number of arguments", 10, 0 
	 error_type_msg: DB "incorrect type", 10, 0 

	 error_division_by_0_msg: DB "Error: Divided by 0", 10, 0 

L_error: 
	print format_str, error_msg 
   jmp L_END 

L_incorrect_num_of_args: 
	print format_str, error_num_args_msg 
   jmp L_END 

L_incorrect_type: 
	print format_str, error_type_msg 
   jmp L_END 

L_deivision_by_0_error: 
	print format_str, error_division_by_0_msg 
   jmp L_END 

L_END: 

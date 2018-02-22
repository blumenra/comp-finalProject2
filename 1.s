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
	dq MAKE_LITERAL(3, 5)
L_const9:
	dq MAKE_LITERAL(3, 1)
L_const11:
	MAKE_LITERAL_STRING 109, 97, 111, 114
L_const17:
	dq MAKE_LITERAL_SYMBOL(L_const11)
L_const19:
	dq MAKE_LITERAL(6, 97)
L_const21:
	dq MAKE_LITERAL(3, 7)

global_table:
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
L_glob68:
	 dq SOB_UNDEFINED 
L_glob69:
	 dq SOB_UNDEFINED 
L_glob70:
	 dq SOB_UNDEFINED 

global main
section .text
main:

mov rax, malloc_pointer 
mov qword [rax], start_of_malloc 

jmp L_make_null
L_null: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 1 
jne L_error 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
TYPE rbx 
cmp rbx, T_NIL
jne L_null_else 
 mov rax, L_const3 
jmp END_null
L_null_else: 
mov rax, L_const5 
END_null: 
leave 
ret 
L_make_null: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_null 
mov rax, [rax] 
mov [L_glob51], rax 

jmp L_make_boolean
L_boolean: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 1 
jne L_error 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
TYPE rbx 
cmp rbx, T_BOOL
jne L_boolean_else 
 mov rax, L_const3 
jmp END_boolean
L_boolean_else: 
mov rax, L_const5 
END_boolean: 
leave 
ret 
L_make_boolean: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_boolean 
mov rax, [rax] 
mov [L_glob38], rax 

jmp L_make_char
L_char: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 1 
jne L_error 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
TYPE rbx 
cmp rbx, T_CHAR
jne L_char_else 
 mov rax, L_const3 
jmp END_char
L_char_else: 
mov rax, L_const5 
END_char: 
leave 
ret 
L_make_char: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_char 
mov rax, [rax] 
mov [L_glob28], rax 

jmp L_make_integer
L_integer: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 1 
jne L_error 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
TYPE rbx 
cmp rbx, T_INTEGER
jne L_integer_else 
 mov rax, L_const3 
jmp END_integer
L_integer_else: 
mov rax, L_const5 
END_integer: 
leave 
ret 
L_make_integer: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_integer 
mov rax, [rax] 
mov [L_glob24], rax 

jmp L_make_pair
L_pair: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 1 
jne L_error 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
TYPE rbx 
cmp rbx, T_PAIR
jne L_pair_else 
 mov rax, L_const3 
jmp END_pair
L_pair_else: 
mov rax, L_const5 
END_pair: 
leave 
ret 
L_make_pair: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_pair 
mov rax, [rax] 
mov [L_glob53], rax 

jmp L_make_procedure
L_procedure: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 1 
jne L_error 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
TYPE rbx 
cmp rbx, T_CLOSURE
jne L_procedure_else 
 mov rax, L_const3 
jmp END_procedure
L_procedure_else: 
mov rax, L_const5 
END_procedure: 
leave 
ret 
L_make_procedure: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_procedure 
mov rax, [rax] 
mov [L_glob54], rax 

jmp L_make_rational
L_rational: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 1 
jne L_error 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
TYPE rbx 
cmp rbx, T_FRACTION
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
mov [L_glob25], rax 

jmp L_make_string
L_string: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 1 
jne L_error 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
TYPE rbx 
cmp rbx, T_STRING
jne L_string_else 
 mov rax, L_const3 
jmp END_string
L_string_else: 
mov rax, L_const5 
END_string: 
leave 
ret 
L_make_string: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_string 
mov rax, [rax] 
mov [L_glob27], rax 

jmp L_make_symbol
L_symbol: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 1 
jne L_error 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
TYPE rbx 
cmp rbx, T_SYMBOL
jne L_symbol_else 
 mov rax, L_const3 
jmp END_symbol
L_symbol_else: 
mov rax, L_const5 
END_symbol: 
leave 
ret 
L_make_symbol: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_symbol 
mov rax, [rax] 
mov [L_glob62], rax 

jmp L_make_vector
L_vector: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 1 
jne L_error 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
TYPE rbx 
cmp rbx, T_VECTOR
jne L_vector_else 
 mov rax, L_const3 
jmp END_vector
L_vector_else: 
mov rax, L_const5 
END_vector: 
leave 
ret 
L_make_vector: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_vector 
mov rax, [rax] 
mov [L_glob68], rax 

jmp L_make_car 
L_car: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 1 
jne L_incorrect_num_of_args 
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
mov [L_glob39], rax 

jmp L_make_cdr 
L_cdr: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 1 
jne L_incorrect_num_of_args 
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
mov [L_glob40], rax 

jmp L_make_integer_to_char 
L_integer_to_char: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 1 
jne L_incorrect_num_of_args 
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
mov [L_glob44], rax 

jmp L_make_char_to_integer 
L_char_to_integer: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 1 
jne L_incorrect_num_of_args 
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
mov [L_glob41], rax 

jmp L_make_cons 
L_cons: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 2 
jne L_incorrect_num_of_args 
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
mov [L_glob42], rax 

jmp L_make_zero 
L_zero: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 1 
jne L_incorrect_num_of_args 
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
mov [L_glob69], rax 

jmp L_make_not 
L_not: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 1 
jne L_incorrect_num_of_args 
mov rbx, [rbp + 8*4] 
mov rbx, [rbx] 
DATA rbx 
mov rax, L_const5 
DATA rax 
cmp rbx,rax 
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
mov [L_glob50], rax 

jmp L_make_eq 
L_eq: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 2 
jne L_incorrect_num_of_args 
mov rbx, [rbp + 8*4] 
mov rcx, [rbp + 8*5] 
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
mov [L_glob49], rax 

jmp L_make_string_len 
L_string_len: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 1 
jne L_incorrect_num_of_args 
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
mov [L_glob58], rax 

jmp L_make_string_ref 
L_string_ref: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 2 
jne L_incorrect_num_of_args 
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
mov [L_glob59], rax 

jmp L_make_string_set 
L_string_set: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 3 
jne L_incorrect_num_of_args 
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
mov [L_glob60], rax 

jmp L_make_vector_len 
L_vector_len: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 1 
jne L_incorrect_num_of_args 
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
mov [L_glob65], rax 

jmp L_make_vector_ref 
L_vector_ref: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 2 
jne L_incorrect_num_of_args 
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
mov [L_glob66], rax 

jmp L_make_vector_set 
L_vector_set: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 3 
jne L_incorrect_num_of_args 
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
mov [L_glob67], rax 

jmp L_make_set_car 
L_set_car: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 2 
jne L_incorrect_num_of_args 
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
mov [L_glob56], rax 

jmp L_make_set_cdr 
L_set_cdr: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 2 
jne L_incorrect_num_of_args 
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
mov [L_glob57], rax 

jmp L_make_remainder 
L_remainder: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 2 
jne L_incorrect_num_of_args 
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
mov [L_glob55], rax 

jmp L_make_smaller_then_bin 
L_smaller_then_bin: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 2 
jne L_incorrect_num_of_args 
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
mov [L_glob31], rax 

jmp L_make_bigger_then_bin 
L_bigger_then_bin: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 2 
jne L_incorrect_num_of_args 
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
mov [L_glob33], rax 

jmp L_make_equals_bin 
L_equals_bin: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 2 
jne L_incorrect_num_of_args 
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
mov [L_glob32], rax 

jmp L_make_plus_bin 
L_plus_bin: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 2 
jne L_incorrect_num_of_args 
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
;At this point the first argument is stored as fraction in r8, r9 
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
mov rax, r9 
imul r11 
mov r13, rax 
mov rax, r8 
imul r11 
mov r14, rax 
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
mov [L_glob34], rax 

jmp L_make_minus_bin 
L_minus_bin: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 2 
jne L_incorrect_num_of_args 
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
blaaa: 
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
mov [L_glob37], rax 

jmp L_make_mul_bin 
L_mul_bin: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 2 
jne L_incorrect_num_of_args 
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
mov [L_glob36], rax 

jmp L_make_div_bin 
L_div_bin: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 2 
jne L_incorrect_num_of_args 
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
mov rax, [malloc_pointer] 
my_malloc 8 
cmp r13, 1 
je .L_make_integer 
mov r10, rax 
MAKE_MALLOC_LITERAL_FRACTION r10, rsi, r13 
mov rax, r10 
jmp L_end_div_bin 
.L_make_integer: 
mov qword [rax], rsi 
shl qword [rax], 4 
or qword [rax], T_INTEGER 
L_end_div_bin: 
leave 
ret 
L_make_div_bin: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_div_bin 
mov rax, [rax] 
mov [L_glob35], rax 

jmp L_make_denominator 
L_denominator: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 1 
jne L_incorrect_num_of_args 
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
mov [L_glob43], rax 

jmp L_make_numerator 
L_numerator: 
push rbp 
mov rbp, rsp 
mov rbx, [rbp + 8*3] 
cmp rbx , 1 
jne L_incorrect_num_of_args 
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
mov [L_glob52], rax 

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
MAKE_LITERAL_CLOSURE rax, rbx, L_lambda_code1
jmp END_L_lambda_code1
L_lambda_code1: 
push rbp 
mov rbp, rsp 
push L_const2 
mov rax, qword [rbp + (4 + 0) * 8] 
push rax 
push 1
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
mov r13, [rax] 
cmp r13, [L_const5]
jne L_or_done1
push L_const2 
mov rax, qword [rbp + (4 + 0) * 8] 
push rax 
push 1
mov rax, L_glob25 
mov rbx, [rax] 
TYPE rbx 
cmp rbx, T_CLOSURE 
jne L_error 
mov rbx, [rax] 
CLOSURE_ENV rbx 
push rbx 
mov rdi, [rbp+8] 
push rdi 
mov r8, rbp 
mov r9, r8 
add r9, 8*5 
sub r8 , 8 
sub r9 , 8 
mov rcx, [r8] 
mov [r9], rcx 
sub r8 , 8 
sub r9 , 8 
mov rcx, [r8] 
mov [r9], rcx 
sub r8 , 8 
sub r9 , 8 
mov rcx, [r8] 
mov [r9], rcx 
sub r8 , 8 
sub r9 , 8 
mov rcx, [r8] 
mov [r9], rcx 
sub r8 , 8 
sub r9 , 8 
mov rcx, [r8] 
mov [r9], rcx 
mov rsp, r9 
mov rax, [rax] 
CLOSURE_CODE rax 
jmp rax 
L_or_done1:
leave 
ret 
END_L_lambda_code1: 
mov rax, [rax] 
mov [L_glob23], rax 
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
add rcx, 8*0 
mov rdx,[rbp + (4 + 0)*8] 
mov qword [rcx], rdx 
add rsi, 8 
mov rdx,[rbp + 2*8] 
MAKE_LITERAL_CLOSURE rax, rbx, L_lambda_code2
jmp END_L_lambda_code2
L_lambda_code2: 
push rbp 
mov rbp, rsp 
push L_const2 
mov rax, qword [rbp + (4 + 0) * 8] 
push rax 
push 1
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
mov rax, [rax] 
cmp rax, [L_const5] 
je L_if3_else1
mov rax, L_const7 
jmp L_if3_done1
L_if3_else1:
push L_const2 
mov rax, qword [rbp + (4 + 0) * 8] 
push rax 
push 1
mov rax, L_glob27 
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
mov rax, [rax] 
cmp rax, [L_const5] 
je L_if3_else2
mov rax, L_const11 
jmp L_if3_done2
L_if3_else2:
push L_const2 
mov rax, qword [rbp + (4 + 0) * 8] 
push rax 
push 1
mov rax, L_glob28 
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
mov rax, [rax] 
cmp rax, [L_const5] 
je L_if3_else3
mov rax, L_const19 
jmp L_if3_done3
L_if3_else3:
mov rax, L_const1 
L_if3_done3:
L_if3_done2:
L_if3_done1:
leave 
ret 
END_L_lambda_code2: 
mov rax, [rax] 
mov [L_glob26], rax 
mov rax, L_const1 
push qword [rax]
call write_sob_if_not_void
add rsp, 1*8
push L_const2 
mov rax, L_const21 
push rax 
push 1
mov rax, L_glob26 
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
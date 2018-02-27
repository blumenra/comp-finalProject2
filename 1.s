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
	MAKE_LITERAL_STRING 97
L_const10:
	dq MAKE_LITERAL_SYMBOL(L_const7)
L_const12:
	MAKE_LITERAL_STRING 98
L_const15:
	dq MAKE_LITERAL_SYMBOL(L_const12)
L_const17:
	MAKE_LITERAL_STRING 99
L_const20:
	dq MAKE_LITERAL_SYMBOL(L_const17)
L_const22:
	MAKE_LITERAL_STRING 100
L_const25:
	dq MAKE_LITERAL_SYMBOL(L_const22)
L_const27:
	MAKE_LITERAL_STRING 101
L_const30:
	dq MAKE_LITERAL_SYMBOL(L_const27)
L_const32:
	MAKE_LITERAL_STRING 102
L_const35:
	dq MAKE_LITERAL_SYMBOL(L_const32)
L_const37:
	MAKE_LITERAL_STRING 103
L_const40:
	dq MAKE_LITERAL_SYMBOL(L_const37)
L_const42:
	MAKE_LITERAL_STRING 104
L_const45:
	dq MAKE_LITERAL_SYMBOL(L_const42)
L_const47:
	MAKE_LITERAL_STRING 105
L_const50:
	dq MAKE_LITERAL_SYMBOL(L_const47)
L_const52:
	MAKE_LITERAL_STRING 106
L_const55:
	dq MAKE_LITERAL_SYMBOL(L_const52)
L_const57:
	dq MAKE_LITERAL_PAIR(L_const55, L_const2)
L_const60:
	dq MAKE_LITERAL_PAIR(L_const50, L_const57)
L_const63:
	dq MAKE_LITERAL_PAIR(L_const45, L_const60)
L_const66:
	dq MAKE_LITERAL_PAIR(L_const40, L_const63)
L_const69:
	dq MAKE_LITERAL_PAIR(L_const35, L_const66)
L_const72:
	dq MAKE_LITERAL_PAIR(L_const30, L_const69)
L_const75:
	dq MAKE_LITERAL_PAIR(L_const25, L_const72)
L_const78:
	dq MAKE_LITERAL_PAIR(L_const20, L_const75)
L_const81:
	dq MAKE_LITERAL_PAIR(L_const15, L_const78)
L_const84:
	dq MAKE_LITERAL_PAIR(L_const10, L_const81)

global_table:
L_glob87:
	 dq SOB_UNDEFINED 
L_glob88:
	 dq SOB_UNDEFINED 
L_glob89:
	 dq SOB_UNDEFINED 
L_glob90:
	 dq SOB_UNDEFINED 
L_glob91:
	 dq SOB_UNDEFINED 
L_glob92:
	 dq SOB_UNDEFINED 
L_glob93:
	 dq SOB_UNDEFINED 
L_glob94:
	 dq SOB_UNDEFINED 
L_glob95:
	 dq SOB_UNDEFINED 
L_glob96:
	 dq SOB_UNDEFINED 
L_glob97:
	 dq SOB_UNDEFINED 
L_glob98:
	 dq SOB_UNDEFINED 
L_glob99:
	 dq SOB_UNDEFINED 
L_glob100:
	 dq SOB_UNDEFINED 
L_glob101:
	 dq SOB_UNDEFINED 
L_glob102:
	 dq SOB_UNDEFINED 
L_glob103:
	 dq SOB_UNDEFINED 
L_glob104:
	 dq SOB_UNDEFINED 
L_glob105:
	 dq SOB_UNDEFINED 
L_glob106:
	 dq SOB_UNDEFINED 
L_glob107:
	 dq SOB_UNDEFINED 
L_glob108:
	 dq SOB_UNDEFINED 
L_glob109:
	 dq SOB_UNDEFINED 
L_glob110:
	 dq SOB_UNDEFINED 
L_glob111:
	 dq SOB_UNDEFINED 
L_glob112:
	 dq SOB_UNDEFINED 
L_glob113:
	 dq SOB_UNDEFINED 
L_glob114:
	 dq SOB_UNDEFINED 
L_glob115:
	 dq SOB_UNDEFINED 
L_glob116:
	 dq SOB_UNDEFINED 
L_glob117:
	 dq SOB_UNDEFINED 
L_glob118:
	 dq SOB_UNDEFINED 
L_glob119:
	 dq SOB_UNDEFINED 
L_glob120:
	 dq SOB_UNDEFINED 
L_glob121:
	 dq SOB_UNDEFINED 
L_glob122:
	 dq SOB_UNDEFINED 
L_glob123:
	 dq SOB_UNDEFINED 
L_glob124:
	 dq SOB_UNDEFINED 
L_glob125:
	 dq SOB_UNDEFINED 
L_glob126:
	 dq SOB_UNDEFINED 
L_glob127:
	 dq SOB_UNDEFINED 
L_glob128:
	 dq SOB_UNDEFINED 
L_glob129:
	 dq SOB_UNDEFINED 
L_glob130:
	 dq SOB_UNDEFINED 
L_glob131:
	 dq SOB_UNDEFINED 
L_glob132:
	 dq SOB_UNDEFINED 
L_glob133:
	 dq SOB_UNDEFINED 
L_glob134:
	 dq SOB_UNDEFINED 
L_glob135:
	 dq SOB_UNDEFINED 
L_glob136:
	 dq SOB_UNDEFINED 
L_glob137:
	 dq SOB_UNDEFINED 
L_glob138:
	 dq SOB_UNDEFINED 
L_glob139:
	 dq SOB_UNDEFINED 
L_glob140:
	 dq SOB_UNDEFINED 
L_glob141:
	 dq SOB_UNDEFINED 

 symbols_table:
	 dq SOB_UNDEFINED 

global main
section .text
main:

mov rax, malloc_pointer 
mov qword [rax], start_of_malloc 

push qword L_const2 
push qword L_const52
push 3 
push L_const2 
call L_cons 
add rsp, 8*4 
push rax 
push qword L_const47
push 3 
push L_const2 
call L_cons 
add rsp, 8*4 
push rax 
push qword L_const42
push 3 
push L_const2 
call L_cons 
add rsp, 8*4 
push rax 
push qword L_const37
push 3 
push L_const2 
call L_cons 
add rsp, 8*4 
push rax 
push qword L_const32
push 3 
push L_const2 
call L_cons 
add rsp, 8*4 
push rax 
push qword L_const27
push 3 
push L_const2 
call L_cons 
add rsp, 8*4 
push rax 
push qword L_const22
push 3 
push L_const2 
call L_cons 
add rsp, 8*4 
push rax 
push qword L_const17
push 3 
push L_const2 
call L_cons 
add rsp, 8*4 
push rax 
push qword L_const12
push 3 
push L_const2 
call L_cons 
add rsp, 8*4 
push rax 
push qword L_const7
push 3 
push L_const2 
call L_cons 
add rsp, 8*4 
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
mov [L_glob122], rax 

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
mov [L_glob109], rax 

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
mov [L_glob113], rax 

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
mov [L_glob88], rax 

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
mov [L_glob124], rax 

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
mov [L_glob125], rax 

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
mov [L_glob133], rax 

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
mov [L_glob134], rax 

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
mov [L_glob140], rax 

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
mov [L_glob89], rax 

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
mov [L_glob110], rax 

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
mov [L_glob111], rax 

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
mov [L_glob116], rax 

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
mov [L_glob112], rax 

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
mov [L_glob114], rax 

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
mov [L_glob141], rax 

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
mov [L_glob121], rax 

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
mov [L_glob120], rax 

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
mov [L_glob129], rax 

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
mov [L_glob130], rax 

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
mov [L_glob117], rax 

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
mov [L_glob131], rax 

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
mov [L_glob137], rax 

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
mov [L_glob138], rax 

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
mov [L_glob139], rax 

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
mov [L_glob118], rax 

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
mov [L_glob136], rax 

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
mov [L_glob127], rax 

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
mov [L_glob128], rax 

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
mov [L_glob126], rax 

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
mov [L_glob95], rax 

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
mov [L_glob96], rax 

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
mov [L_glob97], rax 

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
mov [L_glob93], rax 

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
mov [L_glob94], rax 

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
mov [L_glob99], rax 

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
mov [L_glob98], rax 

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
mov [L_glob115], rax 

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
mov [L_glob123], rax 

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
mov [L_glob105], rax 

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
mov [L_glob108], rax 

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
mov [L_glob102], rax 

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
mov [L_glob104], rax 

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
mov [L_glob103], rax 

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
mov [L_glob106], rax 

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
mov [L_glob107], rax 

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
mov [L_glob135], rax 

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
mov [L_glob132], rax 

jmp L_make_L_apply 
L_apply: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 2 
mov r10, 0 
TAKE_ARG rbx, r10 
mov r10, 1 
TAKE_ARG rcx, r10 
mov rbx, [rbx] 
mov rax, rbx 
TYPE rax 
cmp rax, T_CLOSURE 
jne L_incorrect_type 
 mov rcx, [rcx] 
mov rax, rcx 
TYPE rax 
cmp rax, T_PAIR 
je .cont 
cmp rax, T_NIL 
jne L_incorrect_type 
 .cont: 
mov rsi, [rbp]               ;; save rbp (top of current stack) in rsi 
mov rdi, [rbp+8]             ;; save ret-addr in rdi 
mov r11, [rbp+8*2]           ;; save env in r11 
mov r12, 5 
shl r12, 3 
add r12, rbp                 ;; save pointer to botoom of old frame (one above null) in r12 
mov r8, 0 
.L_loop_apply1: 
cmp rcx, [L_const2] 
je .L_END_loop_apply1 
mov rax, rcx 
MY_CAR rax 
push rax 
CDR rcx 
inc r8 
jmp .L_loop_apply1 
.L_END_loop_apply1: 
mov r9, 0 
mov r10, rsp 
mov r13, rsp 
sub r13, 8                  ;; save pointer to the last argument of the args that will be pushed to stack in r13 
.L_loop_apply2: 
cmp r9, r8 
je .L_END_loop_apply2 
push qword [r10] 
add r10, 8 
inc r9 
jmp .L_loop_apply2 
.L_END_loop_apply2: 
inc r8 
push r8                    ;; push new num of args 
push r11                   ;; push old env of args 
push rdi                   ;; push old ret-addr of args 
push rsi                   ;; push old rbp of args 
mov r9, r8 
add r9, 3 
.L_loop_apply3: 
cmp r9, 0 
je .L_END_loop_apply3 
mov r14, [r13] 
mov [r12], r14 
sub r13, 8 
sub r12, 8 
dec r9 
jmp .L_loop_apply3 
.L_END_loop_apply3: 
add r12, 8 
mov rsp, r12 
mov rbp, [r12] 
add rsp, 8 
CLOSURE_CODE rbx 
jmp rbx 
.L_apply_done: 
leave 
ret 
L_make_L_apply: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_apply 
mov rax, [rax] 
mov [L_glob92], rax 

jmp L_make_L_append_bin 
L_append_bin: 
push rbp 
mov rbp, rsp 
CHECK_ARG_NUM_CORRECTNESS 2 
mov r10, 0 
TAKE_ARG rbx, r10 
mov r10, 1 
TAKE_ARG rcx, r10 
mov rbx, [rbx] 
mov rax, rbx 
TYPE rax 
cmp rax, T_PAIR 
je .next_arg 
cmp rax, T_NIL 
jne L_incorrect_type 
 .next_arg: 
mov rcx, [rcx] 
mov rax, rcx 
TYPE rax 
cmp rax, T_PAIR 
je .cont 
cmp rax, T_NIL 
jne L_incorrect_type 
 .cont: 
mov r8, 0 
.L_loop_append_push_to_stack1: 
cmp rbx, [L_const2] 
je .L_END_loop_append_push_to_stack1 
mov rax, rbx 
MY_CAR rax 
push rax 
CDR rbx 
inc r8 
jmp .L_loop_append_push_to_stack1 
.L_END_loop_append_push_to_stack1: 
.L_loop_append_push_to_stack2: 
cmp rcx, [L_const2] 
je .L_END_loop_append_push_to_stack2 
mov rax, rcx 
MY_CAR rax 
push rax 
CDR rcx 
inc r8 
jmp .L_loop_append_push_to_stack2 
.L_END_loop_append_push_to_stack2: 
mov rax, L_const2 
.L_loop_append: 
cmp r8, 0 
je .L_END_loop_append 
mov r9, rsp 
push r8 
push rax 
push qword [r9] 
push 3 
push L_const2 
call L_cons 
add rsp, 8*4 
pop r8 
pop r9 
dec r8 
jmp .L_loop_append 
.L_END_loop_append: 
.L_append_bin_done: 
leave 
ret 
L_make_L_append_bin: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_append_bin 
mov rax, [rax] 
mov [L_glob100], rax 

jmp L_make_L_append 
L_append: 
push rbp 
mov rbp, rsp 
mov rax, L_const2 
mov r15, rax 
NUM_OF_ARGS rcx 
cmp rcx, 0 
je .L_append_done 
mov r10, 0 
.while: 
TAKE_ARG r8, r10 
push rcx 
push r10 
push r8 
push r15 
push 3 
push L_const2 
call L_append_bin 
add rsp, 4*8 
pop r10 
pop rcx 
mov r15, rax           ;;save in r15 the sum result 
inc r10 
cmp r10, rcx 
je .L_append_done 
jmp .while 
.L_append_done: 
leave 
ret 
L_make_L_append: 
mov rax, [malloc_pointer] 
my_malloc 16 
MAKE_LITERAL_CLOSURE rax, L_const2, L_append 
mov rax, [rax] 
mov [L_glob101], rax 

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
MAKE_LITERAL_CLOSURE rax, rbx, L_lambda_code5
jmp END_L_lambda_code5
L_lambda_code5: 
push rbp 
mov rbp, rsp 
push L_const2 
mov rax, qword [rbp + (4 + 0) * 8] 
push rax 
push 2
mov rax, L_glob88 
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
L_remove_nils13: 
mov r13, [rax] 
cmp r13, [L_const5]
jne L_or_done1
push L_const2              ;push '() to stack 
mov rax, qword [rbp + (4 + 0) * 8] 
push rax 
push 2
mov rax, L_glob89 
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
END_L_lambda_code5: 
mov rax, [rax] 
mov [L_glob87], rax 
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
MAKE_LITERAL_CLOSURE rax, rbx, L_lambda_code6
jmp END_L_lambda_code6
L_lambda_code6: 
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
END_L_lambda_code6: 
mov rax, [rax] 
mov [L_glob90], rax 
mov rax, L_const1 
push qword [rax]
call write_sob_if_not_void
add rsp, 1*8
push L_const2 
mov rax, L_const84 
push rax 
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
MAKE_LITERAL_CLOSURE rax, rbx, L_lambda_code3
jmp END_L_lambda_code3
L_lambda_code3: 
push rbp 
mov rbp, rsp 
mov rax, [malloc_pointer] 
my_malloc 16 
mov rbx, [malloc_pointer] 
my_malloc (8*2) 
mov rcx, [malloc_pointer] 
my_malloc (8*10) 
mov rsi, rbx 
mov qword [rsi], rcx 
mov rdx,[rbp + (4 + 0)*8] 
mov qword [rcx], rdx 
add rcx, 8 
mov rdx,[rbp + (4 + 1)*8] 
mov qword [rcx], rdx 
add rcx, 8 
mov rdx,[rbp + (4 + 2)*8] 
mov qword [rcx], rdx 
add rcx, 8 
mov rdx,[rbp + (4 + 3)*8] 
mov qword [rcx], rdx 
add rcx, 8 
mov rdx,[rbp + (4 + 4)*8] 
mov qword [rcx], rdx 
add rcx, 8 
mov rdx,[rbp + (4 + 5)*8] 
mov qword [rcx], rdx 
add rcx, 8 
mov rdx,[rbp + (4 + 6)*8] 
mov qword [rcx], rdx 
add rcx, 8 
mov rdx,[rbp + (4 + 7)*8] 
mov qword [rcx], rdx 
add rcx, 8 
mov rdx,[rbp + (4 + 8)*8] 
mov qword [rcx], rdx 
add rcx, 8 
mov rdx,[rbp + (4 + 9)*8] 
mov qword [rcx], rdx 
add rcx, 8 
add rsi, 8 
mov rdx,[rbp + 2*8] 
mov r15, rdx 
mov rdx, [r15 + 8*0] 
mov qword [rsi], rdx 
add rsi, 8 
MAKE_LITERAL_CLOSURE rax, rbx, L_lambda_code4
jmp END_L_lambda_code4
L_lambda_code4: 
push rbp 
mov rbp, rsp 
push L_const2              ;push '() to stack 
mov rax, qword [rbp +  2 * 8] 
mov rax, qword [rax + 0 * 8] 
mov rax, qword [rax + 0 * 8] 
push rax 
mov rax, qword [rbp +  2 * 8] 
mov rax, qword [rax + 0 * 8] 
mov rax, qword [rax + 9 * 8] 
push rax 
mov rax, qword [rbp +  2 * 8] 
mov rax, qword [rax + 0 * 8] 
mov rax, qword [rax + 8 * 8] 
push rax 
mov rax, qword [rbp +  2 * 8] 
mov rax, qword [rax + 0 * 8] 
mov rax, qword [rax + 7 * 8] 
push rax 
mov rax, qword [rbp +  2 * 8] 
mov rax, qword [rax + 0 * 8] 
mov rax, qword [rax + 6 * 8] 
push rax 
mov rax, qword [rbp +  2 * 8] 
mov rax, qword [rax + 0 * 8] 
mov rax, qword [rax + 5 * 8] 
push rax 
mov rax, qword [rbp +  2 * 8] 
mov rax, qword [rax + 0 * 8] 
mov rax, qword [rax + 4 * 8] 
push rax 
mov rax, qword [rbp +  2 * 8] 
mov rax, qword [rax + 0 * 8] 
mov rax, qword [rax + 3 * 8] 
push rax 
mov rax, qword [rbp +  2 * 8] 
mov rax, qword [rax + 0 * 8] 
mov rax, qword [rax + 2 * 8] 
push rax 
mov rax, qword [rbp +  2 * 8] 
mov rax, qword [rax + 0 * 8] 
mov rax, qword [rax + 1 * 8] 
push rax 
push 11
mov rax, qword [rbp + (4 + 0) * 8] 
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
leave 
ret 
END_L_lambda_code4: 
leave 
ret 
END_L_lambda_code3: 
push rax 
push 3
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
mov rax, [malloc_pointer] 
my_malloc 16 
mov rbx, [malloc_pointer] 
my_malloc (8*2) 
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
mov rdx, [r15 + 8*0] 
mov qword [rsi], rdx 
add rsi, 8 
MAKE_LITERAL_CLOSURE rax, rbx, L_lambda_code2
jmp END_L_lambda_code2
L_lambda_code2: 
push rbp 
mov rbp, rsp 
push L_const2              ;push '() to stack 
mov rax, L_glob90 
push rax 
push 2
push L_const2 
mov rax, qword [rbp +  2 * 8] 
mov rax, qword [rax + 0 * 8] 
mov rax, qword [rax + 0 * 8] 
push rax 
push 2
push L_const2 
mov rax, qword [rbp +  2 * 8] 
mov rax, qword [rax + 0 * 8] 
mov rax, qword [rax + 0 * 8] 
push rax 
push 2
push L_const2 
mov rax, qword [rbp +  2 * 8] 
mov rax, qword [rax + 0 * 8] 
mov rax, qword [rax + 0 * 8] 
push rax 
push 2
push L_const2 
mov rax, qword [rbp +  2 * 8] 
mov rax, qword [rax + 0 * 8] 
mov rax, qword [rax + 0 * 8] 
push rax 
push 2
push L_const2 
mov rax, qword [rbp +  2 * 8] 
mov rax, qword [rax + 0 * 8] 
mov rax, qword [rax + 0 * 8] 
push rax 
push 2
push L_const2 
mov rax, qword [rbp +  2 * 8] 
mov rax, qword [rax + 0 * 8] 
mov rax, qword [rax + 0 * 8] 
push rax 
push 2
push L_const2 
mov rax, qword [rbp +  2 * 8] 
mov rax, qword [rax + 0 * 8] 
mov rax, qword [rax + 0 * 8] 
push rax 
push 2
push L_const2 
mov rax, qword [rbp +  2 * 8] 
mov rax, qword [rax + 0 * 8] 
mov rax, qword [rax + 0 * 8] 
push rax 
push 2
push L_const2 
mov rax, qword [rbp +  2 * 8] 
mov rax, qword [rax + 0 * 8] 
mov rax, qword [rax + 0 * 8] 
push rax 
push 2
push L_const2 
mov rax, qword [rbp +  2 * 8] 
mov rax, qword [rax + 0 * 8] 
mov rax, qword [rax + 1 * 8] 
push rax 
mov rax, qword [rbp +  2 * 8] 
mov rax, qword [rax + 0 * 8] 
mov rax, qword [rax + 0 * 8] 
push rax 
push 3
mov rax, L_glob92 
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
L_remove_nils11: 
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
L_remove_nils10: 
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
leave 
ret 
END_L_lambda_code2: 
leave 
ret 
END_L_lambda_code1: 
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
mov rax, [rax] 
mov [L_glob91], rax 
mov rax, L_const1 
push qword [rax]
call write_sob_if_not_void
add rsp, 1*8
push L_const2 
push 1
mov rax, L_glob91 
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
L_remove_nils12: 
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

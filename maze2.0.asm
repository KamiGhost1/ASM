%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
xor esi,esi;poisk i
xor edi,edi;vector
mov ecx,0
mov ebx,0;y
mov edx,0;x
mov ah,' '
call way
call view_maze
ret

view_maze:
push ecx
push dx
xor ecx,ecx
xor dx,dx
view:
mov al,[str1+ecx]
cmp al,35
je chain
cmp al,42
je star
cmp al,10
jge x1_space
PRINT_STRING '  '
PRINT_DEC 1,al
jmp view_inc
x1_space:
PRINT_CHAR ' '
PRINT_DEC 1,al
view_inc:
inc cx
inc dx
cmp cx,64
je exit_view_maze
cmp dx,8
jne view
xor dx,dx
NEWLINE
jmp view
exit_view_maze:
pop dx
pop ecx
ret
star:
PRINT_STRING '  '
PRINT_CHAR '*'
jmp view_inc
chain:
PRINT_STRING '  '
PRINT_CHAR '#'
jmp view_inc


way:
mov al,[str1+ebx*8+edx]
cmp al,cl
je check_position
way_1:
inc dx
inc si
cmp si,64
je step_way
cmp dx,8
jl way
xor dx,dx
inc bx
jmp way
check_position:
xor di,di
inc cx
call zalivka
dec cx
jmp way_1
step_way:
xor esi,esi
xor dx,dx
xor bx,bx
inc cx
cmp cx,35
je cx_inc
cmp cx,42
je cx_inc
go_1:
mov al,[str1+8]
cmp al,ah 
je way
ret
cx_inc:
inc cx
jmp go_1

zalivka:
push dx
push bx
mov al,[vectorX+edi]
add dl,al
mov al,[vectorY+edi]
add bl,al
cmp dl,8 
jae step_zalivka
cmp bl,8 
jae step_zalivka
mov al,[str1+ebx*8+edx]
cmp al,ah
jne step_zalivka
mov [str1+ebx*8+edx],cl
step_zalivka:
pop bx
pop dx
inc di
cmp di,4
je exit_zalivka
jmp zalivka
exit_zalivka:
ret
section .data
vectorX db 0,-1,0,1
vectorY db 1,0,-1,0
str1 db "*# # #  "
    db " # # # #"
    db " # #   #"
    db " # ##  #"
    db " #     #"
    db "   ##   "
    db " #   #  "
    db " # # # ",0
finish db "*"

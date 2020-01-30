%include "io.inc"

section .text
global CMAIN
CMAIN:
mov ebp, esp; for correct debugging
mov edi,len 
shr edi,2 
dec edi 
call menu 
ret


qwerty:
mov eax,[mass+ecx*4]
shr eax,16
ret

Print:
mov dword [Printer],eax
shr dword [Printer],16
cmp dword [Printer],0
je exit_Print
PRINT_DEC 4,Printer
NEWLINE
exit_Print:
ret

view_mass:
mov eax,[mass+ecx*4]
call Check_L
call Print
call Check_R
ret
Check_L:
push eax
cmp ah,0
je exit_CL
mov cl,ah
call view_mass
exit_CL:
pop eax
ret
Check_R:
push eax
cmp al,0
je exit_CR
mov cl,al
call view_mass
exit_CR:
pop eax
ret


search_mass:
NEWLINE
PRINT_STRING 'WTF?????'
NEWLINE
GET_DEC 2,bx
search_cicle:
mov eax,[mass+ecx*4]
call qwerty
cmp bx,ax
je success_search
jl Left
jg Right
Left:
mov eax,[mass+ecx*4]
cmp ax,0
je fail_search
mov cl,ah
jmp search_cicle
Right:
mov eax,[mass+ecx*4]
cmp ax,0
je fail_search
mov cl,al
jmp search_cicle
exit_search:
ret
success_search:
NEWLINE
PRINT_STRING'hello Nigga '
PRINT_DEC 2,cx
NEWLINE
ret
fail_search:
NEWLINE
PRINT_STRING'WTF BRO????'
NEWLINE
ret

AAAAAAAAAAddddd:
GET_DEC 2,bx
call search_cicle
inc edi
call qwerty
cmp bx,ax
je exit_adddd
jg RP
jl LP
RP:
mov eax,[mass+ecx*4]
mov dx,di
mov al,dl
mov [mass+ecx*4],eax
shl ebx,16
mov [mass+edi*4],ebx
jmp exit_adddd
LP:
mov eax,[mass+ecx*4]
mov dx,di
mov ah,dl
mov [mass+ecx*4],eax
shl ebx,16
mov [mass+edi*4],ebx
jmp exit_adddd
exit_adddd:
ret

menu:
xor eax,eax
xor ebx,ebx
xor ecx,ecx
xor edx,edx
NEWLINE
PRINT_STRING '0 - exit, 1 - view array, 2 - search, 3 - addddddd'
NEWLINE
GET_DEC 2,ax
cmp ax,0
je exit_prog
cmp ax,1
je view_array
cmp ax,2
je search
cmp ax,3 
je addddddddd
jmp menu
view_array:
call view_mass
jmp menu
search:
call search_mass
jmp menu
addddddddd:
call AAAAAAAAAAddddd
jmp menu
exit_prog:
ret
section .data 
Printer dd 0
mass dd 0x000b0102,0x00090304,0x000e0506,0x00030000,0x000a0000,0x000c0000,0x00170000
len equ $-mass
%include "io.inc"

section .text
global CMAIN
CMAIN:
mov ebp, esp; for correct debugging
xor eax,eax
xor ecx,ecx
xor ebx,ebx
xor edx,edx
lea esi,[A]
mov edi,len
shr edi,1
dec di
step:
cmp cx,di
je exit
inc cx
mov ah,[esi+ecx*2]
mov bx,cx
preprov:
dec bx
mov al,[esi+ebx*2]
cmp ah,al
jg step
provBX:
cmp bx,0
jg prod
je buf
jmp step
prod:
dec bx
mov al,[esi+ebx*2]
cmp ah,al
jl provBX
jg buf1 
buf:
mov dl,ah
smesh:
xchg dx,[esi+ebx*2]
inc bx
cmp bx,cx
jle smesh
jg step
buf1:
mov dl,ah
smesh1:
inc bx
xchg dx,[esi+ebx*2]
cmp bx,cx
jl smesh1
jge step
exit:ret
    
    
section .data 
A dw 6,5,3,1,8,7,2,4
len equ $-A
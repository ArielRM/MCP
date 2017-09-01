.data 0x10008000
ptr: .word 0x10008010
size: .word 12 #em bytes
target: .word 9 
result: .space 4
array: .word 45,15,8
.text

lw $s0,ptr
lw $s1,size
lw $s2,target

add $s1,$s0,$s1

loop:
lw $t0,0($s0)
beq $t0,$s2,encontrado
addi $s0,$s0,4
blt $s0,$s1,loop
add $t1,$zero,$zero
j fim
encontrado:
addi $t1,$zero,0x01
fim:
sw $t1,result


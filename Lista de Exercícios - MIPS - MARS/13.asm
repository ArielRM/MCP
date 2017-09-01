.data 0x10008000
ptr: .word 0x10008008
size: .space 4
string: .asciiz "123456789"
.text

lw $s0,ptr

add $t1,$zero,$zero

loop:
addi $t1,$t1,1
lbu $t0,0($s0)
addi $s0,$s0,1
bne $t0,$zero,loop

sw $t1,size
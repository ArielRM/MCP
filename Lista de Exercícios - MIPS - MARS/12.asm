.data 0x10008000
ptr: .word 0x10008010
size: .word 32 #em bytes
target: .word 2
result: .space 4
array: .word 9,8,5,8,4,8,1,8
.text

lw $s0,ptr
lw $t1,size
add $s1,$s0,$t1
lw $s2,target

add $t0,$zero,$zero
loop:
lw $t1,0($s0)
bne $t1,$s2,test
addi $t0,$t0,1
test:
addi $s0,$s0,4
blt $s0,$s1,loop

sw $t0,result
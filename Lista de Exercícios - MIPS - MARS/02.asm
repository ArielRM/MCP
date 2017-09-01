.data 0x10008000

entrada: .word 1,2,3
resultado: .space 4

.text

la $s1,entrada

lw $t1,($s1)
lw $t2,4($s1)
add $t1,$t1,$t2
lw $t2,8($s1)
add $t1,$t1,$t2
sw $t1,0x0C($s1)


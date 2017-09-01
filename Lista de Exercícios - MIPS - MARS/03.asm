.data 0x10008000

entrada: .word 4,1
saida: .space 4

.text

la $s1,entrada

lw $t1,0($s1)
lw $t2,4($s1)
sub $t1,$t1,$t2
sw $t1,8($s1)


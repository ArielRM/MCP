.data 0x10008000
entrada: .word 98,98
saida: .space 4
.text
la $s1,entrada
lw $t1,0($s1)
lw $t2,4($s1)
bne $t1, $t2,end
sw $t2,8($s1)
end: 
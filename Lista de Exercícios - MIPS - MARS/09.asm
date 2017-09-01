.data 0x10008000
notas: .word 6,7,8
aprovado: .word 0
reprovado: .word 0
.text

la $s0,notas
lw $t0,0($s0)
lw $t1,4($s0)
add $t0,$t0,$t1
lw $t1,8($s0)
add $t0,$t0,$t1
addi $t1,$zero,3
div $t0,$t0,$t1
add $t1,$zero,7

bge $t0,$t1,aprovação
la $s0,reprovado
j salvar
aprovação:
la $s0,aprovado
salvar:
addi $t1,$zero,1
sw $t1,0($s0)

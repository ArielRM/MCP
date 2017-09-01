.data 0x10008000
entrada: .word 4,6,8
saida: .space 12
.text

la $s0,entrada

lw $t0,0($s0)
lw $t1,4($s0)
lw $t2,8($s0)

bgt $t0,$t1,notSwap1
add $t3,$t0,$zero
add $t0,$t1,$zero
add $t1,$t3,$zero
notSwap1:
bgt $t0,$t2,notSwap2
add $t3,$t0,$zero
add $t0,$t2,$zero
add $t2,$t3,$zero
notSwap2:
bgt $t1,$t2,notSwap3
add $t3,$t1,$zero
add $t1,$t2,$zero
add $t2,$t3,$zero
notSwap3:
la $t3,saida
sw $t0,0($t3)
sw $t1,4($t3)
sw $t2,8($t3)

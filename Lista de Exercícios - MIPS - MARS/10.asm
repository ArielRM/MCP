.data 0x10008000
numeros: .word 7,4
resultado: .space 4
.text

la $s0,numeros
lw $t0,0($s0)
lw $t1,4($s0)

mul $t2,$t1,$t0

sw $t2,8($s0)


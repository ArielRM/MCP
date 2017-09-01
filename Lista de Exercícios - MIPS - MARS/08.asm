.data 0x10008000
vezes: .word 10
.text

la $s0,vezes
lw $t0,0($s0)

loop:
subi $t0,$t0,1
bne $t0,$zero,loop
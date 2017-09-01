.data 0x10008000
fonte: .word 0x1000800C
destino: .word 0x10008040
size: .word 20
fonte_data: .word 1,2,3,4,5
.text

lw $s0,fonte
lw $s1,destino

lw $s2,size
add $s2,$s2,$s0

loop:
lw $t0,0($s0)
sw $t0,0($s1)
addi $s0,$s0,4
addi $s1,$s1,4
bne $s2,$s0,loop



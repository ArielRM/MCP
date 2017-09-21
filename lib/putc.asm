# Aguarda que o display fique disponivel e então imprime o valor de $a0

putc:
	lui $t0,0xFFFF
	ori $t0,$t0,0x0008
	lw $t0,0($t0)
	andi $t0,$t0,1
	beq $t0,$0,putc
	lui $t0,0xFFFF
	ori $t0,$t0,0x000c
	sw $a0,0($t0)
	jr $ra
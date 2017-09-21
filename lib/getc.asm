# Aguarda a entrada do usuário e retorna o char em $v0
getc:
	lui $t0,0xFFFF
	lw $v0,0($t0)
	andi $v0,$v0,1
	beq $v0,$0,getc
	lw $v0,4($t0)
	jr $ra
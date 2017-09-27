# Aguarda a entrada do usuário e retorna o char em $v0
.globl getc
getc:
	lui $t0,0xFFFF
	loop:
	lw $v0,0($t0)
	andi $v0,$v0,1
	beq $v0,$0,loop
	lw $v0,4($t0)
	jr $ra

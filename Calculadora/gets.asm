# Aguarda a entrada do usu�rio salva a string no espa�o de mem�ria de $a0 at� $a0 + $a1
#	a string ter� no m�n 1 char (\0) e no m�x n + 1 char (texto + '\0')
.globl gets
gets:
	bltz $a1,gets_end		# n inv�lido
	
	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	addu $a1,$a0,$a1
	gets_for:					# $a0 < $a1 && getc() != '\n'; $a0 <- getc()
		beq $a0,$a1,gets_for_break
		jal getc
		addiu $t0,$0,10
		beq $v0,$t0,gets_for_break
		sb $v0,0($a0)
		addiu $a0,$a0,1
		j gets_for
	gets_for_break:
		sb $0,0($a0)
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	
	gets_end:
		jr $ra

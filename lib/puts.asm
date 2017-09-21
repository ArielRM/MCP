# Aguarda que o display fique disponivel e então imprime a string no enderço de $a0

puts: #	$a0 : ponteiro para string
	addiu $sp,$sp,-8
	addu $t0,$0,$a0
	sw $ra,0($sp)
	puts_for:
		lbu $a0,0($t0)
		beq $a0,$0,puts_break
		sw $t0,4($sp)
		jal putc
		lw $t0,4($sp)
		addiu $t0,$t0,1
		j puts_for
	puts_break:
	lw $ra,0($sp)
	addiu $sp,$sp,8
	jr $ra
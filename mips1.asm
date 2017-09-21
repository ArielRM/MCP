.text
j main

.include "lib/getc.asm"

main:
	jal gets
exit:
	li $v0,10
	syscall
	
# $v0 aponta para a string	
gets:
	sub $sp,$sp,8
	sw $s0,0($sp)
	sw $ra,4($sp)
	lui $s0,0
	gets_doWhile:
		jal getc
		sub $sp,$sp,1
		sb $v0,0($sp)
		addi $s0,$s0,1
		beq $v0,10,gets_doWhileFim
		j gets_doWhile
	gets_doWhileFim:
	sb $0,0($sp)
	li $v0,9
	move $a0,$s0
	syscall
	move $t1,$v0
	gets_for:
		beqz $s0,gets_for_break
		lbu $t0,0($sp)
		sb $t0,0($t1)
		add $sp,$sp,1
		add $t1,$t1,1
		sub $s0,$s0,1
		j gets_for
	gets_for_break:
	lw $s0,0($sp)
	lw $ra,4($sp)
	add $sp,$sp,8
	jr $ra
	
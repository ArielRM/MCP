.text

main:
	addiu $a0,$zero,9
	jal fatorial
	sw $v0,0($gp)
	
	addiu $v0,$zero,10
	syscall

fatorial:
	addiu $sp,$sp,-8
	sw $ra,4($sp)
	sw $s0,0($sp)
	
	addu $s0,$zero,$a0
	
	addi $v0,$zero,1
	beq $s0,$v0,exit
	
	addiu $a0,$a0,-1
	jal fatorial
	
	mul $v0,$v0,$s0

exit:
	lw $s0,0($sp)
	lw $ra,4($sp)
	addiu $sp,$sp,8
	jr $ra
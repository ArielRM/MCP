.text
j main

.data
matriz: .space 36
texto: .asciiz "Entre o valor de a("
texto2: .asciiz ","
texto3: .asciiz ") : "


.text

main:
	la $t0,matriz
	lui $s0,0
	for0:
		beq $s0,3,break0
		lui $s1,0
		for1:
			beq $s1,3,break1
			li $v0,4
			la $a0,texto
			syscall
			li $v0,1
			move $a0,$s0
			syscall
			li $v0,4
			la $a0,texto2
			syscall
			li $v0,1
			move $a0,$s1
			syscall
			li $v0,4
			la $a0,texto3
			syscall
			li $v0,5
			syscall
			sw $v0,0($t0)
			addi $s1,$s1,1
			addiu $t0,$t0,4
			j for1
		break1:
		lui $s1,0
		addi $s0,$s0,1
		j for0
	break0:
	
	la $a0,matriz
	jal det
	move $a0,$v0
	li $v0,1
	syscall
	
exit:
	li $v0,10
	syscall
	

det:	
	lw $t1,0($a0)
	lw $t2,4($a0)
	lw $t3,8($a0)
	lw $t4,12($a0)
	lw $t5,16($a0)
	lw $t6,20($a0)
	lw $t7,24($a0)
	lw $t8,28($a0)
	lw $t9,32($a0)
	
	mul $v0,$t1,$t5
	mul $v0,$v0,$t9
	
	mul $t0,$t2,$t6
	mul $t0,$t0,$t7
	add $v0,$v0,$t0
	
	mul $t0,$t3,$t4
	mul $t0,$t0,$t8
	add $v0,$v0,$t0
	
	mul $t0,$t3,$t5
	mul $t0,$t0,$t7
	sub $v0,$v0,$t0
	
	mul $t0,$t2,$t4
	mul $t0,$t0,$t9
	sub $v0,$v0,$t0
	
	mul $t0,$t1,$t6
	mul $t0,$t0,$t8
	sub $v0,$v0,$t0
	
	jr $ra
	

.data
vetor:	.space 80
.text
main:
	li $a0,20
	la $a1,vetor
	jal fib
	
	li $v0,10
	syscall

fib:
	addiu $sp,$sp,-16
	sw $ra,8($sp)
	sw $s0,4($sp)
	sw $s1,0($sp)
	
	move $s0,$a0
	move $s1,$a1	
	
	li $t0,1
	beq $s0,2,n2
	beq $s0,1,n1
	
		addiu $a0,$a0,-1	
		jal fib			# fibonacci(n-1)
		
		#	saida[n-1] = saida[n-2] + saida[n-3];
		mul $s0,$s0,4		# $s0 = 4*n = [n]
		addu $s0,$s0,$s1	# $s0 = $saida + 4*n = &(saida[n])
		
		lw $t0,-8($s0)		# $t0 = saida[n-2]
		lw $t1,-12($s0)		# $t1 = saida[n-3]
		addu $t0,$t0,$t1	# $t0 = saida[n-2] + saida[n-3]
		
		sw $t0,-4($s0)		# saida[n-1] = $t0
		j fim		
	n2:
		sw $t0,4($a1)
	n1:
		sw $t0,0($a1)
	fim:
	
	lw $s1,0($sp)
	lw $s0,4($sp)
	lw $ra,8($sp)
	addiu $sp,$sp,16
	
	jr $ra
.data
arr: .word 1,-2,-3
arr_size:

.text
main:
	la $a0,arr
	la $a1,arr_size
	subu $a1,$a1,$a0
	div $a1,$a1,4
	jal sum
	move $s0,$v0
exit:
	li $v0,10
	syscall
	
# Soma de todos os elementos de um array
sum:	# $a0 <= int arr[]		$a1 <= int size
	beq $a1,$0,sum_ret0
	
	subiu $sp,$sp,8
	sw $ra,4($sp)
	
	subiu $a1,$a1,1 # a1 = size - 1
	mul $t0,$a1,4
	addu $t0,$a0,$t0 # $t0 = arr[] + 4 * (size - 1)
	lw $t0,0($t0) 		# $t0 = arr[size-1]
	
	sw $t0,0($sp)
	jal sum
	lw $t0,0($sp)
	lw $ra,4($sp)
	addiu $sp,$sp,8
	
	add $v0,$v0,$t0
	jr $ra
	
	sum_ret0:
		li $v0,0
		jr $ra
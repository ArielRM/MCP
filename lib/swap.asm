swap:
	addi $t0,$zero,4 #$t0 <- 4
	mul $t0,$t0,$1 #$t0 <- 4 * k
	lw $t1,0($t0)
	lw $t2,4($t0)
	sw $t1,4($t0)
	sw $t2,0($t0)
	jr $ra
	

main:
	li $a0,2
	jal isqrt
	nop
exit:
	li $v0,10
	syscall


# Calcula a raiz quadrada (inteiro)
isqrt: # $a0 <= num		$v0 <= res
	lui $v0,0
	
	li $t0,1				# int bit =
	sll $t0,$t0,30	#	1 << 30;
	
	isqrt_while1:
		bge $t0,$a0,isqrt_while2
		srl $t0,$t0,2
		j isqrt_while1
	isqrt_while2:
		beq $t0,$0,isqrt_ret
		add $t1,$v0,$t0 # $t1 <- res + bit
		bge $a0,$t1,isqrt_ifTrue # if(num >= res + bit) goto ifTrue
		#else
		srl $v0,$v0,1
		j isqrt_fimWhile
		isqrt_ifTrue:
			sub $a0,$a0,$t1
			srl $v0,$v0,1
			add $v0,$v0,$t0
		isqrt_fimWhile:
			srl $t0,$t0,2
		j isqrt_while2
	isqrt_ret:
		jr $ra
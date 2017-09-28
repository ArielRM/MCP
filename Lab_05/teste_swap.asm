.data
_v: .word 9,8,7,6,5,4,3,2,1,-1
_k: .word 2

.text

main:
	la $a0,_v
	lw $a1,_k
	jal swap
	nop
exit:
	li $v0,10
	syscall

swap:
	sll		$t0,$a1,2		#	$t0 = 4 * k
	addu	$t0,$t0,$a0	#	$t0 = v + 4 * k
	lw		$t1,0($t0)	#	temp = v[k]
	lw		$t2,4($t0)	#	temp2 = v[k+1]
	sw		$t2,0($t0)	#	v[k] = temp2 = v[k+1] 
	sw		$t1,4($t0)	#	v[k+1] = temp = v[k]
	jr		$ra	
.data
vetor: .word 3,2,1
vetor_size:

.text
main:
	la $a0,vetor
	la $a1,vetor_size
	subu $a1,$a1,$a0
	divu $a1,$a1,4
	
	jal bubble
	nop
exit:
	li $v0,10
	syscall

# Algoritmo de ordenaçao BubbleSort
bubble:	# $a0 <= int* v			$a1 <=	int qtd
	sub $t0,$a1,1 # int k = qtd - 1;
	lui $t1,0			# for(int i = 0;
	bubble_for1:
		bge $t1,$a1,bubble_for1Break # i < qtd; 
		lui $t2,0		# for(int j = 0;
		bubble_for2:
			bge $t2,$t0,bubble_for2Break # j < k
			mul $t3,$t2,4			# $t3 <= j * 4 
			addu $t3,$a0,$t3	# $t3 <= &v + 4 * j 
			addiu $t4,$t3,4		#	$t4 <= &v + 4 * j + 4
			lw $t5,0($t3)			# $t5 <= v[j] = aux
			lw $t6,0($t4)			# $t6 <= v[j+1] 
			ble $t5,$t6,bubble_ifFalse	# if(v[j] <= v[j+1]) goto ifFalse
				sw $t6,0($t3)	#	v[j] = v[j+1]
				sw $t5,0($t4) # v[j+1] = v[j](aux)
			bubble_ifFalse:
			addiu $t2,$t2,1		# j++
			j bubble_for2			#)
		bubble_for2Break:
		subi $t0,$t0,1	# k--;
		addiu $t1,$t1,1 # i++
		j bubble_for1		# )
	bubble_for1Break:
	jr $ra
	
		
	
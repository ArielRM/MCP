# Convenção de Chamadas: Estudo de Caso de Ordenação
#	Ariel Rigueiras Montardo								28/09/2017

.data
_v: .word 9,8,7,6,5,4,3,2,1,-1
_n:	.word 10

.text
.globl main
main:
	la $a0,_v
	lw $a1,_n
	jal sort
	li $v0,10	#exit syscall
	syscall
	
# procedure sort
sort:
	addi	$sp,$sp,-12	#	preservação de registradores armazenando seus conteudos na pilha
	sw		$ra,8($sp)	#	salva $ra em sp[2]
	sw		$s1,4($sp)	#	salva $s1 em sp[1]
	sw		$s0,0($sp)	#	salva $s0 em sp[0]
	
	move 	$s0,$zero		#	inicialização de i
	
	for1tst:								#	início do corpo do laço externo
		nop										# MARCA 1
		slt		$t0,$s0,$a1			# for1st
		beq		$t0,$zero,exit1	# for(i = 0; i < n; i++) {
		addi	$s1,$s0,-1			#		j = i - 1;
		
		for2tst:								#	inicio do corpo do laço interno
			slti	$t0,$s1,0				# for2st
			bne		$t0,$zero,exit2	# for( j = i - 1; j >= 0; j--) {
			sll		$t1,$s1,2				# 	$t1 = j * 4
			add		$t2,$a0,$t1			#		$t2 = v + j * 4
			lw		$t3,0($t2)			#		$t3 = v[j];
			lw		$t4,4($t2)			#		$t4 = v[j+1];
			slt		$t0,$t4,$t3			# 	if($t4 >= $t3) 
			beq		$t0,$zero,exit2	#			break;
														#		else {	
			move	$a1,$s1					#			$a1 = j
			nop										# 		MARCA 2
			jal		swap						#			swap($a0,$a1);
			addi	$s1,$s1,-1			#	(j--) do for
			j			for2tst					#	}
			# fim do corpo do laço interno
		exit2:
		addi	$s0,$s0,1				# (i++) do for
		j			for1tst					#	}
		#	fim do corpo do laço externo
	exit1:
	# restauração de conteúdos de registradores preservados na pilha
	lw		$s0,0($sp)	#	$s0 = sp[0]
	lw		$s1,4($sp)	#	$s1 = sp[1]
	lw		$ra,8($sp)	#	$ra = sp[2]
	addi	$sp,$sp,12	
	
	jr		$ra					#	retorno ao procedimento chamador
	
#	codificação da função swap
swap:
	sll		$t0,$a1,2		#	$t0 = 4 * k
	addu	$t0,$t0,$a0	#	$t0 = v + 4 * k
	lw		$t1,0($t0)	#	temp = v[k]
	lw		$t2,4($t0)	#	temp2 = v[k+1]
	sw		$t2,0($t0)	#	v[k] = temp2 = v[k+1] 
	sw		$t1,4($t0)	#	v[k+1] = temp = v[k]
	jr		$ra	

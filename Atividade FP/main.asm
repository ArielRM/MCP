.eqv N 6
.eqv _N 4 # _N = N-2
.eqv _N_ 12 # _N_ = (N-2)*3 
.data
txtb1: .asciiz "b1:"
txtb2: .asciiz "b2:"
txtb3: .asciiz "b3:"

coef: .float 0:3

vetor: .float 0:_N

matriz: .word 0:_N_

.text
.globl main
main:
	la $s0,coef		# float coef[1][3] -> $s0
	la $s1,vetor	# float vetor[1][N-2] -> $s1
	la $s2,matriz	# int matriz[3][N-2] -> $s2

la $a0,txtb1
obtemCoef:
	li $v0,4
	syscall
	li $v0,6
	syscall
	swc1 $f0,12($a0)
	addiu $a0,$a0,4
	bne $a0,$s0,obtemCoef

move $t0,$s2

li $t3,N
subi $t3,$t3,3
mul $t3,$t3,4
addu $t1,$t3,$t0

li $t3,N
subi $t3,$t3,3
mul $t3,$t3,4
addu $t2,$t3,$t1

li $t3,_N
addi $t4,$t3,1

lui $t5,0

obtemMatriz:
	li $v0,5
	syscall
	
	beq $t5,$t3,l1
	beq $t5,$t4,l2
	
	sw $v0,0($t0)
	addiu $t0,$t0,4
l1:
	sw $v0,0($t1)
	addiu $t1,$t1,4
l2:
	sw $v0,0($t2)
	addiu $t2,$t2,4
continue:
	addi $t5,$t5,1
	bne $t5,N,obtemMatriz

la $a0,coef
la $a1,matriz
la $a2,vetor

jal multi

exit:
li $v0,10
syscall

multi:
	li $t2,_N
	
	mul $t1,$t2,4
	addu $t0,$a1,$t1
	addu $t1,$t1,$t0
	
	lui $t2,0
	multi_loop:
		lwc1 $f8,0($a0)
		lwc1 $f10,4($a0)
		lwc1 $f12,8($a0)
		
		lwc1 $f14,0($a1)
		cvt.s.w $f14,$f14
		
		lwc1 $f16,0($t0)
		cvt.s.w $f16,$f16
		
		lwc1 $f18,0($t1)
		cvt.s.w $f18,$f18
		
		mul.s $f8,$f8,$f14
		mul.s $f10,$f10,$f16
		mul.s $f12,$f12,$f18
		
		add.s $f8,$f8,$f10
		add.s $f8,$f8,$f12
		
		swc1 $f8,0($a2)
		
		addiu $a1,$a1,4
		addiu $t0,$t0,4
		addiu $t1,$t1,4
		addiu $a2,$a2,4
		
		addi $t2,$t2,1
		
		bne $t2,_N,multi_loop
		
		jr $ra
		
		
		

	
	
	

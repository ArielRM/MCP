.data
vetor:	.space 200

.text
.globl main
main:
	la $s0,vetor
	addiu $t0,$s0,200
	
	preencher:
		li $v0,41
		syscall
		sw $a0,0($s0)
		addiu $s0,$s0,4
		blt $s0,$t0,preencher
	
	li $a1,50
	la $a0,vetor
	jal normalizar
	
li $v0,10
syscall

normalizar:
	move $t0,$a0
	mul $t1,$a1,4
	addu $t1,$t1,$t0
	
	lw $t3,0($t0)
	
	achaMaior:
		lw $t2,0($t0)
		ble $t2,$t3,menor
		move $t3,$t2
		menor:
		addi $t0,$t0,4
		blt $t0,$t1,achaMaior
		
	mtc1 $t3,$f0
	cvt.s.w $f0,$f0
	divide:
		lwc1 $f1,0($a0)
		cvt.s.w $f1,$f1
		div.s $f1,$f1,$f0
		swc1 $f1,0($a0)
		addiu $a0,$a0,4
		blt $a0,$t1,divide
	jr $ra
		
		
	
	

		
	
	
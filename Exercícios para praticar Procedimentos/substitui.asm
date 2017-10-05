.data 0x10010000
string: .asciiz "Substitoi"
alvo: .ascii "ou"
.text
main:
		la $a0,string
		la $a3,alvo
		lbu $a1,0($a3)
		lbu $a2,1($a3)
		sub $a3,$a3,$a0
		jal substitui
		
		li $v0,10
		syscall
		
substitui:
	addu $t0,$a0,$a3	#$t0 = $a0 + n
	
	addiu $v0,$zero,0 #$v0 = 0
	
	loop:
		beq $a0,$t0,fimLoop
		lbu $t1,0($a0)
		bne $t1,$a1,pula
		sb $a2,0($a0)
		addi $v0,$v0,1
	pula:
		addiu $a0,$a0,1
		j loop
	fimLoop:
	
	jr $ra
		
	
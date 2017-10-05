.data
delimitador:	.asciiz "=================================================================="
input: .space 18

.text
main:
	
	move $s0,$sp #inicio da pilha da calculadora
	loop:
		la $a0,delimitador
		li $v0,4
		syscall
			move $t0,$s0
			imprimePilha:
			beq $t0,$sp,imprimePilhaFim
			lwc1 $f12,0($t0)
			li $v0,2
			syscall
			addiu $t0,$t0,-4
			j imprimePilha
			imprimePilhaFim:
		la $a0,input
		li $a1,18
		syscall
		
	
	

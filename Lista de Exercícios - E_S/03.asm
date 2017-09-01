.data
pergunta: .asciiz "Quantos elementos terá a array?\n> "
pedeElemento: .asciiz "Elemento "
doisPontos: .asciiz " : "
.data 0x10008000
elementos: .space 4
.text

li $v0,4
la $a0,pergunta
syscall
li $v0,5
syscall
move $s0,$v0

la $t1,elementos #inicio da array
move $t0,$zero
entrada:
	li $v0,4
	la $a0,pedeElemento
	syscall
	li $v0,1
	move $a0,$t0
	syscall
	li $v0,4
	la $a0,doisPontos
	syscall
	li $v0,5
	syscall
	move $t2,$v0
	sw $t2,0($t1)
	addi $t0,$t0,1
	addi $t1,$t1,4
	bne $t0,$s0,entrada




	




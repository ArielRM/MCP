.data
texto: .asciiz "Pilha:"
texto2: .asciiz "\nEntrada: "
entrada: .space 11
entrada_tam:
.text
move $s1,$sp
inicio:
	la $a0,texto
	li $v0,4
	syscall
	move $s2,$s1
	subiu $s2,$s2,8
	loop:
		blt $s2,$sp,leEntrada
		#entra tab tab
		li $a0,9
		li $v0,11
		syscall
		syscall
		#entra o valor do elemento n da pilha
		li $v0,1
		lw $a0,0($s2)
		syscall
		#entra \n
		li $a0,10
		li $v0,11
		syscall
		subiu $s2,$s2,8
		j loop
leEntrada:
# entra o texto "Entrada:"
la $a0,texto2
li $v0,4
syscall
# lê uma string de entrada
la $a0,entrada
la $a1,entrada_tam
subu $a1,$a1,$a0
li $v0,8
syscall

lbu $s0,0($a0)

bgt $s0,57,opera
blt $s0,48,opera

jal str2int

addiu $sp,$sp,-8
sw $v0,0($sp)

j inicio

opera:	
	beq $s0,43,soma
	beq $s0,45,subt
	beq $s0,42,mulp
	beq $s0,47,divs
	beq $s0,94,pote
	beq $s0,33,fato
	j inicio
	
	soma:
		lw $t0,0($sp)
		lw $t1,8($sp)
		add $t0,$t0,$t1
		sw $t0,8($sp)
		addiu $sp,$sp,8
		j inicio
	subt:
		lw $t0,0($sp)
		lw $t1,8($sp)
		sub $t0,$t1,$t0
		sw $t0,8($sp)
		addiu $sp,$sp,8
		j inicio
	mulp:
		nop
	divs:
		nop
	pote:
		nop
	fato:
		nop

fim:
	move $sp,$s1
	li $v0,10
	syscall
	
str2int:
	lui $v0,0
	forEach:
		lbu $t0,0($a0)
		beqz $t0,return
		beq $t0,10,return
		mul $v0,$v0,10
		subi $t0,$t0,48
		add $v0,$v0,$t0
		addi $a0,$a0,1
		j forEach
	return:
	jr $ra
		

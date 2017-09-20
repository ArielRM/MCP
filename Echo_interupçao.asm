.data 0x10008000
entrada: .asciiz "Este é um programa ECHO. Entradas de teclado serão repetidas no display.\nEntre ESC para sair.\n"
saindo: .asciiz "\nSaindo..."

.text
main:
	jal enable_rxint
	lui $a0,0x1000
	ori $a0,$a0,0x8000
	jal printString
	
loop:
	j loop

exit:
	la $a0,saindo
	jal printString
	lui $v0,0x0000
	ori $v0,$v0,0x000a
	syscall
	
printChar:
	lui $t0,0xFFFF
	ori $t0,$t0,0x0008
	lw $t0,0($t0)
	andi $t0,$t0,1
	beq $t0,$0,printChar
	lui $t0,0xFFFF
	ori $t0,$t0,0x000c
	sw $a0,0($t0)
	jr $ra

printString:
	addiu $sp,$sp,-8
	addu $t0,$0,$a0
	sw $ra,0($sp)
	printString_for:
		lbu $a0,0($t0)
		beq $a0,$0,printString_break
		sw $t0,4($sp)
		jal printChar
		lw $t0,4($sp)
		addiu $t0,$t0,1
		j printString_for
	printString_break:
	lw $ra,0($sp)
	addiu $sp,$sp,8
	jr $ra

enable_rxint:
	mfc0 $t0,$12
	lui $t1,0xFFFF
	ori $t1,$t1,0xFFFE
	and $t0,$t0,$t1
  	mtc0 $t0,$12
  	lui $t1,0xFFFF
  	lw $t0,0($t1)
  	ori $t0,$t0,2
  	sw $t0,0($t1)
  	mfc0 $t0,$12
  	ori $t0,$t0,1
  	mtc0 $t0,$12
  	jr $ra


.ktext 0x80000180
int:
	addiu $sp,$sp,-8
	sw $t1,4($sp)
	sw $t0,0($sp)
	
	lui $t0,0xFFFF
	lw $t1,0($t0) # $t1 <- ctr rcv
	andi $t1,$t1,1 # $t1 <- ready bit
	beq $t1,$0,endInt
	
	lw $a0,4($t0) # $t1 <- tecla
	addi $t0,$0,27
	beq $a0,$t0,exit
	la $t0,printChar
	jalr $t0
	
endInt:
	mfc0 $t0,$13
	mtc0 $0,$13
	
	lw $t0,0($sp)
	lw $t1,4($sp)
	
	addiu $sp,$sp,8
	eret

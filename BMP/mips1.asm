.data 0x10010000
img: .asciiz "BMP/teste2.bmp"
.data 0x10040000
display: .space 16384
.text
main:
	subiu $sp,$sp,16384
	la $a0,img
	move $a1,$sp
	jal loadTrueColorBMP
	beqz $v0,err
		
	move $a0,$sp
	la $a1,display
	move $a2,$v0
	move $a3,$v1
	jal drawBMP
	
	addiu $sp,$sp,16384
	li $v0,10
	syscall
	err:
		break

drawBMP:
	mul $t0,$a2,$a3
	drawBMPLoop:
		lw $t1,0($a0)
		sw $t1,0($a1)
		addiu $a0,$a0,4
		addiu $a1,$a1,4
		subi $t0,$t0,1
		bgtz $t0,drawBMPLoop
	jr $ra

loadTrueColorBMP:
	move $t0,$a1
	#abre arquivo
	li $v0,13 # parametro p chamada de abertura
	li $a1,0	# flags (0=read, 1=write)
	li $a2,0	# mode = desnecessário
	syscall		# devolve o descritor (ponteiro) do arquivo em $v0
	bgtz $v0,loadTrueColorBMPLerC
	li $v0,0
	li $v1,1
	jr $ra
	loadTrueColorBMPLerC:
	subiu $sp,$sp,20
	move $a0,$v0 # mode o descritor para $a0
	li $v0,14		 # parametro de chamada de leitura de arquivo
	move $a1,$sp # endereço para armazenamento dos dados lidos
	li $a2,18		 # tamanho máx de caracteres
	syscall			 # devolve o número de caracteres lidos
	addiu $sp,$sp,20
	beq $v0,18,loadTrueColorBMPLerWH
	# Close the file 
	li $v0,16 # system call for close file
	syscall   # close file
	li $v0,0
	li $v1,2
	jr $ra
	loadTrueColorBMPLerWH:
	subiu $sp,$sp,8
	li $v0,14		 # parametro de chamada de leitura de arquivo
	move $a1,$sp # endereço para armazenamento dos dados lidos
	li $a2,8		 # tamanho máx de caracteres
	syscall			 # devolve o número de caracteres lidos
	beq $v0,8,loadTrueColorBMPCarregarWH
	addiu $sp,$sp,8
	# Close the file 
	li $v0,16 # system call for close file
	syscall   # close file
	li $v0,0
	li $v1,3
	jr $ra
	loadTrueColorBMPCarregarWH:
	lw $t1,0($sp) # $t1 -> Width
	lw $t2,4($sp) # $t2 -> Height
	move $t3,$t2
	subi $t5,$t1,1
	subi $t6,$t2,1
	mul $t5,$t1,$t6
	mul $t5,$t5,4
	mul $t6,$t1,4
	addu $t5,$t0,$t5
	subiu $sp,$sp,20
	li $v0,14		 # parametro de chamada de leitura de arquivo
	move $a1,$sp # endereço para armazenamento dos dados lidos
	li $a2,28		 # tamanho máx de caracteres
	syscall			 # devolve o número de caracteres lidos
	addiu $sp,$sp,28
	beq $v0,28,loadTrueColorBMPLerBMP
	# Close the file 
	li $v0,16 # system call for close file
	syscall   # close file
	li $v0,0
	li $v1,4
	jr $ra
	loadTrueColorBMPLerBMP:
		move $t4,$t1
		loadTrueColorBMPLerBMP2:
			li $v0,14		 # parametro de chamada de leitura de arquivo
			move $a1,$t5 # endereço para armazenamento dos dados lidos
			li $a2,3		 # tamanho máx de caracteres
			syscall			 # devolve o número de caracteres lidos
			lbu $t7,2($t5)
			sll $t7,$t7,8
			lbu $t8,1($t5)
			or $t7,$t7,$t8
			sll $t7,$t7,8
			lbu $t8,0($t5)
			or $t7,$t7,$t8
			sw $t7,0($t5)
			addiu $t5,$t5,4
			subi $t4,$t4,1
			bgtz $t4,loadTrueColorBMPLerBMP2
		sub $t5,$t5,$t6
		sub $t5,$t5,$t6
		subi $t3,$t3,1
		bgtz $t3,loadTrueColorBMPLerBMP
	# Close the file 
	li $v0,16 # system call for close file
	syscall   # close file
	move $v0,$t1
	move $v1,$t2
	jr $ra
	
	
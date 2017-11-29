.data 0x10000000
display: .space 1048576
img: .asciiz "lena.bmp"
.text
main:
	la $a0,img
	la $a1,img
	li $a2,512
	li $a3,512
	jal abrirImagem
	
	la $t0,img
	la $t1,display
	li $t3,1048576
	loop:
		lw $t2,0($t0)
		sw $t2,0($t1)
		addiu $t0,$t0,4
		addiu $t1,$t1,4
		subi $t3,$t3,1
		bnez $t3,loop
	
	li $v0,10
	syscall

# $a0: char* filename
# $a1: img* imagem
# $a2: int width
# $a3: int heigh
abrirImagem:
	# Salva informações perdidas em syscalls
	move $t0,$a0
	move $t1,$a1
	move $t2,$a2
	move $t3,$a3
	
	#calcula o número de pixels
	mul $t4,$t2,$t3
	
	#calcula o tamanho da imagem (4 bytes por pixel)
	mul $t5,$t4,4
	
	#abre arquivo
	li $v0, 13		# parametro p chamada de abertura
	li $a1, 0		# flags (0=read, 1=write)
	li $a2, 0		# mode = desnecessário
	syscall			# devolve o descritor (ponteiro) do arquivo em $v0
	
	move $t6,$a0
	
	move $a0, $v0		# mode o descritor para $a0
	li $v0, 14		# parametro de chamada de leitura de arquivo
	move $a1,$t1		# endereço para armazenamento dos dados lidos
	move $a2,$t5		# tamanho máx de caracteres
	syscall			# devolve o número de caracteres lidos
	
	# Close the file 
	li   $v0, 16       	# system call for close file
	move $a0, $t6      	# file descriptor to close
	syscall            	# close file
	
	move $t6,$t4
	addiu $t7,$t1,54
	arrumaBytes:
		lbu $t8,0($t7)
		lbu $t9,1($t7)
		sll $t9,$t9,8
		or $t8,$t8,$t9
		lbu $t9,2($t7)
		sll $t9,$t9,16
		or $t8,$t8,$t9
		
		subiu $sp,$sp,4
		sw $t8,0($sp)
		
		addiu $t7,$t7,3
		subiu $t6,$t6,1
		bgtz $t6,arrumaBytes
		
		subi $t6,$t2,1
		mul $t6,$t2,4
		add $t7,$t1,$t6 # A posição do ultimo pixel lido
		move $t8,$t3
		loopLinha:
			move $t9,$t2
			loopColuna:
				lw $t5,0($sp)
				sw $t5,0($t7)
				subiu $t7,$t7,4
				addiu $sp,$sp,4
				subi $t9,$t9,1
				bgtz $t9,loopColuna
			addu $t7,$t7,$t6
			addu $t7,$t7,$t6
			subi $t8,$t8,1
			bgtz $t8,loopLinha
						
		jr $ra	
		

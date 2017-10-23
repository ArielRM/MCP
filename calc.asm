.data
clearScreen: .asciiz "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
texto1:	.asciiz "Pilha:\n"
texto2: .asciiz "Entrada:\t"
entrada: .space 11

.text
move $s0,$sp
imprimePilha:
	la $a0,clearScreen
	li $v0,4
	syscall
	move $t0,$s0
	la $a0,texto1
	syscall
	loop1:
		beq $t0,$sp,getEntrada
		li $a0,9
		li $v0,11
		syscall
		syscall
		lwc1 $f12,-4($t0)
		li $v0,2
		syscall
		li $a0,10
		li $v0,11
		syscall
		subiu $t0,$t0,4
		j loop1
getEntrada:
	la $a0,texto2
	li $v0,4
	syscall
	la $a0,entrada
	li $a1,11
	li $v0,8
	syscall
	
	#analiza o primeiro caracter
	la $a0,entrada
	lbu $t1,0($a0)
	
	beq $t1,99,CA
	beq $t1,67,CA
	
	#.AAAAA
	beq $t1,46,transforma
	# AAA.AAAA
	blt $t1,48,opera
	bgt $t1,57,opera
	
	transforma:
	jal str2float
	
	subiu $sp,$sp,4
	swc1 $f0,0($sp)
	j imprimePilha
	
opera:
	move $t0,$sp
	addiu $t0,$t0,4
	#operaçoes
	beq $t1,33,fato
	ble $s0,$t0,imprimePilha
	beq $t1,43,soma
	beq $t1,45,subt
	beq $t1,42,mulp
	beq $t1,47,divs
	beq $t1,94,pote
	
	j imprimePilha
	
	soma:
		lwc1 $f4,0($sp)
		lwc1 $f6,4($sp)
		addiu $sp,$sp,4
		add.s $f4,$f6,$f4
		swc1 $f4,0($sp)
		j imprimePilha
	subt:
		lwc1 $f4,0($sp)
		lwc1 $f6,4($sp)
		addiu $sp,$sp,4
		sub.s $f4,$f6,$f4
		swc1 $f4,0($sp)
		j imprimePilha
	mulp:
		lwc1 $f4,0($sp)
		lwc1 $f6,4($sp)
		addiu $sp,$sp,4
		mul.s $f4,$f6,$f4
		swc1 $f4,0($sp)
		j imprimePilha
	divs:
		lwc1 $f4,0($sp)
		lwc1 $f6,4($sp)
		addiu $sp,$sp,4
		div.s $f4,$f6,$f4
		swc1 $f4,0($sp)
		j imprimePilha
	pote:
		lwc1 $f14,0($sp)
		lwc1 $f12,4($sp)
		addiu $sp,$sp,4
		jal pot
		swc1 $f0,0($sp)
		j imprimePilha
	fato:
		lwc1 $f12,0($sp)
		jal fat
		swc1 $f0,0($sp)
		j imprimePilha
	CA:
		move $sp,$s0
		j imprimePilha
	li $v0,10
	syscall
	
	
str2float:
	li $t1,0
	mtc1 $t1,$f0
	cvt.s.w $f0,$f0
	li $t1,10
	mtc1 $t1,$f8
	cvt.s.w $f8,$f8
	
	add.s $f6,$f0,$f8
	pt1:
	lbu $t0,0($a0)
	addiu $a0,$a0,1
	subiu $t0,$t0,48
	
	
	beq $t0,-2,pt2
	bltz $t0,ret
	bgt $t0,9,ret
	
	mtc1 $t0,$f10
	cvt.s.w $f10,$f10
	mul.s $f0,$f0,$f8
	add.s $f0,$f0,$f10
	j pt1
	
	pt2:
	lbu $t0,0($a0)
	addiu $a0,$a0,1
	subiu $t0,$t0,48
	
	bltz $t0,ret
	bgt $t0,9,ret
	
	mtc1 $t0,$f10
	cvt.s.w $f10,$f10
	div.s $f10,$f10,$f8
	add.s $f0,$f0,$f10
	
	mul.s $f8,$f8,$f6
	j pt2	
	ret:
	jr $ra
	
pot:
	#f0 = $f12 ^ $f14
	subiu $sp,$sp,8
	sw $ra,0($sp)
	
	li $t0,1
	mtc1 $t0,$f0
	cvt.s.w $f0,$f0
	
	cvt.w.s $f2,$f14
	mfc1 $t0,$f2
	beqz $t0,potRet
	
	bgtz $t0,potPos
	# Potencia negativa
	mul $t0,$t0,-1
	mtc1 $t0,$f14
	cvt.s.w $f14,$f14
	jal pot
	li $t0,1
	mtc1 $t0,$f2
	cvt.s.w $f2,$f2
	div.s $f0,$f2,$f0
	j potRet
		
	potPos:
	sub.s $f14,$f14,$f0
	jal pot
	mul.s $f0,$f12,$f0	
	
	potRet:
		lw $ra,0($sp)
		addiu $sp,$sp,8
		jr $ra
	
fat:
	#f0 = !$f12
	subiu $sp,$sp,8
	sw $ra,4($sp)
	swc1 $f12,0($sp)
	
	li $t0,1
	mtc1 $t0,$f0
	cvt.s.w $f0,$f0
	cvt.w.s $f12,$f12
	mfc1 $t0,$f12
	ble $t0,1,fatRet
	
	subi $t0,$t0,1
	mtc1 $t0,$f12
	cvt.s.w $f12,$f12
	jal fat
	lwc1 $f12,0($sp)
	mul.s $f0,$f0,$f12
	fatRet:
	lw $ra,4($sp)
	addiu $sp,$sp,8
	jr $ra

		
	
	

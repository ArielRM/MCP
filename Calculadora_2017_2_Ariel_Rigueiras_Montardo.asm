#	Calculadora
#	Ariel Rigueiras Montardo
#	26/10/2017

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
	syscall				#printf("%s",clearScreen);
	la $a0,texto1
	syscall				#printf("%s",texto1);
	
	move $t0,$s0	# int i eqv $t0 = $s0
	loop1:
		beq $t0,$sp,getEntrada		# for(i; i > sp; i-=4) {
		li $a0,9
		li $v0,11
		syscall										# printf("\t\t");
		syscall
		lwc1 $f12,-4($t0)
		li $v0,2
		syscall										#printf("%f";*i);
		li $a0,10
		li $v0,11
		syscall										#printf("\n");
		subiu $t0,$t0,4
		j loop1										#}
getEntrada:
	la $a0,texto2
	li $v0,4
	syscall										#printf("%s",texto2);
	la $a0,entrada
	li $a1,11
	li $v0,8
	syscall										#scanf("%s",entrada);
	
	#analiza o primeiro caracter
	la $a0,entrada
	lbu $t1,0($a0)
	
	# if(entrada[0] == 'C' || entrada[0] == 'c') goto CA (clear all);
	beq $t1,99,CA
	beq $t1,67,CA
	
	# if(entrada[0] == '.') goto transforma	(.AAAAA = 0.AAAA)
	beq $t1,46,transforma
	# if(entrada[0] < '0' || entrada[0] > '9') goto opera (se não for um numero possivelmente é uma operação)
	blt $t1,48,opera
	bgt $t1,57,opera
	
	
	transforma:
	jal str2float	#str2float($a0) sendo $a0 = &entrada
	
	subiu $sp,$sp,4	# insere novo valor na pilha
	swc1 $f0,0($sp)
	j imprimePilha	# imprime e obtem proximo valor
	
opera:
	move $t0,$sp			# int temp = $sp
	addiu $t0,$t0,4		# temp += 4
	#operaçoes
	beq $t1,33,fato						# fatorial usa apenas um valor
	ble $s0,$t0,imprimePilha	# se tiver menos de dois valores na pilha as outras operações não podem ser realizadas
	beq $t1,43,soma
	beq $t1,45,subt
	beq $t1,42,mulp
	beq $t1,47,divs
	beq $t1,94,pote
	
	j imprimePilha					# entrada inválida
	
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

		
	
	

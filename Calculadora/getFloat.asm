.globl getFloat
getFloat:
	addi $t0,$zero,4
	sub $sp,$sp,$t0
	sw $ra,0($sp)
	
	addi $t0,$zero,4
	sub $sp,$sp,$t0
	jal getInt
	lwc1 $f0,0($sp)
	cvt.s.w $f0,$f0
	addi $sp,$sp,4
	
	addi $t0,$zero,46
	bne $v1,$t0,getFloat_fim
	
	addi $t0,$zero,20
	sub $sp,$sp,$t0
	swc1 $f0,16($sp)
	sw $v0,12($sp)
	
	jal getInt
	sw $v1,4($sp)
	
			
	lui $a0,0
	ori $a0,$a0,10
	lui $a1,0
	or $a1,$a1,$v0
	
	lw $t0,12($sp)
	add $v0,$v0,$t0
	sw $v0,8($sp)
	
	jal pow
	
	lwc1 $f16,0($sp)
	cvt.s.w $f16,$f16
	div.s $f16,$f16,$f0
	
	lwc1 $f0,16($sp)
	add.s $f0,$f0,$f16
	
	lw $v1,4($sp)
	lw $v0,8($sp)
	addi $sp,$sp,20
	getFloat_fim:
		lw $ra,0($sp)
		addi $sp,$sp,4
		jr $ra
		

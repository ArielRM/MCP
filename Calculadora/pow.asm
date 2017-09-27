.globl pow
pow:
	addi $t0,$zero,1
	mtc1 $t0,$f0
	cvt.s.w $f0,$f0
	mtc1 $a0,$f2
	cvt.s.w $f2,$f2
	pow_for:
		beq $a1,$zero,pow_for_break
		mul.s $f0,$f0,$f2
		sub $a1,$a1,$t0
		j pow_for
	pow_for_break: 
	jr $ra

li $t0,0x00101000

	slt $t2,$0,$t0 # se $0 < $t3 ? $t2 <= 1 : $t2 <= 0
	#$t0 > 0, logo $t2 = 1
	bne $t2, $0, else # $t2 = 1 != 0, então branch para else
	j done
else:	addi $t2,$t2,2 # $t2 += 2
done: 
# $t2 = 3
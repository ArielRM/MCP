# ($sp) atual, Inteiro
# $v1, Digitos contabilizados
# $v0, Caractere de finalização
.globl getInt
getInt:
	addi $t2,$zero,57 # $t2 tem 57
	addi $t3,$zero,10 # $t3 tem 10
	lui $t0,0xFFFF #la 0xFFFF0000
	lui $v0,0
	lui $t1,0
	esperaChar:
		lw $v1,0($t0)
		andi $v1,$v1,1
		beq $v1,$zero,esperaChar # continue
		lw $v1,4($t0)
		sub $t4,$v1,$t2
		bgtz $t4,end
		addi $t4,$t4,9
		bltz $t4,end
		mul $t1,$t1,$t3
		add $t1,$t1,$t4
		addi $v0,$v0,1
		j esperaChar
	end:
		sw $t1,0($sp)
		jr $ra

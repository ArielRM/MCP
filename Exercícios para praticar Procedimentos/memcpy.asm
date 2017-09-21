.data
stringOr:	.asciiz "Hello, World!\n1234567890	ABCDEF"
stringCp:	.space	32

.text
main:
	la $a0,stringOr
	la $a1,stringCp
	li $a2,32
	jal memcpy
exit:
	li $v0,10
	syscall
	
# Memcopy
memcpy:	# $a0 <= char* src		$a1 <= char* dst		$a2 <= int bytes
	memcpy_While:
		beq $a2,$0,memcpy_ret
		lbu $t0,0($a0)
		sb $t0,0($a1)
		addiu $a0,$a0,1
		addiu $a1,$a1,1
		sub $a2,$a2,1
		j memcpy_While
	memcpy_ret:
		jr $ra
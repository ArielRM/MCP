.text
j main
.include "..\lib\libmimo.asm"

.data 0x10008000
string: .space 10

.text
#getc:	# $v0 : char (Locks)
#putc:	#	$a0 : char
#puts: 	#	$a0 : ponteiro para string
#gets: 	# $a0 : ponteiro para string	$a1 : max de caracteres	(a string terá no mín 1 char (\0) e no máx n + 1 char)

main:
	lui $a0,0x1000
	ori $a0,$a0,0x8000
	addi $a1,$0,9
	
	jal gets
	
	lui $a0,0x1000
	ori $a0,$a0,0x8000
	jal puts
	
	addi $a0,$0,10
	jal putc
	
	j exit
	
exit:
	j main
	addi $v0,$0,10
	syscall

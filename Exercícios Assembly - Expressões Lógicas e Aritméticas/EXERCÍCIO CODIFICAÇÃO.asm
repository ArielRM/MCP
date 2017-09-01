# início do segmento de dados (em 0x1000 8000)
.data 0x10008000
stringEspaco: .asciiz " "
vetor: .word 2,0xAAAAAAAA,0xAAAAAAAA
destino: .space 4
.text

.macro printInt(%int)
add $a0,$zero,%int
li $v0,1
syscall
.end_macro

.macro printEspaco
la $a0,stringEspaco
li $v0,4
syscall
.end_macro


la $s0,vetor 
lw $s2,0($s0) #$s2 = Número de dados (bytes) 

addi $s0,$s0,4 #$s0 <- Endereço do vetor

li $s1,32 # Número de deslocamentos por word

li $t2,-1 # Ultimo bit 1 foi para -1

loopArray:
	lw $t3,0($s0) #$t3 <- Word[i]
	loopWord:
	bgez $t3,bit0 # Se o número for positivo MSB = 0
	bgez $t2,ultimo1 # Se $t2 = 1 vai para ultimo1
	li $t2,1 # O ultimo foi -1 logo este é um
	printInt(1)
	j check
	ultimo1:
		li $t2,-1
		printInt(-1)
		j check
	bit0:
		printInt(0)
	check:
		printEspaco
		sll $t3,$t3,1 # $t3 <<= 1
		sub $s1,$s1,1 # $s1--
	bgtz $s1,loopWord
	
	li $s1,32 # Número de deslocamentos por word
	sub $s2,$s2,1
	add $t3,$t3,4
bgtz $s2,loopArray
	


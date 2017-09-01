.macro printString(%strLabel)
la $a0,%strLabel
li $v0,4
syscall
.end_macro

.macro printInt(%int)
add $a0,$zero,%int
li $v0,1
syscall
.end_macro

.macro getInt(%reg)
li $v0,5
syscall
move %reg,$v0
.end_macro

.data 0x10010000
pedeTam: .asciiz "Entre o tamanho do vetor: "
pedeElem: .asciiz "Entre o valor do elemento "
doisPontos: .asciiz ": "
somatorioText: .asciiz "Somatório: "
media: .asciiz "Média: "
resto: .asciiz " resto "
ln: .asciiz "\n"
.data 0x10008000
inicioVetor: .space 4
.text
la $s1,inicioVetor

printString(pedeTam)
getInt($s0)

li $t1,0 #Usado para contagem

loop:
printString(pedeElem)
printInt($t1)
printString(doisPontos)
getInt($t0)
sw $t0,0($s1)
addi $t1,$t1,1
addi $s1,$s1,4
bne $t1,$s0,loop

la $s1,inicioVetor
li $t1,0
li $t2,0
somatorio:
lw $t0,0($s1)
add $t2,$t2,$t0
addi $t1,$t1,1
addi $s1,$s1,4
bne $t1,$s0,somatorio

div $t2,$s0
#media "arredondada" (Quociente + resto)
mflo $t3
mfhi $t4

printString(media)
printInt($t3)
printString(resto)
printInt($t4)
printString(ln)


printString(somatorioText)
printInt($t2)







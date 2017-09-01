.data
pergunta: .ascii "\nDiga alguma coisa que irei dizer também!\n"
vcDiz: .asciiz "Você diz: "
euDigo: .ascii "Eu digo: "
entrada: .space 20


.text

loop:
li $v0,4
la $a0,pergunta
syscall
li $v0,8
li $a1,20
la $a0,entrada
syscall
li $v0,4
la $a0,euDigo
syscall
j loop
.data

digite1: .asciiz "Digite o primeiro número: "
digite2: .asciiz "Digite o segundo número: "

resto: .asciiz ", resto "

mais: .asciiz " + "
menos: .asciiz " - "
vezes: .asciiz " x "
dividido: .asciiz " / "
igual: .asciiz " = "
quebra: .asciiz "\n"

.text

.macro printString (%stringAddr)
li $v0,4
la $a0,%stringAddr
syscall
.end_macro

.macro scanInt(%reg)
li $v0,5
syscall
move %reg,$v0
.end_macro

.macro printInt(%reg)
li $v0,1
move $a0,%reg
syscall
.end_macro

loop:

printString(digite1)
scanInt($t0)

printString(digite2)
scanInt($t1)


add $t2,$t0,$t1
printInt($t0)
printString(mais)
printInt($t1)
printString(igual)
printInt($t2)
printString(quebra)

sub $t2,$t0,$t1
printInt($t0)
printString(menos)
printInt($t1)
printString(igual)
printInt($t2)
printString(quebra)

mul $t2,$t0,$t1
printInt($t0)
printString(vezes)
printInt($t1)
printString(igual)
printInt($t2)
printString(quebra)

div $t0,$t1
printInt($t0)
printString(dividido)
printInt($t1)
printString(igual)
mflo $t2
printInt($t2)
printString(resto)
mfhi $t2
printInt($t2)
printString(quebra)

j loop
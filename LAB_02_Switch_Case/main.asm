.data
# Se��o 1: vari�veis f, g, h, i, j armazenadas em mem�ria (inicializa��o)
_f: .word 0
_g: .word 4
_h: .word 1
_i: .word 4
_j: .word 6

# Se��o 2: JAT
jat:
.word L0
.word L1
.word L2
.word L3
.word default

.text
.globl main
main:
# Se��o 3: registradores recebem valores inicializados (exceto vari�vel k)
lw $s0, _f
lw $s1, _g
lw $s2, _h
lw $s3, _i
lw $s4, _j

la $t4, jat	#carrega endere�o base de jat

# Se��o 4: testa se k est� no intervalo [0,3], caso contr�rio default
bltz $s5,default
slti $t0,$s5,4
beq $t0,$zero,default
# Se��o 5: calcula o endere�o de jat[k]
lui $t0,0 # Zera $t0
ori $t0,$zero,4 # $t0 <- 4
mul $t0,$s5,$t0 # $t0 = k * 4
add $t0,$t0,$t4 # $t0 = JAT + k*4  = JAT[k]
# Se��o 6: desvia para o endere�o em jat[k]
lw $t0,0($t0)
jr $t0
# Se��o 7: codifica as alternativas de execu��o
L0:
add $s0,$s3,$s4
j exit
L1:
add $s0,$s1,$s2
add $s0,$s0,$s5
j exit
L2:
sub $s0,$s1,$s2
j exit
L3:
sub $s0,$s3,$s4
j exit
default:
sub $s0,$s3,$s4
add $s0,$s0,$s2
exit:

.data
# Seção 1: variáveis f, g, h, i, j armazenadas em memória (inicialização)
_f: .word 0
_g: .word 4
_h: .word 1
_i: .word 4
_j: .word 6

# Seção 2: JAT
jat:
.word L0
.word L1
.word L2
.word L3
.word default

.text
.globl main
main:
# Seção 3: registradores recebem valores inicializados (exceto variável k)
lw $s0, _f
lw $s1, _g
lw $s2, _h
lw $s3, _i
lw $s4, _j

la $t4, jat	#carrega endereço base de jat

# Seção 4: testa se k está no intervalo [0,3], caso contrário default
bltz $s5,default
slti $t0,$s5,4
beq $t0,$zero,default
# Seção 5: calcula o endereço de jat[k]
lui $t0,0 # Zera $t0
ori $t0,$zero,4 # $t0 <- 4
mul $t0,$s5,$t0 # $t0 = k * 4
add $t0,$t0,$t4 # $t0 = JAT + k*4  = JAT[k]
# Seção 6: desvia para o endereço em jat[k]
lw $t0,0($t0)
jr $t0
# Seção 7: codifica as alternativas de execução
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

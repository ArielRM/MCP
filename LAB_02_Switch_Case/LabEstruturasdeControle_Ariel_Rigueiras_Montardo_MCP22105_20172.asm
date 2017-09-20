#	Lab: Estruturas de Controle
#
#		Ariel Rigueiras Montardo
#		MCP22105 - 2017-2
#
# Respostas no fim do arquivo



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



# exception.txt:
#	VAZIO



# Testes:
#		k	$s0
#		-1	-1
#		0	10
#		1	6
#		2	3
#		3	-2
#		4	-1



# Quest�es:	
#
#	1 - Qual o ender�o de mem�ria do primeiro elemento armazenado na JAT?
#		jat: 0x10010014
#
#	2 - A que endere�os efetivos de memm�ria correspondem os seguintes r�tulos?
#		L0: 0x00400050		L1: 0x00400058		L2: 0x00400064
#		L3: 0x0040006C		default: 0x00400074
#
#	3 - A pseudo-instru��o la $t4,jat foi expandida pelo montador em termos de duas instru��es
#	nativas no MIPS. Reproduza-as abaixo em linguagem de montagem usando os nomes simb�licos dos
#	registradores utilizados no c�digo. Indique tamb�m o respectivo c�digo em linguagem de m�quina,
#	representado em hexadecimal.
#	
#		Linguagem de montagem		Linguagem de m�quina
#		lui $t4,0x00001001		0x3C011001
#		ori $t4,0x00000014		0x342C0014
#
#	4 -  As instru��es que carregam os valores inicializados de f, g, h, i e j em registradores n�o fazem
#	parte do c�digo gerado para o switch, mas apenas servem para evitar que voc� tenha que inicializ�-
#	las cada vez que mudar o valor de k. Entretanto, � interessante notar que a carga de cada um daqueles
#	valores usa uma pseudo-instru��o, que � expandida em duas instru��es nativas. Mostre a expans�o
#	para a pseudo-instru��o lw $s0, _f (em linguagem de montagem), usando os nomes simb�licos dos
#	registradores utilizados no c�digo.
#
#		Linguagem de montagem
#		lui $s0,0x00001001
#		lw $s0,0($s0)
#
#	5 - Para o c�digo da quest�o 4, qual o valor atribu�do a $at?
#		$at: 0x10010000
#
#	6 - Mostre o c�digo em linguagem de montagem que testa se k pertence a [0,3] (se��o4) e desvia para o endere�o default
#		0x06a00011
#		0x2aa80004
#		0x1100000f	
#
#	7 - Qual a codifica��o em linguagem de m�quina da instru��o j exit?
#		j exit <=> 0x08100020
#
#	8 - O r�tulo exit foi resolvido pelo montador. Que endere�o lhe foi atribuido?
#		exit <=> 0x00400080
#
#	9 - Qual o valor dos 26 bits menos significativos da representa��o bin�ria da instru��o j exit?
#
#	25 24	23 22 21 20	19 18 17 16	15 14 13 12	11 10 09 08	07 06 05 04	03 02 01 00
#	0  0	0  0  0  1	0  0  0  0	0  0  0  0	0  0  0  0	0  0  1  0	0  0  0  0
#
#	10 - Comente a consist�ncia dos valores obtidos nas quest�es 8 e 9, mostrando como um deles �
#	obtido a partir do outro.
#
#	O endere�o de exit pode ser obtido deslocando-se o valor obtido na quest�o 9 em dois bits � esquerda.
#	A instru��o j tem os seis primeiros bits 0x02 (0000 10) como op code, j� os outros 26 bits (25-0) representam o endere�o alvo, por�m endere�os t�m 32 bits, para que essa instru��o seja v�lida s�o necess�rias duas observa��es. Primeiro, os dois ultimos bits do endere�o s�o sempre 0, pois qualquer endere�o de programa � um m�ltiplo de quatro. A segunda observa��o � ser feita � que o valor final de PC ter� seus 4 bits mais significativos inalterados ap�sa instru��o j. Logo o endere�o final de PC pode ser obtido com o seguinte formato (PC & 0xf0000000)|(alvo<<2), onde alvo � a representa��o de 26 bits da instru��o.
#
#	Sendo PCn o valor de PC ao fim da instru��o temos:
#
#		alvo:				0x00100020
#		alvo << 2:			0x00400080 (Endere�o de exit)
#		PC no in�cio da instru��o:	0x0XXXXXXX
#		PC & 0xf0000000:		0x00000000
#	PCn  =	(PC & 0xf0000000)|(alvo<<2):	0x00400080 (Endere�o de exit)

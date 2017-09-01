# f -> $s0
# g -> $s1
# h -> $s2
# i -> $s3
# j -> $s4

# a)	f = g*h + i
mul $s0,$s1,$s2 # f = g*h (LO)
add $s0,$s0,$s3 # f += i

# b)	f = g*(h + i)
add $s0,$s2,$s3 # f = h + i
mul $s0,$s0,$s1 # f *= g

# c)	f = g + (h - 5)
subi $s0,$s2,5 # f = h - 5
add $s0,$s0,$s1 # f += g

# d)	[f,g] = (h*i) + (i*i)	## resultado de 64 bits, Hi em f e Lo em g
mul $s1,$s2,$s3 # g = LO(h*i)
mfhi $s0 # f = HI(h*i)
mul $t1,$s3,$s3 # t1 = LO(i*i)
mfhi $t0 # t0 = HI(i*i)
add $s1,$s1,$t1 # g += LO(i*i)
# POSSIVEL OVERFLOW
add $s0,$s0,$t0 # f += HI(i*i)

# e)	f = g*9 	## sem utilizar a instrução de multiplicação
li $t1,9 # t1 = 9
for: #t = 9; t != 0; t--
  add $s0,$s0,$s1 # f += g
  subi $t1,$t1,1 # t1--
beqz $t1,for
# f = g + g + g ... (9 vezes) = g*9

# f)	f = 2**g	## g >= 0
li $s0,1 # f = 1 (padrão para g = 0)
li $t0,2
loop:
# for( g ; g !=0 ; g-- )
  beqz $s1,end1 # g == 0 ? break : f * 2
  mul $s0,$s0,$t0 # f *= 2
  sub $s1,$s1,1 # g--
end1:

# g)	h = min(f,g)	# mínimo valor enre f e g
bgt $s0,$s1,fMaior # f > g ? fMaior : continua
move $s0,$s2 # h = f
j end2
fMaior:
move $s1,$s2 # h = g
end2:

# h)	h = max(f,g)	#máximo valor entre f e g
bgt $s1,$s0,gMaior # g > f ? gMaior : continua
move $s0,$s2 # h = f
j end
gMaior:
move $s1,$s2 # h = g
end:

# Base dos vetores: A -> $s6, B -> $s7

# i)	B[8] = A[i-j]

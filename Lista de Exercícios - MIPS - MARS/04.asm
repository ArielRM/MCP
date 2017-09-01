.data 0x10008000

entrada: .word -98
dataIfPos: .space 4
dataIfNeg: .space 4

.text

la $s1,entrada
lw $t1,($s1)
bgtz $t1,ifPos
sw $t1,8($s1)
j end
ifPos:
sw $t1,4($s1)
end: 
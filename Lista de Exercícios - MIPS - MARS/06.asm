.data 0x10008000
entrada: .word 7,7
maior: .space 4
.text

la $s1,entrada
lw $t1,0($s1)
lw $t2,4($s1)
bge $t2,$t1,segundoEMaior
sw $t1,8($s1)
j end
segundoEMaior: 
sw $t2,8($s1)
end:
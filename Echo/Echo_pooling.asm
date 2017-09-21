#	Echo via pooling
.data 0xFFFF0000
recvControl:	.space 4
recvData:	.space 4
trmtControl:	.space 4
trmtData:	.space 4

.text 

while1:
	lw $t0,recvControl
	andi $t0,$t0,1
	beqz $t0,while1
	lw $t0,recvData

while2:
	lw $t1,trmtControl
	andi $t1,$t1,1
	beqz $t1,while2
	sw $t0,trmtData
	
j while1
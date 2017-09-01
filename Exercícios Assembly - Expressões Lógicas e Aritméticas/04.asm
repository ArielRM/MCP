# a)
li $s0,0xA00DEFFF
ori $s0,$s0,0x1000000 # $s0 |= (1 << 24)
# $s0 = 0xA10DEFFF

# b)
li $s0,0xA00DEFFF
andi $s0,$s0,0xFFFFDEFB # $s0 &= ~((1<<2)|(1<<8)|(1<<13))
# $s0 = A00DCEFB

# c)
li $s1,0x00FF1234
xori $s1,$s1,0x80000001 # $s1 ^= ((1<<31)|(1<<0))
# $s1 = 0x80FF1235

# d)
li $s1,0x00FF1234
ori $s1,$s1,0x50200002 # $s1 |= (1<<30)|(1<<28)|(1<<21)|(1<<1)
# $s1 = 0x50FF1236

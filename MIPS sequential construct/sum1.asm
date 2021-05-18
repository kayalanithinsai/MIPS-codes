.text
main:
# main part
lw $t0 a #t0 has a first term of ap.
lw $t1 d #t1 has the common difference d of the ap.
lw $t2 n1 #t2 has the nth term n value.
sub $t3 $t2 1
mul $t4 $t3 $t1
add $t5 $t0 $t4
sw $t5 nap
lw $t2 n2
sub $t3 $t2 1
mul $t4 $t3 $t1 # d* (n-1)
mul $t6 $t0 2
add $t6 $t6 $t4
li $t2 3
mul $t6 $t6 $t2
sw $t6 sap
lw $a0 nap
lw $a1 sap
syscall
.data
a: .word 1
d: .word 10
n1: .word 8
n2: .word 6
nap: .word 0
sap: .word 0
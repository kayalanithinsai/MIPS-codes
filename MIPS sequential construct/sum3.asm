.text
main:
li $t0 10
li $t1 20
ori $t2, $t0, 0
ori $t0, $t1, 0
ori $t1, $t2, 0
#Exit
li $v0,10
syscall

.data
A: .word 0:50
.text
main:
la $t0, A
li $t1 50
li $t2 0
loop:
    beq $t2 $t1 exit
    mul $t4 $t2 4
    add $t4 $t4 $t0 
    lw $t3 ($t4)
    mul $t3 $t2 2
    addi $t3 $t3 54
    addi $t2 $t2 1
    j loop

exit:
    li $v0 10
    syscall


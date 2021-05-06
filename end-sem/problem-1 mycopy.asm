.data
A: .word 0:50
.text
main:
la $t0, A
li $t1, 50
li $t2, 0
loop:
    beq $t2, $t1, exit
    lw $t9 ,($t0)
    mul $t9, $t2, 2
    addi $t9, $t9, 54
    sw $t9 ($t0)
    addi $t0, $t0, 4 
    addi $t2 $t2 1
    j loop
exit:
    li $v0 10
    syscall


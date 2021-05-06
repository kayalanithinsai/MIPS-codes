.data

.text
main:

    li $a0 12
    li $a1 34
    jal add_func

    move $a0 $v0
    li $a1 67 
    jal add_func

    move $a0 $v0 
    li $a1 12
    jal add_func

    move $a0 $v0
    li $v0 1
    syscall

    li $v0 10
    syscall

add_func:
    move $t9 $a0 
    move $t8 $a1
    add $t7 $t8 $t9
    move $v0 $t7 

    jr $ra
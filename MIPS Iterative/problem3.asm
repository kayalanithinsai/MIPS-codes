.data
jval: .asciiz " is the value of J.\n"
aval: .asciiz " is the value of a.\n"
.text
    main:

    li $t0 1 # variable J
    li $t1 0 # variable a
    li $t7 20
    li $t6 100
    li $t5 0
    while1:

        bgt $t1 $t7 dowhile
        addi $t0 $t0 1
        addi $t1 $t1 2
        j while1
    
    dowhile:
        addi $t0 $t0 1
        bge $t0 $t6 while2
        j dowhile
    
    while2:
        ble $t1 $t5 EXIT
        addi $t0 $t0 -1
        addi $t1 $t1 -1
        j while2
    EXIT:
        move $a0 $t0
        li $v0 1
        syscall

        li $v0 4
        la $a0 jval
        syscall

        move $a0 $t1
        li $v0 1
        syscall

        li $v0 4
        la $a0 aval
        syscall

        li $v0 10
        syscall

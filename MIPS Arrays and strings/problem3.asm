.data
prompt: .asciiz "Enter The String: "
str: .space 100
.text
    main:

    li $v0 4 # prompting.
    la $a0 prompt
    syscall

    li $v0 8 # input to s.
    la $a0 str
    li $a1 99
    syscall

    la $t1 str
    li $t4 0 # zero register.
    li $t6 97 # left bound
    li $t7 122 # right bound
    li $t5 0 # index.
    add $t2 $t1 $t5
    addi $t5 $t5 1
    lbu $t3 ($t2)
    loop:
        beq $t3 $t4 EXIT
        
        # li $v0 11
        # move $a0 $t3
        # syscall

        blt $t3 $t6 further
        bgt $t3 $t7 further

        addi $t3 $t3 -32
        sb $t3 ($t2)

        further:
            add $t2 $t1 $t5
            addi $t5 $t5 1
            lbu $t3 ($t2)
            j loop
    EXIT:

        li $v0 4
        la $a0 str
        syscall

        li $v0 10
        syscall
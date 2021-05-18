.data
list: .space 100
common: .asciiz " number of fibonacci series is stored at memory location "
endl: .asciiz "\n"
fibon: .asciiz "fibonacci series: "
comma: .asciiz ","
message: .asciiz "Enter Value od N: "
.text
    main:
    # initialise list[0] = 0, list[1] = 1
    
    li $v0 4
    la $a0 message
    syscall

    li $v0 5
    syscall
    move $t3 $v0

    la $t0 list # $t0 indicates base address, $t1 indicates write value, $t2 indicates write/read address, $t3 to store n, $t4 to store i value
    li $t7 4 # to skip 4 bytes.

    li $t1 0
    addi $t2 $t0 0
    sw $t1 ($t2)
    
    li $t1 1
    addi $t2 $t0 4
    sw $t1 ($t2)
    
    li $t4 2 
    # i is indicated by $t4
    for1:
        bgt $t4 $t3 FUNNC
        # get i-2 address to t2.
        addi $t5 $t4 -2
        mul $t2 $t5 $t7 # t2 = (i-2) * 4.
        add $t2 $t2 $t0
        lw $t1 ($t2)
        # get i-1 address to t2.
        addi $t5 $t4 -1
        mul $t2 $t5 $t7 # t2 = (i-1) * 4.
        add $t2 $t2 $t0
        lw $t6 ($t2)
        # add $t6 and $t1
        add $t1 $t1 $t6
        # store $t1 to i * 4 
        addi $t5 $t4 0
        mul $t2 $t5 $t7 # t2 = (i) * 4.
        add $t2 $t2 $t0
        sw $t1 ($t2)

        addi $t4 $t4 1
        j for1

    FUNNC:
        li $t4 0
        for2:
            bge $t4 $t3 FUNNC2

            addi $t5 $t4 1

            li $v0 1
            move $a0 $t5
            syscall

            li $v0 4
            la $a0 common
            syscall

            mul $t2 $t4 $t7 # t2 = (i) * 4.
            add $t2 $t2 $t0

            li $v0 1
            move $a0 $t2
            syscall

            li $v0 4
            la $a0 endl
            syscall

            addi $t4 $t4 1
            j for2

    FUNNC2:
        li $t4 0
        addi $t5 $t3 -1
        for3:
            bge $t4 $t5 EXIT

            mul $t2 $t4 $t7 # t2 = (i) * 4.
            add $t2 $t2 $t0
            lw $t1 ($t2)

            li $v0 1
            move $a0 $t1
            syscall

            li $v0 4
            la $a0 comma
            syscall

            addi $t4 $t4 1
            j for3
    EXIT:
        move $t4 $t5
        mul $t2 $t4 $t7 # t2 = (i) * 4.
        add $t2 $t2 $t0
        lw $t1 ($t2)

        li $v0 1
        move $a0 $t1
        syscall

        li $v0 4
        la $a0 endl
        syscall

        li $v0 10
        syscall


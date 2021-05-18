.data
promptinit: .asciiz "Before Bubble Sort: "
promp: .asciiz "Enter The 10 numbers: "
array: .word 0:10
spc: .asciiz ", "
endl: .asciiz "\n"
iter: .asciiz "Iteration "
semicol: .asciiz ": "
finalprompt: .asciiz "After Bubble Sort: "

.text
    main:
    
    li $v0 4
    la $a0 promp
    syscall

    # $t0 -> i
    # $t1 -> j
    # $t2 -> array base address
    # $t3 -> to load integer
    # $t5 -> to load second integer.
    # $t4 -> 4
    # $t6 ->n-i-1
    # $t7 for 9
    # $t8 for 10
    # $t9 for temp and address access

    li $t8 10 # var n
    li $t7 9
    li $t4 4
    la $t2 array

    li $t0 0
    loop1:
        beq $t0 $t8 ck1
        
        mul $t9 $t0 $t4 
        add $t9 $t9 $t2 

        li $v0 5
        syscall
        move $t3 $v0 

        sw $t3 ($t9)

        addi $t0 $t0 1
        j loop1
    
    ck1:
    li $v0 4
    la $a0 promptinit
    syscall

    li $t0 0
    loop2:
        beq $t0 $t7 ck2
        
        mul $t9 $t0 $t4 
        add $t9 $t9 $t2 

        lw $t3 ($t9)

        li $v0 1
        move $a0 $t3 
        syscall

        li $v0 4
        la $a0 spc 
        syscall

        addi $t0 $t0 1
        j loop2

    ck2:
        mul $t9 $t0 $t4 
        add $t9 $t9 $t2 

        lw $t3 ($t9)

        li $v0 1
        move $a0 $t3 
        syscall

        li $v0 4
        la $a0 endl 
        syscall

        li $t0 0
        loop3:
            beq $t0 $t7 loop3further
            li $t1 0
            sub $t6 $t7 $t0 
            loop4:
            beq $t1 $t6 loop4further 
                # read array[j]
                mul $t9 $t4 $t1 
                add $t9 $t9 $t2 
                lw $t3 ($t9)
                # read array[j+1]
                addi $t9 $t1 1
                mul $t9 $t4 $t9
                add $t9 $t9 $t2 
                lw $t5 ($t9)
                # if array[j] <= array[j+1] then skip the swap.
                ble $t3 $t5 skipswap
                move $t9 $t3
                move $t3 $t5 
                move $t5 $t9 

                mul $t9 $t4 $t1 
                add $t9 $t9 $t2 
                sw $t3 ($t9)

                addi $t9 $t1 1
                mul $t9 $t4 $t9
                add $t9 $t9 $t2 
                sw $t5 ($t9)

                # swap and store to array[j] and array[j+1]
                skipswap:
                addi $t1 $t1 1
                j loop4

            loop4further:
                addi $t0 $t0 1
                # print the array after iteration.
                li $v0 4
                la $a0 iter 
                syscall

                li $v0 1
                move $a0 $t0 
                syscall

                li $v0 4
                la $a0 semicol
                syscall

                li $t5 0
                loop5:
                    beq $t5 $t7 ck3
                    mul $t9 $t5 $t4 
                    add $t9 $t9 $t2 

                    lw $t3 ($t9)

                    li $v0 1
                    move $a0 $t3 
                    syscall

                    li $v0 4
                    la $a0 spc 
                    syscall

                    addi $t5 $t5 1
                    j loop5

                ck3:
                    mul $t9 $t0 $t4 
                    add $t9 $t9 $t2 

                    lw $t3 ($t9)

                    li $v0 1
                    move $a0 $t3 
                    syscall

                    li $v0 4
                    la $a0 endl 
                    syscall
                    j loop3
        loop3further:

            li $v0 4
            la $a0 finalprompt
            syscall

            li $t5 0
                loop6:
                    beq $t5 $t7 ck4
                    mul $t9 $t5 $t4 
                    add $t9 $t9 $t2 

                    lw $t3 ($t9)

                    li $v0 1
                    move $a0 $t3 
                    syscall

                    li $v0 4
                    la $a0 spc 
                    syscall

                    addi $t5 $t5 1
                    j loop6

                ck4:
                    mul $t9 $t0 $t4 
                    add $t9 $t9 $t2 

                    lw $t3 ($t9)

                    li $v0 1
                    move $a0 $t3 
                    syscall

                    li $v0 4
                    la $a0 endl 

                    li $v0 10
                    syscall

            # print final array and exit
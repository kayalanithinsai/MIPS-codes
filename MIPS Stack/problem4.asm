.data
inp: .asciiz "Enter n: "
out0: .asciiz " element in fibonacci series is "
out1: .asciiz " element in fibonacci series cannot be genreated, Overflow condition incurs in this case. "


.text
main:
    # input for number:- 
    li $v0 4
    la $a0 inp
    syscall

    # read to $s0.
    li $v0 5
    syscall
    move $s0 $v0

    # writing to Stack top.
    sw $s0 -4($sp)
    addi $sp $sp -4

    # function call to fibonacci
    jal fibonacci

    lw $t1 0($sp)
    addi $sp $sp 4
    lw $t0 0($sp)
    addi $sp $sp 4

    li $v0 1
    move $a0 $s0
    syscall

    bne $t0 -1 normal
    li $v0 4
    la $a0 out1
    syscall
    j exit
    
    normal:
    li $v0 4
    la $a0 out0
    syscall

    beq $t0 0 continue32
    li $v0 1
    move $a0 $t0
    syscall

    move $t2 $t1
    li $t3 0
    li $t4 10
    loopl:
        div $t2 $t4
        mflo $t2

        addi $t3 $t3 1
        beq $t2 $0 endloopl
        j loopl
    endloopl:

    addi $t3 $t3 -9
    li $t4 -1
    mul $t3 $t3 $t4

    loopp:
        beq $t3 $0 endloopp

        addi $t3 $t3 -1
        j loopp
    endloopp:
        continue32:
            li $v0 1
            move $a0 $t1
            syscall

        # exit code
        exit:
            li $v0 10
            syscall
    
    # fibonacci function
    fibonacci:
        # $t0 contains n

        lw $t0 0($sp)
        addi $sp $sp 4

        # if $t0 > 60 goto overflow. 
        bgt $t0 60 overflow

        li $t1 0
        li $t3 0
        li $t2 0
        li $t4 1
        li $t5 3
        li $t6 1000000000
        loop:
        bgt $t5 $t0 endloop

        add $t1 $t1 $t3
        add $t2 $t2 $t4

        blt $t2 $t6 continue
        sub $t2 $t2 $t6
        addi $t1 $t1 1
        continue:

        move $t7 $t1
        move $t1 $t3
        move $t3 $t7

        move $t7 $t2
        move $t2 $t4
        move $t4 $t7

        addi $t5 $t5 1
        j loop
        endloop:

        bgt $t0 1 continue2
        li $t4 0
        continue2:

        sw $t3 -4($sp)
        addi $sp $sp -4
        sw $t4 -4($sp)
        addi $sp $sp -4
        j endoverflow

        overflow:
        li $t1 -1
        sw $t1 -4($sp)
        addi $sp $sp -4
        sw $t2 -4($sp)
        addi $sp $sp -4
        endoverflow:
        jr $ra


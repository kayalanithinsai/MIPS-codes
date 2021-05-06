.data
promptint: .asciiz "Enter Thee ["
promptend: .asciiz "] element: "
coma: .asciiz ","
result: .asciiz "The determinant is :"
matrix: .word 0:9

.text
main:
    # $t0 used as variable i
    # $t9 used fr temp varable
    # $t2 used for base address

    la $t2 matrix
    input_loop:
    beq $t0 9 Input_complete
    # $t0/3 = i, $t0%3 = j
        
        li $v0 4
        la $a0 promptint
        syscall

        li $t1 3
        div $t0 $t1 
        
        li $v0 1
        mflo $a0 
        addi $a0 $a0 1
        syscall

        li $v0 4
        la $a0 coma
        syscall

        li $v0 1
        mfhi $a0
        addi $a0 $a0 1
        syscall

        li $v0 4
        la $a0 promptend
        syscall

        li $v0 5
        syscall
        move $t1 $v0

        mul $t9 $t0 4
        add $t9 $t9 $t2 

        sw $t1 ($t9)

        addi $t0 $t0 1
        j input_loop

    Input_complete:
        # a0 a1 a2
        # a3 a4 a5
        # a6 a7 a8
        # det = a0 *(a4 * a8 - a7 * a5) + a1( a5 * a6 - a3* a8) + a2(a3 * a7 - a6*a4)
        # temp $t8 --> (each term)
        # temp2 $t7
        # $t3 to read element
        # $t1 stores det.

        la $t2 matrix
        li $t1 0
        li $t8 0
        li $t7 1

        li $t0 4
        mul $t9 $t0 4
        add $t9 $t9 $t2 
        lw $t3 ($t9)

        mul $t7 $t7 $t3 
        
        li $t0 8
        mul $t9 $t0 4
        add $t9 $t9 $t2 
        lw $t3 ($t9)

        mul $t7 $t7 $t3 
        add $t8 $t8 $t7 
        li $t7 1

        li $t0 7
        mul $t9 $t0 4
        add $t9 $t9 $t2 
        lw $t3 ($t9)

        mul $t7 $t7 $t3 
        
        li $t0 5
        mul $t9 $t0 4
        add $t9 $t9 $t2 
        lw $t3 ($t9)

        mul $t7 $t7 $t3 
        sub $t8 $t8 $t7 
        li $t7 1

        li $t0 0
        mul $t9 $t0 4
        add $t9 $t9 $t2 
        lw $t3 ($t9)
        mul $t8 $t8 $t3
        add $t1 $t1 $t8 

        li $t0 5
        mul $t9 $t0 4
        add $t9 $t9 $t2 
        lw $t3 ($t9)
        li $t7 1
        mul $t7 $t7 $t3

        li $t0 6
        mul $t9 $t0 4
        add $t9 $t9 $t2 
        lw $t3 ($t9)
        mul $t7 $t7 $t3 

        li $t8 0
        add $t8 $t8 $t7 
        li $t7 1

        li $t0 3
        mul $t9 $t0 4
        add $t9 $t9 $t2 
        lw $t3 ($t9)
        mul $t7 $t7 $t3 

        li $t0 8
        mul $t9 $t0 4
        add $t9 $t9 $t2 
        lw $t3 ($t9)
        mul $t7 $t7 $t3 

        sub $t8 $t8 $t7 
        li $t0 1
        mul $t9 $t0 4
        add $t9 $t9 $t2 
        lw $t3 ($t9)
        mul $t8 $t8 $t3 
        add $t1 $t1 $t8 

        li $t8 0
        li $t7 1

        li $t0 3
        mul $t9 $t0 4
        add $t9 $t9 $t2 
        lw $t3 ($t9)
        mul $t7 $t7 $t3 

        li $t0 7
        mul $t9 $t0 4
        add $t9 $t9 $t2 
        lw $t3 ($t9)
        mul $t7 $t7 $t3 

        add $t8 $t8 $t7 

        li $t7 1
        li $t0 6
        mul $t9 $t0 4
        add $t9 $t9 $t2 
        lw $t3 ($t9)
        mul $t7 $t7 $t3 

        li $t0 4
        mul $t9 $t0 4
        add $t9 $t9 $t2 
        lw $t3 ($t9)
        mul $t7 $t7 $t3 

        sub $t8 $t8 $t7 
        li $t0 2
        mul $t9 $t0 4
        add $t9 $t9 $t2 
        lw $t3 ($t9)
        mul $t8 $t8 $t3 

        add $t1 $t1 $t8 

        li $v0 4
        la $a0 result
        syscall

        li $v0 1
        move $a0 $t1 
        syscall

        li $v0 10
        syscall

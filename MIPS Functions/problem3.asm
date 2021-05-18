.data
prompt_n: .asciiz "Input Value of n: "
prompt_r: .asciiz "Input Value of r: "
fact_prompt: .asciiz "The factorial is: "
npr_promt: .asciiz "The npr value is: "
ncr_prompt: .asciiz "The ncr value is: "
endl: .asciiz "\n"
.text
    main:
        # $t0 represents n
        # $t1 represents r
        # $t2 represents result form function
        li $v0 4
        la $a0 prompt_n
        syscall
        li $v0 5
        syscall
        move $t0 $v0
        li $v0 4
        la $a0 prompt_r
        syscall
        li $v0 5
        syscall
        move $t1 $v0 

        li $v0 4
        la $a0 fact_prompt
        syscall
        move $a0 $t0 
        jal Fact 
        move $t2 $v0 
        li $v0 1
        move $a0 $t2 
        syscall
        li $v0 4
        la $a0 endl
        syscall

        li $v0 4
        la $a0 npr_promt
        syscall
        move $a0 $t0
        move $a1 $t1 
        jal npr_Fact
        move $t2 $v0 
        li $v0 1
        move $a0 $t2 
        syscall
        li $v0 4
        la $a0 endl
        syscall

        li $v0 4
        la $a0 ncr_prompt
        syscall
        move $a0 $t0
        move $a1 $t1
        jal ncr_Fact
        move $t2 $v0 
        li $v0 1
        move $a0 $t2 
        syscall
        li $v0 4
        la $a0 endl
        syscall

        li $v0 10
        syscall

    Fact:
        # $t3 represents i
        # $t4 represents 0
        # result to $t5
        move $t3 $a0 
        li $t5 1
        li $t4 0
        loop_fact:
            beq $t3 $t4 Further_loop_fact
            mul $t5 $t5 $t3 
            addi $t3 $t3 -1
            j loop_fact
        Further_loop_fact:
            move $v0 $t5 
            jr $ra
    npr_Fact:
        # $t6 for n
        # $t7 for r
        # $t2 result for factorial
        # $t8 for final result.
        # $t9 -> return ra
        move $t9 $ra
        move $t6 $a0 
        move $t7 $a1
        sub $t7 $t6 $t7 

        jal Fact
        move $t8 $v0 

        move $a0 $t7 
        jal Fact
        move $t2 $v0 

        div $t8 $t8 $t2 
        move $v0 $t8 
        move $ra $t9 
        jr $ra 
    ncr_Fact:
        # $t6 -> n
        # $t7 -> r
        # $t8 -> final res
        # $t2 -> return res
        move $t9 $ra 
        move $t6 $a0
        move $t7 $a1 

        jal Fact
        move $t8 $v0 

        move $a0 $a1 
        jal Fact
        move $t2 $v0 
        div $t8 $t8 $t2 

        sub $t7 $t6 $t7 
        move $a0 $t7 
        jal Fact
        move $t2 $v0 
        div $t8 $t8 $t2

        move $v0 $t8 
        move $ra $t9 
        jr $ra 

        
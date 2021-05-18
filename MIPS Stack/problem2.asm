.data
    input_string: .space 100
    promt: .asciiz "Enter the airthmetic expression: "
    endl: .asciiz "\n"
    opening_prompt: .asciiz "Number of opening braces: "
    closing_prompt: .asciiz "Number of closeing braces: "
    correct_exp: .asciiz "The airthmetic expression is correct in terms of number of opening and closing paranthesis.\n"
    incorr_exp: .asciiz "The airthmetic expression is incorrect in terms of number of opening and closing paranthesis.\n"
.text
main:
    # $t0 for index i
    # $t3 to read current char
    # $t2 for base address
    # $t1 for score
    # $t4 for no.of opening baraces.
    # $t5 fr flg

    li $v0 4
    la $a0 promt
    syscall

    li $v0 8
    la $a0 input_string
    li $a1 99
    syscall
    
    li $t0 0
    la $t2 input_string

    li $t5 0
    add $t9 $t2 $t0
    lb $t3 ($t9) 
    addi $t0 $t0 1 
    string_loop:
        beq $t3 0 loop_further
        beq $t3 10 loop_further

        # if $t3 is '(' add 1 to both $t1 and $t4
        bne $t3 40 no_update_open
        addi $t1 $t1 1
        addi $t4 $t4 1
        # if $t3 is ')' sub 1 from $t1. and check if $t1 >= 0
        no_update_open:
        bne $t3 41 no_update_close
        addi $t1 $t1 -1
        # after if and else.
        no_update_close:
        bge $t1 0 no_flg_update 
        li $t5 1
        no_flg_update:
            add $t9 $t2 $t0
            lb $t3 ($t9) 
            addi $t0 $t0 1 
            j string_loop
    loop_further:
        beq $t5 1 print_no
        bgt $t1 0 print_no

        print_yes:
            li $v0 4
            la $a0  correct_exp
            syscall

            li $v0 4
            la $a0 opening_prompt
            syscall

            li $v0 1
            move $a0 $t4 
            syscall

            li $v0 4
            la $a0 endl
            syscall

            li $v0 4
            la $a0 closing_prompt
            syscall

            sub $t1 $t1 $t4 
            li $t9 -1
            mul $t1 $t1 $t9 

            li $v0 1
            move $a0 $t1 
            syscall

            li $v0 4
            la $a0 endl
            syscall

            li $v0 10
            syscall
        print_no:
            li $v0 4
            la $a0  incorr_exp
            syscall

            li $v0 4
            la $a0 opening_prompt
            syscall

            li $v0 1
            move $a0 $t4 
            syscall

            li $v0 4
            la $a0 endl
            syscall

            li $v0 4
            la $a0 closing_prompt
            syscall

            sub $t1 $t1 $t4 
            li $t9 -1
            mul $t1 $t1 $t9 

            li $v0 1
            move $a0 $t1 
            syscall

            li $v0 4
            la $a0 endl
            syscall

            li $v0 10
            syscall

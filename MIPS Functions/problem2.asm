.data
first: .space 10
second: .space 10
concat: .space 20
endl: .asciiz "\n"
len1: .asciiz "Length of first String: "
len2: .asciiz "Length of second String: "
promt1: .asciiz "Input first String: "
promt2: .asciiz "Input second Stirng: "
preinput: .asciiz "Input Charecter is "
not_string: .asciiz "not "
postinput1: .asciiz "present in the first string"
postinput2: .asciiz "present in the second string"
prompt_char: .asciiz "Enter the charecter for search: "
first_concat: .asciiz "First concatenated string: "
second_concat: .asciiz "Second concatenated string: "
.text
    main:
        
        li $v0 4
        la $a0 promt1
        syscall
        li $v0 8
        la $a0 first
        li $a1 10
        syscall
        li $v0 4
        la $a0 promt2
        syscall
        li $v0 8
        la $a0 second
        li $a1 10
        syscall

        li $v0 4
        la $a0 prompt_char
        syscall

        # input comparing char from first string -> t9
        li $v0 12
        syscall
        move $t9 $v0 
        li $v0 4
        la $a0 endl
        syscall

        # call for string 1 for len
        li $v0 4
        la $a0 len1
        syscall
        la $a0 first 
        jal Func1
        move $a0 $v0
        li $v0 1
        syscall
        li $v0 4
        la $a0 endl
        syscall

        # call fr string 2 for len
        li $v0 4
        la $a0 len2
        syscall
        la $a0 second
        jal Func1
        move $a0 $v0 
        li $v0 1
        syscall
        li $v0 4
        la $a0 endl
        syscall
        

        li $v0 4
        la $a0 preinput
        syscall
        la $a0 first
        move $a1 $t9
        jal Func2
        li $v0 4
        la $a0 postinput1
        syscall
        li $v0 4
        la $a0 endl
        syscall

        # input char comparing from second string
        li $v0 4
        la $a0 preinput
        syscall
        la $a0 second
        move $a1 $t9
        jal Func2
        li $v0 4
        la $a0 postinput2
        syscall
        li $v0 4
        la $a0 endl
        syscall

        li $v0 4
        la $a0 first_concat
        syscall
        la $a0 first
        la $a1 second
        jal Func3
        li $v0 4
        la $a0 concat
        syscall 
        li $v0 4
        la $a0 endl
        syscall

        li $v0 4
        la $a0 second_concat
        syscall
        la $a1 first
        la $a0 second
        jal Func3
        li $v0 4
        la $a0 concat
        syscall 
        li $v0 4
        la $a0 endl
        syscall

        li $v0 10
        syscall

    Func1:
        # base address $t0
        # index i $t1
        # temp pointer $t2
        # counter regiter $t3
        # zero register $t4
        # load charecter to $t5
        li $t1 0
        li $t3 0
        li $t4 0
        move $t0 $a0 
        lb $t5 ($t0)
        lenloop:
            beq $t5 $t4 furtherlen
            addi $t3 $t3 1
            addi $t1 $t1 1
            add $t2 $t0 $t1 
            lb $t5 ($t2)
            j lenloop
        furtherlen:
            addi $t3 $t3 -1
            move $v0 $t3
            jr $ra

    Func2:
        # base address $t0
        # int i $t1
        # address pointer $t2
        # load charecter to $t5
        # zero register $t4
        move $t0 $a0
        move $t3 $a1  
        li $t1 0
        lb $t5 ($t0)
        loopcheck:
            beq $t5 $t4 further_check_exit
            beq $t5 $t3 further_check_print
            addi $t1 $t1 1
            add $t2 $t0 $t1 
            lb $t5 ($t2)
            j loopcheck
        further_check_print:
            jr $ra 
        further_check_exit:
            li $v0 4
            la $a0 not_string
            syscall
            jr $ra 
    Func3:
        # $t0 base address of first/second string
        # $t2 point address of concat string
        # $t5 read char from array
        # $t4 0
        
        move $t0 $a0
        la $t2 concat
        li $t4 0
        li $t7 10
        lb $t5 ($t0) 
        loop1:
            beq $t5 $t4 further_loop1
            beq $t5 $t7 further_loop1
            sb $t5 ($t2)
            addi $t2 $t2 1
            addi $t0 $t0 1
            lb $t5 ($t0)
            j loop1
        further_loop1:
            move $t0 $a1 
            lb $t5 ($t0)
            loop2:
                beq $t5 $t4 further_loop2
                beq $t5 $t7 further_loop2
                sb $t5 ($t2)
                addi $t2 $t2 1
                addi $t0 $t0 1
                lb $t5 ($t0)
                j loop2 
        further_loop2:
            jr $ra 

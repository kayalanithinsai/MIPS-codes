.data
sentence: .space 100
prompt: .asciiz "Enter the input string: "
responsive: .asciiz "The sentence after vovels removal: "
.text
main:
    # input the string form user.
    li $v0 4
    la $a0 prompt
    syscall

    li $v0 8
    la $a0 sentence
    li $a1 100
    syscall

    # find the length of the string
    # $t0 for base address
    # $t1/$t3 to read char.
    # $t2 represents size of string
    # $t4 represents size of stack.

    la $t0 sentence
    li $t2 0
    loop1:
        lbu $t1 0($t0)
        beq $t1 '\n' endloop1
        beq $t1 $0 endloop1
        addi $t0 $t0 1
        addi $t2 $t2 1
        j loop1

    endloop1:

        # loop back from n-1 to 0
        la $t0 sentence
        addi $t2 $t2 -1
        li $t4 0
        loop2:
            beq $t2 -1 endloop2
            # read sentence[$t2] to $t3.
            add $t9 $t2 $t0 
            lbu $t3 0($t9)

            # if $t3 is 'a'
            beq $t3 'a' skip_stack
            # if $t3 is 'e'
            beq $t3 'e' skip_stack
            # if $t3 is 'i'
            beq $t3 'i' skip_stack
            # if $t3 is 'o'
            beq $t3 'o' skip_stack
            # if $t3 is 'u'
            beq $t3 'u' skip_stack
            
            # append to stack.
            addi $sp $sp -1
            sb $t3 ($sp) 
            addi $t4 $t4 1

            skip_stack:
                addi $t2 $t2 -1
                j loop2 

    endloop2:
        li $t2 0

        li $v0 4
        la $a0 responsive
        syscall

        loop3:

            beq $t2 $t4 exit
            lbu $t3 ($sp)
            addi $sp $sp 1
            move $a0 $t3 
            li $v0 11
            syscall

            addi $t2 $t2 1
            j loop3

    exit:
        li $v0 10
        syscall

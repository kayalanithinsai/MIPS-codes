.data

    message: .asciiz "Enter Number :"
    endl: .asciiz "\n"

.text
    main:

        li $v0 4
        la $a0 message
        syscall

        li $v0 5
        syscall
        move $t0 $v0

        li $t1 0

        while:
            beq $t0 $t1 EXIT
            li $v0 1
            move $a0 $t0
            syscall

            li $v0 4
            la $a0 endl
            syscall

            sub $t0 $t0 1
            j while
        
        EXIT:
            li $v0 10
            syscall
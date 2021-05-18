.data
prompt: .asciiz "Enter 2 numbers: "
before: .asciiz "before swap: "
after: .asciiz "after swap: "
zeroerror: .asciiz "Zero cannot be one of the number.\n"
comma: .asciiz ", "
endl: .asciiz "\n"

.text
    main:
        li $v0 4
        la $a0 prompt
        syscall

        li $v0 5
        syscall
        move $t2 $v0

        li $v0 5
        syscall
        move $t3 $v0

        move $t0 $t2
        move $t1 $t3 
        # Func1
        jal Func1
        
        move $t0 $t2
        move $t1 $t3 
        # Func2
        jal Func2
        
        move $t0 $t2
        move $t1 $t3 
        # Func3
        jal Func3

        move $t0 $t2
        move $t1 $t3 
        # Func4
        jal Func4

        li $v0 10
        syscall

    Func1:
        move $t2 $t0
        move $t0 $t1
        move $t1 $t2

        li $v0 4
        la $a0 after
        syscall
        li $v0 1
        move $a0 $t0 
        syscall
        li $v0 4
        la $a0 comma
        syscall
        li $v0 1
        move $a0 $t1 
        syscall
        li $v0 4
        la $a0 endl
        syscall

        jr $ra
    Func2:
        xor $t0 $t0 $t1 
        xor $t1 $t0 $t1 
        xor $t0 $t0 $t1 

        li $v0 4
        la $a0 after
        syscall
        li $v0 1
        move $a0 $t0 
        syscall
        li $v0 4
        la $a0 comma
        syscall
        li $v0 1
        move $a0 $t1 
        syscall
        li $v0 4
        la $a0 endl
        syscall

        jr $ra
    Func3:
        mul $t0 $t0 $t1
        li $t6 0
        beq $t0 $t6 spec
        beq $t1 $t6 spec
        div $t1 $t0 $t1 
        div $t0 $t0 $t1 

        li $v0 4
        la $a0 after
        syscall
        li $v0 1
        move $a0 $t0 
        syscall
        li $v0 4
        la $a0 comma
        syscall
        li $v0 1
        move $a0 $t1 
        syscall
        li $v0 4
        la $a0 endl
        syscall

        jr $ra
        spec:
            li $v0 4
            la $a0 zeroerror
            syscall
            jr $ra 
    Func4:
        add $t0 $t0 $t1 
        sub $t1 $t0 $t1 
        sub $t0 $t0 $t1

        li $v0 4
        la $a0 after
        syscall
        li $v0 1
        move $a0 $t0 
        syscall
        li $v0 4
        la $a0 comma
        syscall
        li $v0 1
        move $a0 $t1 
        syscall
        li $v0 4
        la $a0 endl
        syscall

        jr $ra 
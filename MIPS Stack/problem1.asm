.data
    spc: .asciiz ", "
    endl: .asciiz "\n"
    prompt: .asciiz "Enter the 10 Input numbers: "
    rev_prompt: .asciiz "Reverse String: "
    array: .word 0:10
.text
main:
    li $t4 4
    li $t0 0
    li $t8 10
    la $t2 array
    # $t0 index i
    # $t2 base address.
    # $t4 4
    # $t8 10 
    input_loop:
        beq $t0 $t8 ck1
        li $v0 4
        la $a0 prompt
        syscall
        li $v0 5
        syscall
        move $t3 $v0 

        mul $t9 $t0 $t4 
        add $t9 $t9 $t2 
        sw $t3 ($t9) 

        addi $sp $sp -4
        sw $t3 4($sp) 

        addi $t0 $t0 1
        j input_loop
    ck1:
        li $v0 4
        la $a0 rev_prompt
        syscall
        li $t0 0
        retreive_loop:
            beq $t0 9 ck2 

            addi $sp $sp 4
            lw $t3 ($sp)
            

            move $a0 $t3 
            li $v0 1
            syscall

            li $v0 4
            la $a0 spc
            syscall

            addi $t0 $t0 1

            j retreive_loop
    ck2:
        addi $sp $sp 4
        lw $t3 ($sp)
        
        move $a0 $t3 
        li $v0 1
        syscall

        li $v0 4
        la $a0 endl
        syscall

        li $v0 10
        syscall





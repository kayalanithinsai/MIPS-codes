.data
A: .double 1.1, 2.1, 3.1
   .double 1.1, 2.1, 3.1
   .double 1.1, 2.1, 3.1

B: .double 1.1, 0.0, 1.1
   .double 2.1, 0.0, 2.1
   .double 3.1, 0.0, 3.1

C: .double 0.0, 0.0, 0.0
   .double 0.0, 0.0, 0.0
   .double 0.0, 0.0, 0.0

endl: .asciiz "\n"
spc: .asciiz " "
promptA: .asciiz "Enter Input Values of Matrix A: "
promptB: .asciiz "Enter Input Values of Matrix B: "
.text
    main:
    li $t0 0 # var i
    li $t1 0 # var j
    li $t2 0 # var k
    li.d $f4 0.0
    li $t4 8 # skip value.
    la $t5 A
    la $t6 B
    la $t7 C
    li $t8 3
    # adress reading be $t9 and temp.
    # $f1 A[i][k]
    # $f2 B[k][j]
    # multiply to $f2 = $f2 * $f1
    # add $f2 to $f3.
    # for(int i=0;i<9;i++) cin>>A[i];
    # for(int i=0;i<9;i++) cin>>B[i]; 
    li $t0 0
    li $t1 9
    la $t9 A 
    li $v0 4
    la $a0 promptA
    syscall
    Aloop:
        beq $t0 $t1 Bread
        li $v0 7
        syscall

        s.d $f0 ($t9)
        add $t9 $t9 $t4 
        addi $t0 $t0 1
        j Aloop
    Bread:
        li $t0 0
        la $t9 B
        li $v0 4
        la $a0 promptB
        syscall
        Bloop:
            beq $t0 $t1 settoloop1
            li $v0 7
            syscall

            s.d $f0 ($t9)
            add $t9 $t9 $t4 
            addi $t0 $t0 1
            j Bloop
    settoloop1:
        li $t0 0
        li $t1 1

    loop1:
        beq $t0 $t8 EXIT
        li $t1 0
        loop2:
            beq $t1 $t8 loop1further
            li $t2 0
            li.d $f4 0.0
            loop3:
            beq $t2 $t8 loop2further

            # readind A[i][k] -> A + (n * i + k) * 4
            mul $t9 $t0 $t8
            add $t9 $t9 $t2
            mul $t9 $t9 $t4 
            add $t9 $t9 $t5

            l.d $f0 ($t9)
            
            # readind B[k][j] -> B + (n * k + j) * 4
            mul $t9 $t2 $t8
            add $t9 $t9 $t1
            mul $t9 $t9 $t4 
            add $t9 $t9 $t6

            l.d $f2 ($t9)

            mul.d $f6 $f0 $f2 
            add.d $f4 $f4 $f6 

            addi $t2 $t2 1
            j loop3

        loop2further:
            # current c[i][j] calculation is complete. C + (n * i + j) * 4

            mul $t9 $t8 $t0 
            add $t9 $t9 $t1 
            mul $t9 $t9 $t4 
            add $t9 $t9 $t7 

            s.d $f4 ($t9)
            
            mov.d $f12 $f4
            li $v0 3
            syscall

            li $v0 4
            la $a0 spc
            syscall

            addi $t1 $t1 1
            j loop2
    loop1further:

        li $v0 4
        la $a0 endl
        syscall

        addi $t0 $t0 1
        j loop1

    EXIT:
    li $v0 10
    syscall
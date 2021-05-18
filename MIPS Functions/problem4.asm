.data
promp: .asciiz "Enter The Array numbers: "
array_orig: .word 0:10
array: .word 0:10
stack_array: .word 0:300
spc: .asciiz ", "
endl: .asciiz "\n"
debug: .asciiz "This is debug statement.\n"
b_b_s: .asciiz "Before Bubble Sort: "
a_b_s: .asciiz "After Bubble Sort: "
b_q_s: .asciiz "Before Quick Sort: "
a_q_s: .asciiz "After Quick Sort: "
b_s_s: .asciiz "Before Selection Sort: "
a_s_s: .asciiz "After Selection Sort: "
t_n_c: .asciiz "Total Number of Comparisions: "
t_n_s: .asciiz "Total Number of Swaps: "
b_t_c: .asciiz " is best in terms of comparision.\n"
b_t_s: .asciiz " is best in terms of swaps.\n"
b_s: .asciiz "Bubble Sort"
s_s: .asciiz "Selection Sort"
q_s: .asciiz "Quick Sort"
.text
    main:

    # $t0 -> i
    # $t1 -> j
    # $t2 -> array base address
    # $t3 -> to load integer
    # $t5 -> to load second integer.
    # $t4 -> 4
    # $t6 ->n-i-1/min_id/mid
    # $t7 for 9
    # $t8 for 10
    # $t9 for temp and address access

    li $t8 10 # var n
    li $t7 9
    li $t4 4
    la $t2 array_orig 

    li $t0 0
    input_loop1:
        beq $t0 $t8 input_ck1
        mul $t9 $t0 $t4 
        add $t9 $t9 $t2 
        li $v0 4
        la $a0 promp
        syscall
        li $v0 5
        syscall
        move $t3 $v0 
        sw $t3 ($t9)
        addi $t0 $t0 1
        j input_loop1
    input_ck1:
        jal copy_array
        jal Bubble_Sort

        la $s6 stack_array 
        jal copy_array
        jal quick_sort

        jal copy_array
        jal selection_sort


        # $s0,$s2,$s4
        jal comapre
        jal swaps_comapre

        li $v0 10
        syscall

    copy_array:
        la $t1 array
        la $t2 array_orig
        li $t0 0

        copy_loop:
            beq $t0 $t8 copy_further
            mul $t9 $t0 $t4 
            add $t9 $t9 $t2
            lw $t3 ($t9)
            mul $t9 $t0 $t4 
            add $t9 $t9 $t1
            sw $t3 ($t9)
            addi $t0 $t0 1
            j copy_loop
        copy_further:
            jr $ra

    print_array:
        move $t2 $a0 
        li $t0 0
        print_loop:
            beq $t0 $t7 print_futher
            mul $t9 $t0 $t4 
            add $t9 $t9 $t2 
            lw $t3 ($t9)
            li $v0 1
            move $a0 $t3
            syscall
            li $v0 4
            la $a0 spc
            syscall
            addi $t0 $t0 1
            j print_loop
        print_futher:
            mul $t9 $t4 $t0 
            add $t9 $t9 $t2 
            lw $t3 ($t9) 
            li $v0 1
            move $a0 $t3 
            syscall
            li $v0 4
            la $a0 endl
            syscall
            jr $ra 


    Bubble_Sort:
        li $v0 4
        la $a0 b_b_s
        syscall
        move $s7 $ra 
        la $a0 array
        jal print_array

        li $t0 0
        bubble_loop1:
            beq $t0 $t7 bubble_loop1_further
            li $t1 0
            sub $t6 $t7 $t0 
            bubble_loop2:
            beq $t1 $t6 bubble_loop2_further 
                # read array[j]
                mul $t9 $t4 $t1 
                add $t9 $t9 $t2 
                lw $t3 ($t9)
                # read array[j+1]
                addi $t9 $t1 1
                mul $t9 $t4 $t9
                add $t9 $t9 $t2 
                lw $t5 ($t9)
                # if array[j] <= array[j+1] then skip the swap.
                addi $s0 $s0 1
                ble $t3 $t5 bubble_skipswap
                addi $s1 $s1 1
                move $t9 $t3
                move $t3 $t5 
                move $t5 $t9 

                mul $t9 $t4 $t1 
                add $t9 $t9 $t2 
                sw $t3 ($t9)

                addi $t9 $t1 1
                mul $t9 $t4 $t9
                add $t9 $t9 $t2 
                sw $t5 ($t9)

                # swap and store to array[j] and array[j+1]
                bubble_skipswap:
                addi $t1 $t1 1
                j bubble_loop2

            bubble_loop2_further:
                addi $t0 $t0 1
                j bubble_loop1
                # print the array after iteration.
        bubble_loop1_further:
            li $v0 4
            la $a0 a_b_s 
            syscall

            la $a0 array
            jal print_array

            li $v0 4
            la $a0 t_n_c
            syscall
            li $v0 1
            move $a0 $s0 
            syscall
            li $v0 4
            la $a0 endl
            syscall

            li $v0 4
            la $a0 t_n_s 
            syscall 
            li $v0 1
            move $a0 $s1 
            syscall
            li $v0 4
            la $a0 endl 
            syscall
            
            move $ra $s7 
            jr $ra 
    selection_sort:
        li $v0 4
        la $a0 b_s_s 
        syscall
        move $s7 $ra
        la $a0 array 
        jal print_array

        li $t0 0
        la $t2 array
        selection_loop1:    
            beq $t0 $t7 selection_loop1_further 
            addi $t1 $t0 1
            move $t6 $t0 
            selection_loop2:
                beq $t1 $t8 selection_loop2_further
                # read array[j]
                mul $t9 $t1 $t4 
                add $t9 $t9 $t2 
                lw $t3 ($t9) 
                # read array[min_id]
                mul $t9 $t6 $t4 
                add $t9 $t9 $t2 
                lw $t5 ($t9) 
                addi $s2 $s2 1
                # compare array[j] and array[min_id]
                bge $t3 $t5 selection_skip_min_update
                move $t6 $t1 
                selection_skip_min_update:
                    addi $t1 $t1 1
                    j selection_loop2
            selection_loop2_further:
                addi $s3 $s3 1
                mul $t9 $t4 $t0 
                add $t9 $t9 $t2 
                lw $t3 ($t9) 

                mul $t9 $t4 $t6 
                add $t9 $t9 $t2 
                lw $t5 ($t9)

                move $t9 $t3 
                move $t3 $t5 
                move $t5 $t9 

                mul $t9 $t4 $t0 
                add $t9 $t9 $t2 
                sw $t3 ($t9)
                mul $t9 $t4 $t6 
                add $t9 $t9 $t2 
                sw $t5 ($t9) 

                addi $t0 $t0 1
                j selection_loop1
        selection_loop1_further:
            li $v0 4
            la $a0 a_s_s
            syscall

            la $a0 array 
            jal print_array

            li $v0 4
            la $a0 t_n_c
            syscall
            li $v0 1
            move $a0 $s2  
            syscall
            li $v0 4
            la $a0 endl
            syscall

            li $v0 4
            la $a0 t_n_s 
            syscall 
            li $v0 1
            move $a0 $s3 
            syscall
            li $v0 4
            la $a0 endl 
            syscall
            
            move $ra $s7 
            jr $ra            

    quick_sort:

        li $v0 4
        la $a0 b_q_s 
        syscall
        move $s7 $ra
        la $a0 array 
        jal print_array

        li $a0 0
        move $a1 $t7 
        jal quick 

        li $v0 4
        la $a0 a_q_s 
        syscall
        la $a0 array
        jal print_array

        li $v0 4
        la $a0 t_n_c
        syscall
        li $v0 1
        move $a0 $s4  
        syscall
        li $v0 4
        la $a0 endl
        syscall

        li $v0 4
        la $a0 t_n_s 
        syscall 
        li $v0 1
        move $a0 $s5
        syscall
        li $v0 4
        la $a0 endl 
        syscall        

        move $ra $s7 
        jr $ra 

    quick:
        # need low and high.
        bge $a0 $a1 quick_exit
        # add low, high, $ra to stack array.
        sw $a0 0($s6)
        sw $a1 4($s6)
        sw $ra 8($s6) 

        # call partition and get partition index.
        jal partition
        sw $v0 12($s6) 

        # quick sort low to pi-1
        
        lw $a1 12($s6)
        addi $a1 $a1 -1
        addi $s6 $s6 16
        jal quick
        addi $s6 $s6 -16
        # quick sort pi+1 to high
        
        lw $a0 12($s6)
        lw $a1 4($s6)
        addi $a0 $a0 1
        addi $s6 $s6 16
        jal quick
        addi $s6 $s6 -16
        # get back our $ra
        lw $ra 8($s6)
        quick_exit:
            jr $ra 


    partition:
        # arguments low, high.
        add $t6 $a0 $a1 
        li $t9 2
        div $t6 $t6 $t9 
        addi $v0 $a0 -1 
        
        move $t0 $a0
        la $t2 array 
        partition_loop:
            bgt $t0 $a1 partition_loop_further

            # load elements to $t3 -> a[i/$t0] and $t5 a[mid/$t6] 
            mul $t9 $t0 $t4 
            add $t9 $t9 $t2 
            lw $t3 ($t9)

            mul $t9 $t6 $t4 
            add $t9 $t9 $t2 
            lw $t5 ($t9) 
            addi $s4 $s4 1
            bge $t3 $t5 parittion_not_if1
            addi $v0 $v0 1
            blt $v0 $t6 parittion_not_if2
            move $t6 $t0 
            parittion_not_if2:
            # swap a[$v0] , a[i]
            # read a[$v0] to t3.
            addi $s5 $s5 1
            mul $t9 $v0 $t4 
            add $t9 $t9 $t2 
            lw $t3 ($t9)
            mul $t9 $t0 $t4 
            add $t9 $t9 $t2 
            lw $t5 ($t9) 
            move $t9 $t3 
            move $t3 $t5 
            move $t5 $t9 
            mul $t9 $v0 $t4 
            add $t9 $t9 $t2 
            sw $t3 ($t9)
            mul $t9 $t0 $t4 
            add $t9 $t9 $t2 
            sw $t5 ($t9)         
            parittion_not_if1: 
                addi $t0 $t0 1   
                j partition_loop
        partition_loop_further:
            addi $v0 $v0 1
            addi $s5 $s5 1
            mul $t9 $v0 $t4 
            add $t9 $t9 $t2 
            lw $t3 ($t9)
            mul $t9 $t6 $t4 
            add $t9 $t9 $t2 
            lw $t5 ($t9) 
            move $t9 $t3 
            move $t3 $t5 
            move $t5 $t9 
            mul $t9 $v0 $t4 
            add $t9 $t9 $t2 
            sw $t3 ($t9)
            mul $t9 $t6 $t4 
            add $t9 $t9 $t2 
            sw $t5 ($t9)           
            jr $ra 

    comapre:
        blt $s0 $s2 compare_if_1
        bge $s0 $s2 compare_else_1

        compare_if_1:
            blt $s0 $s4 print_bubble_compare
            bge $s0 $s4 print_quick_compare
        
        compare_else_1:
            blt $s2 $s4 print_selection_compare
            bge $s2 $s4 print_quick_compare
        print_bubble_compare:
            li $v0 4
            la $a0 b_s
            syscall
            la $a0 b_t_c 
            syscall
            jr $ra 
        print_selection_compare:
            li $v0 4
            la $a0 s_s
            syscall
            la $a0 b_t_c 
            syscall
            jr $ra 
        print_quick_compare:
            li $v0 4
            la $a0 q_s
            syscall
            la $a0 b_t_c 
            syscall
            jr $ra 
    swaps_comapre:
        blt $s1 $s3 swap_if_1
        bge $s1 $s3 swap_else_1

        swap_if_1:
            blt $s1 $s5 print_bubble_swap
            bge $s1 $s5 print_quick_swap
        
        swap_else_1:
            blt $s3 $s5 print_selection_swap
            bge $s3 $s5 print_quick_swap
        
        print_bubble_swap:
            li $v0 4
            la $a0 b_s
            syscall
            la $a0 b_t_s 
            syscall
            jr $ra 
        print_selection_swap:
            li $v0 4
            la $a0 s_s
            syscall
            la $a0 b_t_s
            syscall
            jr $ra 
        print_quick_swap:
            li $v0 4
            la $a0 q_s
            syscall
            la $a0 b_t_s
            syscall
            jr $ra         
.data
spacebar: .asciiz " "
endl: .asciiz "\n"
message: .asciiz "Enter Number: "
.text
    main:
    # prompt message
    li $v0 4
    la $a0 message
    syscall
    # input number n
    li $v0 5
    syscall
    move $t0 $v0 # n is stored in register $t0

    li $t1 1 # this is variable i --> $t1, j --> $t2
    for1:
        bgt $t1 $t0 EXIT
        sub $t3 $t0 $t1 # $t3 means n-i.
        li $t2 0 # set j to 0.
        for2:
            # for loop for spaces.
            bge $t2 $t3 part3
            li $v0 4
            la $a0 spacebar
            syscall
            addi $t2 $t2 1
            j for2
        part3:
            # set j = 1 and loop for 1 to n
            li $t2 1
            for3:
                bgt $t2 $t1 part4
                li $v0 1
                move $a0 $t2
                syscall
                addi $t2 $t2 1
                j for3
        part4:
            # set j = n and loop for n to 1.
            move $t2 $t1
            addi $t2 $t2 -1
            li $t4 0
            for4:
                ble $t2 $t4 part5
                li $v0 1
                move $a0 $t2
                syscall
                addi $t2 $t2 -1
                j for4
                
        part5:
            li $v0 4
            la $a0 endl
            syscall
            addi $t1 $t1 1
            j for1

    EXIT:
        li $v0 10
        syscall

# c code for the following
# int n;
# cin>>n;
# for(int i=1;i<=n;i++){
#     int j    
#     for(j=0;j<n-i;j++){
#         cout<<" ";
#     }
#     for(int j=1;j<=i;j++){
#         cout<<j;
#     }
#     for(j=n;j>0;j--){
#         cout<<j;
#     }
#     cout<<endl;
# }
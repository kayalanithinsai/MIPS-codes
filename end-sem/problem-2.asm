.data
prompt: .asciiz "test sentence"
.text
main:
    li $s0 4
    li $s1 8
    slt $s3 $s0 $s1 
    beq $s3 $t0 label
    addi $s0 $s1 -3
    label:
        addi $s1 $s0 2 
    
    li $v0 10
    syscall

 .text 
main:
la $a0, messageone
li $v0, 4 
syscall 

li $v0,8
la $a0 first 
li $a1, 3
syscall 

la $a0 endl
li $v0 4
syscall

la $a0, messagetwo
li $v0, 4 
syscall 

li $v0,8
la $a0 second 
li $a1, 3
syscall 

la $a0 endl
li $v0 4
syscall

la $t0 first
la $t1 second

lbu   $t2, 0($t0) 
lbu   $t3, 0($t1) 

lbu   $t4, 1($t0)  
lbu   $t5, 1($t1) 

sne $t6, $t2, $t3
sne $t7, $t4, $t5

move $a0, $t6
li $v0, 1
syscall

move $a0, $t7
li $v0, 1
syscall

li $v0, 10 
syscall 

.data 
endl: .asciiz "\n"
messageone: .asciiz "First string: "
messagetwo: .asciiz "Enter second string: " 
first: .space 3
second: .space 3
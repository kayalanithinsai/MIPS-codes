.data
sentence: .space 100
inp: .asciiz "Enter the input string: "
.text
main:
li $v0 4
la $a0 inp
syscall
li $v0 8
la $a0 sentence
li $a1 100
syscall
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
la $t0 sentence
addi $t2 $t2 -1
li $t4 0
loop2:
beq $t2 -1 endloop2
add $t9 $t2 $t0 
lbu $t3 0($t9)
beq $t3 'a' skip_stack
beq $t3 'e' skip_stack
beq $t3 'i' skip_stack
beq $t3 'o' skip_stack
beq $t3 'u' skip_stack
addi $sp $sp -1
sb $t3 ($sp) 
addi $t4 $t4 1
skip_stack:
    addi $t2 $t2 -1
    j loop2 
endloop2:
li $t2 0
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
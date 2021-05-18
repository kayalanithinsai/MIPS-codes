.text
main:
li $v0 4
la $a0 initial  # prompt the initial
syscall

li $v0 8
la $a0 string
li $a1 4 # reading string
syscall

li $v0 4
la $a0 endl
syscall

la $a1 string
lbu $a0 1($a1) # using lbu to get string[1]
li $v0 11
syscall

#exiting
li $v0 10
syscall

.data
initial: .asciiz "Enter String: "
endl: .asciiz "\n"
string: .space 4

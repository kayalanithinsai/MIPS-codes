.text
main:

li $v0 4
la $a0 initial #printing initaila user message
syscall

li $v0 8
la $a0 name
li $a1 50 # using name variable to get input.
syscall

li $v0 4
la $a0 messageprefix # output messageprefix
syscall

la $a0 name
syscall

la $a0 messagepostfix # output messagepostfix
syscall

li $v0 10
syscall #exiting

.data
initial: .asciiz "Enter Your Name:"
name: .space 50
messageprefix: .asciiz "hii "
messagepostfix: .asciiz ", MIPS assembly programming is very exciting to learn\n"

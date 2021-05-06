.data
str: .space 200
vowels: .asciiz "aeoiu"
inp: .asciiz "Enter the input string: "
out0: .asciiz "\nA Vowel was Found at Relative Position\t"
endl: .asciiz "\n"

.text
main:
li $v0 4
la $a0 inp
syscall

li $v0 8
la $a0 str
li $a1 100
syscall

la $t0 str
loop0:
lbu $t1 0($t0)
beq $t1 '\n' endloop0
addi $t0 $t0 1
j loop0
endloop0:

sb $0 0($t0)

la $t0 str
addi $sp $sp -4
sw $t0 0($sp)

jal find_vowels

li $v0 17
syscall
find_vowels:

lw $s0 0($sp)
addi $sp $sp 4

move $t0 $s0
move $s1 $ra
loop1:
lbu $t1 0($t0)
beq $t1 0 endloop1
la $t2 vowels

loop2:
lbu $t3 0($t2)
beq $t3 0 endloop2
bne $t1 $t3 continue

sub $t4 $t0 $s0
addi $t4 $t4 1
addi $sp $sp -4
sw $t4 0($sp)
jal print
continue:
addi $t2 $t2 1
j loop2
endloop2:

addi $t0 $t0 1
j loop1
endloop1:

jr $s1
print:
li $v0 4
la $a0 out0
syscall
lw $a0 0($sp)
addi $sp $sp 4
li $v0 1
syscall
jr $ra

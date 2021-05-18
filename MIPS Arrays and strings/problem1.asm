
.data

stud: .asciiz "Nithin" "Shyam" "RAM" "teja" "agarwal" "sharma"
marks: .word 20 30 50 60
	.word 15 20 30 40
	.word 80 90 90 90
	.word 70 70 70 70
	.word 99 100 0 50
	.word 95 90 95 90
usr: .space 101
inp: .asciiz "Enter Student Name: "
out: .asciiz "The marks of student is as follows:\n"
phy: .asciiz "Physics: "
che: .asciiz "Chemistry:"
mat: .asciiz "Mathematics: "
bio: .asciiz "Biology: "
endl: .asciiz "\n"
out2: .asciiz "Student name is not matched"


.globl main

.text

main:

li $v0 4
la $a0 inp
syscall

li $v0 8
li $a1 50
la $a0 usr
syscall	#read

la $t0 usr
loop0:
lbu $t1 0($t0)
bne $t1 '\n' continue0
li $t2 0
sb $t2 0($t0)
j endloop0
continue0:
addi $t0 $t0 1
j loop0
endloop0:


la $t0 stud
la $t1 marks

move $t9 $t1
addi $t9 $t9 96

loop1:
li $t8 1
beq $t1 $t9 endloop1
li $t8 0

la $t2 usr
loop2:

lbu $t3 0($t0)
lbu $t4 0($t2)

beq $t3 $0 endloop2
beq $t4 $0 endloop2
bne $t3 $t4 endloop2
addi $t2 $t2 1
addi $t0 $t0 1
j loop2
endloop2:

sub $t5 $t3 $t4


loop3:
lbu $t3 0($t0)
beq $t3 $0 endloop3
addi $t0 $t0 1
j loop3
endloop3:

addi $t0 $t0 1

bne $t5 $0 continue
li $v0 4
la $a0 out
syscall

la $a0 phy
syscall
li $v0 1
lw $a0 0($t1)
syscall
li $v0 4
la $a0 endl	#print physics
syscall

addi $t1 $t1 4
li $v0 4
la $a0 che
syscall
li $v0 1
lw $a0 0($t1)
syscall
li $v0 4
la $a0 endl	#print chemistry
syscall

addi $t1 $t1 4
li $v0 4
la $a0 mat
syscall
li $v0 1
lw $a0 0($t1)
syscall
li $v0 4
la $a0 endl	#print maths
syscall

addi $t1 $t1 4
li $v0 4
la $a0 bio
syscall
li $v0 1
lw $a0 0($t1)
syscall
li $v0 4
la $a0 endl	#print bio
syscall
j endloop1
continue:


addi $t1 $t1 16
j loop1
endloop1:


beq $t8 $0 finish
li $v0 4
la $a0 out2
syscall

finish:
li $v0 17
syscall #exit

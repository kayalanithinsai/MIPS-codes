.text
main:

la $a0 principle
li $v0 4
syscall

li $v0 5
syscall
move $t0 $v0

mtc1 $t0 $f0
cvt.s.w $f0 $f0

la $a0 rate
li $v0 4
syscall

li $v0 5
syscall
move $t1 $v0

mtc1 $t1 $f1
cvt.s.w $f1 $f1

la $a0 time
li $v0 4
syscall

li $v0 5
syscall
move $t2 $v0

mtc1 $t2 $f2
cvt.s.w $f2 $f2

mul.s $f3 $f0 $f1
mul.s $f4 $f3 $f2

li.s $f5 0.01

mul.s $f6 $f5 $f4

add.s $f7 $f0 $f6

la $a0 raw
li $v0 4
syscall

mov.s $f12 $f6
li $v0 2
syscall

la $a0 endl
li $v0 4
syscall

la $a0 absolute
li $v0 4
syscall

mov.s $f12 $f7
li $v0 2
syscall

li $v0 10
syscall


.data
principle: .asciiz "Enter Principle: "
rate: .asciiz "Enter the rate of intrest: "
time: .asciiz "Enter the Time: "
raw: .asciiz "The value of the Raw is: "
endl: .asciiz "\n"
absolute: .asciiz "The Absolute Value is :"

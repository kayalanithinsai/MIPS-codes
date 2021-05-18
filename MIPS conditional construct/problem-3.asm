.data
	promptname: .asciiz "Enter Name of the student :"
	prompttclss: .asciiz "Enter Total number of classes :"
	promptaclss: .asciiz "Enter No of attended classes :"
	message1: .asciiz " is allowed to sit in the exam.\n"
	message2: .asciiz " is not allowed to sit in the exam.\n"
	name: .space 40

.text
	main:
		li $v0 4
		la $a0 promptname
		syscall

		li $v0 8
		la $a0 name
		li $a1 30
		syscall

		li $v0 4
		la $a0 prompttclss
		syscall

		li $v0 5
		syscall
		move $t0 $v0

		li $v0 4
		la $a0 promptaclss
		syscall

		li $v0 5
		syscall
		move $t1 $v0

		li $v0 4
		la $a0 name
		syscall

		li $t5 100
		mul $t4 $t1 $t5
		divu $t4 $t0
		mflo $t2

		li $t3 75

		bge $t2 $t3 first

		li $v0 4
		la $a0 message2
		syscall

		li $v0 10
		syscall
	first:
		li $v0 4
		la $a0 message1
		syscall

		li $v0 10
		syscall

.data
	promptfirst: .asciiz "Enter First number :"
	promptsecond: .asciiz "Enter Second number :"
	message: .asciiz " is greater than "
	exiting: .asciiz "exiting\n"
	debug: .asciiz "Debugging Statement\n"
.text
	main:
		li $v0 6
		syscall
		mov.s $f1, $f0
		li $v0 6
		syscall
		mov.s $f2 $f0
		c.lt.s $f1, $f2
		bc1t first
		bc1f second
	
	first:
		mov.s $f3 $f1
		mov.s $f1 $f2
		mov.s $f2 $f3

		li $v0 2
		mov.s $f12 $f1
		syscall
		
		li $v0 4
		la $a0 message
		syscall

		li $v0 2
		mov.s $f12 $f2
		syscall

		li $v0 10
		syscall
	
	second:
		li $v0 2
		mov.s $f12 $f1
		syscall
		
		li $v0 4
		la $a0 message
		syscall

		li $v0 2
		mov.s $f12 $f2
		syscall

		li $v0 10
		syscall

.data

	positive: .asciiz "Input year is leap year\n"
	negative: .asciiz "Input year is not leap year\n"

.text

	main:
		#input year to $t0

		li $v0 5
		syscall
		move $t0 $v0

		# to compae number to 0.
		li $t3 0 
		
		# check if number is divisible by 400.
		
		li $t1 400
		divu $t0 $t1
		mfhi $t1
		bne $t1 $t3 first
		
		li $v0 4
		la $a0 positive
		syscall

		li $v0 10
		syscall

		first:
			li $t1 100
			divu $t0 $t1
			mfhi $t1
			bne $t1 $t3 second

			li $v0 4
			la $a0 negative
			syscall

			li $v0 10
			syscall

		second:
			li $t1 4
			divu $t0 $t1
			mfhi $t1
			bne $t1 $t3 third

			li $v0 4
			la $a0 positive
			syscall

			li $v0 10
			syscall

		third:
			li $v0 4
			la $a0 negative
			syscall

			li $v0 10
			syscall
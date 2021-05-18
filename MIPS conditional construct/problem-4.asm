.data
gradea: .asciiz "The student got grade A\n"
gradeb: .asciiz "The Student got grade B\n"
gradec: .asciiz "The student got grade C\n"
gradef: .asciiz "The student got grade F\n"

.text
	main:
		li $v0 5
		syscall
		move $t0 $v0

		li $t1 80
		blt $t0 $t1 first

		li $v0 4
		la $a0 gradea
		syscall

		li $v0 10
		syscall

	first:
		li $t1 60
		blt $t0 $t1 second

		li $v0 4
		la $a0 gradeb
		syscall

		li $v0 10
		syscall

	second:
		li $t1 40
		blt $t0 $t1 third

		li $v0 4
		la $a0 gradec
		syscall

		li $v0 10
		syscall
	third:
		li $v0 4
		la $a0 gradef
		syscall

		li $v0 10
		syscall
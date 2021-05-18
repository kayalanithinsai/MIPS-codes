.text
main:
		li $t0, 1
		li $t1, 0
		nor $t2, $t1, $t0
		nor $t3, $t0, $t2
		nor $t4, $t1, $t2
		nor $t5, $t4, $t3
		nor $t6, $t5, $t5
		and $t7, $t1, $t0
li $v0, 1
move $a0 , $t6
syscall
li $v0, 10
syscall	
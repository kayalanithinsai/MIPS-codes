.data

.text
main:  	
	li $t0, 10
	li $t1, 10
	li $t2, 10 
	li $t3, 10
	srl $t0 , $t0 ,3
	srl $t1, $t1, 2
	srl $t2, $t2, ,1
	srl $t3, $t3, 1 
	add $t1, $t1, $t0
	add $t2, $t2, $t3
	add $t5 , $t2, $t1	

li $v0, 1
move $a0 , $t5
syscall
li $v0, 10
syscall	
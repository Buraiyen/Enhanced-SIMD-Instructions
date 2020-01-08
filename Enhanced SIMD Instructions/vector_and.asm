# ***************************** 341 Top Level Module **********************************************************
#
# File name: 		vector_and.asm
# Verson:		1.2
# Date:			November 30, 2018
# Programmer:		Brian Nguyen
# Description: 		Each element of vector a is compared with the corresponding element of vector b using the AND operator
# 
# 				vec_and d, a, b
#
#
# 
#


	# *********************************************************
	#			MAIN CODESEGMENT
	# *********************************************************

main:
	la $a0, a		# initialize vector a
	la $a1, b		# initialize vector b
	la $a2, d		# initialize vector d
	lw $t3, size		# initialize the loop breaker
	li $t4, 0		# initialize count variable
	j loop
	
loop:
	lw $t0, 0($a0)		# load element from vector a
	lw $t1, 0($a1)		# load element from vector b
	and $t1, $t1, $t0	
	sw $t1, 0($a2)		# store sum in vector d
	addi $a0,$a0, 4		# iterate to next element in vector a
	addi $a1,$a1, 4		# iterate to next element in vector b
	addi $a2, $a2, 4	# iterate to the next element in vector d
	addi $t4, $t4, 1	# increment the count variable
	
	bne $t4, $t3, loop	# once the count variable reaches the end of the sizes of the vectors (8), the loop will break

combine:
	mul $t3, $t3, 4
	sub $a2, $a2, $t3
	lw $t0, 0($a2)
	lw $t1, 4($a2)
	sll $t0, $t0, 8
	add $t0, $t0, $t1
	lw $t1, 8($a2)
	sll $t0, $t0, 8
	add $t0, $t0, $t1
	lw $t1, 12($a2)
	sll $t0, $t0, 8
	add $t0, $t0, $t1
	lw $t1, 16($a2)
	lw $t2, 20($a2)
	sll $t1, $t1, 8
	add $t1, $t1, $t2
	lw $t2, 24($a2)
	sll $t1, $t1, 8
	add $t1, $t1, $t2
	lw $t2, 28($a2)
	sll $t1, $t1, 8
	add $t1, $t1, $t2
	
exit:	ori $v0, $zero, 10	# $v0 <-- function code for "exit"
	syscall			# Syscall to exit
	
proc1:	j proc1		# placeholder stub

	# *******************************************************************
	#	PROJECT		RELATED		DATA		SECTION		
	# *******************************************************************


	.data	#		[0]	[1]	[2]	[3]	[4]	[5]	[6]	[7]
		a:	.word	0x23,	0x3C,	0x47,	0x5D,	0x08,	0x7F,	0x19,	0x6F
		b: 	.word	0X98,	0X19,	0X63,	0XC5,	0X5E,	0X80,	0XB3,	0X6E
		d: 	.space 8
		size: 	.word 8


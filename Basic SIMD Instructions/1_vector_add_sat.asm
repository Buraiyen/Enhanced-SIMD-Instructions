# ***************************** 341 Top Level Module **********************************************************
#
# File name: 		1_vector_add_sat.asm
# Verson:		1.2
# Date:			November 23, 2018
# Programmer:		Brian Nguyen
# Description: 		Each element of vector a is added to the corresponding element of vector b. 
#			The unsigned-integer is placed into the corresponding element of vector d
# 
# 				vec_addsu d, a, b
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
	li $t5, 0xFF		# load the limit
	j loop
	
	#*********************************************************
	#	Branch used to store 0xFF in an index
	#*********************************************************
store:	
	sw $t5, 0($a2)		# Stores 0xFF into vector d
	addi $a0,$a0, 4		# iterate to next element in vector a
	addi $a1,$a1, 4		# iterate to next element in vector b
	addi $a2, $a2, 4	# iterate to the next element in vector d
	addi $t4, $t4, 1	# increment the count variable
	b loop
	
	#*********************************************************
	#	Go through each element in both 
	#	vectors and add them
	#*********************************************************
loop:
	lw $t0, 0($a0)		# load element from vector a
	lw $t1, 0($a1)		# load element from vector b
	addu $t1, $t1, $t0	# sum of elements unsigned
	#****************************************************************
	slt $t6, $t5, $t1	# if the sum of the registers is greater than
	bne $t6, $zero, store	# 0xFF, then go to the "store" branch
	#***************************************************************
	sw $t1, 0($a2)		# store sum in vector d
	addi $a0,$a0, 4		# iterate to next element in vector a
	addi $a1,$a1, 4		# iterate to next element in vector b
	addi $a2, $a2, 4	# iterate to the next element in vector d
	addi $t4, $t4, 1	# increment the count variable
	
	bne $t4, $t3, loop	# once the count variable reaches the end of the sizes of the vectors (8), the loop will break
	mul $t3, $t3, 4		
	sub $a2, $a2, $t3
	lw $t0, 0($a2)
	lw $t1, 4($a2)
	sll $t0, $t0, 8
	add $t0, $t0, $t1
	sll $t0, $t0, 8
	addi $a2, $a2, 4
	lw $t1, 4($a2)
	add $t0, $t0, $t1
	sll $t0, $t0, 8
	lw $t1, 8($a2)
	add $t0, $t0, $t1
	lw $t1, 12($a2)
	lw $t2, 16($a2)
	sll $t1, $t1, 8
	add $t1, $t1, $t2
	sll $t1, $t1, 8
	lw $t2, 20($a2)
	add $t1, $t1, $t2
	sll $t1, $t1, 8
	lw $t2, 24($a2)
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

	# *******************************************************************
	#		EXPECTED		OUTPUT		
	# *******************************************************************
	
	#		[0]	[1]	[2]	[3]	[4]	[5]	[6]	[7]
	#	d: 	0xBB,	0x55,	0xAA,	0xFF,	0x66,	0xFF,	0xCC,	0xDD

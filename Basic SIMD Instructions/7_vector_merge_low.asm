# ***************************** 341 Top Level Module **********************************************************
#
# File name: 		7_vector_merge_high.asm
# Verson:		1.0
# Date:			November 18, 2018
# Programmer:		Brian Nguyen
# Description: 		The even elementso of the result of vector d are obtained left-to-right from the low elements of vector a. The odd elements of the result are obtained left-to-right
#			from the low elements of vector b
# 
# 				vec_mergeh d, a, b
#
#


	# *********************************************************
	#			MAIN CODESEGMENT
	# *********************************************************


	.text			# main (must be global)
	.globl main

main:
	la $a0, a		# initialize vector a
	la $a1, b		# initialize vector b
	la $a2, d		# initialize vector d
	li $t3, 4		# initialize end count
	li $t4, 0		# initialize count variable
	li $t5, 0		# initialize second count variable
	j half_array		# jump to label half_array
	
	#******************************************************************
	# The purpose of this label is to reach the middle of the vector 
	# which will then use the low elements to store into the new array
	#******************************************************************
half_array:
	addi $a0, $a0, 4
	addi $a1, $a1, 4
	addi $t4, $t4, 1
	bne $t3, $t4, half_array
	
loop:
	lw $t0, 0($a0)		# retrieve element from vector a
	sw $t0, 0($a2)		# store element into vector d
	addi $a2, $a2, 4	# increment to next element in vector a
	
	lw $t0, 0($a1)		# retrieve element from vector b
	sw $t0, 0($a2)		# store element into vector d
	addi $a2, $a2, 4	# increment to next element in vector b
	
	addi $a0,$a0, 4		# iterate to next element in vector a
	addi $a1,$a1, 4		# iterate to next element in vector b
	
	addi $t5, $t5, 1	# increment count variable by one
	bne $t5, $t4, loop
	
	mul $t3, $t3, 4	
	mul $t3, $t3, 2		
	sub $a2, $a2, $t3 
	lw $t0, 0($a2)
	lw $t1, 4($a2)
	sll $t0, $t0, 8
	add $t0, $t0, $t1
	sll $t0, $t0, 8
	sll $t0, $t0, 8
	lw $t2, 8($a2)
	lw $t3, 12($a2)
	sll $t2, $t2, 8
	
	add $t2, $t2, $t3

	add $t0, $t0, $t2	# first half of vector
	
	lw $t2, 16($a2)
	lw $t3, 20($a2)
	sll $t2, $t2, 8
	add $t2, $t2, $t3
	sll $t2, $t2, 8
	lw $t3, 24($a2)
	add $t2, $t2, $t3
	sll $t2, $t2, 8
	lw $t3, 28($a2)
	add $t2, $t2, $t3
exit:
	ori $v0, $zero, 10	# $v0 <-- function code for "exit"
	syscall			# Syscall to exit

	# *******************************************************************
	#	PROJECT		RELATED		DATA		SECTION		
	# *******************************************************************

	.data	#		[0]	[1]	[2]	[3]	[4]	[5]	[6]	[7]
		a:	.word	0x5A,	0xF0,	0xA5,	0x01,	0xAB,	0x01,	0x55,	0xC3
		b: 	.word	0XA5,	0X0F,	0X5A,	0X23,	0XCD,	0X23,	0XAA,	0X3C
		d:	.space 	8
		
	# *******************************************************************
	#		EXPECTED		OUTPUT		
	# *******************************************************************
	
	#		[0]	[1]	[2]	[3]	[4]	[5]	[6]	[7]
	#	a:	0x5A,	0xF0,	0xA5,	0x01,	0xAB,	0x01,	0x55,	0xC3
	#	b: 	0XA5,	0X0F,	0X5A,	0X23,	0XCD,	0X23,	0XAA,	0X3C
	#	d: 	0xAB,	0xCD,	0x01,	0x23,	0x55	0xAA,	0xC3,	0x3C

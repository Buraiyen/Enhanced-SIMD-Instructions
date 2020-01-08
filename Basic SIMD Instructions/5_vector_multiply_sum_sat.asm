# ***************************** 341 Top Level Module **********************************************************
#
# File name: 		5_vector_multiply_sum_sat.asm
# Verson:		1.4
# Date:			November 21, 2018
# Programmer:		Brian Nguyen
# Description: 		Each element of vector d is the 16-bit sum of the corresponding elements of vector c and the 16-bit "temp" products of the 8-bit
#			elements of vector a and vector b which overlap the positions of that in vector c. The sum is performed with 16-bit saturating addition (no-wrap)
# 
# 				vec_msums d, a, b
#
#
# Register Usage:	$a0, $a1, $a2, $a3
#			$t0, $t1, #t2, $t3, $t4
#
# Notes: 		

	# *********************************************************
	#			MAIN CODESEGMENT
	# *********************************************************
	
	.text			# main (must be global)
	.globl main

main:
	la $a0, a		# load vector a
	la $a1, b		# load vector b
	la $a2, c		# load vector c
	la $a3, d		# load vector d
	lw $t3, size		# initialize the size of the vectors
	li $s0, 0xFFFF		# load word limit 
	li $t4, 0		# initialize counter variable
	j loop


str_limit: 	
	sw $s0, 0($a3)		# store 0xFFFF into vector d
				
				#********************************
	addi $a0, $a0, 4	# the positions of all vectos get incremented
	addi $a1, $a1, 4	#
	addi $a2, $a2, 4	#
	addi $a3, $a3, 4	#
				#********************************
				
	addi $t4, $t4, 1	# loop counter gets incremented
loop:
	lw $t0, 0($a0)			# load element from vector a
	lw $t1, 0($a1)			# load element from vector b
	mul $t1, $t1, $t0		# multiply two elements from vector a and b
	
					#****************************
	addi $a0, $a0, 4		# the positions of both vectors
	addi $a1, $a1, 4		# get incremented
					#****************************
					
	lw $t5, 0($a0)			# load element from vector a
	lw $t6, 0($a1)			# load element from vector b
	mul $t6, $t6, $t5		# multiply two elements from vector a and b
	add $t6, $t6, $t1 		# add the products from both resultants
	lw $t7, 0($a2)			# load element from vector c
	add $t7, $t7, $t6		# add the product from 
	
					#****************************
	slt $s1,  $s0, $t7		# checks if the resultant 
	bne $s1, $zero, str_limit	# is greater than  0xFFFF
					#****************************
					
	sw $t7, 0($a3)			# store the resultant into vector d
	
					#****************************
	addi $a0, $a0, 4		# the positions of all vectors
	addi $a1, $a1, 4		# get incremented
	addi $a2, $a2, 4
	addi $a3, $a3, 4
					#****************************
					
	addi $t4, $t4, 1		# loop counter gets incremented
	bne $t4, $t3, loop		# if loop counter reaches its limit, then exit. Else, keep looping
	
	# combine
	mul $t3, $t3, 4		
	sub $a2, $a2, $t3
	lw $t0, 16($a2)
	lw $t1, 20($a2)
	sll $t0, $t0, 8
	sll $t0, $t0, 8
	add $t0, $t0, $t1
	lw $t2, 24($a2)
	lw $t3, 28($a2)
	sll $t2, $t2, 8
	sll $t2, $t2, 8
	
	add $t2, $t2, $t3
	
	
exit:	ori $v0, $zero, 10	# $v0 <-- function code for "exit"
	syscall			# Syscall to exit
	
proc1:	j proc1		# placeholder stub

	# *******************************************************************
	#	PROJECT		RELATED		DATA		SECTION		
	# *******************************************************************

	.data	#		[0]	[1]	[2]	[3]	[4]	[5]	[6]	[7]
		.data	#		[0]	[1]	[2]	[3]	[4]	[5]	[6]	[7]
		a:	.word	0x23,	0x0C,	0xF1,	0x4D,	0x5C,	0x7F,	0x19,	0x1A
		b: 	.word	0XA3,	0X0C,	0X5B,	0XFD,	0XC5,	0XFF,	0XC9,	0XEE
		c:	.word	0x609E,	0x19F7,	0x4567,	0x0766
		d: 	.space 4
		size: 	.word 4
		
	# *******************************************************************
	#		EXPECTED		OUTPUT		
	# *******************************************************************
	
	#		[0]		[1]		[2]		[3]	
	#	d: 	0x7777,		0xBBBB,		0xFFFF,		0x3333

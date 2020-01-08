# ***************************** 341 Top Level Module **********************************************************
#
# File name: 		4_vector_mul_odd.asm
# Verson:		1.0
# Date:			November 4, 2018
# Programmer:		Brian Nguyen
# Description: 		Using a sequence of MIPS instructions, have two vectors where each odd element of one vector is multiplied to the corresponding odd element of
#			another vector. The result is placed into an empty vector
# 
# 				vec_mulo d, a, b
#
#
# Register Usage:	$a0, $a1, $a2
#			$t0, $t1, #t2, $t3, $t4
#
# Notes: 		

	# *********************************************************
	#			MAIN CODESEGMENT
	# *********************************************************


	.text			# main (must be global)
	.globl main

main:
	la $a0, a		# initialize vector a
	la $a1, b		# initialize vector b
	la $a2, d		# initialize d (an empty vector)
	lw $t3, size		# the size of the vector (4)
	li $t4, 0		# count variable
	
				# the pointers are automatically incremented by 1 before the loop so they it starts at index 1 of each vector
	addi $a0,$a0, 4
	addi $a1,$a1, 4
	j loop
	
loop:
	
	lw $t0, 0($a0)		# retrieve element from vector a
	lw $t1, 0($a1)		# retrieve element from vector b
	mul $t2, $t0, $t1	# multiply elements
	sw $t2, 0($a2)		# store result in vector d
				
				# increment by two to retrieve odd elements
	addi $a0,$a0, 8		
   	addi $a1,$a1, 8
   	
   				
   	addi $a2,$a2,4		# increment vector d by one
   	addi $t4, $t4, 1	# increment counter variable
   	bne $t4,$t3,loop	# if the pointer reaches the end of both arrays, then exit loop
   	mul $t3, $t3, 4		
	sub $a2, $a2, $t3
	lw $t0, 0($a2)
	lw $t1, 4($a2)
	sll $t0, $t0, 8
	sll $t0, $t0, 8
	add $t0, $t0, $t1
	lw $t2, 8($a2)
	lw $t3, 12($a2)
	sll $t2, $t2, 8
	sll $t2, $t2, 8
	add $t2, $t2, $t3

exit:	ori $v0, $zero, 10	# $v0 <-- function code for "exit"
	syscall			# Syscall to exit

	.data	#		[0]	[1]	[2]	[3]	[4]	[5]	[6]	[7]
		a:	.word	0xAE,	0xE9,	0x5A,	0xE0,	0xF0,	0x80,	0xCC,	0x66
		b: 	.word	0X33,	0X14,	0X61,	0X70,	0X60,	0X98,	0X88,	0XAB
		d: 	.space 4
		
		size: 	.word 4

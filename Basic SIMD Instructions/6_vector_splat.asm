# ***************************** 341 Top Level Module **********************************************************
#
# File name: 		6_vector_splat.asm
# Verson:		1.0
# Date:			November 4, 2018
# Programmer:		Brian Nguyen
# Description: 		The "splat" instruction is used to copy any element from one vector into all the elements of another vector. Each element of the result of
#			vector d is a component b of vector a
# 
# 				vec_splat d, a, b
#
#

#			
#
# Notes: 		

	# *********************************************************
	#			MAIN CODESEGMENT
	# *********************************************************


	.text			# main (must be global)
	.globl main

main:
	la $a0, a		# initialize vector a
	la $a1, d		# initialize vector d (empty vector)
	lw $t0, b
	add $t0, $t0, $t0	# double the index
	add $t0, $t0, $t0	# double the index again (4x)
	add $t1, $t0, $a0
	lw $t2, 0($t1)		# load index b into register $t4
	
	lw $t3, size		# the size of the vector (8)
	li $t4, 0		# count variable
	j loop

loop:
	sw $t2, 0($a1)		# $t2 gets stored into the empty vector
	addi $a1, $a1, 4	# increment pointer
	addi $t4, $t4, 1	# increment count variable
	bne $t4, $t3, loop	# once the pointer reaches the end of the vector, exit
	
	mul $t3, $t3, 4		
	sub $a1, $a1, $t3 
	lw $t0, 0($a1)
	lw $t1, 4($a1)
	sll $t0, $t0, 4
	sll $t0, $t0, 4
	add $t0, $t0, $t1
	lw $t2, 8($a1)
	lw $t3, 12($a1)
	sll $t2, $t2, 4
	sll $t2, $t2, 4
	add $t2, $t2, $t3
	sll $t0, $t0, 4
	sll $t0, $t0, 4
	sll $t0, $t0, 4
	sll $t0, $t0, 4
	add $t0, $t0, $t2

exit:	ori $v0, $zero, 10	# $v0 <-- function code for "exit"
	syscall			# Syscall to exit

	# *******************************************************************
	#	PROJECT		RELATED		DATA		SECTION		
	# *******************************************************************

	.data	#		[0]	[1]	[2]	[3]	[4]	[5]	[6]	[7]
		a:	.word	0x23,	0x0C,	0x12,	0x4D,	0x05,	0x7F,	0x19,	0x2A
		d: 	.space 	8
		b:	.word 	5
		size:	.word 	8
		
	# *******************************************************************
	#		EXPECTED		OUTPUT		
	# *******************************************************************
	
	#		[0]	[1]	[2]	[3]	[4]	[5]	[6]	[7]
	#	a:	0x23,	0x0C,	0x12,	0x4D,	0x05,	0x7F,	0x19,	0x2A
	#	d: 	0x7F,	0x7F,	0x7F,	0x7F,	0x7F,	0x7F,	0x7F,	0x7F


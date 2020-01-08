# ***************************** 341 Top Level Module **********************************************************
#
# File name: 		vector_swap.asm
# Verson:		1.0
# Date:			November 4, 2018
# Programmer:		Brian Nguyen
# Description: 		All elements in vector a are placed into vector b, and all elements in vector b are placed into vector a
# 
# 				vec_swap d, a, b
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
	la $a0, vec_a
	la $a1, vec_b
	lw $t3, size		# initialize the size of the vectors
	li $t4, 0		# initialize counter variable

	lw $t0, 0($a0)		# retrieve first element from vec_a
	addi $a0, $a0, 4	
	lw $t1, 0($a0)		# retrieve second element from vec_a
	addi $a0, $a0, 4
	
	lw $t2, 0($a1)		# retrieve first element from vec_b
	addi $a1, $a1, 4
	lw $t3, 0($a1)		# retrieve second element from vec_b
	addi $a1, $a1, 4
	
	sub $a0, $a0, 8
	sub $a1, $a1, 8
	
	sw $t0, 0($a1)		# store first element from vec_a
	addi $a1, $a1, 4	
	sw $t1, 0($a1)		# store second element from vec_a
	addi $a1, $a1, 4
	
	sw $t2, 0($a0)		# store first element from vec_b
	addi $a0, $a0, 4
	sw $t3, 0($a0)		# store second element from vec_b
	
	# *******************************************************************
	#	PROJECT		RELATED		DATA		SECTION		
	# *******************************************************************

.data	#		[0]	[1]	[2]
		vec_a:	.word	0xABCD, 0x1234
		vec_b: 	.word	0xEF01, 0x5678
		vec_d: 	.space 4
		size: 	.word 2

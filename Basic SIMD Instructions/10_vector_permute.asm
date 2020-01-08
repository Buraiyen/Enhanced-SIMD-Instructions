# ***************************** 341 Top Level Module **********************************************************
#
# File name: 		10_vector_permute.asm
# Verson:		1.0
# Date:			November 23, 2018
# Programmer:		Brian Nguyen
# Description: 		The "permute" instruction fills the result vector d with elements from either vector a or vector b, depending upon the
#			element sepcifier in vector c. The vector elements can be specified in any order
# 
# 				vec_perm d, a, b, c
#
#
# Register Usage:	$a0, $a1, $a2, $a3
#			$t0, $t1, #t2, $t3, $t4
#			$s0
#
# Notes: 	

	# *********************************************************
	#			MAIN CODESEGMENT
	# *********************************************************
	
	.text			# main (must be global)
	.globl main
	
main:
	la $a0, vec_a		# load vector a
	la $a1, vec_b		# load vector b
	la $a2, vec_c		# load vector c
	la $a3, vec_d		# load vector d
	li $s1, 1
	li $s2, 0x10		# load overflow limit
	li $s4, 4		
	lw $t3, size		# initialize the size of the vectors
	li $t4, 0		# initialize counter variable
	#div $s3, $s3, $s2
	j loop
	
	
vec_a_permute:
	

	div $t0, $s2
	mfhi $t8		# element of vector c % 10 (to get the last digit)
	mul $t0, $t8, 4		# now multiply the mod by 4 to get element position
	add $a0, $a0, $t0
	lw $t1, ($a0)		# load element from vector a
	sw $t1, ($a3)		# store vector a element into vector 
	sub $a0, $a0, $t0	# go back to starting point
	addi $a2, $a2, 4	# go to next position of vector c
	addi $a3, $a3, 4	# go to next position of vector d
	b loop			# branch to loop
	
vec_b_permute:

	div $t0, $s2
	mfhi $t8		# element of vector c % 10 (to get the last digit)
	mul $t0, $t8, 4		# now multiply the mod by 4 to get element position
	add $a1, $a1, $t0
	lw $t1, ($a1)		# load element from vector b
	sw $t1, ($a3)		# store vector b element into vector d
	sub $a1, $a1, $t0	# go back to starting point
	addi $a2, $a2, 4	# go to next position of vector c
	addi $a3, $a3, 4	# go to next position of vector d
	b loop			# branch to loop
loop:
	
	lw $t0, 0($a2)			# load element from vector c (the element specifier)
	div $t1, $t0, $s2		# dividing by 10
	addi $t4, $t4, 1
	beq $t4, $t3, combine		
	beq $t1, $zero, vec_a_permute	# if the result is 0, go to branch vec_a_permute
	beq $t1, $s1, vec_b_permute	# if the result is 1, go to branch vec_b_permute
	
	
combine:	

	subi $a3, $a3, 40
	
	lw $t0, 8($a3)
	lw $t1, 12($a3)
	sll $t0, $t0, 8
	add $t0, $t0, $t1
	lw $t1, 16($a3)
	sll $t0, $t0, 8
	add $t0, $t0, $t1
	lw $t1, 20($a3)
	sll $t0, $t0, 8
	add $t0, $t0, $t1
	
	lw $t1, 24($a3)
	lw $t2, 28($a3)
	sll $t1, $t1, 8
	add $t1, $t1, $t2
	lw $t2, 32($a3)
	sll $t1, $t1, 8
	add $t1, $t1, $t2
	lw $t2, 36($a3)
	sll $t1, $t1, 8
	add $t1, $t1, $t2
	
exit:	
	
	ori $v0, $zero, 10		# $v0 <-- function code for "exit"
	syscall			# Syscall to exit
	# *******************************************************************
	#	PROJECT		RELATED		DATA		SECTION		
	# *******************************************************************

	.data	#		[0]	[1]	[2]	[3]	[4]	[5]	[6]	[7]
		vec_c:	.word	0x04,	0x17,	0x10,	0x02,	0x13,	0x05,	0x01,	0x05	
		
		vec_a:	.word	0xA5,	0x67,	0x01,	0x3D,	0xAB,	0x45,	0x39,	0x3C
		vec_b:	.word	0XEF,	0XC5,	0X4D,	0X23,	0X12,	0X77,	0XAA,	0XCD
		vec_d:	.space 8
		size: 	.word 9


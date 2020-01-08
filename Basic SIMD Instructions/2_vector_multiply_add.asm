# ***************************** 341 Top Level Module **********************************************************
#
# File name: 		2_vector_multiply__add.asm
# Verson:		1.0
# Date:			November 22, 2018
# Programmer:		Brian Nguyen
# Description: 		Multiply the vector elements in a by the vector elements in b and then add the immediate result to the vector elements in c, storing each result
#			in vector d, in one instruction and in one rouunding
# 
# 				vec_madd d, a, b, c
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
	la $a3, vec_d		# load vector d (empty vector)
	li $s0, 0x100		# load the divisor
	lw $t3, size		# initialize the size of the vectors
	li $t4, 0		# initialize counter variable
	j loop
	
	#******************************
	# branch used for performing modulus on an overflow
	# so that it remains 8-bit
	#****************************
str_limit:
					#*********************
	div $t2, $s0			# Pseudoinstruction for
	mfhi $t2			# modulus: $d = $s % $t
	sw $t2, 0($a3)			#*********************
				
					#*********************************
	addi $a0, $a0, 4		# increment positions for all vectors
	addi $a1, $a1, 4
	addi $a2, $a2, 4
	addi $a3, $a3, 4
					#*********************************
				
	addi $t4, $t4, 1		# increment counter variable
	beq $t3, $t4, exit		# when counter variable reaches its limit, then exit the loop
	b loop
	
loop:
	lw $t0, 0($a0)			# load element from vector a
	lw $t1, 0($a1)			# load element from vector b
	mul $t1, $t1, $t0		# multiply the two elements together
	
	lw $t2, 0($a2)			# load element from vector c
	add $t2, $t2, $t1		# add the result of the products and the element loaded from vector d
	slt $t5, $s0, $t2		# if the result is greater than 0x100, go to branch str_limit
	bne $t5, $zero, str_limit
	sw $t2, 0($a3)			# store result in vector d
					
					#**********************************
	addi $a0, $a0, 4		# increment positions in all vectors
	addi $a1, $a1, 4
	addi $a2, $a2, 4
	addi $a3, $a3, 4
					#**********************************
					
	addi $t4, $t4, 1		# increment counter variable
	bne $t3, $t4, loop		# when counter variable reaches its limit, then exit the loop
exit:
	mul $t3, $t3, 4		
	sub $a3, $a3, $t3
	lw $t0, 0($a3)
	lw $t1, 4($a3)
	sll $t0, $t0, 8
	add $t0, $t0, $t1
	sll $t0, $t0, 8
	addi $a2, $a2, 4
	lw $t1, 8($a3)
	add $t0, $t0, $t1
	sll $t0, $t0, 8
	lw $t1, 12($a3)
	add $t0, $t0, $t1
	lw $t1, 16($a3)
	lw $t2, 20($a3)
	sll $t1, $t1, 8
	add $t1, $t1, $t2
	sll $t1, $t1, 8
	lw $t2, 24($a3)
	add $t1, $t1, $t2
	sll $t1, $t1, 8
	lw $t2, 28($a3)
	add $t1, $t1, $t2
	
	
	
	ori $v0, $zero, 10		# $v0 <-- function code for "exit"
	syscall				# Syscall to exit
	
proc1:	j proc1		# placeholder stub

	# *******************************************************************
	#	PROJECT		RELATED		DATA		SECTION		
	# *******************************************************************

	.data	#		[0]	[1]	[2]	[3]	[4]	[5]	[6]	[7]
		vec_a:	.word	0x12,	0x0C,	0x1A,	0x0D,	0x23,	0x05,	0x19,	0x12
		vec_b: 	.word	0X3D,	0X0C,	0X10,	0X4D,	0X05,	0X7F,	0X19,	0X2B
		vec_c:	.word	0x60,	0x09,	0x1B,	0x05,	0x50,	0x1E,	0x06,	0x60
		vec_d: 	.space 8
		
		size: 	.word 8

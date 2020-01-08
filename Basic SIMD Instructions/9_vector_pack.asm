# ***************************** 341 Top Level Module **********************************************************
#
# File name: 		9_vector_pack.asm
# Verson:		1.0
# Date:			November 22, 2018
# Programmer:		Brian Nguyen
# Description: 		Each high element of the result vector d is the truncation of the corresponding wider element of vector a. Each low element of the result is the truncation
#			of the corresponding wider element of vector b
# 
# 				vec_pack d, a, b
#
#
# Register Usage:	$a0, $a1, $a2
#			$t0, $t1, $t3, $t4
#			
#
# Notes: 	


	# *********************************************************
	#			MAIN CODESEGMENT
	# *********************************************************


	.text			# main (must be global)
	.globl main

main:
	la $a0, vec_a			# load vector a
	la $a1, vec_b			# load vector b
	la $a2, vec_d			# load vector d (empty vector)
	li $s0, 0x10			# load the divisor
	lw $t3, size			# load the size of the vector
	li $t4, 0			# initialize counter variable
	j high_loop
	
	# *************************************************
	# loop used for storing high elements into vector
	# *************************************************
high_loop:
	lw $t0, 0($a0)			# load element from vector a
					#*************************
	div $t0, $s0			# Psuedoinstruction for 
	mfhi $t0			# modulus: $d = $s % $t
					#*************************
			
	sw $t0, 0($a2)			# store the high result into vector d
	addi $a0,$a0, 4			# iterate to next element in vector a
	addi $a2,$a2, 4			# iterate to next element in vector d

	addi $t4, $t4, 1		# increment loop counter
	bne $t3, $t4, high_loop		# once the loop counter reaches its limit, then exit the loop
	addi $t4, $zero, 0		# reset loop counter
	
	# *************************************************
	# loop used for storing low elements into vector
	# *************************************************
low_loop:
	lw $t0, 0($a1)			# load element from vector b
	
					#*************************
	div $t0, $s0			# Psuedoinstruction for 
	mfhi $t0			# modulus: $d = $s % $t
					#*************************
					
	sw $t0, 0($a2)			# store the result low result into 
	
	addi $a1,$a1, 4			# iterate to next element in vector a
	addi $a2,$a2, 4			# iterate to next element in vector d

	addi $t4, $t4, 1		# inncrement loop counnter
	bne $t3, $t4, low_loop		# once the loop counter reaches its limit, then exit the loop
	mul $t3, $t3, 4	
	mul $t3, $t3, 2		
	sub $a2, $a2, $t3 
	lw $t0, 0($a2)
	lw $t1, 4($a2)
	sll $t0, $t0, 4
	add $t0, $t0, $t1
	sll $t0, $t0, 4
	lw $t1, 8($a2)
	add $t0, $t0, $t1
	sll $t0, $t0, 4
	lw $t1, 12($a2)
	add $t0, $t0, $t1
	sll $t0, $t0, 4
	lw $t1, 16($a2)
	add $t0, $t0, $t1
	sll $t0, $t0, 4
	lw $t1, 20($a2)
	add $t0, $t0, $t1
	sll $t0, $t0, 4
	lw $t1, 24($a2)
	add $t0, $t0, $t1
	sll $t0, $t0, 4
	lw $t1, 28($a2)
	add $t0, $t0, $t1
	
	lw $t2, 32($a2)
	lw $t3, 36($a2)
	sll $t2, $t2, 4
	add $t2, $t2, $t3
	sll $t2, $t2, 4
	lw $t3, 40($a2)
	add $t2, $t2, $t3
	sll $t2, $t2, 4
	lw $t3, 44($a2)
	add $t2, $t2, $t3
	sll $t2, $t2, 4
	lw $t3, 48($a2)
	add $t2, $t2, $t3
	sll $t2, $t2, 4
	lw $t3, 52($a2)
	add $t2, $t2, $t3
	sll $t2, $t2, 4
	lw $t3, 56($a2)
	add $t2,$t2, $t3
	sll $t2, $t2, 4
	lw $t3, 60($a2)
	add $t2, $t2, $t3
	
exit:	ori $v0, $zero, 10		# $v0 <-- function code for "exit"
	syscall	

	# *******************************************************************
	#	PROJECT		RELATED		DATA		SECTION		
	# *******************************************************************


	.data	#		[0]	[1]	[2]	[3]	[4]	[5]	[6]	[7]
		vec_a:	.word	0x5A,	0xFB,	0x6C,	0x1D,	0xAE,	0x5F,	0xC0,	0x41
		vec_b: 	.word	0X52,	0XF3,	0XA4,	0X15,	0XA6,	0X57,	0XC8,	0X49
		vec_d: 	.space 16
		size: 	.word 8

	# *******************************************************************
	#		EXPECTED		OUTPUT		
	# *******************************************************************
	
	#		[0]	[1]	[2]	[3]	[4]	[5]	[6]	[7]	[8]	[9]	[10]	[11]	[12]	[13]	[14]	[15]
	#	d: 	A,	B,	C,	D,	E,	F,	0,	1,	2,	3,	4,	5,	6,	7,	8,	9

	

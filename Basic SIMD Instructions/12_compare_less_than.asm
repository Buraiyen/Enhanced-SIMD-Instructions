# ***************************** 341 Top Level Module **********************************************************
#
# File name: 		11_compare_less_than.asm
# Verson:		1.0
# Date:			November 18, 2018
# Programmer:		Brian Nguyen
# Description: 		Each element of the result vector d is TRUE (all bits = 1) if the corresponding element of vector a is less than to the corresponding element of vector b. Otherwise
#			the element of result is FALSE (all bits = 0)
# 
# 				vec_cmpltu d, a, b
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
	la $a0, a	# initialize vector a
	la $a1, b	# initialize vector b
	la $a2, d	# initialize vector d

	li $t7, 0xFF	# load 0xFF
	
	lw $t3, size	# initialize the size of the vectors
	li $t4, 0	# initialize counter variable
	
	j loop
	
store:
	sw $t7, 0($a2)
	addi $a0,$a0, 4		# iterate to next element in vector a
	addi $a1,$a1, 4		# iterate to next element in vector b
	addi $a2, $a2, 4	# iterate to the next element in vector d
	b loop
	
loop:
	lw $t0, 0($a0)		# retrieve element from vector a
	lw $t1, 0($a1)		# retrieve element from vector b
	slt $t5, $t0, $t1	# if the element in vector a is less than the one in vector b, then the value of the current position is 0xFF
	bne $t5, $zero, store
	
	addi $a0,$a0, 4		# iterate to next element in vector a
	addi $a1,$a1, 4		# iterate to next element in vector b
	addi $a2, $a2, 4	# iterate to the next element in vector d
	addi $t4, $t4, 1
	bne $t3, $t4, loop
combine:
	
	subi $a2, $a2, 40
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

	# *******************************************************************
	#	PROJECT		RELATED		DATA		SECTION		
	# *******************************************************************

	.data	#		[0]	[1]	[2]	[3]	[4]	[5]	[6]	[7]
		a:	.word	0x5A,	0xFB,	0x6C,	0x1D,	0xA6,	0x5F,	0xC0,	0x40
		b: 	.word	0X52,	0XFB,	0XA4,	0X15,	0XAE,	0X5F,	0XC8,	0X41
		d: 	.space 	8
		size: 	.word 	6
		
	# *******************************************************************
	#		EXPECTED		OUTPUT		
	# *******************************************************************
	
	#		[0]	[1]	[2]	[3]	[4]	[5]	[6]	[7]
	#	d: 	0x00,	0x00,	0xFF,	0x00,	0xFF,	0x00,	0xFF,	0xFF

		
	

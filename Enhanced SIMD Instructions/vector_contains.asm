# ***************************** 341 Top Level Module **********************************************************
#
# File name: 		vector_contains.asm
# Verson:		1.0
# Date:			November 4, 2018
# Programmer:		Brian Nguyen
# Description: 		If an element in a vector contains a certain specified value, then store 0xFF in a new vector at that same index
# 
# 				vec_cnt d, a
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
	
	la $a0, vec_a
	la $a1, vec_d
	lw $t3, size
	li $t1, 0x01
	li $t2, 0xFF
	li $t4, 0
	j loop
	
store:
	sw $t2, 0($a1)
	addi $a0, $a0, 4
	addi $a1, $a1, 4
	addi $t4, $t4, 1
	beq $t3, $t4, exit
	b loop
loop:

	lw $t0, 0($a0)
	
	beq $t0, $t1, store
	addi $a0, $a0, 4
	addi $a1, $a1, 4
	addi $t4, $t4, 1
	bne $t3, $t4, loop
	

	
exit:
	ori $v0, $zero, 10	# $v0 <-- function code for "exit"
	syscall			# Syscall to exit

	
	# *******************************************************************
	#	PROJECT		RELATED		DATA		SECTION		
	# *******************************************************************

.data	#			[0]    [1]   	[2]	[3]	[4]	[5]	[6]	[7]
		vec_a:	.word	0xAB, 	0xCD,	 0x01,	 0x01, 	0x01, 	0xF3,	 0x61, 	0x01
		vec_d: 	.space 8
		size: 	.word 8

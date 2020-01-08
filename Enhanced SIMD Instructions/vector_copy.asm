# ***************************** 341 Top Level Module **********************************************************
#
# File name: 		vector_copy.asm
# Verson:		1.0
# Date:			November 4, 2018
# Programmer:		Brian Nguyen
# Description: 		The elements in a vector are copied into another empty vector
# 
# 				vec_cpy d, a
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
	li $t4, 0
	j loop
loop:
	lw $t0, 0($a0)
	sw $t0, 0($a1)
	
	addi $a0, $a0, 4
	addi $a1, $a1, 4
	addi $t4, $t4, 1
	bne $t3, $t4, loop
	
combine:
	lw $t0, 0($a0)
	lw $t1, 4($a0)
	sll $t0, $t0, 8
	sll $t0, $t0, 8
	add $t0, $t0, $t1
	lw $t1, 8($a0)
	lw $t2, 12($a0)
	sll $t1, $t1, 8
	sll $t1, $t1, 8
	add $t1, $t1, $t2
	
exit:	ori $v0, $zero, 10	# $v0 <-- function code for "exit"
	syscall			# Syscall to exit
	
	# *******************************************************************
	#	PROJECT		RELATED		DATA		SECTION		
	# *******************************************************************

	.data	
		vec_a:	.word	0xABCD, 0x1234, 0x5678, 0x9ABC
		vec_d: 	.space 4
		size: 	.word 4

# ***************************** 341 Top Level Module **********************************************************
#
# File name: 		vector_shift_left.asm
# Verson:		1.0
# Date:			November 4, 2018
# Programmer:		Brian Nguyen
# Description: 		The elements in a vector are shifted left once and placed into a new vector
# 
# 				vec_sll d, a
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
	la $a1, vec_d
	lw $t0, ($a0)
	lw $t3, size
	li $t4, 0
	li $t5, 0xFFFF
	j loop
	
overflow:
	sw $t5, 0($a1)
	addi $a0, $a0, 4
	addi $a1, $a1, 4
	addi $t4, $t4, 1
	beq $t3, $t4, combine
loop:
	lw $t0, 0($a0)
	sll $t0, $t0, 1
	slt $t2, $t5, $t0
	bne $t2, $zero, overflow
	sw $t0, 0($a1)
	
	addi $a0, $a0, 4
	addi $a1, $a1, 4
	addi $t4, $t4, 1
	bne $t3, $t4, loop
	
	
	
combine:
	mul $t3, $t3, 4
	sub $a1, $a1, $t3
	lw $t1, 0($a1)
	sll $t1, $t1, 8 
	sll $t1, $t1, 8 
	lw $t2, 4($a1)
	add $t1, $t1, $t2
	
	lw $t2, 8($a1)
	lw $t3, 12($a1)
	sll $t2, $t2, 8 
	sll $t2, $t2, 8
	
	add $t2, $t2, $t3
	
exit:
	ori $v0, $zero, 10	# $v0 <-- function code for "exit"
	syscall			# Syscall to exit
	
	# *******************************************************************
	#	PROJECT		RELATED		DATA		SECTION		
	# *******************************************************************

.data	#		[0]	[1]	[2]
		vec_a:	.word	0xABCD, 0x1234, 0x5678, 0x9ABC
		vec_d: 	.space 4
		size: 	.word 4

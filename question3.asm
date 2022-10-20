.data
PROMPT: .asciiz "Enter n and formulae:\n"
OUTPUT: .asciiz "The values are:\n"
CELULAS: .space 200 
VALORES: .space 80 
newline: .asciiz "\n"

.text
.globl main
.globl BREAK_LOOP_PRINT
.globl ASCII_TO_NUM
.globl NO_FORM

main:

	li $v0,4
	la $a0,PROMPT
	syscall
	

	li $v0,5
	syscall
	move $s0,$v0
	
	jal INPUT	
	jal CALC_PRINT
	

INPUT: 

	li $t0,0 
	la $t8,CELULAS

	loop_input:
		beq $t0,$s0, break_loop_input

		li $v0,8 
		move $a0,$t8 
		li $a1,20  
		syscall

		addi $t0,$t0,1
		addi $t8,$t8,10
	b loop_input
	break_loop_input:
	jr $ra

CALC_PRINT:	
	li $s1,0 

	li $v0,4
	la $a0,OUTPUT
	syscall

	move $t0,$s0
	la $t8,CELULAS
	la $s7,VALORES

LR_PRINT:
	beqz $t0, BREAK_LOOP_PRINT
	lb $t2, ($t8) 
	bne $t2, '=', NO_FORM 
		
		
		addi $a1, $t8, 1  	
		jal ASCII_TO_NUM
		
		
		li $t5,4
		mult $v1,$t5
		mflo $v1
		
		
		la $t7,VALORES 
		add $t7,$t7,$v1
		
		
		lw $a0,($t7)
		li $v0,1
		syscall
		
		
		sw $a0,($s7)
		addi $s7,$s7,4
		
		
		add $s1,$s1,$a0
		
		
		la $a0, newline 
      li $v0, 4   
		syscall
		
		
		addi $t0,$t0,-1
		addi $t8,$t8,10
		j LR_PRINT


NO_FORM:

	move $a1,$t8
	jal ASCII_TO_NUM

	li $v0,1
	move $a0,$v1
	syscall


	sw $a0,($s7)
	addi $s7,$s7,4
		

	add $s1,$s1,$v1

	 la $a0, newline 
    li $v0, 4 
	syscall
	addi $t0,$t0,-1
	addi $t8,$t8,10
	j LR_PRINT
	
BREAK_LOOP_PRINT:



	li $v0,1
	move $a0,$s1
	syscall
	j exit


ASCII_TO_NUM:


	addi $sp,$sp,-8
	sw $t0,($sp)
	sw $t1,4($sp)
	li $v1,0
	li $t0,0 

	CL:
	lb $t1,($a1)
	beq $t1,10,BCL

	addi $sp,$sp,-1
	sb $t1,($sp)

	addi $t0,$t0,1
	addi $a1,$a1,1
	j CL
	BCL:
	li $t2,1 
	loop_extract:
	beq $t0,$zero, BLEX

	lb $t1,($sp)
	addi $sp,$sp,1

	addi $t1,$t1,-48

	mult $t1,$t2
	mflo $t1

	add $v1,$v1,$t1

	addi $t0,$t0,-1

	li $t9,10
	mult $t2,$t9
	mflo $t2
	j loop_extract
	BLEX:

		lw $t0,($sp)
		lw $t1,4($sp)
		addi $sp,$sp,8
		jr $ra

	exit:
	li $v0,10
	syscall

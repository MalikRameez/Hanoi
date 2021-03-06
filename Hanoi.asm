.data
	

Prompt:  
	.asciiz "\nPlease enter the number of disks: "
Author:
	.asciiz "Author: Aaron Foltz\n"
AB:
	.asciiz "Move disk from A to B\n"
AC: 
	.asciiz "Move disk from A to C\n"
BC:
	.asciiz "Move disk from B to C\n"
BA:
	.asciiz "Move from disk B to A\n"
CAB:
	.asciiz "Move from disk C to B\n"
CA: 
	.asciiz "Move from disk C to A\n"
Exit:
	.asciiz "The disks have all been moved"
	

    .globl main
    .text
    
main:
    li $v0, 4 #Print author and program info
    la $a0, Author
    syscall
    
start:
    
    li  $v0, 4 #Print the prompt asking for number of disks
    la  $a0, Prompt
    syscall

    li $v0, 5
    syscall
    add $t0, $v0, $zero #loading number in $t0 
    
    move $a0, $zero	#clears arg register
    move $a1, $zero	#clears arg register
    move $a2, $zero	#clears arg register
    move $a3, $zero	#clears arg register
    
    move $a0, $t0	#places n in first arg reg
    addi $a1, $a1, 1	#Makes the arg registers hold the "tower number"
    addi $a2, $a2, 2
    addi $a3, $a3, 3
    
    addi $t3, $zero, 1	#makes $t3 = 1
    addi $t4, $zero, 2	#makes $t4 = 2
    addi $t5, $zero, 3	#makes $t5 = 3
    jal hanoi		#call hanoi for the first time
    
    
    li 	$v0, 4;      
    la 	$a0, Exit;    			
    syscall;
	
	hanoi:
	
	slti $t1, $a0, 1
	beq $t1, $t3, End	#if n<1, do nothing, end
	
	addi $sp, $sp, -20
	sw $ra, 0($sp)		#saves return address
	sw $a0, 4($sp)		#saves n on stack
	sw $a1, 8($sp)		#saves peg 1 on stack
	sw $a2, 12($sp)		#saves peg 2 on stack
	sw $a3, 16($sp)		#saves peg 3 on stack
	
	addi $a0, $a0, -1	#n = n-1
	

	move $t2, $a2		#saves a2
	move $a2, $a3		#Changes destination to middle peg
	move $a3, $t2		#changes middle peg to final peg

	
	jal hanoi		#First recursive call with pegs switched
	
	lw $ra, 0($sp)		#loads return address
	lw $a0, 4($sp)		#loads n
	lw $a1, 8($sp)		#loads peg 1
	lw $a2, 12($sp)		#loads peg 2
	lw $a3, 16($sp)		#loads peg 3
	add $sp, $sp, 20
	

	beq $a1, $t3, FromA	#if source is A
	beq $a1, $t4, FromB	#if source is B
	beq $a1, $t5, FromC	#if source is C

	
hanoi2:

	addi $sp, $sp, -20
	sw $ra, 0($sp)		#saves return address
	sw $a0, 4($sp)		#saves n
	sw $a1, 8($sp)		#saves peg 1
	sw $a2, 12($sp)		#saves peg 2
	sw $a3, 16($sp)		#saves peg 3
	
	move $t6, $a1		#saves a1 for peg switch
	move $t7, $a2		#saves a2 for peg switch
	
	move $a1, $a2		# Moves spare peg to source peg
	move $a2, $t6		# Moves source peg to spare peg		

	
	addi $a0, $a0, -1	#n = n-1
	jal hanoi		#second recursive call with pegs rearranged
	
	lw $ra, 0($sp)		#loads address after the first hanoi call
	addi $sp, $sp, 20
	jr $ra
	
FromA:
	beq $a3, $t4, PrintAB	#Source is A, Dest is B
	beq $a3, $t5, PrintAC	#Source is A, Dest is B
	
PrintAB:
	addi $sp, $sp, -4
	sw $a0, 0($sp)		#save a0
	li  $v0, 4 #Print the Move from A to B
	la  $a0, AB
	syscall
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	j hanoi2

PrintAC:
	addi $sp, $sp, -4
	sw $a0, 0($sp)		#save a0
	li  $v0, 4 #Print the Move from A to C
	la  $a0, AC
	syscall
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	j hanoi2
	
	FromB:
	beq $a3, $t3, PrintBA	#Source is B, Dest is A
	beq $a3, $t5, PrintBC	#Source is B, Dest is C

PrintBA:
	addi $sp, $sp, -4
	sw $a0, 0($sp)		#save a0
	li  $v0, 4 #Print the Move from B to A
	la  $a0, BA
	syscall
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	j hanoi2
PrintBC:
	addi $sp, $sp, -4
	sw $a0, 0($sp)		#save a0
	li  $v0, 4 #Print the Move from B to C
	la  $a0, BC
	syscall
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	j hanoi2
FromC:
	beq $a3, $t3, CA	#Source is C, Dest is A
	beq $a3, $t4, CB	#Source is C, Dest is B
	
PrintCA:
	addi $sp, $sp, -4
	sw $a0, 0($sp)		#save a0
	li  $v0, 4 #Print the Move from C to A
	la  $a0, CA
	syscall
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	j hanoi2

PrintCB:
	addi $sp, $sp, -4
	sw $a0, 0($sp)		#save a0
	li  $v0, 4 #Print the Move from C to B
	la  $a0, CB
	syscall
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	j hanoi2

	
End:
	jr $ra
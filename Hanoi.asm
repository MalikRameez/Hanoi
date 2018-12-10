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
   
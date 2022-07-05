# Title: Simple Calculator
# Author: Preston Nakamura
# Date: 3/6/2021
# Discription: Calculator for basic arithmetic with two inputs

.text
  .globl main
main:
	#Moves through a sequence of steps to perform the task
	jal displayMenu 
	jal getChoice

#Determins if input is addition. If true branch to addition. If false check next case.
CaseA:
	li $t1, '+'
	seq $t2, $t1, $t0 
	beqz $t2, CaseB
		b addition
	
#Determins if input is subtraction. If true branch to subtraction subprogram. If false check next case.	
CaseB:
	li $t1, '-'
	seq $t2, $t1, $t0 
	beqz $t2, CaseC
		b subtraction
	
#Determins if input is multiplication. If true branch to multiplication subprogram. If false check next case.	
CaseC:
	li $t1, '*'
	seq $t2, $t1, $t0 
	beqz $t2, CaseD
		b multiplication
	
#Determins if input is division. If true branch to division subprogram. If false check next case.	
CaseD:
	li $t1, '/'
	seq $t2, $t1, $t0 
	beqz $t2, CaseE
		b division
	
#Determins if input is modulus. If true branch to modulus subprogram. If false check next case.
CaseE:
	li $t1, '%'
	seq $t2, $t1, $t0 
	beqz $t2, CaseF
		b modulus
	
#Determins if input is quit. If true branch to quit subprogram. If false check next case.	
CaseF:
	li $t1, 'Q'
	seq $t2, $t1, $t0 
	beqz $t2, CaseG
		b quit
#If input is not recognized print error string and branch to start of program for new input.
CaseG:
	la $a0, error
	li $v0, 4
	syscall
		b main


.data		# Any Data needed for the main method
	error: .asciiz "\nInvalid input"
##############################################
# displayMenu Subprogram

.text
#Print out menue of simple calcualtor 
displayMenu:
	la $a0, menu
	li $v0, 4
	syscall

#Return to jal sequence
jr $ra
.data  # Any Data needed for displayMenu
menu: .asciiz "\n\nSimple Calculator\n +. Addition\n -. Subtraction\n *. Multiplication\n /. Division\n %. Modulus\n Q. Quit\n"
##############################################
# getChoice Subprogram

.text
getChoice:
	#Prompt user to select operator
	la $a0, choice
	li $v0, 4
	syscall

	#Read input from user
	li $v0, 12
	syscall
	move $t0, $v0 #$t0 has choice

	#Return to jal sequence
	jr $ra
.data
choice: .asciiz "Enter operator: "
##############################################
# getNum Subprogram

.text
getNum: 
	li $v0, 4
	syscall
	li $v0, 5 #Record user input
	syscall #Execute

	jr $ra
.data

##############################################
# addition Subprogram

.text
addition:
	#Load prompt and call subroutine getNum
	la $a0, numA1
	jal getNum #Jump to get the input number
	move $t4, $v0 #Num stored in $t4

	#Load prompt and call subroutine getNum
	la $a0, numA2
	jal getNum #Jump to get the input number
	move $t5, $v0 #num stored in $t5
	
	#Perform addition and store in $t6
	add $t6, $t4, $t5

	#Print result text and result
	la $a0, proA
	li $v0, 4
	syscall
	move, $a0, $t6
	li $v0, 1
	syscall

	#Return to top of program
	b main
.data
	numA1: .asciiz "\nEnter first addend: "
	numA2: .asciiz "Enter second addend: "
	proA: .asciiz "\nSum = "
##############################################
# subtraction Subprogram

.text
subtraction:
	#Load prompt and call subroutine getNum
	la $a0, numS1
	jal getNum #Jump to get the input number
	move $t4, $v0 #num stored in $t4

	#Load prompt and call subroutine getNum
	la $a0, numS2
	jal getNum #Jump to get the input number
	move $t5, $v0 #num stored in $t5
	
	#Perform subtraction and store in $t6
	sub $t6, $t4, $t5

	#Print product string and product
	la $a0, proS
	li $v0, 4
	syscall
	move, $a0, $t6
	li $v0, 1 
	syscall

	#Return to top of program
	b main
.data
	numS1: .asciiz "\nEnter subtrahend: "
	numS2: .asciiz "Enter minuend: "
	proS: .asciiz "\nDifference = "
##############################################
# multiplication Subprogram

.text
multiplication:
	#Load prompt and call subroutine getNum
	la $a0, numM1
	jal getNum #Jump to get the input number
	move $t4, $v0 #num stored in $t4

	#Load prompt and call subroutine getNum
	la $a0, numM2
	jal getNum #Jump to get the input number
	move $t5, $v0 #num stored in $t5

	#Perform multiplication and store in $t6
	mul $t6, $t4, $t5

	#Print return string and return value
	la $a0, proM
	li $v0, 4
	syscall
	move, $a0, $t6
	li $v0, 1 
	syscall

	b main
.data
	numM1: .asciiz "\nEnter multiplicand: "
	numM2: .asciiz "Enter multiplier: "
	proM: .asciiz "\nProduct = "
##############################################
# division Subprogram

.text
division:
	#Load prompt and call subroutine getNum
	la $a0, numD1
	jal getNum #Jump to get the input number
	move $t4, $v0 #num stored in $t4

	#Load prompt and call subroutine getNum
	la $a0, numD2
	jal getNum #Jump to get the input number
	move $t5, $v0 #num stored in $t5

	#Perfomr division and store result in $t6
	divu $t6, $t4, $t5

	#Print result text and result
	la $a0, proD
	li $v0, 4
	syscall
	move, $a0, $t6
	li $v0, 1 
	syscall

	#Return to start of program
	b main
.data
	numD1: .asciiz "\nEnter dividend: "
	numD2: .asciiz "Enter divisor: "
	proD: .asciiz "\nQuotient = "
##############################################
# modulus Subprogram

.text
modulus:
	#Load prompt and call subroutine getNum
	la $a0, numO1
	jal getNum #Jump to get the input number
	move $t4, $v0 #num stored in $t4

	#Load prompt and call subroutine getNum
	la $a0, numO2
	jal getNum #Jump to get the input number
	move $t5, $v0 #num stored in $t5

	#Perform Modulus and stores result in $t6
	divu $t4, $t5
	mfhi $t6

	#Load prompt and call subroutine getNum
	la $a0, proO
	move, $a0, $t6
	li $v0, 1 
	syscall

	#Return to the top of the program
	b main
.data
	numO1: .asciiz "\nEnter dividend: "
	numO2: .asciiz "Enter divisor: "
	proO: .asciiz "\nRemainer = "
##############################################
# quit Subprogram

.text
quit:
	#Print bye text
	la $a0, bye 
	li $v0, 4
	syscall

	#Exit smoothly
	li $v0, 10
	syscall

.data
	bye: .asciiz "\nBye bye :)"

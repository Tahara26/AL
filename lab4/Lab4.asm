# Justin Tahara 10/22/17
# Due 11/12/17
# Lab 4 - Prime Finder
# 02C Michael Powell

.data 
Number: .asciiz "Enter your number: "
comma: .asciiz ", "

.text

main:
   
	li 	$v0, 4		# Sets up the displaying message
	la 	$a0, Number	# Reads the message and stores in a0
	syscall			# Do the syscall

	li 	$v0, 5		# Takes in the user input
	syscall			# Do the syscall
	move	$t0, $v0	# Takes the integer the user inputted and stores in t0
	
	li 	$t1, 2		# Sets the Numerator to 2
	li	$t2, 1		# Sets the Denominator to 1
loop:
	addi  	$t2, $t2, 1	# Adds 1 to the value of the Denominator
	beq     $t1, 2, print2	# Code that skips the first comma
	div 	$t1, $t2	# Divides the Numerator by the Denominator
	mfhi	$t7		# Stores the remainder in register t7
	beq	$t2, $t1, print	# If the Numerator equals the Denominator just jump to print
	beq 	$t7, 0, adder	# If the number is divisble by numbers other than itself move to the next number
	j	loop		# Restart the loop for next Denominator
	
adder: 
	addi	$t1, $t1, 1	# Inceases the Numerator by 1 
	li	$t2, 1		# Resets the Denominator to 1
	bgt  	$t1, $t0, end	# If the Numerator is greater than the user input then end the code
	j	loop		# Jumps back to the loop for the next Numerator
	
print:
	li 	$v0, 4		# Sets up syscall for adding a comma
	la 	$a0, comma 	# Calls the phrase to print a comma and a space
	syscall			# Do the syscall
print2:
	li 	$v0, 1		# Sets up sycall for printing integers
	la	$a0, ($t1)	# Moves the value in t1 to a0
	syscall			# Do the syscall
	addi	$t1, $t1, 1	# Increases the Numerator by 1
	bgt 	$t1, $t0, end	# If the Numerator is greater than the user input then end the code
	li	$t2, 1		# Resets the Denominator to 1
	j 	loop		# Jumps back to loop to start next number
	
end:
	li 	$v0, 10		# Ends the program
	syscall			# Do the syscall


# Justin Tahara 10/22/17
# Due 11/26/17
# Lab 5 - Vigenere Cipher
# 02C Michael Powell

.data 
Key: 		.asciiz "The given key is: "
Text:		.asciiz "The given text is: "
Encrypt: 	.asciiz "The encrypted text is: "
Decrypt: 	.asciiz "The decreypted text is: "
NL: 		.asciiz "\n"

.text
main:
	lw	$t0, ($a1)	# Loads the given key in $t0
	lw 	$t1, 4($a1)	# Loads the given text in $t1
	li 	$v0, 4		# Sets up the displaying message
	la 	$a0, Key	# Reads the message and stores in a0
	syscall			# Do the syscall
	la 	$a0, ($t0)	# Puts the user's key next to the text
	syscall			# Do the syscall
	li	$v0, 4		# Sets up for new line
	la	$a0, NL		# Creates new line
	syscall			# Do the syscall
	li 	$v0, 4		# Sets up the displaying message
	la 	$a0, Text	# Reads the message and stores in a0
	syscall			# Do the syscall
	la 	$a0, ($t1)	# Puts the user's input text next to the text
	syscall			# Do the Syscall
	li	$v0, 4		# Sets up for new line
	la	$a0, NL		# Creates new line
	syscall			# Do the syscall
	li 	$v0, 4		# Sets up the displaying message
	la 	$a0, Encrypt	# Prints next message
	syscall			# Do the syscall
	move	$t2, $t0	# Make a copy of the key in a separate terminal
	move  	$t3, $t1	# Make a copy of the text in a separate terminal

Encode:
	lb 	$t4, ($t2)	# Takes the byte from the input key
	lb	$t5, ($t3)	# Takes the byte from the input text
	beqz	$t4, Looper	# Jumps to the looper if the byte in the key equals zero
	beqz	$t5, Message	# Jumps to the next part if the text string ends
	add	$t6, $t5, $t4 	# Adds the byte from the key and text
	div 	$t7, $t6, 128	# Divides the sum by 128 which is the total amount of ascii values
	mfhi 	$t7		# Stores the remainder in $t7
	li  	$v0, 11		# Sets up to print out the ascii character
	move 	$a0, $t7	# Move the value from $t7 to $a0
	syscall			# Do the syscall
	addi	$t2, $t2, 1	# Shift the byte of the key
	addi	$t3, $t3, 1 	# Shift the byte of the text
	j	Encode		# Jump back to the loop

Looper:	
	move	$t2, $t0	# Resets the key	
	j	Encode		# Jump back to the loop
		
Message:
	move	$t2, $t0	# Resets the key 
	move	$t3, $t1	# Resets the text
	li	$v0, 4		# Sets up for new line
	la	$a0, NL		# Creates new line
	syscall			# Do the syscall
	li 	$v0, 4		# Sets up the displaying message
	la 	$a0, Decrypt	# Prints the next message on the new line
	syscall			# Do the syscall
	
Decode:		
	lb 	$t4, ($t2)	# Takes the byte from the input key
	lb	$t5, ($t3)	# Takes the byte from the input text
	beqz	$t4, Looper2	# Jumps to the looper if the byte in the key equals zero
	beqz	$t5, End	# Jumps to the end if the text byte ends
	add	$t6, $t4, $t5	# Adds the byte of the key and text
	div 	$t7, $t6, 128	# Divides the sum by 128 which is the total amount of ascii values
	mfhi 	$t7		# Stores the remainder in $t7
	sub	$t7, $t7, $t4	# Subtracts the key from the encrypted ascii value
	bgez 	$t7, Print	# If number is positive jump without adding 128
	add	$t7, $t7, 128	# Adds 128 back to the value 
Print:
	li  	$v0, 11		# Sets up to print out the ascii value
	move 	$a0, $t7	# Move the value from $t7 to $a0
	syscall			# Do the syscall
	addi	$t2, $t2, 1	# Shift the byte of the key
	addi	$t3, $t3, 1 	# Shift the byte of the text
	j	Decode		# Jumps back to the loop

Looper2:	
	move	$t2, $t0	# Resets the key 
	j	Decode		# Jumps back to the loop
				
End:
	li 	$v0, 10		# Ends the program
	syscall			# Do the syscall
	

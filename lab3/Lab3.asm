# Justin Tahara 10/22/17
# Due 11/01/17
# Lab 3 - Decimal Converter
# 02C Michael Powell

			
					# Data for the program
.data
hello: .asciiz 				"Welcome to the Converter\n"
input: .asciiz				"Input Number: "
new_line: .asciiz 			"\n"
output: .asciiz				"Output Number: "

.text
main:
	move	$s0,$a1
	lw	$s0,($s0)
	la	$a0, hello 		# Load the addr of hello into $a0.
	li	$v0, 4 			# 4 is the print_string syscall.
	syscall 			# Do the syscall.
	la 	$a0, input		# Load the addr of input into $a0
	syscall				# Do the syscall.
	la 	$a0, ($s0)		# Puts the user's input number next to the text
	syscall				# Do the syscall and put the number the user inputted	
	la 	$a0, new_line		# Sets up a new line for the output line
	syscall				# Do the syscall
	la	$a0, output		# Output message is displayed 
	syscall				# Do the syscall
	
	li	$t9, 45			# Stores the ascii value of "-" in t9
	lb	$t8, ($s0)		# Loads the value or user input in t8
	beq 	$t9, $t8, negative	# Checks if value at the first bit is "-" and if it is jumps
					# To the negative loop, but if not just proceeds				
					
positive:
	andi	$t0, $t0, 0
	add	$t3, $t3, $t4
	add 	$t0, $s0, $t3		# Adds value that has been iterated
	sub	$t3, $t3, $t4		# This line just returns t3 to it's correct value
	lb 	$t1, ($t0)		# Loads address of the iterated bit
	and	$t0, $t0, $zero		# Sets the t0 terminal to null
	beq	$t1, $t0, convert	# If the loaded bit is '/0', then the conversion is over and jumps to convert
	addi	$t3, $t3, 1		# Iterate the integer length
	addi	$t1, $t1, -48		# Converts from the ascii value to decimal by subtracting 48
	andi	$t0, $t0, 0		# This line is in the process of setting t0 to be equal to 10 
	add	$t0, $t0, 10		# Because of the previous line we can then multiply
	mult	$t2, $t0		# t2(converted extracted bit) is multiplied by 10
	mflo	$t2			# Needed to add the last integer
	add	$t2, $t1, $t2		# Multiplication process is complete
	j 	positive		# Jumps to the beginning of positive loop 

negative:
	andi	$t0, $t0, 0
	add	$t3, $t3, $t4
	add 	$t0, $s0, $t3		# Adds value that has been iterated
	sub	$t3, $t3, $t4		# This line just returns t3 to it's correct value
	lb 	$t1, 1($t0)		# Loads the bit after the "-" and starts the conversion
	and	$t0, $t0, $zero		# Sets the t0 terminal to null
	beq	$t1, $t0, twosc		# If the loaded bit is '/0', then the conversion is over and jumps to twosc
	addi	$t3, $t3, 1		# Iterate the integer length
	addi	$t1, $t1, -48		# Converts from the ascii value to decimal by subtracting 48
	andi	$t0, $t0, 0		# This line is in the process of setting t0 to be equal to 10 
	add	$t0, $t0, 10		# Because of the previous line we can then multiply
	mult	$t2, $t0		# t2(converted extracted bit) is multiplied by 10
	mflo	$t2			# Needed to add the last integer
	add	$t2, $t1, $t2		# Multiplication process is complete
	j	negative		# Jumps to the beginning of negative loop

twosc:
	not	$t2, $t2		# Makes the converted number negative
	add	$t2, $t2, 1		# Adds a 1 to make sure the values match its negative counterpart
	
convert:
	andi 	$t0, $t0, 0		# These set of andi and addi functions moves the bits and cleans out the 
	addi 	$t1, $t1, 0		# Terminals in order to keep track of the value for the binary converter
	addi 	$t1, $t2, 0		
	andi 	$t2, $t2, 0		
	addi	$t3, $t3, 0		
	andi	$t4, $t4, 0		
	
	
	add	$t0, $zero, $a0		# Put the input value into the t0 terminal
	addi 	$t3, $zero, 1		# The 1 is loaded as a mask
	sll 	$t3, $t3, 31		# Using shift left logical we move the mask to right position
	addi 	$t4, $zero, 32		# A counter that loops through the numbers 
loop:

	and 	$t2, $t1, $t3		# This line ands the user input with the mask we set up earlier
	beq 	$t2, $zero, print	# Branches off to print if its the value equals 0
	addi 	$t2, $zero, 1		# Just adds a 1 in $t1
	j 	print			# Jumps to print 

print:	
	li  	$v0, 1			# Stores 1 into the v0 terminal
	move 	$a0, $t2		# Move the value from t2 to a0
	syscall				# Do the syscall
	srl 	$t3, $t3, 1		# Shifts the number to the right to print the next number
	addi 	$t4, $t4, -1		# Subtracts a 1 from the t4 to reset it 
	bne	$t4, $zero, loop	# Goes back to the printing loop

exit:
	li	 $v0, 10 		# 10 is the exit syscall.
	syscall 			# do the syscall.
					

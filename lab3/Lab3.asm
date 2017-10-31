# Justin Tahara 10/22/17

.data
hello: .asciiz 				"Welcome to the Converter\n"
user_input: .asciiz			"Input Number: "
new_line: .asciiz 			"\n"
output: .asciiz				"Output Number: "

.text
main:
	move	 $s0,$a1
	lw	 $s0,($s0)
	la	 $a0, hello 		# load the addr of hello into $a0.
	li	 $v0, 4 		# 4 is the print_string syscall.
	syscall 			# do the syscall.
	la 	 $a0, user_input	# load the addr of user_input into $a0
	syscall				# do the syscall.
	la 	 $a0, ($s0)		# puts the user's input number next to the text
	syscall				# do the syscall and put the number the user inputted	
	la 	 $a0, new_line		# sets up a new line for the output line
	syscall				# do the syscall
	la	 $a0, output		# output message displayed 
	syscall				# do the syscall
	
	
	loop:
	
	addi 	 $t0, $t0, 0
	beq 	 $t0, 45, negative
	and	 $s2, $t0, 0
	beq 	 $t0, $s2, 
	
	
	
	
	
	negative: 
	
	
	
	li	 $v0, 10 		# 10 is the exit syscall.
	syscall 			# do the syscall.
					# Data for the program:



.data
name: .asciiz "Reversible primes:\n"
newLine:	.asciiz		"\n"

.globl main
.text 

main: 	addi $sp,$sp, -60
	sw $a0, 56($sp)
	sw $s3, 52($sp)
	sw $s2, 48($sp)
	sw $s1, 44($sp)
	sw $s0, 40($sp)
	sw $v0, 36($sp)
	sw $ra, 32($sp)
	sw $t7, 28($sp)
	sw $t6, 24($sp)
	sw $t5, 20($sp)
	sw $t4, 16($sp)
	sw $t3, 12($sp)
	sw $t2, 8($sp)
	sw $t1, 4($sp)	
	sw $t0, 0($sp)
	
	li $v0,4
	la $a0, name

	addi $t0,$t0,0 		# count = 0
	addi $s0,$s0,1 		# Pinteger = 1
	addi $s2,$s2,0 		# squareRNum = 0
	addi $s3,$s3,0 		# reverse_square = 0
	
Loop4:	slti $t1,$t0,12
	beq $t1,$zero, EXIT
	
	move $a0,$s0 		# $a0 = $s0
	jal  reverse_number 	# function call: reverse_number($a0)
	move $s1, $v0 		# $s1 = $v0. store return value in register $s1
	
	jal isPerfect 		# function call: isPerfect($a0)
	move $t2, $v0 		# move result into register $t2
	addi $t7,$zero,1 	# set $t1 to 1
	bne $t2, $t7,increment 	# if $t2 != $t7 branch to exit
	
	move $a0, $s1 		# $a0 = $s1 
	jal isPerfect  		# function call: isPerfect($a0)
	move $t3, $v0 		# copy result to $t3
	bne $t3, $t7, increment # if $t3 != $t7, branch to increment
	
	move $a0,$s0 		# $a0 = $s0
	jal sqrt  		# function call: sqrt($a0)
	move $s2,$v0 		# copy result into $s2
	
	move $a0,$s1 		# $a0 = $s1
	jal sqrt  		# function call: sqrt($a0)
	move $s3,$v0 		# copy result into $s3
	
	move $a0,$s2 		# $a0 = $s2
	jal isPrime  		# function call: isPrime($a0)
	move $t4,$v0 		# copy result into $t4
	
	bne $t4,$t7,increment 	# if $t4 != $t7, branch to increment
	
	move $a0,$s3 		# $a0 = $s3
	jal isPrime  		# function call: isPrime($a0)
	move $t5, $v0  		# copy result into $t5
	
	bne $t5,$t7,increment  	# if $t5 != $t7, branch to increment
	
	move $a0, $s0  		# $a0 = $s0
	jal palindrome   	# function call: palindrome($a0)
	move $t6, $v0   	# copy result into $t6
	
	bne $t6,$zero, increment   # if $t6 != 0, branch to increment
	
	li $v0, 4
	la $a0, newLine
	syscall
	# something has to come here
	
increment: addi $s0,$s0,4
	j Loop4
	
EXIT:	lw $a0,56($sp)
	lw $s3, 52($sp)
	lw $s2, 48($sp)
	lw $s1, 44($sp)
	lw $s0, 40($sp)
	lw $v0, 36($sp)
	lw $ra, 32($sp)
	lw $t7, 28($sp)
	lw $t6, 24($sp)
	lw $t5, 20($sp)
	lw $t4, 16($sp)
	lw $t3, 12($sp)
	lw $t2, 8($sp)
	lw $t1, 4($sp)	
	lw $t0, 0($sp)
	
	addi $sp,$sp, 60

isPrime: addi $sp,$sp,-32  	# add memory address in stack 
	sw $v0,28($sp)
	sw $ra,24($sp)
	sw $a0,20($sp)
	sw $t4,16($sp)
	sw $t3,12($sp)
	sw $t2,8($sp)
	sw $t1,4($sp)
	sw $t0,0($sp)
	
	bne $a0,$zero,FL 	# branch if number != 0

	addi $t4,$zero,1

	bne $a0,$t4,FL  	# branch if number != 1
	
	add $t0,$zero,$zero 	# prime = 0 
	
FL:	addi $t2, $zero, 2 	# index = 2
	div $a0,$t2  		# number/ 2
	mflo $t3 		# $t3 = number/ 2
	
	slt $t4,$t3,$t2 	# $t4 = 0 if $t3 > $t1
	bne $t4,$zero,IF_1 	# branch if $t4 != 0
	
	div $a0,$t2 		# number % index
	mfhi $t4 		# $t4 =  number % index
	
	bne $t4,$zero,ELSE 	# if number % index != 0 go to ELSE
	add $t0,$zero,$zero 	# $t0 = 0
	
ELSE:   addi $t0, $zero, 1  	# $t0 = 0 + 1

	addi $t2,$t2,4 		# $t1 += 1
	j FL 			# goto FL

IF_1:	bne $t0,$t4,ELSE1_2 	# go to ELSE1_2 if prime != 1
	add $v0,$t0,$zero 	# return output to caller
	
ELSE1_2: addi $v0,$t0,1
	
	
	lw $v0,28($sp)
	lw $ra,24($sp)
	lw $a0,20($sp)
	lw $t0,16($sp)
	lw $t1,12($sp)
	lw $t2,8($sp)
	lw $t3,4($sp)
	lw $t4,0($sp)

	addi $sp,$sp,32
	
	jr $ra 			# return to caller
	
palindrome: addi $sp,$sp,-36   	# add memory address in stack 
	
	sw $a0,32($sp)
	sw $ra,28($sp)
	sw $v0,24($sp)
	sw $t5,20($sp)
	sw $t4,16($sp)
	sw $t3,12($sp)
	sw $t2,8($sp)
	sw $t1,4($sp)
	sw $t0,0($sp)
	
	move $t5,$a0 		# copy $a0 content into $t5(value)
	
while_loop: add $t0, $zero, $zero	 # reversed = 0
	add $t2,$t5,$zero	# original = value
	bne $t5,$zero,IF 	# branch if value != 0
	addi $t3,$zero,10 	# $t3 = 10
	div $t5,$t3
	mfhi $t1 		# remainder = value % 10
	
	mul $t4, $t0, $t3 	# $t4 = reversed * 10
	add $t0, $t4, $t1 	# reversed = reversed * 10 + remainder
	
	div $t5,$t3
	mflo $t5 		# value /= 10
	j while_loop 		# go to while loop
	
IF: 	bne $t2,$t0,ELSE1 	# go to ELSE if $t2 != $t0
	addi $v0,$zero,1  	# return 1
	
ELSE1:	add $v0,$zero,$zero 	# return 0

	lw $a0,32($sp)
	lw $ra,28($sp)
	lw $v0,24($sp)
	lw $t5,20($sp)
	lw $t4,16($sp)
	lw $t3,12($sp)
	lw $t2,8($sp)
	lw $t1,4($sp)
	lw $t0,0($sp)
	addi $sp,$sp,36
	
	jr $ra
	
reverse_number: addi $sp,$sp,-32
		
	sw $a0,28($sp)
	sw $ra,24($sp)
	sw $v0,20($sp)
	sw $t4,16($sp)
	sw $t3,12($sp)
	sw $t2,8($sp)
	sw $t1,4($sp)
	sw $t0,0($sp)
	
	li $t0,0 		#reversed = 0
	move $t4,$a0
L1:	beq $t4,$zero,S1	# if $a0 = 0, branch to S1
	addi $t2,$zero,10 	# $t2 = 10
	div $t4,$t2 		# integer % 10
	mfhi $t1 		# remainder = integer % 10
	
	mult $t0,$t2 		# reversed * 10
	mflo $t3  		# $t3 = reversed * 10
	add $t0,$t3,$t1 	# reversed = reversed * 10 + remainder
	
	div $t4,$t2  		# $a0/$t2
	mflo $t4		# $a0 = $a0/ $t2
	j L1
	
S1: 	add $v0, $zero, $a0

	lw $a0,28($sp)
	lw $ra,24($sp)
	lw $v0,20($sp)
	lw $t4,16($sp)
	lw $t3,12($sp)
	lw $t2,8($sp)
	lw $t1,4($sp)
	lw $t0,0($sp)
	addi $sp,$sp,32

	jr $ra
	
isPerfect: addi $sp,$sp,-40
	
	sw $a0,36($sp)
	sw $ra,32($sp)
	sw $v0,28($sp)
	sw $t6,24($sp)
	sw $t5,20($sp)
	sw $t4,16($sp)
	sw $t3,12($sp)
	sw $t2,8($sp)
	sw $t1,4($sp)
	sw $t0,0($sp)
	
	move $t6,$a0		# num stored in $t6
	addi $t0,$zero,1	# index = 1
	add $t5,$zero,$zero 	# output = 0
	
L2: 	mul $t1,$t0,$t0 	# $t1 = index * index
	
	slt $t2,$t6,$t1 	# $t2 = 0 if num <= $t1
	bne $t2,$zero,S2	# branch to S2 if $t2 = 0
	
	div $t6,$t0 		# num % $t0
	mfhi $t3 		# $t3 = num % index
	
	bne $t3,$zero,ELSE3 	# branch tp ELSE3 if $t3 != 0
	
	mflo $t4 		# $t4 = num / index
	
	bne $t4,$t0,ELSE3  	# branch tp ELSE3 if $t4 != $t0
	addi $t5,$zero,1 	# $output = 1
	add $v0,$t5,$zero 	# $v0 = output
	
	add $t0,$t0,4
	j L2
	
ELSE3:	addi $t5,$t5,0 		# output = 0
	add $v0,$t5,$zero
	
	add $t0,$t0,4 		# index += 1
	j L2

S2:	add $v0,$zero,$zero
	
	lw $a0,36($sp)
	lw $ra,32($sp)
	lw $v0,28($sp)
	lw $t6,24($sp)
	lw $t5,20($sp)
	lw $t4,16($sp)
	lw $t3,12($sp)
	lw $t2,8($sp)
	lw $t1,4($sp)
	lw $t0,0($sp)
	addi $sp,$sp,40
	
	jr $ra
	
sqrt:	addi $sp,$sp,-48
	sw $a0,44($sp)
	sw $v0,40($sp)
	sw $ra,36($sp)
	sw $s0,32($sp)
	sw $t7,28($sp)
	sw $t6,24($sp)
	sw $t5,20($sp)
	sw $t4,16($sp)
	sw $t3,12($sp)
	sw $t2,8($sp)
	sw $t1,4($sp)
	sw $t0,0($sp)
	
	move $t2,$a0 
	addi $t0,$zero,2 
	div $t2,$t0
	mflo $t1 		# sqrt = num / 2 
	
	add $t3,$zero,$zero 	# temp = 0
	
Loop3:	bne $t1,$t3,EXIT3
	
	add $t3,$zero,$t1 	# temp = sqrt
	
	div $t2,$t3 		# num/temp
	mflo $t4
	
	add $t5,$t4,$zero 	# $t5 = num/temp
	add $t6,$t5,$t3 	# $t6 = num/temp + temp
	
	addi $t7,$zero,2
	div $t7,$t6 		# (num/temp + temp)/2
	mflo $s0 		# $s0 =  (num/temp + temp)/2
	
	add $t1,$s0,$zero 	# sqrt = (num/temp + temp)/2
	
	j Loop3
	
	add $v0,$t1,$zero
	
EXIT3:	lw $a0, 44($sp)
 	lw $v0, 40($sp)
	lw $ra, 36($sp)
	lw $s0, 32($sp)
	lw $t7, 28($sp)
	lw $t6, 24($sp)
	lw $t5, 20($sp)
	lw $t4, 16($sp)
	lw $t3, 12($sp)
	lw $t2, 8($sp)
	lw $t1, 4($sp)	
	lw $t0, 0($sp) 
	
	addi $sp,$sp,48
	
	jr $ra
	
	
	
	
	

	.data
		readA: .asciiz "Give me the first Integer: "
		readB: .asciiz "Give me the second Integer: "
		MKD: .asciiz "Who you think is the highest common factor of these 2 Integers?\n> "
		correct: .asciiz "Congratulations"
		false: .asciiz "False. Try Again!"
		answer: .asciiz "\nThe HCF is: "

	.text
	.globl main
main:
	la $a0,readA			# read first
	li $v0,4
	syscall

	li $v0,5
	syscall

	move $s0,$v0			#save the first

	la $a0,readB			# read second
	li $v0,4
	syscall

	li $v0,5
	syscall

	move $s1,$v0			#save the second

	jal find			#jump to Highest Common Factor function

	la $a0,MKD
	li $v0,4
	syscall

	li $v0,5			# the user gives his answer
	syscall

	move $s3,$v0			#save the result and the answer we give
	move $s4,$v1

	beq $v0,$v1,true		# if the answer is the same as the result, go to true.

	la $a0,false			# else false
	li $v0,4			# print "False. Try again!"
	syscall
	j exit


true:
	la $a0,correct			# print "Congratulations."
	li $v0,4
	syscall
	j exit

exit:					# exit
	la $a0,answer			#print the HCF
	li $v0,4
	syscall

	move $a0,$s4
	li $v0,1
	syscall

	li $v0,10			#end program
	syscall

find:					#find function
	rem $t0,$s0,$s1			# y = a%b ( the Highest Common Factor )
	loop:
		beq $t0,0,ok		# while y != 0
		addi $s0,$s1,0		# a = b
		addi $s1,$t0,0		# b = y
		rem $t0,$s0,$s1		# y = a%b
		j loop			# next loop

ok:
	addi $v1,$s1,0			# return the result y ( y = highest common factor )
	jr $ra

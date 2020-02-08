	.data
		diabasea: .asciiz "Give me the first Integer: "
		diabaseb: .asciiz "Give me the second Integer: "
		MKD: .asciiz "Who you think is the highest common factor of these 2 Integers?\n> "
		correct: .asciiz "Congratulations"
		false: .asciiz "False. Try Again!"

	.text
	.globl main
main:
	la $a0,diabasea
	li $v0,4
	syscall

	li $v0,5
	syscall

	move $s0,$v0

	la $a0,diabaseb
	li $v0,4
	syscall

	li $v0,5
	syscall

	move $s1,$v0

	jal find

	la $a0,MKD
	li $v0,4
	syscall

	li $v0,5
	syscall

	move $s3,$v0

	beq $v0,$v1,true

	la $a0,false
	li $v0,4
	syscall
	j exit


true:
	la $a0,correct
	li $v0,4
	syscall
	j exit

exit:
	li $v0,10
	syscall

find:
	rem $t0,$s0,$s1
	loop:
		beq $t0,0,ok
		addi $s0,$s1,0
		addi $s1,$t0,0
		rem $t0,$s0,$s1
		j loop

ok:
	addi $v1,$s1,0
	jr $ra
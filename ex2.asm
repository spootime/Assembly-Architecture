# Starter file for ex1.asm

.data 0x0
magic: .space 5 		# more than enough space to read in "P3\n" plus null
numstr: .asciiz "P3\n"
newline: .asciiz "\n"
        
.text 0x3000

main:
	

	la $a0, numstr #print pre-made P2 Statement
	li $v0, 4
	syscall

	addi $v0, $0, 5 #take x1 input from user
	syscall
	add $s0, $zero, $v0 #store in $s0
	
	addi $v0, $0, 5 #take x2 input from user
	syscall
	add $s1, $zero, $v0 #store in $s1
	
	addi $v0, $0, 5 #take y1 input from user
	syscall
	add $s6, $zero, $v0 #store in $s6
	
	addi $v0, $0, 5 #take y2 input from user
	syscall
	add $s7, $zero, $v0 #store in $s7

	addi $v0, $0, 5 #take col input from user
	syscall
	add $s2, $zero, $v0 #store in $s2

	
	addi $v0, $0, 5 #take row input from user
	syscall
	add $s3, $zero, $v0 #store in $s3

	addi $v0, $zero, 1	
	add $a0, $zero, $s2 #print column
	syscall

	addi 	$v0, $0, 4  			# print newline
	la 	$a0, newline 			
	syscall    
	
	addi $v0, $zero, 1	
	add $a0, $zero, $s3 #print row
	syscall
	
	addi 	$v0, $0, 4  			# print newline
	la 	$a0, newline 			
	syscall
	
	addi $v0, $0, 5 #take 255 input from user
	syscall
	add $s4, $zero, $v0 #store in $s4
	
	addi $v0, $zero, 1	
	addi $a0, $zero, 255 #print 255
	syscall
	
	addi 	$v0, $0, 4  			# print newline
	la 	$a0, newline 			
	syscall


	#------------------------------------------------------------#
	# Write code here to do exactly what main does in the C program.
	# That is, read and write the magic numbers,
	# read and write the number of cols and rows,
	# and read and write the ppm_max values.  The output's
	# magic number will be "P2".  And, regardless of the input's
	# ppm_max, the output will always have 255 as its ppm_max.
	#------------------------------------------------------------#


	#------------------------------------------------------------#
	# Write code here to implement the double-for loop of the C
	# program, to iterate through all the pixels in the image.
	#
	# The actual conversion from RGB to gray value of a single
	# pixel must be done by a separate procedure called rgb_to_gray
	#------------------------------------------------------------#
	add $s5, $zero, $zero
	Loop1:
	beq $s5, $s3, end #row loop
	add $t7, $zero, $zero
	   Loop2:
	     beq $t7, $s2, endloop2 #col loop
	     
	     
	     addi $v0, $0, 5 
	     syscall
	     add $a0, $zero, $v0 #red argument
	     
	     addi $v0, $0, 5 
	     syscall
	     add $a1, $zero, $v0 #green argument
	     
	     addi $v0, $0, 5 
	     syscall
	     add $a2, $zero, $v0 #blue argument
	     
	     add $a3, $zero, $s4 #255 argument
	     
	     slt $t4, $t7, $s0 # t7 = j, s0 = x1
	     beq $t4, 1, grayline
	     beq $t7, $s0, nextEQ1
	     beq $t4, $zero, nextEQ1
	     
	     nextEQ1:
	     slt $t4, $t7, $s1 # t7 = j, s1 = x2 
	     beq $t4, 1, nextEQ2
	     beq $t7, $s1, nextEQ2
	     beq $t4, $zero, grayline
	     
	     nextEQ2:
	     slt $t4, $s5, $s6 # s5 = i, s6 = y1
	     beq $t4, 1, grayline
	     beq $s5, $s6, nextEQ3
	     beq $t4, $zero, nextEQ3
	     
	     nextEQ3:
	     slt $t4, $s5, $s7 # s5 = i, s7 = y2
	     beq $t4, 1, nextEQ4
	     beq $s5, $s7, nextEQ4
	     beq $t4, $zero, grayline
	     
	     nextEQ4:
	     jal rgbprint
	     addi $t7, $t7, 1
	     b Loop2
	     
	     
	     
	     grayline: 
	     jal	rgb_to_gray
	     addi $t7, $t7, 1
	     b Loop2
	     
  	     b Loop2
	endloop2:
	addi $s5, $s5, 1
	b Loop1
	

end: 
	ori   $v0, $0, 10     # system call 10 for exit
	syscall               # exit



rgb_to_gray:
	#------------------------------------------------------------#
	# $a0 has r
	# $a1 has g
	# $a2 has b
	# $a3 has ppm_max
	#
	# Write code to compute gray value in $v0 and return.
	#------------------------------------------------------------#
	li $t1, 30
    mult $t1, $a0
    mflo $t2 #take R mult by 30 and store in t2

    li $t1, 59
    mult $t1, $a1
    mflo $t3 #take G bult by 59 and store in t3

    li $t1, 11
    mult $t1, $a2
    mflo $t4 #take B mult by 11 and store in t4

    add $t5, $t2, $t3 # R + G = t5
    add $t5, $t5, $t4 # t5 + B = t5

    li $t1, 255
    mult $t5, $t1
    mflo $t5 #255 * (R+G+B)

    li $t1, 100
    mult $t1, $a3
    mflo $t6 # 100 * ppm_max

    div $t5, $t6 # divide 255*RGB / 100*ppm_max
    mflo $v0 #return value?
    addi $t5, $v0, 0
    
    addi $v0, $0, 1
    add $a0, $0, $t5
    syscall

    addi 	$v0, $0, 4  			# print newline
    la 	$a0, newline 			
    syscall
    
    addi $v0, $0, 1
    add $a0, $0, $t5
    syscall

    addi 	$v0, $0, 4  			# print newline
    la 	$a0, newline 			
    syscall
    
    addi $v0, $0, 1
    add $a0, $0, $t5
    syscall

    addi 	$v0, $0, 4  			# print newline
    la 	$a0, newline 			
    syscall


	jr	$ra
	
rgbprint:
	add $t0, $zero, $a0
	add $t1, $zero, $a1
	add $t2, $zero, $a2 
	add $t8, $v0, 0
	
	
	addi $v0, $0, 1
	add $a0, $0, $t0 # print rgb value
	syscall
	     
	addi 	$v0, $0, 4  			# print newline
	la 	$a0, newline 			
	syscall
	
	addi $v0, $0, 1
	add $a0, $0, $t1 # print rgb value
	syscall
	     
	addi 	$v0, $0, 4  			# print newline
	la 	$a0, newline 			
	syscall
	
	addi $v0, $0, 1
	add $a0, $0, $t2 # print rgb value
	syscall
	     
	addi 	$v0, $0, 4  			# print newline
	la 	$a0, newline 			
	syscall
	
		jr $ra
	
	
	
	

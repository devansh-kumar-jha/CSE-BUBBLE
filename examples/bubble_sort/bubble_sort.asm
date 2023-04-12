# Conversions
# move $t0, $s0
# add $t0, $s0, $0
# li $t0, 42
# addi $t0, $0, 42
# la $t0, label
# add $t0, $0, label
# bgez $rs, label
# bge $rs, $0, label

.data
strInput: .asciiz "Enter the values of the array:\n"
strInit: .asciiz "The initial array:\n"
strResult: .asciiz "The sorted array is:\n"
strCR: .asciiz "\n"
strCT: .asciiz " "

# Please change the code here to change the array being sorted. Also please put the size of array in n.
arr:    .word 897, 565, 656, 1234, 665, 3434, 897, 565, 656, 1234, 665, 3434, 1126, 554, 3349, 678, 3656, 9989  # input array
n:      .word 18 # size of array

.text
.globl main

# Stores values - $s0: arr[n] start address    $s1: value of n
main:
    # STEP 1 -- Allocate required array
    la $s2, arr 
    # addi $t0, $0, arr    # store start address of arr[n]
    lw $s3, n              # store value of n
    
    # STEP 2 -- Print intial array
    # First print the string prelude  
    li $v0, 4
    # addi $v0, $0, 4      # syscall number 4 -- print string
    la $a0, strInit
    # add $a0, $0, strInit
    syscall        # actually print the string
    # Then print the initial array
    # li $t1, 0
    addi $t1, $0, 0         # counter for the loop
    # move $t0, $s0
    add $t0, $s2, $0     # get the start address of arr[n]
    loopp1: # li $v0, 1
 		addi $v0, $0, 1           # syscall number 1 -- print integer
            lw $a0, 0($t0)      # load values and put in $a0 for print
            syscall             # actually print the integer
            # li $v0, 4
		addi $v0, $0, 4           # syscall number 4 -- print string
            la $a0, strCR
		# add $a0, $0, strCR
            syscall
            addi $t1, $t1, 1     # increase the counter by 1
            addi $t0, $t0, 4     # increase address to the next value
            bne $t1, $s3, loopp1 # iterate over the loop

    # STEP 3 -- Function Call
    jal bubble_sort

    # STEP 4 -- Print the sorted array
    # li $v0, 4 
    addi $v0, $0, 4          # syscall number 4 -- print string
    la $a0, strCR
    # add $a0, $0, strCR
    syscall
    # First print the string prelude  
    # li $v0, 4
    addi $v0, $0, 4      # syscall number 4 -- print string
    la $a0, strResult
    # add $a0, $0, strResult
    syscall        # actually print the string
    # Then print the sorted array
    # li $t1, 0
    addi $t1, $0, 0         # counter for the loop
    # move $t0, $s0
    add $t0, $0, $s2     # get the start address of arr[n]
    loop2:  # li $v0, 1
		addi $v0, $0, 1           # syscall number 1 -- print integer
            lw $a0, 0($t0)      # load values and put in $a0 for print
            syscall             # actually print the integer
            # li $v0, 4
		addi $v0, $0, 4
		addi $v0, $0, 4           # syscall number 4 -- print string
            la $a0, strCR
		# add $a0, $0, strCR
            syscall
            addi $t1, $t1, 1    # increase the counter by 1
            addi $t0, $t0, 4    # increase address to the next value
            bne $t1, $s3, loop2 # iterate over the loop
    
    # STEP 5 -- exit
    # li $v0, 10
    addi $v0, $0, 10  # Syscall number 10 is to terminate the program
    syscall     # exit now

# Sorts the array in place by using bubble sort technique
# Uses $s2: Start address of array arr[i], $s3: Length of array
.text
bubble_sort:

    # STEP 1 -- ITERATE OVER THE ARRAY AND SORT
    # li $t0, 0
    addi $t0, $0, 0                           # initiate a counter i
    outer:  sub $t1, $s3, $t0           # $t1 = n-i
            addi $t1, $t1, -1           # $t1 = n-i-1
            # li $t2, 0
		addi $t2, $0, 0             # initiate a counter j
            sub $s1, $t2, $t1
            # bgez $t8, oend
		slt $s7, $s1, $0
		beq $s7, $0, oend
		bge $s1, $0, oend             # Finish the loop if it should be empty
    inner:  sll $t3, $t2, 2             # $t3 = j*4
            add $t3, $t3, $s2           # Address of arr[j]
            addi $t4, $t3, 4            # Address of arr[j+1]
            lw $t5, 0($t3)              # $t5 = arr[j]
            lw $t6, 0($t4)              # $t6 = arr[j+1]
            sub $s0, $t5, $t6           # $t7 = arr[j] - arr[j+1]
            # blez $t7, inend 
            slt $s7, $s0, $0
            bne $s7, $0, inend          # branch out if arr[j] <= arr[j+1]
            sw $t5, 0($t4)              # store arr[j] into arr[j+1]
            sw $t6, 0($t3)              # store arr[j+1] into arr[j]
    inend:  addi $t2, $t2, 1            # $t2 = j+1
            bne $t2, $t1, inner         # iterate over the inner loop
    oend:   addi $t0, $t0, 1            # $t0 = i+1
            bne $t0, $s3, outer         # iterate over the outer loop      
            
    # STEP 2 -- Return to main        
    end:    jr $ra                      # return from the insertion_sort module

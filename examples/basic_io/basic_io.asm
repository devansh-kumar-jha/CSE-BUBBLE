.data
strInput: .asciiz "Enter the values of the array:\n"
strResult: .asciiz "The array:\n"
strCR: .asciiz "\n"
strCT: .asciiz " "
buffer: .space 2

# Please change the code here to change the array being sorted. Also please put the size of array in n.
n:      .word 5 # size of array

.text
.globl main

# Stores values - $s0: arr[n] start address    $s1: value of n
main:
    # STEP 1 -- Allocate required array
    lw $s1, n              # store value of n
    sll $t0, $s1, 2        # $t0 = n*4
    sub $sp, $sp, $t0
    move $s0, $sp          # store start address of arr[n]
    
    # STEP 2 -- Take array as an input
    # First print the string prelude  
    li $v0, 4      # syscall number 4 -- print string
    la $a0, strInput
    syscall        # actually print the string
    # Then print the initial array
    li $t1, 0         # counter for the loop
    move $t2, $s0     # get the start address of arr[n]
    loopp1: li $v0, 5            # syscall number 5 -- input integer
            syscall              # input the integer
            sw $v0, 0($t2)       # store values in $a0 in array
            addi $t1, $t1, 1     # increase the counter by 1
            addi $t2, $t2, 4     # increase address to the next value
            bne $t1, $s1, loopp1 # iterate over the loop

    # STEP 3 -- Print the array
    li $v0, 4           # syscall number 4 -- print string
    la $a0, strCR
    syscall
    # First print the string prelude  
    li $v0, 4      # syscall number 4 -- print string
    la $a0, strResult
    syscall        # actually print the string
    # Then print the sorted array
    li $t1, 0         # counter for the loop
    move $t0, $s0     # get the start address of arr[n]
    loop2:  li $v0, 1           # syscall number 1 -- print integer
            lw $a0, 0($t0)      # load values and put in $a0 for print
            syscall             # actually print the integer
            li $v0, 4           # syscall number 4 -- print string
            la $a0, strCR
            syscall
            addi $t1, $t1, 1    # increase the counter by 1
            addi $t0, $t0, 4    # increase address to the next value
            bne $t1, $s1, loop2 # iterate over the loop
    
    # STEP 4 -- exit
    li $v0, 10  # Syscall number 10 is to terminate the program
    syscall     # exit now

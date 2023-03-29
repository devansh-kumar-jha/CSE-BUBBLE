.data
msg: .asciiz "Hello World"

.text
.globl main

main:   
    addi $sp, $sp, -1
    sw $0, 0($sp)
    lw $v0, 0($sp)     # syscall 4 (print_string)
    addi $v0, $v0, 4
    
    la $a0, msg        # argument: string (la is a pseudo-instruction: load address)
    
    # loads the address of the label msg into $a0
    syscall # print the string
    jr $ra # return

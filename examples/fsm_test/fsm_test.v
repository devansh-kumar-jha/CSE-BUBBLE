`include "..\..\source\processor.v"
`include "..\..\source\decode.v"
`include "..\..\source\alu.v"
`include "..\..\source\transfer.v"
`include "..\..\source\branching.v"
`include "..\..\source\system.v"
`include "..\..\source\memory.v"

module processor_test();

    // Registers and wires which will be used as an interface between processor and test benches
    reg clk,reset,start_signal;
    reg add_into;
    reg [31:0] new_instruction;
    wire end_signal;
    wire [31:0] debug1,debug2,debug3,debug4,debug5;

    // Call the processor module for the execution of the program in the machine.
    processor psd(clk,reset,start_signal,new_instruction,add_into,end_signal,debug1,debug2,debug3,debug4,debug5);

    // Control the reset signal for a small amount of time to start the machine
    initial begin
        reset <= 1'b0;
        #2
        reset <= 1'b1;
        #2
        reset <= 1'b0;
    end

    // Machine process synchronizing clock signal generation
    initial begin
        start_signal <= 1'b0;
        add_into <= 1'b0;
        new_instruction <= 32'b0; clk <= 1'b0;
        #10
        clk <= 1'b0;
        forever #10 clk <= ~clk;
    end

    // Input the instructions in the processor in the data loading phase
    // After that input the data into the processor
    // After that set the start_sginal to HIGH
    
    // Register 6 - r0 - This register will be hardwired to 0 at all times
    // Register (8-9) - (v0-v1) - This will be used for system calls and system instructions by the user
    // Register (10-13) - (a0-a3) - Will be used to provide arguments for function or system calls by the user
    // Register (17-23) - (t0-t6) - Temprorary Registers - Will be used to store values just required temprorarily
    // Register (24-31) - (s0-s7) - Stored Registers - Will be used to store values required over multiple functions or modules
    initial begin
        $monitor("clk = %d start = %d end = %d ID = %d PC = %d memory = %b $t4 = %d $inst = %b",clk,start_signal,end_signal,debug1,debug2,debug3,debug4,debug5);

        #10
        $display("Loading of instruction memory begins");
        // Write program to enter instruction memory into the machine
        #10 new_instruction <= 32'b000001_00110_10101_0000000011111111;                     // addi $t4, $0, num1
        #20 new_instruction <= 32'b000001_00110_10110_0000000011111110;                     // addi $t5, $0, num2
        #20 new_instruction <= 32'b000001_00110_10111_0000000011111101;                     // addi $t6, $0, num3
        #20 new_instruction <= 32'b001000_10101_10001_0000000000000000;                     // lw $t0, 0($t4)
        #20 new_instruction <= 32'b001000_10110_10010_0000000000000000;                     // lw $t1, 0($t5)
        #20 new_instruction <= 32'b001000_10111_10011_0000000000000000;                     // lw $t2, 0($t6)
        #20 new_instruction <= 32'b000000_10011_10010_10101_00000_000001;                   // sub $t4, $t2, $t1
        #20 new_instruction <= 32'b000001_00110_01000_0000000000000001;                     // loopp1: addi $v0, $0, 1
        #20 new_instruction <= 32'b000001_10101_01010_0000000000000000;                     // addi $a0, $t4, 0
        #20 new_instruction <= 32'b010101_00000000000000000000000000;                       // syscall
        #20 new_instruction <= 32'b000001_10101_10101_0000000000000001;                     // addi $t4, $t4, 1
        // #10 new_instruction <= 32'b001000_00010_00001_0000000000001100;                  // bne $t4, $t0, loopp1
        #20 new_instruction <= 32'b000001_00110_01000_0000000000000010;                     // addi $v0, $0, 2
        #20 new_instruction <= 32'b010101_00000000000000000000000000;                       // syscall

        $display("Change of loading memory target to data memory happens");
        // Change the add_into flag from instruction to data memory
        #20 add_into <= 1'b1;

        $display("Loading of data memory begins");
        // Write program to enter data memory into the machine
        #20 new_instruction <= 32'b00000000000000000000000000001010;                     // num1:   .word 10 stored at data[255]
        #20 new_instruction <= 32'b00000000000000000000000000000110;                     // num2:   .word 6 stored at data[254]
        #20 new_instruction <= 32'b00000000000000000000000000001101;                     // num3:   .word 13 stored at data[253]

        $display("The input to memory is now stopped");
        // End the data loading phase and start the execution of the program
        start_signal <= 1'b1;

        $display("The execution of program starts here");
        // Execution starts here, you can print certain values here to check execution
        
        #300
        $finish;
    end

endmodule

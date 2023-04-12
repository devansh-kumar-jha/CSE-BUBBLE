`include "..\..\source\processor.v"
`include "..\..\source\decode.v"
`include "..\..\source\alu.v"
`include "..\..\source\transfer.v"
`include "..\..\source\branching.v"
`include "..\..\source\system.v"
`include "..\..\source\memory.v"

module tb();

    // Registers and wires which will be used as an interface between processor and test benches
    reg clk,reset,start_signal;
    reg add_into;
    reg [31:0] new_instruction;
    wire end_signal;

    // Call the processor module for the execution of the program in the machine.
    processor psd(clk,reset,start_signal,new_instruction,add_into,end_signal);

    // Control the reset signal for a small amount of time to start the machine
    initial begin
        reset <= 1'b0;
        #1
        reset <= 1'b1;
        #1
        reset <= 1'b0;
    end

    // Machine process synchronizing clock signal generation
    initial begin
        start_signal <= 1'b0;
        add_into <= 1'b0;
        new_instruction <= 32'b0;
        #10
        clk <= 1'b0;
        forever #10 clk <= ~clk;
    end

    // Input the instructions in the processor in the data loading phase
    // After that input the data into the processor
    // After that set the start_signal to HIGH
    initial begin

        #10
        // Write program to enter instruction memory into the machine
            new_instruction <= 32'b000000_00110_10001_0000000000000000
        #20 new_instruction <= 32'b000000_11001_10001_10010_00000_000001
        #20 new_instruction <= 32'b000000_10010_10010_1111111111111111
        #20 new_instruction <= 32'b000000_00110_10011_0000000000000000
        #20 new_instruction <= 32'b000000_10011_10010_11001_00000_000001
        #20 new_instruction <= 32'b010011_11001_00110_11111_00000_000000
        #20 new_instruction <= 32'b001010_00110_11111_0000000000001111
        #20 new_instruction <= 32'b001010_00110_11001_0000000000001110 
        #20 new_instruction <= 32'b000111_10011_10100_0000000000000010
        #20 new_instruction <= 32'b000000_10100_11000_10100_00000_000000
        #20 new_instruction <= 32'b000000_10100_10101_0000000000000100
        #20 new_instruction <= 32'b001000_10100_10110_0000000000000000
        #20 new_instruction <= 32'b001000_10101_10111_0000000000000000
        #20 new_instruction <= 32'b000000_10110_10111_11000_00000_000001
        #20 new_instruction <= 32'b010011_11000_00110_11111_00000_000000
        #20 new_instruction <= 32'b001011_00110_11111_0000000000000011
        #20 new_instruction <= 32'b001001_10101_10110_0000000000000000
        #20 new_instruction <= 32'b001001_10100_10111_0000000000000000
        #20 new_instruction <= 32'b000000_10011_10011_0000000000000001
        #20 new_instruction <= 32'b001011_10010_10011_1111111111110101    
        #20 new_instruction <= 32'b000000_10001_10001_0000000000000001
        #20 new_instruction <= 32'b001011_11001_10011_1111111111101100
        #20 new_instruction <= 32'b100001_00000000000000000000010000

        // Change the add_into flag from instruction to data memory
        #20 add_into <= 1'b1;

        // Write program to enter data memory into the machine
        #20 new_instruction <= 32'd10;
        #20 new_instruction <= 32'd643;
        #20 new_instruction <= 32'd573;
        #20 new_instruction <= 32'd532;
        #20 new_instruction <= 32'd087;
        #20 new_instruction <= 32'd879;
        #20 new_instruction <= 32'd242;
        #20 new_instruction <= 32'd64;
        #20 new_instruction <= 32'd805;
        #20 new_instruction <= 32'd868;
        #20 new_instruction <= 32'd57320
        // End the data loading phase and start the execution of the program
        // Execution starts here, you can print certain values here to check execution
        start_signal <= 1'b1;
        
        #10000
        $finish;
    end

endmodule
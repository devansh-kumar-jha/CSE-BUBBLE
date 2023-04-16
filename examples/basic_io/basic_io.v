`include "..\..\source\processor.v"
`include "..\..\source\decode.v"
`include "..\..\source\alu.v"
`include "..\..\source\transfer.v"
`include "..\..\source\branching.v"
`include "..\..\source\system.v"
`include "..\..\source\memory.v"

module basic_io_test();

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

        // Write program to enter instruction memory into the machine
        #10 new_instruction <= 32'b0;

        // Change the add_into flag from instruction to data memory
        #10 add_into <= 1'b1;

        // Write program to enter data memory into the machine
        #10 new_instruction <= 32'b0;

        // End the data loading phase and start the execution of the program
        // Execution starts here, you can print certain values here to check execution
        start_signal <= 1'b1;
        
        #10000
        $finish;
    end

endmodule

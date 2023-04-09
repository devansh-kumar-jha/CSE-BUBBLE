//! This is the controller module for execution of operating system internal instructions.
//! There are 3 system instructions which are given by
    // 26: syscall          - Opcode: 21
    // 27: display          - Opcode: 22
    // 28: exit             - Opcode: 23
//! The 3 parameters passed between the processor and this module are characterized by
    // rs - Input Argument 1 containing the type of system instruction to be executed
    // rt - Input Argument 2 containing the value to be displayed in case of display system instruction
    // rd - Output Argument 3 this is not used and kept as an high impedance port in this module

/// This is a sequential logic which runs at the subsequent clock cycle.
module system_top (
    input wire clk,reset,                   // Synchronizing signals of the processor machine
    input wire [31:0] ir,                   // Instruction Register
    input wire [31:0] instr_ID,             // Decoded instruction ID
    input wire [31:0] rs,rt,                // 2 input parameters to the system module from processor
    output wire [31:0] rd                   // 1 output parameter from system module to processor
);

    always @(posedge clk) begin
        if(instr_ID != 26) begin end        // Ignore for instructions which are not syscall
        else begin
            if(rs == 1) begin               // The instruction is for display
                $display(rt);
            end
            else begin                      // The instruction is for exiting the program
                #5
                $finish;
            end
        end
    end

endmodule
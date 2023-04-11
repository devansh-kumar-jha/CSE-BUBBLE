//! This is the controller module for execution of operating system internal instructions.
//! There are 3 system instructions which are given by
    // 26: syscall          - Opcode: 21
    // 27: display          - Opcode: 22
    // 28: exit             - Opcode: 23
//! The 3 parameters passed between the processor and this module are characterized by
    // rs - Input Argument 1 containing the type of system instruction to be executed
    // rt - Input Argument 2 containing the value to be displayed in case of display system instruction
    // rd - Output Argument 3 this is not used and kept as an high impedance port in this module

/// This is a combinational logic.
module system_top (
    input wire reset,
    input wire [31:0] ir,                   // Instruction Register
    input wire [31:0] instr_ID,             // Decoded instruction ID
    input wire [31:0] rs,rt,                // 2 input parameters to the system module from processor
    output wire [31:0] rd                   // 1 output parameter from system module to processor
);

    always @(*) begin
        if(instr_ID != 26) begin end            // Ignore for instructions which are not syscall
        else begin
            if(rs == 32'd1) begin               // The instruction is for display
                $display(rt);
            end
            else if(rs == 32'd2) begin          // The instruction is for exiting the program
                #5
                $finish;
            end
            else begin end                      // The instruction is for a nop system call where we have to ignore the clock cycle
        end
    end

endmodule

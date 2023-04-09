//! This is the controller module for execution of data transfer instructions.
//! There are 2 data transfer instructions which are given by
    // 13: lw r0, 10(r1)    - I type - Opcode: 8
    // 14: sw r0, 10(r1)    - I type - Opcode: 9
//! The 3 parameters passed between the processor and this module are characterized by
    // rs - Input Argument 1 containing the base address
    // rt - Input Argument 2 containing the offset from the base address which may be positive or negative
    // rd - Output Argument 3 which containes the address value which is to be interfaced with data memory in either read or write.

/// This will be a purely combinational logic.
module data_transfer_top (
    input wire [31:0] ir,                   // Instruction Register
    input wire [31:0] instr_ID,             // Decoded instruction ID
    input wire [31:0] rs,rt,                // 2 input parameters to the data transfer module from processor
    output wire [31:0] rd                   // 1 output parameter from data transfer module to processor
);

    assign rd = rs + rt;

endmodule
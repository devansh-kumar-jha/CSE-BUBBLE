//! This is the file which contains implementation of all conditional or unconditional branch instructions.
//! There are 9 instructions implemented here which are given by
    // 15: beq r0, r1, 10   - I type - Opcode: 10
    // 16: bne r0, r1, 100  - I type - Opcode: 11
    // 17: bgt r0, r1, 10   - I type - Opcode: 12
    // 18: bgte r0, r1, 100 - I type - Opcode: 13
    // 19: ble r0, r1, 10   - I type - Opcode: 14
    // 20: bleq r0, r1, 100 - I type - Opcode: 15
    // 21: j 100            - J type - Opcode: 16
    // 22: jr r0            - J type - Opcode: 17
    // 23: jal 1000         - J type - Opcode: 18
//! The 3 parameters passed between the processor and this module are characterized by
    // rs - Input Argument 1 contains parameter 1 of the Conditional Branch instruction. First operand in logical comparison.
    // rt - Input Argument 2 parameter 2 of the Conditional Branch instruction. Second operand in logical comparison.
    // rd - Input Argument 3 contains destination offset for the program counter next position.
    // For unconditional branch instruction "rs" denotes the jump location.
    // out - Output Argument 4 contains the extra jump to be followed by the program counter.

/// This will be a combinational logic.
module branch_top (
    input wire [31:0] ir,                    // Instruction Register
    input wire [31:0] instr_ID,              // Decoded instruction ID
    input wire [31:0] rs,rt,rd,              // Input Arguments 1, 2 and 3 got from processor
    output wire [31:0] out                   // Output Argument 4 sent to processor
);
    // Register to update the output of ALU
    reg [31:0] out_reg;
    // Wire mesh to capture outputs from all ALU submodules
    wire [31:0] opt[0:13];
    
    // Calling all subordinate modules
    beq branch0(rs,rt,rd,opt[0]);
    bne branch1(rs,rt,rd,opt[1]);
    bgt branch2(rs,rt,rd,opt[2]);
    bgte branch3(rs,rt,rd,opt[3]);
    ble branch4(rs,rt,rd,opt[4]);
    bleq branch5(rs,rt,rd,opt[5]);
    j branch6(rs,rt,rd,opt[6]);
    jr branch7(rs,rt,rd,opt[7]);
    jal branch8(rs,rt,rd,opt[8]);

    // Combinational Always block to select the correct output from the above outputs. 
    always @(ir) begin
        if(instr_ID >=15 && instr_ID <= 23) begin                // Presence of any Branch instruction
            out_reg <= opt[instr_ID - 15];
        end
        else begin end                                           // Ignore this if it is not a Branch instruction
    end

    // Assigning output to the communicating output port variable.
    assign out = out_reg;

endmodule

/// CONDITIONAL BRANCH INSTRUCTIONS
// Module for supporting branch if equal operation.
// beq r0, r1, 10
module beq (
    input wire [31:0] rs,rt,rd,
    output wire [31:0] out
);
    assign out = (rs == rt) ? rd : 32'b0;
endmodule

// Module for supporting branch if not equal operation.
// bne r0, r1, 10
module bne (
    input wire [31:0] rs,rt,rd,
    output wire [31:0] out
);
    assign out = (rs != rt) ? rd : 32'b0;
endmodule

// Module for supporting branch if greater than operation.
// bgt r0, r1, 10
module bgt (
    input wire [31:0] rs,rt,rd,
    output wire [31:0] out
);
    assign out = (rs > rt) ? rd : 32'b0;
endmodule

// Module for supporting branch if greater than equal to operation.
// bgte r0, r1, 10
module bgte (
    input wire [31:0] rs,rt,rd,
    output wire [31:0] out
);
    assign out = (rs >= rt) ? rd : 32'b0;
endmodule

// Module for supporting branch if less than operation.
// ble r0, r1, 10
module ble (
    input wire [31:0] rs,rt,rd,
    output wire [31:0] out
);
    assign out = (rs < rt) ? rd : 32'b0;
endmodule

// Module for supporting branch if less than equal to operation.
// bleq r0, r1, 10
module bleq (
    input wire [31:0] rs,rt,rd,
    output wire [31:0] out
);
    assign out = (rs <= rt) ? rd : 32'b0;
endmodule


/// CONDITIONAL BRANCH INSTRUCTIONS
// Module for supporting jump operation.
// j 1000
module j (
    input wire [31:0] rs,rt,rd,
    output wire [31:0] out
);
    assign out = rs;
endmodule

// Module for supporting jump register operation.
// jr 1000
module jr (
    input wire [31:0] rs,rt,rd,
    output wire [31:0] out
);
    assign out = rs;
endmodule

// Module for supporting jump and link operation.
// jal 1000
module jal (
    input wire [31:0] rs,rt,rd,
    output wire [31:0] out
);
    assign out = rs;
endmodule

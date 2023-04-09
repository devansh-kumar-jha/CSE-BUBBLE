//! This file will run the Branching Instructions of the processor.
//! This contains various modules which can be used as required and take the required amount of
//! information from the processor and output the computed value in the output wire which is used by the processor.

/// This will be a combinational logic.
module branching(initial_pc,r0,r1,const,pc);
    input [31:0] initial_pc,r0,r1,const;
    output [31:0] pc;

    // reg [31:0] pc_check;
    // wire [4:0] r0,r1,r2;
    // assign r1 = ir[25:21];
    // assign r0 = ir[20:16];
    // assign num = ir[15:0];

    // always @(*) begin
    //     check <= data_in;
    // end

    // assign data_out <= check;
endmodule

// module beq(instr_ID,move,a,b,pc);
//     input [31:0] instr_ID,move,a,b;
//     output [31:0] pc;

//     reg [31:0] pc_reg;

//     always @(*) begin
//         if(instr_ID == 15 and a == b) begin
//             pc_reg <= pc + 4 + move;
//         end
//     end

//     assign pc = pc_reg;
// endmodule

// module bne(instr_ID,move,a,b,pc);
//     input [31:0] instr_ID,move,a,b;
//     output [31:0] pc;

//     reg [31:0] pc_reg;

//     always @(*) begin
//         if(instr_ID == 16 and a != b) begin
//             pc_reg <= pc + 4 + move;
//         end
//     end

//     assign pc = pc_reg;
// endmodule

// module bgt(instr_ID,move,a,b,pc);
//     input [31:0] instr_ID,move,a,b;
//     output [31:0] pc;

//     reg [31:0] pc_reg;

//     always @(*) begin
//         if(instr_ID == 17 and a > b) begin
//             pc_reg <= pc + 4 + move;
//         end
//     end

//     assign pc = pc_reg;
// endmodule

// module bgte(instr_ID,move,a,b,pc);
//     input [31:0] instr_ID,move,a,b;
//     output [31:0] pc;

//     reg [31:0] pc_reg;

//     always @(*) begin
//         if(instr_ID == 18 and a >= b) begin
//             pc_reg <= pc + 4 + move;
//         end
//     end

//     assign pc = pc_reg;
// endmodule

// module ble(instr_ID,move,a,b,pc);
//     input [31:0] instr_ID,move,a,b;
//     output [31:0] pc;

//     reg [31:0] pc_reg;

//     always @(*) begin
//         if(instr_ID == 19 and a < b) begin
//             pc_reg <= pc + 4 + move;
//         end
//     end

//     assign pc = pc_reg;
// endmodule

// module bleq(instr_ID,move,a,b,pc);
//     input [31:0] instr_ID,move,a,b;
//     output [31:0] pc;

//     reg [31:0] pc_reg;

//     always @(*) begin
//         if(instr_ID == 20 and a <= b) begin
//             pc_reg <= pc + 4 + move;
//         end
//     end

//     assign pc = pc_reg;
// endmodule

// module j(instr_ID,move,pc);
//     input [31:0] instr_ID,move,a,b;
//     output [31:0] pc;

//     reg [31:0] pc_reg;

//     always @(*) begin
//         if(instr_ID == 21) begin
//             pc_reg <= move;
//         end
//     end

//     assign pc = pc_reg;
// endmodule

// module jr(instr_ID,move,pc);
//     input [31:0] instr_ID,move,a,b;
//     output [31:0] pc;

//     reg [31:0] pc_reg;

//     always @(*) begin
//         if(instr_ID == 22) begin
//             pc_reg <= move;
//         end
//     end

//     assign pc = pc_reg;
// endmodule

// module jal(instr_ID,move,pc);
//     input [31:0] instr_ID,move,a,b;
//     output [31:0] pc;

//     reg [31:0] pc_reg;

//     always @(*) begin
//         if(instr_ID == 23) begin
//             pc_reg <= pc + move;
//         end
//     end

//     assign pc = pc_reg;
// endmodule

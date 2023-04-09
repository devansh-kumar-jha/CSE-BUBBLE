//! This file will run the Instruction Decode phase inside the processor.
//! Here in the instruction in the Instruction Register will be read in 1 clock cycle
//! The module takes input the IR register contents and decodes the op-code and function part to get the current instruction.

module instr_decode (
    input [31:0] ir;                 // Instruction Register
    output [31:0] ID;                // Decoded Instruction ID
    output wire [31:0] rs,rt,rd;     // Address of parameters of the instruction
);
    // Wires for fragmenting the instruction in IR register
    wire [5:0] opcode,func;
    reg [31:0] id_reg,rs_reg,rt_reg,rd_reg;

    assign opcode = ir[31:26];
    assign func = ir[5:0];

    // Whenever the values under ir are changed this module will be signalled and the always block will execute.
    // ID gets the particular instruction ID as explained in the "processor.v" file.
    always @(ir) begin
        if(opcode == 0) begin
            id_reg <= func + 1;
            rs_reg <= {27'b0,ir[25:21]}; rt_reg <= {27'b0,ir[20:16]}; rd_reg <= {27'b0,ir[15:11]};
        end
        else if(opcode <= 6) begin
            id_reg <= opcode + 4;
            if(opcode == 3 || opcode==4) begin
                rs_reg <= {27'b0,ir[25:21]}; rt_reg <= {27'b0,ir[20:16]}; rd_reg <= {27'b0,ir[15:11]};
            end
            else begin
                rs_reg <= {27'b0,ir[25:21]}; rt_reg <= {16'b0,ir[15:0]}; rd_reg <= {27'b0,ir[20:16]};
            end
        end
        else if(opcode == 7) begin
            id_reg <= func + 11;
            rs_reg <= {27'b0,ir[25:21]}; rt_reg <= {16'b0,ir[15:0]}; rd_reg <= {27'b0,ir[20:16]};
        end
        else begin
            id_reg <= opcode + 5;
            if(opcode < 16 || opcode == 20) begin
                rs_reg <= {27'b0,ir[25:21]}; rt_reg <= {16'b0,ir[15:0]}; rd_reg <= {27'b0,ir[20:16]};
            end
            else if(opcode < 19) begin rs_reg <= {6'b0,ir[25:0]}; end
            else begin
                rs_reg <= {27'b0,ir[25:21]}; rt_reg <= {27'b0,ir[20:16]}; rd_reg <= {27'b0,ir[15:11]};
            end
        end
    end

    assign ID = id_reg;
    assign rs = rs_reg;
    assign rt = rt_reg;
    assign rd = rd_reg;
endmodule

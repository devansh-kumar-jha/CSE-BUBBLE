// This file will run the Instruction Decode phase inside the processor.
// Here in the instruction in the Instruction Register will be read in 1 clock cycle
// The module takes input the IR register contents and decodes the op-code and function part to get the current instruction.

module instr_decode (
    input [31:0] ir;           // Instruction Register
    output [31:0] ID;          // Decoded Instruction ID
);
    wire [5:0] opcode,func;
    assign opcode = ir[31:26];
    assign func = ir[5:0];
    reg [31:0] id_reg;

    // Whenever the values under ir are changed this module will be signalled and
    // the always block will execute.
    // ID gets the particular instruction ID as explained in the "processor.v" file
    always @(*) begin
        if(opcode == 0) begin
            id_reg <= func + 1;
        end
        else if(opcode <= 6) begin
            id_reg <= opcode + 4;
        end
        else if(opcode == 7) begin
            id_reg <= func + 11;
        end
        else begin
            id_reg <= opcode + 5;
        end
    end

    assign ID = id_reg;
endmodule

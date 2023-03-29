`include "../../source/instr_fetch.v"

module decode_test();
    // Example of decoding the instruction
    reg [31:0] ir;
    wire [31:0] ID;

    // Instantiating the module for Instruction Decode
    instr_decode uut(ir, ID);

    initial begin
        
    end
endmodule

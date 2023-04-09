`include "../../source/instr_decode.v"

module decode_test();
    // Example of decoding the instruction
    reg [31:0] ir;
    wire [31:0] ID;

    // Instantiating the module for Instruction Decode
    instr_decode uut(ir, ID);

    initial begin
        ir <= 000001 01111 01111 1111111111111111
        #10
        $display("The decoded instruction is ",ID);

        ir <= 001001 00110 01111 0000000000000000
        #10
        $display("The decoded instruction is ",ID);

        ir <= 001000 01000 01111 0000000000000000
        #10
        $display("The decoded instruction is ",ID);

        ir <= 000001 01111 01111 1111111111111111
        #10
        $display("The decoded instruction is ",ID);

        ir <= 000001 01111 01111 1111111111111111
        #10
        $display("The decoded instruction is ",ID);

        ir <= 000001 01111 01111 1111111111111111
        #10
        $display("The decoded instruction is ",ID);

        ir <= 000001 01111 01111 1111111111111111
        #10
        $display("The decoded instruction is ",ID);

        ir <= 000001 01111 01111 1111111111111111
        #10
        $display("The decoded instruction is ",ID);

        ir <= 000001 01111 01111 1111111111111111
        #10
        $display("The decoded instruction is ",ID);

        ir <= 000001 01111 01111 1111111111111111
        #10
        $display("The decoded instruction is ",ID);

        ir <= 000001 01111 01111 1111111111111111
        #10
        $display("The decoded instruction is ",ID);

    end
endmodule

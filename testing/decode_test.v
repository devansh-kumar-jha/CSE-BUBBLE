`include "../source/decode.v"

module decode_test();
    // Example of decoding the instruction
    reg [31:0] ir;
    wire [31:0] ID,rs,rt,rd;

    // Instantiating the module for Instruction Decode
    instr_decode uut(ir, ID, rs, rt, rd);

    initial begin
        ir <= 000001_01111_01111_11111_11111_000000;
        #10
        $display("The decoded instruction ID is %d",ID);
        $display("The parameters extracted are as follows");
        $display("The parameter 1 is %d",rs);
        $display("The parameter 2 is %d",rt);
        $display("The parameter 3 is %d",rd);

        ir <= 001001_00110_01111_0000000000000000;
        #10
        $display("The decoded instruction ID is %d",ID);
        $display("The parameters extracted are as follows");
        $display("The parameter 1 is %d",rs);
        $display("The parameter 2 is %d",rt);
        $display("The parameter 3 is %d",rd);

        ir <= 001000_01000_01111_0000000000000000;
        #10
        $display("The decoded instruction ID is %d",ID);
        $display("The parameters extracted are as follows");
        $display("The parameter 1 is %d",rs);
        $display("The parameter 2 is %d",rt);
        $display("The parameter 3 is %d",rd);

        ir <= 000001_01111_01111_11111_11111_000001;
        #10
        $display("The decoded instruction ID is %d",ID);
        $display("The parameters extracted are as follows");
        $display("The parameter 1 is %d",rs);
        $display("The parameter 2 is %d",rt);
        $display("The parameter 3 is %d",rd);

        ir <= 000001_01111_01111_11111_11111_000001;
        #10
        $display("The decoded instruction ID is %d",ID);
        $display("The parameters extracted are as follows");
        $display("The parameter 1 is %d",rs);
        $display("The parameter 2 is %d",rt);
        $display("The parameter 3 is %d",rd);

        ir <= 000001_01111_01111_11111_11111_000000;
        #10
        $display("The decoded instruction ID is %d",ID);
        $display("The parameters extracted are as follows");
        $display("The parameter 1 is %d",rs);
        $display("The parameter 2 is %d",rt);
        $display("The parameter 3 is %d",rd);

        ir <= 001000_01000_01111_0000000000000000;
        #10
        $display("The decoded instruction ID is %d",ID);
        $display("The parameters extracted are as follows");
        $display("The parameter 1 is %d",rs);
        $display("The parameter 2 is %d",rt);
        $display("The parameter 3 is %d",rd);

        ir <= 001000_01000_01111_0000000000000000;
        #10
        $display("The decoded instruction ID is %d",ID);
        $display("The parameters extracted are as follows");
        $display("The parameter 1 is %d",rs);
        $display("The parameter 2 is %d",rt);
        $display("The parameter 3 is %d",rd);

        ir <= 001000_01000_01111_0000000000000000;
        #10
        $display("The decoded instruction ID is %d",ID);
        $display("The parameters extracted are as follows");
        $display("The parameter 1 is %d",rs);
        $display("The parameter 2 is %d",rt);
        $display("The parameter 3 is %d",rd);

        ir <= 010101_01000011110000000000000000;
        #10
        $display("The decoded instruction ID is %d",ID);
        $display("The parameters extracted are as follows");
        $display("The parameter 1 is %d",rs);
        $display("The parameter 2 is %d",rt);
        $display("The parameter 3 is %d",rd);

        ir <= 001000_01000_01111_0000000000000000;
        #10
        $display("The decoded instruction ID is %d",ID);
        $display("The parameters extracted are as follows");
        $display("The parameter 1 is %d",rs);
        $display("The parameter 2 is %d",rt);
        $display("The parameter 3 is %d",rd);

    end
endmodule

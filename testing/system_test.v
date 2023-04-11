`include "../source/system.v"

module system_test();
    // Example of decoding the instruction
    reg reset;
    reg [31:0] ir,ID,rs,rt;
    wire [31:0] rd;

    // Instantiating the module for Instruction Decode
    system_top uut(reset, ir, ID, rs, rt, rd);

    // Control the reset signal for a small amount of time to start the machine
    initial begin
        reset <= 1'b0;
        #1
        reset <= 1'b1;
        #1
        reset <= 1'b0;
    end
    
    initial begin
        ir <= 32'b0; ID <= 32'b0;
        rs <= 32'b0; rt <= 32'b0;
    end

    initial begin
        ir <= 32'b001001_00010_00001_0000000001100100;                // This is sw $1, 100($2)
        ID <= 32'd14; rs <= 32'd10; rt <= 32'd100;                    // Nothing printed or seen in registers specifically
        #10
        $display("The decoded instruction ID is %d",ID);
        $display("The parameters extracted are as follows");
        $display("The input 1 is %d",$signed(rs));
        $display("The input 2 is %d",$signed(rt));
        $display("The output is %d",$signed(rd));
        
        ir <= 32'b010101_00000000000000000000000000;                  // This is syscall to display value in rt
        ID <= 32'd26; rs <= 32'd1; rt <= 32'd1001;                    // The value 1001 is visible on screen
        #10
        $display("The decoded instruction ID is %d",ID);
        $display("The parameters extracted are as follows");
        $display("The input 1 is %d",$signed(rs));
        $display("The input 2 is %d",$signed(rt));
        $display("The output is %d",$signed(rd));

        ir <= 32'b010101_00000000000000000000000000;                 // This is nop instruction
        ID <= 32'd26; rs <= 32'd3; rt <= 32'd12;                     // No change in previour output
        #10
        $display("The decoded instruction ID is %d",ID);
        $display("The parameters extracted are as follows");
        $display("The input 1 is %d",$signed(rs));
        $display("The input 2 is %d",$signed(rt));
        $display("The output is %d",$signed(rd));

        ir <= 32'b010101_00000000000000000000000000;                 // This is syscall for finishing program
        ID <= 32'd26; rs <= 32'd2; rt <= 32'd12;                     // The program exits here
        #10
        $display("The decoded instruction ID is %d",ID);
        $display("The parameters extracted are as follows");
        $display("The input 1 is %d",$signed(rs));
        $display("The input 2 is %d",$signed(rt));
        $display("The output is %d",$signed(rd));

        #2000 $finish;

    end
endmodule



module tb();
    reg [31:0] mem[0:31];
    reg [31:0] chk;
    reg clk;

    integer i;
    initial begin
        
    end
    
    initial begin
        chk <= 0;
        for(i=0;i<32;i=i+1) begin mem[i]<=0; end
    end

    initial begin
        
    end

endmodule

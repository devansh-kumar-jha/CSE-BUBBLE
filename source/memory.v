module instruction_memory #(parameter width = 32, parameter depth = 256) (clk,in,out,reset,address_a,address_b);
    input [width-1:0] in,address_a,address_b;
    input clk,reset,mode,writeEnable;
    output [width-1:0] out;
    reg [width-1:0] memory[0:depth-1];
    reg [width-1:0] dataout;
    integer i;

    always @(posedge reset or posedge clk) begin
        if(reset==1'b1) begin
            dataout <= 0;
            for(i=0;i<depth;i=i+1) begin memory[i] <= 0; end
        end
        else begin
            memory[address_a] = in;
            dataout = memory[address_b];
        end
    end
    assign out = dataout;
endmodule

module data_memory #(parameter width = 32, parameter depth = 256) (clk,in,out,reset,address_a,address_b);
    input [width-1:0] in,address_a,address_b;
    input clk,reset,mode,writeEnable;
    output [width-1:0] out;
    reg [width-1:0] memory[0:depth-1];
    reg [width-1:0] dataout;
    integer i;

    always @(posedge reset or posedge clk) begin
        if(reset==1'b1) begin
            dataout <= 0;
            for(i=0;i<depth;i=i+1) begin memory[i] <= 0; end
        end
        else begin
            memory[address_a] = in;
            dataout = memory[address_b];
        end
    end
    assign out = dataout;
endmodule

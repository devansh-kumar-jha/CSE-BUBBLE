/// These are the memory modules which will be called and used in the processor module. They all will be present in the
/// write mode until the loading phase of the processor is running after that instruction memory would convert into
/// read only mode but the data memory would still be present in write mode to the user.

/// This is the module for instruction memory which has specific controls for
/// read enable and write enable which will be used to control the flow into and out of memory.
module instr_memory #(parameter width = 32, parameter depth = 256) (clk,reset,in,out,address,mode,writeEnable);
    input [width-1:0] in,address;
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
            memory[address] = in;
            dataout = memory[address_b];
        end
    end
    
    assign out = dataout;
endmodule

/// The data memory is used for storing the data and its specifications include the possibility
/// of reading and writing from both the sides (top and bottom) of the memory which results in
/// differntial addressing in this memory.
/// This memory will always be available to us in the write mode but the writeEnable will be activated only at times.
module data_memory #(parameter width = 32, parameter depth = 256) (clk,reset,in,out,address_a,address_b,mode,writeEnable);
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

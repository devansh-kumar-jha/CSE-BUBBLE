// This file will run the Instruction Fetch phase inside the processor.
// Here in the instruction will be loaded inside the Instruction Register in 1 clock cycle
// The module takes input the program counter and the instruction memory from the processor
// and outputs the instruction in IR register

module instr_fetch (
  input clk,                                // Clock signal
  input reset,                              // Reset signal
  input [31:0] pc,                          // Program Counter
  input [31:0][0:255]  instruction_memory,  // Instruction_memory
  output [31:0] ir_wire                     // Instruction Register
);

  reg [31:0] ir;
  // Always block for instruction fetch
  always @(posedge clk, posedge reset) begin
    if (reset) begin
      // Reset the instruction register
      ir <= 32'h0;
    end
    else begin
      // Fetch the instruction at the current program counter
      ir <= instruction_memory[pc];
    end
  end
  
  assign ir_wire = ir;

endmodule

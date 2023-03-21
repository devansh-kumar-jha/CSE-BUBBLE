// This file will run the Instruction Fetch phase inside the processor.
// Here in the instruction will be loaded inside the Instruction Register in 1 clock cycle
// The module takes input the program counter and the instruction memory from the processor
// and outputs the instruction in IR register


module instr_fetch(
  input clk,                                // Clock signal
  input reset,                              // Reset signal
  input [31:0] pc,                          // Program Counter
  input [31:0][255:0]  instruction_memory,  // Instruction_memory
  output reg [31:0] ir                      // Instruction Register
);

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

endmodule

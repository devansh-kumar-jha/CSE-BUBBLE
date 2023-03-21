`include "instr_fetch.v"
`include "instr_decode.v"
`include "alu.v"
`include "branching.v"
`include "system.v"

module processor(clk,reset,instruct,data,signal);
    //! STEP 1 -- DEFINING INPUTS AND OUTPUTS OF THE MODULE
    // clk - The synchronizing clock for all process of the machine.
    // reset - An intial signal will be passed for very short time which will be used to reset all processor to starting state.
    // instruct - Instruction to be fed in the instruction memory
    // data - Data to be fed in the Data Memory
    // signal - Will be set to 1 upon termination of the program, will be zero initially
    input clk,reset;
    input [31:0] instruct[0:255];
    input [31:0] data[0:255];
    output signal;
    wire clk,reset,signal,instruct,data;

    //! STEP 2 -- DEFINING THE GENERAL PURPOSE AND OTHER REGISTERS/WIRES INSIDE THE PROCESSOR
    /// process - Total 32 registers inside the processor each of 32 width stored under the process matrix
    /// Registers 0-5 : System controlled registers PC, EPC, Cause, BadVAddr, Status, IR
    /// Registers 6-31 : User controlled registers r0, at, v0-v1, a0-a3, gp, sp, ra, t0-t6, s0-s7
    // Register 0 - PC - Program Counter (Denotes the next instruction to be fetched)
    // Register 1 - EPC -
    // Register 2 - Cause -
    // Register 3 - BadVAddr -
    // Register 4 - Status -
    // Register 5 - IR - It will Store the Current Instruction which is being executed
    // Register 6 - r0 - This register will be hardwired to 0 at all times
    // Register 7 - at -
    // Register (8-9) - (v0-v1) - This will be used for system calls and system instructions by the user
    // Register (10-13) - (a0-a3) - Will be used to provide arguments for function or system calls by the user
    // Register 14 - gp - Global Pointer - Will be pointing to the start of the global area,
    //                                     can be used to point the starting address of heap in data memory
    // Register 15 - sp - Stack Pointer - Will denote the starting location of stack memory in data memory
    // Register 16 - ra - Return Address - Will Store the address of the instruction where we have to return after function exits
    // Register (17-23) - (t0-t6) - Temprorary Registers - Will be used to store values just required temprorarily
    // Register (24-31) - (s0-s7) - Stored Registers - Will be used to store values required over multiple functions or modules
    reg [31:0] process[0:31]
    /// Instruction memory which will be used by the processor is defined in the wire matrix below
    wire [31:0] instr[0:255];
    /// Data memory which will be used by the processor is defined in the wire matrix below
    wire [31:0] data[0:255];

    //! STEP 3 -- INITIALIZATION OF INSTRUCTION MEMORY AND DATA MEMORY BEFORE STARTING THE PROCESSOR


    //! STEP 4 -- INITIALIZATION OF PROGRAM COUNTER AND OTHER SYSTEM CONTROLLED REGISTERS INSIDE THE PROCESSOR
    // reset will be activated for a very small time during the starting of the execution. That will be used by the processor
    // to intiate all the registers in it.
    // It will also be used by other modules instantiated in PROCESSOR for resetting there induvidual memory
    always @(posedge reset) begin
        process[0] <= 0; // Set PC as 0 (start of the program)
        process[5] <= 0; // Clear the IR Register
        process[6] <= 0; // Register r0 always hardwired to 0
        integer i;
        for(i=8;i<=13;i=i+1) begin process[i] <= 0; end // Clear all v and a registers in processor
        for(i=17;i<=31;i=i+1) begin process[i] <= 0; end // Clear all t and s registers in processor
    end

    //! STEP 5 -- INSTRUCTION FETCH PHASE (MODULE WILL BE CALLED WHICH WILL LOAD THE NEXT INSTRUCTION IN IR REGISTER)

    //! STEP 6 -- INSTRUCTION DECODE PHASE (READ THE IR REGISTER AND SEND THE CONTROL TO THAT PARTICULAR INSTRUCTION DATA PATH)

    //! STEP 7 -- INCREMENT THE PC UPON POSEDGE OF CLOCK AND READ THE NEXT INSTRUCTION

    //! STEP 8 -- MAKE THE OUTPUT "SIGNAL" = 1 TO SIGNAL THE CALLING TEST BENCH THAT THE PROGRAM EXECUTION IS FINISHED

endmodule

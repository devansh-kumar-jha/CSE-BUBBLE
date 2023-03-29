`include "instr_fetch.v"
`include "instr_decode.v"
`include "alu.v"
`include "transfer.v"
`include "branching.v"
`include "system.v"

module processor_top(clk,reset,instruct,data,signal,final);
    //! STEP 1 -- DEFINING INPUTS AND OUTPUTS OF THE MODULE
    // clk - The synchronizing clock for all process of the machine.
    // reset - An intial signal will be passed for very short time which will be used to reset all processor to starting state.
    // instruct - Instruction to be fed in the instruction memory
    // data - Data to be fed in the Data Memory
    // signal - Will be set to 1 upon termination of the program, will be zero initially
    // final - The final value where the program terminates, here the signal will be set signalling that the program is over
    input clk,reset;
    input [31:0] instruct[0:255];
    input [31:0] data[0:255];
    input [31:0] final;
    output signal;
    wire clk,reset,signal,instruct,data,final; 

    //! STEP 2 -- INTERFACING OF INSTRUCTION MEMORY AND DATA MEMORY BEFORE STARTING THE PROCESSOR
    
    //! STEP 3 -- INSTANTIATING THE PROCESSOR FOR EXECUTION

    //! STEP 4 -- END THE PROGRAM

endmodule

module processor(clk,reset,instr,data,signal,final);
    //! STEP 1 -- DEFINING INPUTS AND OUTPUTS OF THE MODULE
    input clk,reset;
    /// Instruction memory which will be used by the processor is defined in the wire matrix below.
    /// The instruction memory has a size of 32 bits * 256 registers
    input [31:0] instr[0:255];
    /// Data memory which will be used by the processor is defined in the wire matrix below
    /// The data memory has a size of 32 bits * 256 registers
    input [31:0] data[0:255];
    input [31:0] final;
    output signal;
    wire clk,reset,signal,instr,data,final; 
    
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
    // Register 7 - at - This register will be used by the Assembler time to time to implement Pseudo Instructions
    // Register (8-9) - (v0-v1) - This will be used for system calls and system instructions by the user
    // Register (10-13) - (a0-a3) - Will be used to provide arguments for function or system calls by the user
    // Register 14 - gp - Global Pointer - Will be pointing to the start of the global area,
    //                                     can be used to point the starting address of heap in data memory
    // Register 15 - sp - Stack Pointer - Will denote the starting location of stack memory in data memory
    // Register 16 - ra - Return Address - Will Store the address of the instruction where we have to return after function exits
    // Register (17-23) - (t0-t6) - Temprorary Registers - Will be used to store values just required temprorarily
    // Register (24-31) - (s0-s7) - Stored Registers - Will be used to store values required over multiple functions or modules
    reg [31:0] process[0:31]

    //! STEP 3 -- INITIALIZATION OF PROGRAM COUNTER AND OTHER SYSTEM CONTROLLED REGISTERS INSIDE THE PROCESSOR
    // reset will be activated for a very small time during the starting of the execution. That will be used by the processor
    // to intiate all the registers in it.
    // It will also be used by other modules instantiated in PROCESSOR for resetting there induvidual memory
    always @(posedge reset) begin
        signal <= 0;  // Set the signal to be 0 initially
        process[0] <= 0; // Set PC as 0 (start of the program)
        process[5] <= 0; // Clear the IR Register
        process[6] <= 0; // Register r0 always hardwired to 0
        process[7] <= 0; // Register at set to 0
        integer i;
        for(i=8;i<=13;i=i+1) begin process[i] <= 0; end // Clear all v and a registers in processor
        process[14] <= 0;   // Global Pointer initialized at the top of the Data Memory
        process[15] <= 255; // Stack Pointer initialized at the end of the Data Memory
        process[16] <= 0; // Register ra set to 0
        for(i=17;i<=31;i=i+1) begin process[i] <= 0; end // Clear all t and s registers in processor
    end

    //! STEP 4 -- INSTRUCTION FETCH PHASE (MODULE WILL BE CALLED WHICH WILL LOAD THE NEXT INSTRUCTION IN IR REGISTER)
    // The instr_fetch module will be used to run the IR register and get the instruction to be decoded next inside the
    // IR register.
    // It will also use the reset signal to reset its internal memory register where the IR is stored and output at a clock posedge.
    // process[0] -> The PC register value
    // process[5] -> The IR register value
    instr_fetch fetch(clk,reset,process[0],instr,process[5]);

    //! STEP 5 -- INSTRUCTION DECODE PHASE (READ THE IR REGISTER AND SEND THE CONTROL TO THAT PARTICULAR INSTRUCTION DATA PATH)
    /// The instr_decode module will be used to decode the instruction currently present in the IR register.
    /// The instructions are encoded within the following categories broadly -
    // R type Instructions (32 bits) = Opcode (6 bits) + Argument 1 (5 bits) + Argument 2 (5 bits) + Destination (5 bits)
    //                                + Shift Amount (5 bits) + Function (6 bits)
    // I type Instructions (32 bits) = Opcode (6 bits) + Argument 1 (5 bits) + Destination (5 bits)
    //                                + Constant (16 bits)
    // J type Instructions (32 bits) = Opcode (6 bits) + Constant (26 bits)
    /// The ISA CSE-BUBBLE Implements the following 25 Instructions which are explained below -
    /// 6 Airthemetic Instructions
    // 1:  add r0, r1, r2   - R type - Opcode: 0 Function: 0
    // 2:  sub r0, r1, r2   - R type - Opcode: 0 Function: 1
    // 3:  addu r0, r1, r2  - R type - Opcode: 0 Function: 2
    // 4:  subu r0, r1, r2  - R type - Opcode: 0 Function: 3
    // 5:  addi r0, r1, 100 - I type - Opcode: 1
    // 6:  addiu r0, r1, 10 - I type - Opcode: 2
    /// 6 Logical Instructions
    // 7:  and r0, r1, r2   - R type - Opcode: 3 Function: 0
    // 8:  or r0, r1, r2    - R type - Opcode: 4 Function: 0
    // 9:  andi r0, r1, 10  - I type - Opcode: 5
    // 10: ori r0, r1, 100  - I type - Opcode: 6
    // 11: sll r0, r1, 10   - I type - Opcode: 7 Function: 0
    // 12: srl r0, r1, 100  - I type - Opcode: 7 Function: 1
    /// 2 Data Transfer Instructions
    // 13: lw r0, 10(r1)    - I type - Opcode: 8
    // 14: sw r0, 10(r1)    - I type - Opcode: 9
    /// 6 Conditional Branching Instructions
    // 15: beq r0, r1, 10   - I type - Opcode: 10
    // 16: bne r0, r1, 100  - I type - Opcode: 11
    // 17: bgt r0, r1, 10   - I type - Opcode: 12
    // 18: bgte r0, r1, 100 - I type - Opcode: 13
    // 19: ble r0, r1, 10   - I type - Opcode: 14
    // 20: bleq r0, r1, 100 - I type - Opcode: 15
    /// 3 Unconditional Branch Instructions
    // 21: j 100            - J type - Opcode: 16
    // 22: jr r0            - J type - Opcode: 17
    // 23: jal 1000         - J type - Opcode: 18
    /// 2 Comparison Instructions
    // 24: slt r0, r1, r2   - R type - Opcode: 19 Function: 0
    // 25: slti r0, r1, 100 - I type - Opcode: 20
    /// Other Special System Instructions
    // 26: syscall          - Opcode: 21
    // 27: display          - Opcode: 22
    // 28: input            - Opcode: 23
    // 29: exit             - Opcode: 24
    /// This register will contain the ID of the instruction which will later be used by the top module of the ALU.
    reg [31:0] instr_ID;
    /// This is a combinational decoder logic and does not require and clock signal for helping in the execution.
    instr_decode decode(process[5],instr_ID);

    //! STEP 6 -- CALLING THE TOP MODULES OF VARIOUS PARTS OF THE PROCESSOR TO IMPLEMENT THE INSTRUCTION AS REQUIRED
    /// For the particular decoded ID of the instruction we will call the top modules for ALU ad Branching Statements which will
    /// later on decide what to do according to the instruction ID.
    /// It outputs the changes required in the data memory and processor register.
    /// Each instruction will have its own data path of execution which will be pointed to from here.
    
    /// This is the top module of control for all Airthmetic Logic Operations in the Processor. This module instantiates
    /// the other sub-modules for various ALU tasks. It works on the processor registers only.
    // alu_top alu(clk,reset,instr_ID,data);

    /// This is the top module of control for all Data Transfer Operations in the Processor. This module instantiates the
    /// other data loading and storing modules. This works on both data memory and processor registers.
    // data_transfer_top transfer(clk,reset,processor,data);
    
    /// This is the top module of control for all Branching Operations in the Processor. This module instantiates the
    /// other branching related modules. This works on both instruction memory and processor registers.
    // branch_top branch(clk,reset,process[0],instr_ID,data);
    
    /// This is the top module for implementation of all system instructions which are the special processor instructions
    /// independent of the R, I and J type classification.
    // system_top sys(clk,reset,instr_ID,process);

    //! STEP 7 -- INCREMENT THE PC UPON POSEDGE OF CLOCK FOR READING THE NEXT INSTRUCTION

    //! STEP 8 -- MAKE THE OUTPUT "SIGNAL" = 1 TO SIGNAL THE CALLING TEST BENCH THAT THE PROGRAM EXECUTION IS FINISHED
    // When the PC becomes equal to final instruction location than the signal will be set.
    // When the signal is set the processor does not allow the Program Counter to move further and waits for the top-module to finish
    // The execution of the program.
    assign signal = (process[0] == final) ? 1'b1 : 1'b0;

endmodule

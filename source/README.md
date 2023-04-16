# SOURCE
Source code for the Instruction Set Architecture being implemented in Verilog

## FILES INCLUDED
1) *processor.v* - The top central module which will be called by the user program. It simulates the CPU which will handle the whole execution of the program.
2) *decode.v* - Contains the instruction decode phase of the fsm.
3) *memory.v* - All data and instruction memory modules are present in it.
4) *branching.v* - Implements the execution of all conditional and unconditional branch instructions.
5) *alu.v* - Implements all arithmetic, logical and comparison instructions.

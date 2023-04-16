# SOURCE
Source code for the Instruction Set Architecture being implemented in Verilog

## FILES INCLUDED
1) *processor.v* - The top central module which will be called by the user program. It simulates the CPU which will handle the whole execution of the program.
2) *instr_fetch.v* - The module which will put the next instruction to be executed in the IR register on a posedge of clock.
3) *instr_decode.v* - Will send the processor to a particular data path to execute the instruction currently present in the IR register.

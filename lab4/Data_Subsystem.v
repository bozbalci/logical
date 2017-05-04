`timescale 1ns / 1ps

module Data_Subsystem (
    output [23:0] MemAddr,
    input [31:0] fromMemData,
    output [31:0] toMemData,
    output [31:0] Instr,
    output ZE,
    output NG,
    output CY,
    output OV,
    input [4:0] AddrA,
    input [4:0] AddrB,
    input [4:0] AddrC,
    input [3:0] ALUop,
    input WrC,
    input WrPC,
    input WrCR,
    input WrIR,
    input Mem_ALU,
    input PC_RA,
    input IR_RB,
    input ALU_PC,
    input ZE_SE,
    input Sin_Sout,
    input Clk,
    input Reset
);

/* Do not modify above this line! */

/* ALU wires. A_in and B_in are operands. ALUdata is the output,
* it is also referred to as PCin later in this file.
*/
wire [31:0] A_in;
wire [31:0] B_in;
wire [31:0] ALUdata;
wire [3:0] Cond;

/* PC register's output. */
wire [23:0] PCout;

/* Instruction register's output. */
wire [31:0] IRout;
assign Instr = IRout;

/* Connection between the switch and Mux1. */
wire [31:0] Bout;

/* Output of the Extender module. */
wire [31:0] EXTout;

/* Inputs/outputs of the register file. */
wire [31:0] DataA;
wire [31:0] DataB;
wire [31:0] DataC;

Extender extender (IRout, ZE_SE, EXTout);

Switch32 switch (fromMemData, toMemData, Bout, DataB, Sin_Sout);

ALU alu (A_in, B_in, ALUop, ALUdata, Cond);

Reg_File register_file(AddrA, AddrB, AddrC, DataA, DataB, DataC,
    WrC, Reset, Clk
);

Register4 CR (Cond, {ZE, NG, CY, OV}, WrCr, Reset, Clk);
Register24 PC (ALUdata[23:0], PCout, WrPC, Reset, Clk); /* ALUdata is PCin */
Register32 IR (Bout, IRout, WrIR, Reset, Clk);

Mux32 mux1 (ALUdata, Bout, Mem_ALU, DataC);
Mux32 mux2 ({8'b0,PCout}, DataA, PC_RA, A_in);
Mux32 mux3 (DataB, EXTout, IR_RB, B_in);
Mux24 mux4 (PCout, ALUdata[23:0], ALU_PC, MemAddr);

endmodule

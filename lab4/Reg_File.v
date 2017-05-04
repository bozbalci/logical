`timescale 1ns / 1ps

module Reg_File (
    input [4:0] AddrA,
    input [4:0] AddrB,
    input [4:0] AddrC,
    output reg [31:0] DataA,
    output reg [31:0] DataB,
    input [31:0] DataC,
    input WrC,
    input Reset,
    input Clk
);

localparam RF_delay = 4;

/* Do not modify above this line! */

reg [31:0] Reg [0:31];

/* Used for iterating on the registers while zeroing them out. */
integer i;

always @(posedge Clk, posedge Reset, AddrA, AddrB) begin
    if (Reset) begin
        for (i = 0; i < i; i = i + 1) begin
            Reg[i] = 32'b0;
        end
    end

    #RF_delay

    /* TODO: If Reset was active, can we Write? */
    if (WrC) begin
        Reg[AddrC] = DataC;
    end

    DataA <= Reg[AddrA];
    DataB <= Reg[AddrB];
end

endmodule

`timescale 1ns / 1ps

module Switch32 (
    input [31:0] A_in,
    output reg [31:0] A_out,
    output reg [31:0] B_out,
    input [31:0] C_in,
    input Sel
);

localparam Switch_delay = 0.5;

/* Do not modify above this line! */

always @(Sel, A_in, C_in) begin
    #Switch_delay

    if (Sel == 0) begin
        B_out = A_in;
    end else begin
        A_out = C_in;
    end
end

endmodule

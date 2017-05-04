`timescale 1ns / 1ps

module Extender (
    input [31:0] X_in,
    input ZE_SE,
    output reg [31:0] X_out
);

localparam Ext_delay = 0.5;

/* Do not modify above this line! */

always @(X_in, ZE_SE) begin
    #Ext_delay

    if (ZE_SE == 0) begin
        /* Extend with zero. */
        X_out = {16'b0, X_in[15:0]};
    end else begin
        /* Extend according to the sign. */
        if (X_in[15] == 1) begin
            X_out = {16'hFFFF, X_in[15:0]};
        end else begin
            X_out = {16'b0, X_in[15:0]};
        end
    end
end

endmodule

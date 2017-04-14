`timescale 1ns / 1ps
module testbench_MUX (
);

reg [31:0] A_in;
reg [31:0] B_in;
reg Sel;
wire [31:0] Data_out;

Mux32 INS(A_in, B_in, Sel, Data_out);

initial begin
    A_in = 32'b01010101010101010101010101010101;
    B_in = 32'b10101010101010101010101010101010;
    Sel = 0;
end

initial begin
    $monitor("time=%d, out=%b", $time, Data_out);
end

initial begin
#1; // 1
    Sel = 1;
#6; // 7
    Sel = 0;
#10; // 17
    A_in = 32'b11111010101010101010101010101010;
#10; // 27
    Sel = 0;
#10; // 37
    B_in = 32'b00000000000000000000000000000000;
#10; // 47
    A_in = 32'b11101111111111111111111111111111;
#10; // 57
    Sel = 1;
#10; // 67
    $finish;
end
endmodule

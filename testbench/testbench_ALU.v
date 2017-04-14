`timescale 1ns / 1ps

module testbench_ALU (
);

reg [3:0] A;
reg [3:0] B;
reg [3:0] ALUop;
wire [3:0] C;
wire [3:0] Cond;

ALU INS(A, B, ALUop, C, Cond);

initial begin
    $monitor("time=%d, ALUop=%b, A=%b, B=%b, C=%b, Cond=%b",
        $time, ALUop, A, B, C, Cond);
end

initial begin
    A = 4'b0000;
    B = 4'b0001;
    ALUop = 4'b0000;
end

initial begin
#10;
    ALUop = 4'b0001;
    A = 4'b1111;
    B = 4'b0001;
#10;
    A = 4'b1100;
#10;
    B = 4'b0011;
#10;
    B = 4'b0111;
#10;
    ALUop = 4'b0000;
#10;
    A = 4'b0000;
#10;
    ALUop = 4'b0001;
#10;
    B = 4'b0001;
#10;
    ALUop = 4'b0001;
    A = 4'b1111;
#10;
    ALUop = 4'b0010;
    A = 4'b0000;
#10;
    ALUop = 4'b0001;
    A = 4'b0111;
#10;
    ALUop = 4'b0010;
    A = 4'b1000;
#10;
    ALUop = 4'b0001;
    A = 4'b0100;
    B = 4'b0100;
#10;
    A = 4'b1000;
    B = 4'b1000;
#10;
    A = 4'b0100;
    B = 4'b0001;
#10;
    A = 4'b0110;
    B = 4'b1001;
#10;
    A = 4'b1000;
    B = 4'b0001;
    $finish;
end
endmodule

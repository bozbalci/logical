`timescale 1ns / 1ps

module Memory (
    input [23:0] Addr,

    /* When set to 1, read as a word, otherwise read a byte. */
    input Length,

        input Rd,
        input Wr,
        input Enable,
        output reg Rdy,
        input [31:0] DataIn,
        output reg [31:0] DataOut
    );

    localparam Tmem = 8;
    localparam Td = 0.2;

    /* Do not modify above this line! */

    initial begin
        Rdy = 1;
    end

    /* Initialize a 16 MB memory. The following line initializes
    * 2^24 words, each of them 8-bits wide. */
   reg [7:0] Mem [0:'h00FFFFFF];

   always @(posedge Wr, posedge Rd)
   begin

       if (Enable && Rdy) begin
           #Td Rdy = 0;

           if (Rd) begin
               if (Length == 0) begin
                   /* Read a single byte. */

                   #(Tmem - Td) DataOut = {24'b0, Mem[Addr]};
           end else begin
               /* Read a word. */

               #(Tmem - Td) DataOut = {
                   Mem[{Addr[23:2], 2'b11}],
                   Mem[{Addr[23:2], 2'b10}],
                   Mem[{Addr[23:2], 2'b01}],
                   Mem[{Addr[23:2], 2'b00}]
                   };
               end

               Rdy = 1;
           end

           if (Wr) begin
               if (Length == 0) begin
                   /* Write a single byte. */

                   #(Tmem - Td) Mem[Addr] = DataIn[7:0];
               end else begin
                   /* Write a word. */

                   #(Tmem - Td)

                   Mem[{Addr[23:2], 2'b00}] <= DataIn[7:0];
                   Mem[{Addr[23:2], 2'b01}] <= DataIn[15:8];
                   Mem[{Addr[23:2], 2'b10}] <= DataIn[23:16];
                   Mem[{Addr[23:2], 2'b11}] <= DataIn[31:24];
               end

               Rdy = 1;
           end
       end
   end

endmodule

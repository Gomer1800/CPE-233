`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 02/19/2019 08:12:12 PM
// Design Name: 
// Module Name: ClockDivider
//////////////////////////////////////////////////////////////////////////////////

module ClockDivider(
    input clk,
    output logic sclk);

  localparam MAX_COUNT = 2272727; 
  logic [26:0] count = 0;

   always_ff @ (posedge clk)              
   begin
        count <= count + 1;
         if (count == MAX_COUNT) 
         begin
            count <= 0; 
            sclk <= ~sclk;
         end          
   end
endmodule
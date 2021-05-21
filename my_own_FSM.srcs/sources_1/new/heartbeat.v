`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2021 08:55:21 PM
// Design Name: 
// Module Name: heartbeat
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module heartbeat(
clk,reset,beat
    );
input wire clk,reset;
output wire beat;
reg [31:0] counter;
parameter TOPCOUNT = 100_000_000;
always @ (posedge clk) begin
if (reset || counter == TOPCOUNT-1) 
counter <= 32'b0;
else 
counter <= counter + 1;
end
assign beat = (counter == TOPCOUNT-1);



endmodule

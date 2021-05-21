`timescale 1ns / 1ps
module spot (
input wire clk,
input wire spot_inN,
input wire spot_inS,
input wire spot_inW,
input wire spot_inE,
output wire spot_outN,
output wire spot_outS,
output wire spot_outW,
output wire spot_outE);
reg N;
reg S;
reg E;
reg W;
// you write the module code!
/* it is not difficult; you will need a one-line clocked process to infer the D-flip-flop, and a
continuous assignment to generate the output.*/
always @ (posedge clk)begin
N <= (~spot_inN);
E <= (~spot_inE);
S <= (~spot_inS);
W <= (~spot_inW);
end

assign spot_outN = N & spot_inN;
assign spot_outS = S & spot_inS;
assign spot_outE = E & spot_inE;
assign spot_outW = W & spot_inW;
endmodule
`timescale 1ns / 1ps
module debouncer (
input wire NB,
input wire EB,
input wire WB,
input wire SB,
//switchIn
input wire clk,
input wire reset,
output wire debounceoutN,
output wire debounceoutS,
output wire debounceoutW,
output wire debounceoutE);

wire beat;
heartbeat #(
.TOPCOUNT(6600_000)//66ms
) debouncebeat (
.clk(clk),
.reset(reset),
//.enable(1'b1),//!!!!!!!!!!!!!
.beat(beat)
);

reg[2:0] pipelineN;
reg[2:0] pipelineS;
reg[2:0] pipelineW;
reg[2:0] pipelineE;

always @(posedge clk) begin
if (beat) begin
pipelineN[0] <= NB;
pipelineN[1] <= pipelineN[0];
pipelineN[2] <= pipelineN[1];
pipelineS[0] <= SB;
pipelineS[1] <= pipelineS[0];
pipelineS[2] <= pipelineS[1];
pipelineW[0] <= WB;
pipelineW[1] <= pipelineW[0];
pipelineW[2] <= pipelineW[1];
pipelineE[0] <= EB;
pipelineE[1] <= pipelineE[0];
pipelineE[2] <= pipelineE[1];
end
 
/*always @(posedge clk) begin
if (beat) begin
pipelineS[0] <= SB;
pipelineS[1] <= pipelineS[0];
pipelineS[2] <= pipelineS[1];
end 

always @(posedge clk) begin
if (beat) begin
pipelineW[0] <= WB;
pipelineW[1] <= pipelineW[0];
pipelineW[2] <= pipelineW[1];
end 
always @(posedge clk) begin
if (beat) begin
pipelineE[0] <= EB;
pipelineE[1] <= pipelineE[0];
pipelineE[2] <= pipelineE[1];
end */
/*else if(reset)begin
pipeline[0] <= 1'b0;
pipeline[1] <= 1'b0;
pipeline[2] <= 1'b0;
end*/
end
assign debounceoutN = &pipelineN;
assign debounceoutS = &pipelineS;
assign debounceoutW = &pipelineW;
assign debounceoutE = &pipelineE;

endmodule

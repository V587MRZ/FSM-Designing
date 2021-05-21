`timescale 1ns / 1ps
// trigger signal 
module my_FSM_top(
    input wire clk,
    input wire reset,
    input wire btn_N,
    input wire btn_S,
    input wire btn_E,
    input wire btn_W,
    output wire [15:0] LED
    );
    wire spot_inN,spot_inS,spot_inE,spot_inW, spot_outN,spot_outS,spot_outE,spot_outW, deb_outN, deb_outS, deb_outW, deb_outE; 
    assign spot_inN = deb_outN;
    assign spot_inW = deb_outW;
    assign spot_inS = deb_outS;
    assign spot_inE = deb_outE;
    debouncer deb (.NB(btn_N),.EB(btn_E),.SB(btn_S),.WB(btn_W), .clk(clk), .debounceoutN(deb_outN), .debounceoutS(deb_outS), .debounceoutW(deb_outW), .debounceoutE(deb_outE), .reset(reset));
    spot spot (.spot_inN(spot_inN),.spot_inS(spot_inS),.spot_inW(spot_inW),.spot_inE(spot_inE), .spot_outN(spot_outN),.spot_outW(spot_outW),.spot_outS(spot_outS),.spot_outE(spot_outE), .clk(clk));
    FSM fsm (.clk(clk), .reset(reset), .btn_N(spot_outN), .btn_S(spot_outS), .btn_E(spot_outE), .btn_W(spot_outW), .LED(LED));
endmodule
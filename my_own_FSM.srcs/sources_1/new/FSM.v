`timescale 1ns / 1ps


module FSM(
input wire clk,
input wire reset,
input wire btn_N,
input wire btn_S,
input wire btn_E,
input wire btn_W,
output reg [15:0] LED);
reg [2:0] state, nextstate;
parameter N=2'b10,S=2'b01,W=2'b00,E=2'b11;
parameter IDLE = 3'b0, S1 =3'd1, S2=3'd2, S3=3'd3, S4=3'd4, S5=3'd5, S6=3'd6, READY = 3'b111;
wire [11:0] correct_steps;
reg [11:0] entered_steps;
reg [15:0] led;
assign correct_steps= {E,N,N,E,S,S};
wire beat, dclk;


always @(posedge clk) begin // register logic
if (reset) state <= IDLE;
else state <= nextstate; end

always @(posedge clk) begin // nextstate login
case(state)
IDLE: if(btn_N||btn_S||btn_E||btn_W) nextstate = S1;
else nextstate = IDLE;
S1: if(btn_N||btn_S||btn_E||btn_W) nextstate = S2;
else nextstate = S1;
S2: if(btn_N||btn_S||btn_E||btn_W) nextstate = S3;
else nextstate = S2;
S3: if(btn_N||btn_S||btn_E||btn_W) nextstate = S4;
else nextstate = S3;
S4: if(btn_N||btn_S||btn_E||btn_W) nextstate = S5;
else nextstate = S4;
S5: if(btn_N||btn_S||btn_E||btn_W) nextstate = S6;
else nextstate = S5;
S6: if(btn_N||btn_S||btn_E||btn_W) nextstate = READY;
else nextstate = S6;
READY: if(reset||btn_N||btn_S||btn_E||btn_W) nextstate = IDLE;
else nextstate = READY; 
default:; endcase end

always @(posedge clk) begin // state/output logic and external logic
case(state)
IDLE: begin LED <= led;
entered_steps <= 12'b0; end
S1:begin LED <= led;
         if(btn_N) entered_steps[11:10] <= N;  
        else if(btn_S)  entered_steps[11:10] <= S;  
        else if(btn_W)  entered_steps[11:10] <= W;  
        else if(btn_E)  entered_steps[11:10] <= E;    
end
S2: begin LED <= led;
        if(btn_N) entered_steps[9:8] <= N;  
        else if(btn_S)  entered_steps[9:8] <= S;  
        else if(btn_W)  entered_steps[9:8] <= W;  
        else if(btn_E)  entered_steps[9:8] <= E;   
end
S3: begin LED <= led;
        if(btn_N) entered_steps[7:6] <= N;  
        else if(btn_S)  entered_steps[7:6] <= S;  
        else if(btn_W)  entered_steps[7:6] <= W;  
        else if(btn_E)  entered_steps[7:6] <= E;  end
S4: begin LED <= led;
        if(btn_N) entered_steps[5:4] <= N;  
        else if(btn_S)  entered_steps[5:4] <= S;  
        else if(btn_W)  entered_steps[5:4] <= W;  
        else if(btn_E)  entered_steps[5:4] <= E;  end
S5: begin LED <= led;
        if(btn_N) entered_steps[3:2] <= N;  
        else if(btn_S)  entered_steps[3:2] <= S;  
        else if(btn_W)  entered_steps[3:2] <= W;  
        else if(btn_E)  entered_steps[3:2] <= E;   end
S6: begin LED <= led;
        if(btn_N) entered_steps[1:0] <= N;  
        else if(btn_S)  entered_steps[1:0] <= S;  
        else if(btn_W)  entered_steps[1:0] <= W;  
        else if(btn_E)  entered_steps[1:0] <= E;   end
READY: LED <= led;
default:;
endcase end

always @(posedge clk) begin
case(state)
IDLE: led <= 16'b1010101010101010;
S1: led <= 16'b1;
S2: led <= 16'b0000000000000011;
S3: led <= 16'b0000000000000111;
S4: led <= 16'b0000000000001111;
S5: led <= 16'b0000000000011111;
S6: led <= 16'b0000000000111111;
READY: begin if (entered_steps == correct_steps) led <= ~(16'd0); 
else led <= 16'b0; end

default:;
endcase end

endmodule

`timescale 1ns / 1ps

module pc #(parameter WIDTH = 32)(
	input wire clk,rst,stallF,
	input wire [WIDTH-1:0] pcnext,
	output reg [WIDTH-1:0] pc,
	output reg ce
    );


	always @(posedge clk) begin
        if(rst) begin
            ce <= 0;
        end
        else begin
            ce <= 1;
        end
    end
	always @(posedge clk) begin
		if(!ce) 
			pc <= 32'hbfc00000;
		else if(~stallF) 
			pc <= pcnext;
		
	end
endmodule

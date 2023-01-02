`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/12 11:26:03
// Design Name: 
// Module Name: hilo_reg
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


module hilo_reg(
	input  wire clk,rst,we,
	input  wire [1:0] wconfig,
	input  wire [31:0] hi_i,lo_i,
	output wire [31:0] hi_o,lo_o
    );
	
	reg [31:0] hi, lo;
	always @(posedge clk) begin
		if(rst) begin
			hi <= 0;
			lo <= 0;
		end else begin
            if(wconfig[1])
                hi <= hi_i;
            else
                hi <= hi;
            if(wconfig[0])
                lo <= lo_i;
            else
                lo <= lo;
        end
	end

	assign hi_o = hi;
	assign lo_o = lo;
endmodule
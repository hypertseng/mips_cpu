`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/26 21:25:26
// Design Name: 
// Module Name: pc
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


module pc #(parameter WIDTH = 32)(
	input wire clk,rst,en,
	input wire[WIDTH-1:0] d,
	output reg[WIDTH-1:0] q
    );
	always @(posedge clk,posedge rst) begin
		if(rst) begin
			q <= 0;
		end else if(en) begin
			/* code */
			q <= d;
		end
	end
endmodule
// module pc_reg #(parameter WIDTH=32)(
//     input wire clk,
//     input wire stallF,
//     input wire rst,
//     input wire [WIDTH-1:0] pc_next,

//     output reg [ WIDTH-1:0] pc,
//     output reg ce
// );
//     always @(posedge clk) begin
//         if(rst) begin
//             ce <= 0;
//         end
//         else begin
//             ce <= 1;
//         end
//     end

//     always @(posedge clk) begin
//         if(!ce) begin
//             // pc <= 32'hbfbffffc;
//             pc <= 32'hbfc00000;
//             // pc <= 32'h0000_0000;
//         end
//         else if(~stallF) begin
//             pc <= pc_next;
//         end
//     end
// endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/22 10:23:13
// Design Name: 
// Module Name: hazard
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


module hazard(
	//fetch stage
	output wire stallF,
	output wire flushF,
	//decode stage
	input wire[4:0] rsD,rtD,
	input wire branchD,
	output wire forwardaD,forwardbD,
	output wire stallD,
	output wire flushD,
	//execute stage
	input wire stall_divE,
	input wire[4:0] rsE,rtE,
	input wire[4:0] writeregE,
	input wire regwriteE,
	input wire[1:0] memtoregE,
	output wire[1:0] forwardaE,forwardbE,
	output wire flushE,stallE,
	//mem stage
	input wire[4:0] writeregM,
	input wire regwriteM,
	input wire[1:0] memtoregM,

	//write back stage
	input wire[4:0] writeregW,
	input wire regwriteW
    );

	wire lwstallD,branchstallD;

	//forwarding sources to D stage (branch equality)
	assign forwardaD = (rsD != 0 & rsD == writeregM & regwriteM);
	assign forwardbD = (rtD != 0 & rtD == writeregM & regwriteM);
	
	//forwarding sources to E stage (ALU)
	assign forwardaE = rsE !=0 && regwriteM && (rsE == writeregM) ? 2'b01 :
					   rsE !=0 && regwriteW && (rsE == writeregW) ? 2'b10 : 2'b00;
					   
	assign forwardbE = rtE !=0 && regwriteM && (rtE == writeregM) ? 2'b01 :
					   rtE !=0 && regwriteW && (rtE == writeregW) ? 2'b10 : 2'b00;

	// always @(*) begin
	// 	forwardaE = 2'b00;
	// 	forwardbE = 2'b00;
	// 	if(rsE != 0) begin
	// 		/* code */
	// 		if(rsE == writeregM & regwriteM) begin
	// 			/* code */
	// 			forwardaE = 2'b10;
	// 		end else if(rsE == writeregW & regwriteW) begin
	// 			/* code */
	// 			forwardaE = 2'b01;
	// 		end
	// 	end
	// 	if(rtE != 0) begin
	// 		/* code */
	// 		if(rtE == writeregM & regwriteM) begin
	// 			/* code */
	// 			forwardbE = 2'b10;
	// 		end else if(rtE == writeregW & regwriteW) begin
	// 			/* code */
	// 			forwardbE = 2'b01;
	// 		end
	// 	end
	// end

	//stalls
	assign #1 lwstallD = (memtoregE == 2'b01) & (rtE == rsD | rtE == rtD);
	assign #1 branchstallD = branchD &
				(regwriteE & 
				(writeregE == rsD | writeregE == rtD) |
				(memtoregM == 2'b01) &
				(writeregM == rsD | writeregM == rtD));
// stall by div
	// assign #1 stallD = lwstallD | branchstallD | stall_divE;
	// assign #1 stallF = stallD | stall_divE;
	// 	//stalling D stalls all previous stages
	// assign #1 flushE = stallD;
	// assign #1 stallE = stall_divE;

	//////// new add by stall_divE, see if can merge ///////
	assign stallF = stall_divE;
	assign stallD = stall_divE;
	assign stallE = stall_divE;
	assign stallM = 1'b0;
	assign stallW = 1'b0;
// test if stall is correct without div
	assign #1 stallD = lwstallD | branchstallD;
	assign #1 stallF = stallD;
		//stalling D stalls all previous stages
	// assign flushE = ~stall_divE;
	assign flushE = 0;
	// assign #1 flushE = stallD;
	assign #1 stallE = 0;

		//stalling D flushes next stage
	// Note: not necessary to stall D stage on store
  	//       if source comes from load;
  	//       instead, another bypass network could
  	//       be added from W to M
  	assign flushF = 1'b0;
//    assign flushD = ((branchE & predict_wrong) | exceptionoccur) & (~longest_stall);
    assign flushD = 1'b0;
endmodule

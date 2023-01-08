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
	input wire branchD,jumprD,
	output wire forwardaD,forwardbD,
	output wire stallD,
	output wire flushD,
	//execute stage
	// input wire stall_divE,
	input wire[4:0] rsE,rtE,
	input wire[4:0] writeregE,
	input wire regwrite_enE,
	input wire[1:0] memtoregE,
	output wire[1:0] forwardaE,forwardbE,
	output wire flushE,stallE,
	//mem stage
	input wire[4:0] writeregM,
	input wire regwrite_enM,
	input wire[1:0] memtoregM,

	//write back stage
	input wire[4:0] writeregW,
	input wire regwrite_enW,

    input wire i_stall,       // 两个访存 stall信号
    input wire d_stall,
	output wire longest_stall // 全局stall指令
    );

	wire lwstall,branchstallD,jrstall;

	//forwarding sources to D stage (branch equality)
	assign forwardaD = (rsD != 0 & rsD == writeregM & regwrite_enM);
	assign forwardbD = (rtD != 0 & rtD == writeregM & regwrite_enM);
	
	//forwarding sources to E stage (ALU)
	assign forwardaE = rsE !=0 && regwrite_enM && (rsE == writeregM) ? 2'b10 :
					   rsE !=0 && regwrite_enW && (rsE == writeregW) ? 2'b01 : 2'b00;
					   
	assign forwardbE = rtE !=0 && regwrite_enM && (rtE == writeregM) ? 2'b10 :
					   rtE !=0 && regwrite_enW && (rtE == writeregW) ? 2'b01 : 2'b00;

	// stall by div
	// assign #1 stallD = lwstall | branchstallD | stall_divE;
	// assign #1 stallF = stallD | stall_divE;
	// 	//stalling D stalls all previous stages
	// assign #1 flushE = stallD;
	// assign #1 stallE = stall_divE;

	//////// new add by stall_divE, see if can merge ///////
	// assign stallF = stall_divE;
	// assign stallD = stall_divE;
	// assign stallE = stall_divE;

	// test if stall is correct without div
	// assign #1 stallF = stallD;
	// assign #1 stallD = lwstall | branchstallD;
	//stalling D stalls all previous stages
	// assign flushE = ~stall_divE;
	// assign flushE = 0;
	// assign #1 flushE = stallD;
	// assign #1 stallE = 0;

	//stalling D flushes next stage
	// Note: not necessary to stall D stage on store
  	//       if source comes from load;
  	//       instead, another bypass network could
  	//       be added from W to M
  	//stalls
	assign #1 lwstallD = memtoregE & (rtE == rsD | rtE == rtD);
	assign #1 branchstallD = branchD &
				(regwrite_enE & 
				(writeregE == rsD | writeregE == rtD) |
				memtoregM &
				(writeregM == rsD | writeregM == rtD));
//    assign jrstall = (jumprD & regwrite_enE & ((writeregE == rsD) | (writeregE == rtD)))|
//                     (jumprD & memtoregM & ((writeregM == rsD) | (writeregM == rtD)));
//	assign #1 stallD = lwstallD | jrstall;
    assign #1 stallD = lwstallD;
	assign #1 stallF = stallD;
		//stalling D stalls all previous stages
	assign #1 flushE = stallD;
    assign stallE = 0;

    // assign stallF = (longest_stall | lwstall | jrstall) & ~exceptionoccur;
    // assign stallD = longest_stall | lwstall | jrstall;
    // assign stallE = longest_stall;
    // assign stallM = longest_stall;
    // assign stallW = longest_stall;

    // assign flushF = 1'b0;
    // assign flushD = ((branchE & predict_wrong) | exceptionoccur) & (~longest_stall);
    // assign flushE = (lwstall | jrstall         | exceptionoccur) & (~longest_stall); // TODO:exceptionoccur信号用于异常时清除所有的寄存器，还未完全测试
    // assign flushM = (exceptionoccur                            ) & (~longest_stall);
    // assign flushW = (exceptionoccur                            ) & (~longest_stall);
endmodule

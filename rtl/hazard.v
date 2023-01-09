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
	input wire predict_wrong,
	output wire forwardaD,forwardbD,
	output wire stallD,
	output wire flushD,
	//execute stage
	// input wire stall_divE,
	input wire[4:0] rsE,rtE,
	input wire[4:0] writeregE,
	input wire branchE,
	input wire regwrite_enE,
	input wire[1:0] memtoregE,
	input wire div_stallE,
	output wire[1:0] forwardaE,forwardbE,
	output wire flushE,stallE,
	//mem stage
	input wire[4:0] writeregM,
	input wire regwrite_enM,
	input wire[1:0] memtoregM,
	output wire stallM,
	output wire flushM,
	//write back stage
	input wire[4:0] writeregW,
	input wire regwrite_enW,
	output wire stallW,
	output wire flushW,

    input wire i_stall,       // 两个访存 stall信号
    input wire d_stall,
	output wire longest_stall // 全局stall指令
    );

	wire lwstallD,branchstallD,jrstall;

	//forwarding sources to D stage (branch equality)
	assign forwardaD = (rsD != 5'b0 & (rsD == writeregM) & regwrite_enM);
	assign forwardbD = (rtD != 5'b0 & (rtD == writeregM) & regwrite_enM);
	
	//forwarding sources to E stage (ALU)
	assign forwardaE = ((rsE != 5'b0) && regwrite_enM && (rsE == writeregM)) ? 2'b10 :
					   ((rsE != 5'b0) && regwrite_enW && (rsE == writeregW)) ? 2'b01 : 2'b00;
					   
	assign forwardbE = ((rtE != 5'b0) && regwrite_enM && (rtE == writeregM)) ? 2'b10 :
					   ((rtE != 5'b0) && regwrite_enW && (rtE == writeregW)) ? 2'b01 : 2'b00;


  	//stalls
	assign lwstallD = memtoregE & (rtE == rsD | rtE == rtD);
	assign branchstallD = branchD &
				(regwrite_enE & 
				(writeregE == rsD | writeregE == rtD) |
				memtoregM &
				(writeregM == rsD | writeregM == rtD));
	assign jrstall = jumprD & regwrite_enE & ((writeregE == rsD) | (writeregE == rtD)); //|
	
	// assign stallF = stallD;
	// assign stallD = lwstallD | jrstall;
    // assign stallE = 0;
    // assign stallM = 0;
    // assign stallW = 0;

	// assign flushF = 0;
	// assign flushD = (branchE & predict_wrong) ;
	// assign flushE = stallD;
	// assign flushM = 0;
	// assign flushW = 0;
	assign longest_stall = div_stallE;
    assign stallF = div_stallE | lwstallD | jrstall;
    assign stallD = div_stallE | lwstallD | jrstall;
    assign stallE = div_stallE;
    assign stallM = 1'b0;
    assign stallW = 1'b0;

    assign flushF = 1'b0;
    assign flushD = (branchE & predict_wrong) & (~div_stallE);
    assign flushE = (lwstallD | jrstall) & (~div_stallE);
    assign flushM = 1'b0;
    assign flushW = 1'b0;
endmodule

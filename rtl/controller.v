`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/10/23 15:21:30
// Design Name: 
// Module Name: controller
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


module controller(
	// input wire clk,rst,
	// //decode stage
	// input wire[5:0] opD,functD,
	// output wire pcsrcD,branchD,equalD,jumpD,
	
	// //execute stage
	// input wire flushE,
	// output wire memtoregE,alusrcE,
	// output wire regdstE,regwriteE,	
	// output wire[2:0] alucontrolE,

	// //mem stage
	// output wire memtoregM,memwriteM,regwriteM,
	// //write back stage
	// output wire memtoregW,regwriteW
	//===================下面是新代码====================
	input wire clk,rst,
	input wire [5:0] op,funct,
	input wire [4:0] rs, 
	input wire [4:0] rt,
	output wire memtoreg,memwrite,
    output wire branch,alusrc,
    output wire regdst,regwrite,
	output wire write_al,
	output wire jump,jumpr,
	output wire[7:0] alucontrol,
	output wire invalid, // 保留地址异常
	output wire cp0write // 写入cp0

    );
	
	// //decode stage
	// wire[1:0] aluopD;
	// wire memtoregD,memwriteD,alusrcD,
	// 	regdstD,regwriteD;
	// wire[2:0] alucontrolD;

	// //execute stage
	// wire memwriteE;

	maindec md(
		opD,
		memtoregD,memwriteD,
		branchD,alusrcD,
		regdstD,regwriteD,
		jumpD,
		aluopD
		);
	aludec ad(.funct(funct),.op(op),.rs(rs),.rt(rt),.alucontrol(alucontrol));

	// assign pcsrcD = branchD & equalD;

	//pipeline registers
	// floprc #(8) regE(
	// 	clk,
	// 	rst,
	// 	flushE,
	// 	{memtoregD,memwriteD,alusrcD,regdstD,regwriteD,alucontrolD},
	// 	{memtoregE,memwriteE,alusrcE,regdstE,regwriteE,alucontrolE}
	// 	);
	// flopr #(8) regM(
	// 	clk,rst,
	// 	{memtoregE,memwriteE,regwriteE},
	// 	{memtoregM,memwriteM,regwriteM}
	// 	);
	// flopr #(8) regW(
	// 	clk,rst,
	// 	{memtoregM,regwriteM},
	// 	{memtoregW,regwriteW}
	// 	);
endmodule

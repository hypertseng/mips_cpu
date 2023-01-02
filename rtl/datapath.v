`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/02 15:12:22
// Design Name: 
// Module Name: datapath
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


module datapath(
	input wire clk,rst,
	output wire[31:0] pcF,
	input wire[31:0] instrF,
	output wire memwriteM,
	output wire[3:0] sig_write,
	output wire[31:0] aluoutM,writedataM,
	input wire[31:0] readdataM 
    );
	

//↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓合并后controller部分的连线↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓�?
	wire[31:0] pcnext;
	wire regdstE,alusrcE,pcsrcD,regwriteE,regwriteM,regwriteW;
	wire [1:0] memtoregE,memtoregM,memtoregW;//��Ϊ��λ
	wire flushE;
	//decode stage
	wire [1:0] memtoregD;
	wire memwriteD,alusrcD,regdstD,regwriteD,gprtohiD,gprtoloD;
	//execute stage
<<<<<<< HEAD
	wire memwriteE,gprtohiE,gprtoloE;
	wire gprtohiM,gprtoloM;
	wire gprtohiW,gprtoloW;
//↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑�?
=======
	wire memwriteE,hilowriteE;
	wire hilowriteM;
//↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑�?
>>>>>>> f5dbda4d5745065da05ab83dae1d1ac6fa7bdd3d

 	//FD
	wire [31:0] pcplus4F;
	wire [31:0] pcnextbrFD,pcbranchD;
	wire pc_reg_cef;
	//decode stage
	wire [7:0] alucontrolD;
	wire [31:0] pcplus4D,instrD;
    
	wire forwardaD,forwardbD;
	wire [5:0] opD,functD;
	wire [4:0] rsD,rtD,rdD;
	wire [31:0] signimmD,signimmshD;
	wire [31:0] srcaD,srca2D,srcbD,srcb2D;
	wire [31:0] hi_oD,lo_oD;
	//execute stage
	wire [7:0] alucontrolE;
	wire [31:0] pcplus4E;
	wire [1:0] forwardaE,forwardbE;
	wire [4:0] rsE,rtE,rdE;
	wire [4:0] writeregE;
	wire [31:0] signimmE;
	wire [31:0] srcaE,srca2E,srcbE,srcb2E,srcb3E,srcaM,srcaW;
	wire [31:0] aluoutE;
	wire [63:0] aluout64E;
	wire [31:0] hi_oE,lo_oE;
	//mem stage
	wire [7:0] alucontrolM;
	wire [31:0] WriteDataE_modified
	wire [4:0] writeregM;
	wire [31:0] hi_oM,lo_oM;
	wire [63:0] aluout64M;
	//writeback stage
	wire [7:0] alucontrolW;
	wire [4:0] writeregW;
	wire [31:0] aluoutW,readdataW,resultW,hi_oW,lo_oW;
	

	
	//hazard	
    wire stallF, stallD, stallE, stallW;
    wire flushF, flushD, flushE, flushW;
    wire [1:0] forward_aE, forward_bE;

	// decoder
	maindec md(
		opD,rsD,rtD,functD,
		memtoregD,memwriteD,branchD,alusrcD,regdstD,regwriteD,jumpD,gprtohiD,gprtoloD
		);
	aludec alu_decoder0(
		opD,rsD,rtD,functD,
		alucontrolD,branch_judge_controlD
    );

	

	//pipeline registers
	floprc #(32) regE(
		clk,rst,
		flushE,
		{memtoregD,memwriteD,alusrcD,regdstD,regwriteD,alucontrolD,gprtohiD,gprtoloD},
		{memtoregE,memwriteE,alusrcE,regdstE,regwriteE,alucontrolE,gprtohiE,gprtoloE}
		);
	flopr #(32) regM(
		clk,rst,
<<<<<<< HEAD
		{memtoregE,memwriteE,regwriteE,gprtohiE,gprtoloE},
		{memtoregM,memwriteM,regwriteM,gprtohiM,gprtoloM}
		);
	flopr #(32) regW(
		clk,rst,
		{memtoregM,regwriteM,gprtohiM,gprtoloM},
		{memtoregW,regwriteW,gprtohiW,gprtoloW}
=======
		// 增加ALU控制信号传递
		{memtoregE,memwriteE,regwriteE,alucontrolE,hilowriteE},
		{memtoregM,memwriteM,regwriteM,alucontrolM,hilowriteM}
 		);
	flopr #(32) regW(
		clk,rst,
		// 增加ALU控制信号传递
		{memtoregM,regwriteM,alucontrolM},
		{memtoregW,regwriteW,alucontrolW}
>>>>>>> f5dbda4d5745065da05ab83dae1d1ac6fa7bdd3d
		);

	//hazard detection
	hazard h(
		//fetch stage
		stallF,
		//decode stage
		rsD,rtD,
		branchD,
		forwardaD,forwardbD,
		stallD,
		//execute stage
		rsE,rtE,
		writeregE,
		regwriteE,
		memtoregE,
		forwardaE,forwardbE,
		flushE,
		//mem stage
		writeregM,
		regwriteM,
		memtoregM,
		//write back stage
		writeregW,
		regwriteW
		);
	assign pcplus4F = pcF + 32'h4;



	//next PC logic (operates in fetch an decode)
	mux2 #(32) pcbrmux(pcplus4F,pcbranchD,pcsrcD,pcnextbrFD);
	mux2 #(32) pcmux(pcnextbrFD,
		{pcplus4D[31:28],instrD[25:0],2'b00},
		jumpD,pcnext);

	//regfile (operates in decode and writeback)
	regfile rf(clk,regwriteW,rsD,rtD,writeregW,resultW,srcaD,srcbD);
	//decode�׶ζ�����wb�׶�д��hilo��gpr -> hilo)
    hilo_reg hilo_regD(clk,rst,gprtohiW,gprtoloW,srcaW,srcaW,hi_oD,lo_oD);
    
	//fetch stage logic
	pc #(32) pcreg(clk,rst,stallF,pcnext,pcF,pc_reg_ceF);
	// adder pcadd1(pcF,32'b100,pcplus4F);

	// assign pcnext = sel[2] ? (sel[1] ? (sel[0] ? 32'b0 : pcexceptionM):
    //                               (sel[0] ? pcplus4E : pcbranchM)) :
    //                     (sel[1] ? (sel[0] ? pcjumpE : pcjumpD) :
    //                               (sel[0] ? pcbranchD : pcplus4F))
    //             ;
	assign pcnext = pcplus4E;

	//decode stage
	flopenr #(32) r1D(clk,rst,~stallD,pcplus4F,pcplus4D);
	flopenrc #(32) r2D(clk,rst,~stallD,flushD,instrF,instrD);
	signext se(instrD[15:0],signimmD);
	sl2 immsh(signimmD,signimmshD);
	adder pcadd2(pcplus4D,signimmshD,pcbranchD);
	mux2 #(32) forwardamux(srcaD,aluoutM,forwardaD,srca2D);
	mux2 #(32) forwardbmux(srcbD,aluoutM,forwardbD,srcb2D);
	assign pcsrcD = branchD & (srca2D==srcb2D);

	assign opD = instrD[31:26];
	assign rsD = instrD[25:21];
	assign rtD = instrD[20:16];
	assign rdD = instrD[15:11];
	assign functD = instrD[5:0];

	//execute stage

	id_ex id_ex0(
        .clk(clk),
        .rst(rst),
        .stallE(stallE),
        .flushE(flushE),

		.pc_plus4D(pcplus4D),
		.pc_plus4E(pcplus4E)
		);

	floprc #(32) r1E(clk,rst,flushE,srcaD,srcaE);
	floprc #(32) r2E(clk,rst,flushE,srcbD,srcbE);
	floprc #(32) r3E(clk,rst,flushE,signimmD,signimmE);
	floprc #(5) r4E(clk,rst,flushE,rsD,rsE);
	floprc #(5) r5E(clk,rst,flushE,rtD,rtE);
	floprc #(5) r6E(clk,rst,flushE,rdD,rdE);
	floprc #(32) r7E(clk,rst,flushE,hi_oD,hi_oE);
    floprc #(32) r8E(clk,rst,flushE,lo_oD,lo_oE);
    
	mux3 #(32) forwardaemux(srcaE,resultW,aluoutM,forwardaE,srca2E);
	mux3 #(32) forwardbemux(srcbE,resultW,aluoutM,forwardbE,srcb2E);
	mux2 #(32) srcbmux(srcb2E,signimmE,alusrcE,srcb3E);
	// alu alu(srca2E,srcb3E,alucontrolE,aluoutE);
	alu alu0(.alu_num1(srca2E),
	         .alu_num2(srcb2E),
	         .alucontrol(alucontrolE),
             .alu_out_64(aluout64E), //����64λ�˳����
	         .alu_out(aluoutE)
	);
	mux2 #(5) wrmux(rtE,rdE,regdstE,writeregE);

	//mem stage
	// 增加写处理模块
	write_data write_data0(	.alucontrolE(alucontrolE),
							.aluoutE(aluoutE),
							.WriteDataE(srcb2E),
							.sig_write(sig_write),
							.WriteDataE_modified(WriteDataE_modified)
	);
	flopr #(32) r1M(clk,rst,WriteDataE_modified,writedataM);
	// flopr #(32) r1M(clk,rst,srcb2E,writedataM);
	flopr #(32) r1M(clk,rst,srcb2E,writedataM);
	flopr #(32) r5M(clk,rst,srcaE,srcaM);
	flopr #(32) r2M(clk,rst,aluoutE,aluoutM);
	flopr #(64) r4M(clk,rst,aluout64E,aluout64M);
	flopr #(5) r3M(clk,rst,writeregE,writeregM);
<<<<<<< HEAD
	flopr #(32) r6M(clk,rst,hi_oE,hi_oM);
	flopr #(32) r7M(clk,rst,lo_oE,lo_oM);
    // mem�׶γ˳�����д��hi lo�Ĵ���
    hilo_reg hilo_reg_alu(clk,rst,gprtohiM,gprtoloM,aluout64M[63:32],aluout64M[31:0],hi_oM,lo_oM);
=======
    // ��дhi lo�Ĵ���
    hilo_reg hilo_reg(clk,rst,hilowriteM,aluout64M[63:32],aluout64M[31:0],hi_oM,lo_oM);
>>>>>>> f5dbda4d5745065da05ab83dae1d1ac6fa7bdd3d
    
	//writeback stage
	// 增加读处理模块
	read_data read_data0(	.alucontrolW(alucontrolW),
							.readdataW(readdataW),
							.dataadrW(aluoutW),
							.readdataW_modified(readdataW_modified)
	);
	flopr #(32) r1W(clk,rst,aluoutM,aluoutW);
	flopr #(32) r2W(clk,rst,readdataM,readdataW);
	flopr #(5) r3W(clk,rst,writeregM,writeregW);
	flopr #(32) r4W(clk,rst,hi_oM,hi_oW);
	flopr #(32) r5W(clk,rst,lo_oM,lo_oW);
	flopr #(32) r6W(clk,rst,srcaM,srcaW);
	
	mux4 #(32) resmux_new(aluoutW,readdataW_modified,hi_oW,lo_oW,memtoregW,resultW);
//	mux2 #(32) resmux(aluoutW,readdataW,memtoregW,resultW);

endmodule

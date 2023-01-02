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
	output wire[31:0] aluoutM,writedataM,
	input wire[31:0] readdataM,
	output wire [31:0]  debug_wb_pc,      
    output wire [3:0]   debug_wb_rf_wen,
    output wire [4:0]   debug_wb_rf_wnum, 
    output wire [31:0]  debug_wb_rf_wdata
    );
	

//↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓合并后controller部分的连线↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

	//decode stage
	wire [1:0] memtoregD;
	wire memwriteD,alusrcD,regdstD,regwriteD,gprtohiD,gprtoloD;
	//execute stage
	wire memwriteE,gprtohiE,gprtoloE;
	wire gprtohiM,gprtoloM;
	wire gprtohiW,gprtoloW;
//↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

	// 同步新增代码
	wire regdstE,alusrcE,pcsrcD,regwriteE,regwriteM,regwriteW;
	wire [1:0] memtoregE,memtoregM,memtoregW;


	wire [63:0] hilo;
 	//FD
	wire [31:0] pcplus4F;
	wire [31:0] pcnextbrFD,pcbranchD;
	wire pc_ce_reg;
	//decode stage
	wire [7:0] alucontrolD;
	wire [31:0] pcplus4D;
    
	wire [31:0] instrD;
	wire [31:0] pcnextFD,pcplus4D;
	wire forwardaD,forwardbD;
	wire [5:0] opD,functD;
	wire [4:0] rsD,rtD,rdD;
	wire [31:0] signimmD,signimmshD;
	wire [31:0] srcaD,srca2D,srcbD,srcb2D;
	wire [31:0] hi_oD,lo_oD;
	//execute stage
	wire stall_divE;
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
	wire [4:0] writeregM;
	wire [31:0] hi_oM,lo_oM;
	wire [63:0] aluout64M;
	//writeback stage
	wire [4:0] writeregW;
	wire [31:0] aluoutW,readdataW,resultW,hi_oW,lo_oW;
	wire [31:0] readdataW_modified;


	
	//hazard	
    wire stallF, stallD, stallE, stallW;
    wire flushF, flushD, flushE, flushW;
    wire [1:0] forward_aE, forward_bE;
    
    //predict
    wire predictF,predictD, predictE, predict_wrong,predict_wrongM;
    wire actual_takeM, actual_takeE;
    // assign predictD = 1'b1;
    // assign predictD = 1'b0;
    // assign predict_wrong = (zeroE != predictE);

	// decoder
	maindec md(
		opD,rsD,rtD,functD,
		memtoregD,memwriteD,branchD,alusrcD,regdstD,regwriteD,jumpD,gprtohiD,gprtoloD
		);
	aludec alu_decoder0(
		opD,rsD,rtD,functD,
		alucontrolD,branch_judge_controlD
    );
    
//    //锟斤拷锟斤拷前锟斤拷(bypass)
//    mux4 #(32) mux4_forward_aE(
//        rd1E,                       
//        resultM_without_rdata,
//        resultW,
//        pc_plus4D,                          // 执锟斤拷jalr锟斤拷jal指锟筋；写锟诫到$ra锟侥达拷锟斤拷锟斤拷锟斤拷锟捷ｏ拷锟斤拷转指锟斤拷锟接︼拷映俨锟街革拷锟斤拷锟斤拷一锟斤拷指锟斤拷牡锟街凤拷锟絇C+8锟斤拷 //锟斤拷锟皆憋拷证锟接迟诧拷指锟筋不锟结被flush锟斤拷锟斤拷plush_4D锟斤拷锟斤拷
//        {2{jumpE | branchE}} | forward_aE,  // 锟斤拷exe锟阶讹拷锟斤拷jal锟斤拷锟斤拷jalr指锟筋，锟斤拷锟斤拷bxxzal时锟斤拷jumpE | branchE== 1锟斤拷选锟斤拷pc_plus4D锟斤拷

//        src_aE
//    );
//    mux4 #(32) mux4_forward_bE(
//        rd2E,                               //
//        resultM_without_rdata,                            //
//        resultW,                            // 
//        immE,                               //锟斤拷锟斤拷锟斤拷
//        {2{alu_imm_selE}} | forward_bE,     //main_decoder锟斤拷锟斤拷alu_imm_selE锟脚号ｏ拷锟斤拷示alu锟节讹拷锟斤拷锟斤拷锟斤拷锟斤拷为锟斤拷锟斤拷锟斤拷

//        src_bE
//    );
    
//    mux4 #(32) mux4_rs_valueE(rd1E, resultM_without_rdata, resultW, 32'b0, forward_aE, rs_valueE); //锟斤拷锟斤拷前锟狡猴拷锟絩s锟侥达拷锟斤拷锟斤拷值
//    mux4 #(32) mux4_rt_valueE(rd2E, resultM_without_rdata, resultW, 32'b0, forward_bE, rt_valueE); //锟斤拷锟斤拷前锟狡猴拷锟絩t锟侥达拷锟斤拷锟斤拷值
    


	//pipeline registers
	floprc #(32) regE(
		clk,rst,
		flushE,
		{memtoregD,memwriteD,alusrcD,regdstD,regwriteD,alucontrolD,gprtohiD,gprtoloD},
		{memtoregE,memwriteE,alusrcE,regdstE,regwriteE,alucontrolE,gprtohiE,gprtoloE}
		);
	flopr #(32) regM(
		clk,rst,
		// 澧炲姞ALU鎺у埗淇″彿浼狅拷??
		// 澧炲姞ALU鎺у埗淇″彿浼犻€�
		{memtoregE,memwriteE,regwriteE,alucontrolE,gprtohiE,gprtoloE},
		{memtoregM,memwriteM,regwriteM,alucontrolM,gprtohiM,gprtoloM}
 		);
	flopr #(32) regW(
		clk,rst,
		// 澧炲姞ALU鎺у埗淇″彿浼狅拷??
		// 澧炲姞ALU鎺у埗淇″彿浼犻€�
		{memtoregM,regwriteM,alucontrolM,gprtohiM,gprtoloM},
		{memtoregW,regwriteW,alucontrolW,gprtohiW,gprtoloW}
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
		stall_divE,
		rsE,rtE,
		writeregE,
		regwriteE,
		memtoregE,
		forwardaE,forwardbE,
		flushE,stallE,
		//mem stage
		writeregM,
		regwriteM,
		memtoregM,
		//write back stage
		writeregW,
		regwriteW
		);



	//next PC logic (operates in fetch an decode)
	mux2 #(32) pcbrmux(pcplus4F,pcbranchD,pcsrcD,pcnextbrFD);
	mux2 #(32) pcmux(pcnextbrFD,
		{pcplus4D[31:28],instrD[25:0],2'b00},
		jumpD,pcnextFD);

	assign pcnextFD = pcplus4E;
		

	//regfile (operates in decode and writeback)
	regfile rf(clk,regwriteW,rsD,rtD,writeregW,resultW,srcaD,srcbD);

	//fetch stage logic
	pc #(32) pcreg(clk,rst,~stallF,pcnextFD,pcF,pc_ce_reg);
	adder pcadd1(pcF,32'b100,pcplus4F);
	hilo_reg hilo_regD(clk,rst,gprtohiW,gprtoloW,srcaW,srcaW,hi_oD,lo_oD);

	//decode stage
	flopenr #(32) r1D(clk,rst,~stallD,pcplus4F,pcplus4D);
	flopenrc #(32) r2D(clk,rst,~stallD,flushD,instrF,instrD);
	signext se(instrD[15:0],signimmD);
	sl2 immsh(signimmD,signimmshD);
	adder pcadd2(pcplus4D,signimmshD,pcbranchD);
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
	// alu alu(srca2E,srcb3E,alucontrolE,hilo,aluoutE);
	alu alu0(.alu_num1(srca2E),
	         .alu_num2(srcb2E),
	         .alucontrol(alucontrolE),
			 .hilo(hilo),
			 .sa(sa),

             .alu_out_64(aluout64E), //锟斤拷锟斤拷64位锟剿筹拷锟斤拷锟�?
	         .alu_out(aluoutE),
	         .stall_div(stall_divE)
	);
	
	mux2 #(5) wrmux(rtE,rdE,regdstE,writeregE);
	//锟斤拷锟斤拷branch锟斤拷锟�
    branch_judge branch_judge0(
        .branch_judge_controlE(branch_judge_controlE),
        .srcaE(rs_valueE),
        .srcbE(rt_valueE),
        .branch_takeE()
    );
	//mem stage
	write_data write_data0(	.alucontrolE(alucontrolE),
							.aluoutE(aluoutE),
							.WriteDataE(srcb2E),
							.sig_write(sig_write),
							.WriteDataE_modified(WriteDataE_modified)
	);
	flopr #(32) r1M(clk,rst,WriteDataE_modified,writedataM);
	// flopr #(32) r1M(clk,rst,srcb2E,writedataM);
	flopr #(32) r2M(clk,rst,aluoutE,aluoutM);
	flopr #(5) r3M(clk,rst,writeregE,writeregM);
	flopr #(64) r4M(clk,rst,aluout64E,aluout64M);
	flopr #(32) r5M(clk,rst,srcaE,srcaM);

	//writeback stage
	// 澧炲姞璇诲鐞�
 	read_data read_data0(	.alucontrolW(alucontrolW),
							.readdataW(readdataW),
							.dataadrW(aluoutW),
							.readdataW_modified(readdataW_modified)
	);
	flopr #(32) r6M(clk,rst,hi_oE,hi_oM);
	flopr #(32) r7M(clk,rst,lo_oE,lo_oM);

    // mem锟阶段乘筹拷锟斤拷锟斤拷写锟斤拷hi lo锟侥达拷锟斤拷
    hilo_reg hilo_reg_alu(clk,rst,gprtohiM,gprtoloM,aluout64M[63:32],aluout64M[31:0],hi_oM,lo_oM);
    
	flopr #(32) r1W(clk,rst,aluoutM,aluoutW);
	flopr #(32) r2W(clk,rst,readdataM,readdataW);
	flopr #(5) r3W(clk,rst,writeregM,writeregW);
	flopr #(32) r4W(clk,rst,hi_oM,hi_oW);
	flopr #(32) r5W(clk,rst,lo_oM,lo_oW);
	flopr #(32) r6W(clk,rst,srcaM,srcaW);
	
	mux4 #(32) resmux_new(aluoutW,readdataW,hi_oW,lo_oW,memtoregW,resultW);
//	mux2 #(32) resmux(aluoutW,readdataW,memtoregW,resultW);
    
    // DEBUG OUTPUT
//    assign debug_wb_pc          = pcW;
//    assign debug_wb_rf_wen      = {4{regwriteW & ~stallW}};
//    assign debug_wb_rf_wnum     = WriteRegW;
//    assign debug_wb_rf_wdata    = ResultW;
endmodule

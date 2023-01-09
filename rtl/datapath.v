`timescale 1ns / 1ps

module datapath(
	input wire clk,rst,
	output wire[31:0] pcF,
	input wire[31:0] instrF,
	output wire memwriteM,
	output wire[3:0] sig_writeM,
	output wire[31:0] aluoutM,writedataM,
	input wire[31:0] readdataM,
	output wire sig_enM,

    output wire longest_stall, 
    input wire i_stall,       
    input wire d_stall,

	output wire [31:0]  debug_wb_pc,      
    output wire [3:0]   debug_wb_rf_wen,
    output wire [4:0]   debug_wb_rf_wnum, 
    output wire [31:0]  debug_wb_rf_wdata
    );
	


	//decode stage
	wire regdstD;
	wire memwriteD,alusrcD,regwrite_enD,gprtohiD,gprtoloD;
	//execute stage
	wire memwriteE,gprtohiE,gprtoloE;
	wire gprtohiM,gprtoloM;
	wire gprtohiW,gprtoloW;

	wire regdstE;
	wire alusrcE,pcsrcD;
	wire [1:0] memtoregD,memtoregE,memtoregM,memtoregW;
//	wire [1:0] pcsrcD;
	wire [63:0] hiloM;
 	//FD
	wire [31:0] pcD,pcE,pcM,pcW,pcplus4F,pcplus4D,pcplus4E,pcnextbrFD,pcbranchD,pcbranchE,pcbranchM,pcnextFD,pcjumpD;
	wire [31:0] inst_ce;
	wire pc_ce_reg;
	wire jump_conflictD;
	//decode stage
	wire jumpD,jumprD;
	wire [7:0] alucontrolD;

    wire [7:0] branch_judge_controlD;
	wire [31:0] instrD;
	wire forwardaD,forwardbD;
	wire [5:0] opD,functD;
	wire [4:0] rsD,rtD,rdD,saD;
	wire [31:0] signimmD,signimmshD;
	wire [31:0] srcaD,srca2D,srcbD,srcb2D;
	//execute stage
	wire[3:0] sig_writeE;
	wire sig_enE;
	wire stall_divE;
	wire [7:0] alucontrolE;
	wire [1:0] forwardaE,forwardbE;
	wire [4:0] rsE,rtE,rdE,saE;
	wire [4:0] writeregE;
	wire [4:0] writeregE_temp;
	wire [31:0] signimmE;
	wire [31:0] srcaE,srca2E,srcbE,srcb2E,srcb3E,srcaM,srcaW;
	wire [31:0] aluoutE;
	wire zeroE;
	wire [63:0] aluout64E;
	wire [7:0] branch_judge_controlE;
	wire [31:0] WriteDataE_modified;
	wire regwrite_enE;
	//mem stage
	wire [4:0] writeregM;
	wire [31:0] hi_oM,lo_oM;
	wire [63:0] aluout64M;
	wire [7:0] alucontrolM;
	wire regwrite_enM;
	wire [31:0] resultM;
	//writeback stage
	wire [4:0] writeregW;
	wire [31:0] aluoutW,readdataW,resultW,hi_oW,lo_oW;
	wire [31:0] readdataW_modified;
    wire [7:0] alucontrolW;
    wire regwrite_enW;
	
	//hazard	
    wire stallF, stallD, stallE, stallM, stallW;
    wire flushF, flushD, flushE, flushM, flushW;
    
    //predict
    wire branch_takeM, branch_takeE;
	wire branchD,branchE;
	// 预测模块
    wire predictF,predictD, predictE, predict_wrong,predict_wrongM;
    wire actual_takeM, actual_takeE;
    
	assign predict_wrong = (zeroE != predictE);
    assign actual_takeE = zeroE;

    compete_predict branch_predict(clk, rst, flushD, stallD, pcF, pcM,
    branchD, branchM, actual_takeM, actual_takeE,
    predict_wrongM, predictD, predictF);

	wire [31:0] pc_temp1, pc_temp2, pc_temp3, pc_temp4;


    wire [4:0] pc_dst_al;
    wire write_alD,write_alE;
    assign pc_dst_al = 5'b11111;

	// decoder
	maindec md(
		opD,rsD,rtD,functD,
		memtoregD,memwriteD,branchD,alusrcD,regdstD,regwrite_enD,gprtohiD,gprtoloD,write_alD,jumpD,jumprD
		);
	aludec alu_decoder0(
		opD,rsD,rtD,functD,
		alucontrolD,branch_judge_controlD
    );

    
//    
//    mux4 #(32) mux4_forward_aE(
//        rd1E,                       
//        resultM_without_rdata,
//        resultW,
//        pc_plus4D,                          
//        {2{jumpE | branchE}} | forward_aE,  

//        src_aE
//    );
//    mux4 #(32) mux4_forward_bE(
//        rd2E,                               //
//        resultM_without_rdata,                            //
//        resultW,                            // 
//        immE,                               
//        {2{alu_imm_selE}} | forward_bE,     

//        src_bE
//    );
    
//    mux4 #(32) mux4_rs_valueE(rd1E, resultM_without_rdata, resultW, 32'b0, forward_aE, rs_valueE); 
//    mux4 #(32) mux4_rt_valueE(rd2E, resultM_without_rdata, resultW, 32'b0, forward_bE, rt_valueE); 


	//hazard detection
	hazard h(
		//fetch stage
		.stallF(stallF),
		.flushF(flushF),
		//decode stage
		.rsD(rsD),.rtD(rtD),
		.branchD(branchD),.jumprD(jumprD),
		.forwardaD(forwardaD),.forwardbD(forwardbD),
		.predict_wrong(predict_wrong),
		.stallD(stallD),
		.flushD(flushD),
		//execute stage
		// .stall_divE(stall_divE),
		.rsE(rsE),.rtE(rtE),
		.writeregE(writeregE),
		.regwrite_enE(regwrite_enE),
		.branchE(branchE),
		.memtoregE(memtoregE),
		.forwardaE(forwardaE),.forwardbE(forwardbE),
		.flushE(flushE),.stallE(stallE),
		//mem stage
		.writeregM(writeregM),
		.regwrite_enM(regwrite_enM),
		.memtoregM(memtoregM),
		.flushM(flushM),
		.stallM(stallM),
		//write back stage
		.writeregW(writeregW),
		.regwrite_enW(regwrite_enW),
		.stallW(stallW),
		.flushW(flushW),

     	.i_stall(i_stall),       // 涓や釜璁垮瓨 stall淇�?�彿
 		.d_stall(d_stall),
		.longest_stall(longest_stall) // 鍏ㄥ眬stall鎸囦�???
		);



//    // pc_jumpD <- jumpD & ~jump_conflictD

                        
//    assign pc_sel = (branchM & ~succM & branch_takeM) ? 2'b10:
//                    (branchM & ~succM & ~branch_takeM) ? 2'b11:
//                    (branchD & ~branchM & pred_takeD ||
//                     branchD & branchM & succM & pred_takeD) ? 2'b01:
//                     2'b00;

	//  you can't delete the next line  
	assign pcsrcD = {jumpD,branchD & (srca2D == srcb2D)};
	mux2 #(32) pcbrmux(pcplus4F,pcbranchD,pcsrcD,pcnextbrFD);
	// you can't delete the next code
	// mux2 #(32) pcmux(pcnextbrFD,pcjumpD,jumpD,pcnextFD);

		// flopr 1
    mux2 #(32) before_pc_which_wrong(pcbranchE,pcplus4E+4, predictE, pc_temp1);
    mux2 #(32) before_pc_wrong(pcplus4F,pcbranchD, branchD & predictD, pc_temp2);
    mux2 #(32) before_pc_predict(pc_temp2,pc_temp1,predict_wrong & branchE, pc_temp3);
    mux2 #(32) before_pc_jump(pc_temp3,{pcplus4D[31:28],instrD[25:0],2'b00},jumpD, pc_temp4);
    mux2 #(32) before_pc_jumpr(pc_temp4,srca2D,jumprD, pcnextFD);   
	// mux2 #(32) before_pc_exception(pc_temp5,pcexceptionM,exceptionoccur, pc_in);
	

    //remove stallW temporarily 
	//regfile (operates in decode and writeback)
	regfile regfile0(
	.clk(clk),
//	.stallW(stallW),
	.we3(regwrite_enM),
	.ra1(rsD), 
	.ra2(rtD), 
	.wa3(writeregM), 
	.wd3(resultM),
	.rd1(srcaD), 
	.rd2(srcbD)
    );

	//fetch stage logic
	pc #(32) pcreg(clk,rst,~stallF,pcnextFD,pcF,pc_ce_reg);
//	assign pcplus4F = pcF + 4;
	adder pcadd1(pcF,32'b100,pcplus4F);

	//IF_ID flop
	flopenr #(32) r1D(clk,rst,~stallD,pcplus4F,pcplus4D);
	flopenrc #(32) r2D(clk,rst,~stallD,flushD,instrF,instrD);
	flopenrc #(32) r3D(clk,rst,~stallD,flushD,pcF,pcD);

	// decode stage 
	signext se(instrD[15:0],signimmD);
	sl2 immsh(signimmD,signimmshD);
	adder pcadd2(pcplus4D,signimmshD,pcbranchD);
	mux2 #(32) forwardamux(srcaD,aluoutM,forwardaD,srca2D);
	mux2 #(32) forwardbmux(srcbD,aluoutM,forwardbD,srcb2D);

	assign opD 		= 	instrD[31:26];
	assign rsD 		= 	instrD[25:21];
	assign rtD 		= 	instrD[20:16];
	assign rdD 		= 	instrD[15:11];
	assign functD 	= 	instrD[5 : 0];
	assign saD 		= 	instrD[10: 6];

    assign jump_conflictD = jumprD &&
                            ((regwrite_enE && rsD == writeregE) ||          
                            (regwrite_enM && rsD == writeregM));
    
    wire [31:0] pcjumpimmD;
    assign pcjumpimmD = {pcplus4D[31:28], instrD[25:0], 2'b00};

    assign pcjumpD = jumpD ?  pcjumpimmD : srcaD;



	// merge flopenrc
	flopenrc #(1) 	fp3_1(clk, rst, ~stallE, flushE, predictD, predictE);
	flopenrc #(32)  fp3_2(clk, rst, ~stallE, flushE, pcbranchD, pcbranchE);
	flopenrc #(8)  	fp3_3(clk, rst, ~stallE, flushE, branch_judge_controlD, branch_judge_controlE);
	flopenrc #(32)  fp3_4(clk, rst, ~stallE, flushE, pcplus4D, pcplus4E);
	flopenrc #(1)  	fp3_5(clk, rst, ~stallE, flushE, jump_conflictD, jump_conflictE);
	flopenrc #(32)  fp3_6(clk, rst, ~stallE, flushE, srcaD, srcaE);
	flopenrc #(32)  fp3_7(clk, rst, ~stallE, flushE, srcbD, srcbE);
	flopenrc #(32)  fp3_8(clk, rst, ~stallE, flushE, signimmD, signimmE);
	flopenrc #(5)  	fp3_9(clk, rst, ~stallE, flushE, rsD, rsE);
	flopenrc #(5)  	fp3_10(clk, rst, ~stallE, flushE, rtD, rtE);
	flopenrc #(5)  	fp3_11(clk, rst, ~stallE, flushE, rdD, rdE);
	flopenrc #(5)  	fp3_22(clk, rst, ~stallE, flushE, saD, saE);
	flopenrc #(2)  	fp3_12(clk, rst, ~stallE, flushE, memtoregD, memtoregE);
	flopenrc #(1)  	fp3_13(clk, rst, ~stallE, flushE, memwriteD, memwriteE);
	flopenrc #(1)  	fp3_14(clk, rst, ~stallE, flushE, alusrcD, alusrcE);
	flopenrc #(1)  	fp3_15(clk, rst, ~stallE, flushE, regdstD, regdstE);
	flopenrc #(1)  	fp3_16(clk, rst, ~stallE, flushE, regwrite_enD, regwrite_enE);
	flopenrc #(8)  	fp3_17(clk, rst, ~stallE, flushE, alucontrolD, alucontrolE);
	flopenrc #(1)  	fp3_18(clk, rst, ~stallE, flushE, gprtohiD, gprtohiE);
	flopenrc #(1)  	fp3_19(clk, rst, ~stallE, flushE, gprtoloD, gprtoloE);
	flopenrc #(32)  fp3_20(clk, rst, ~stallE, flushE, pcD, pcE);
	flopenrc #(1)  	fp3_21(clk, rst, ~stallE, flushE, branchD, branchE);
	flopenrc #(1)  fp3_23(clk, rst, ~stallE, 1'b0  , write_alD, write_alE);
	
	//execute stage
	//mux write reg
	mux3 #(32) forwardaemux(srcaE,resultW,aluoutM,forwardaE,srca2E);
	mux3 #(32) forwardbemux(srcbE,resultW,aluoutM,forwardbE,srcb2E);
	mux2 #(32) srcbmux(srcb2E,signimmE,alusrcE,srcb3E);
	alu alu0(.clk(clk),
			 .rst(rst),
			 .alu_num1(srca2E),
	         .alu_num2(srcb3E),
	         .alucontrol(alucontrolE),
			 .hilo(hiloM),
			 .sa(saE),
			 .flushE(flushE),
			 .pcplus4E(pcplus4E),
	         .alu_out(aluoutE),
	         .alu_out_64(aluout64E), 
	         .overflowE(),
	         .zeroE(zeroE),
	         .stall_div(stall_divE)
	);
	

    branch_judge branch_judge0(
        .branch_judge_controlE(branch_judge_controlE),
        .srcaE(srca2E),
        .srcbE(srcb2E),
        .branch_takeE(branch_takeE)
    );
    
    assign branch_takeE = zeroE;
    
    //mux write reg
    mux2 #(5) mux_regfile(rdE,rtE,regdstE,writeregE_temp);

    mux2 #(5) mux_al(writeregE_temp,pc_dst_al,write_alE,writeregE);
    
    
    //EX_MEM flop
	flopr#(32) 	fp4_1(clk,rst,aluoutE,aluoutM);
	flopr#(5) 	fp4_2(clk,rst,writeregE,writeregM);
	flopr#(64) 	fp4_3(clk,rst,aluout64E,aluout64M);
	flopr#(32) 	fp4_4(clk,rst,srcaE,srcaM);
	flopr#(32) 	fp4_5(clk,rst,pcbranchE,pcbranchM);
	flopr#(1) 	fp4_6(clk,rst,branch_takeE,branch_takeM);
	flopr#(2) 	fp4_7(clk,rst,memtoregE,memtoregM);
	flopr#(1) 	fp4_8(clk,rst,memwriteE,memwriteM);
	flopr#(1) 	fp4_9(clk,rst,regwrite_enE,regwrite_enM);
	flopr#(8) 	fp4_10(clk,rst,alucontrolE,alucontrolM);
	flopr#(1) 	fp4_11(clk,rst,gprtohiE,gprtohiM);
	flopr#(1) 	fp4_12(clk,rst,gprtoloE,gprtoloM);
	flopr#(32) 	fp4_13(clk,rst,WriteDataE_modified,writedataM);
	flopr#(32) 	fp4_14(clk,rst,pcE,pcM);
	flopr#(4) 	fp4_15(clk,rst,sig_writeE,sig_writeM);
	flopr#(1) 	fp4_16(clk,rst,sig_enE,sig_enM);

	flopenrc #(1)  fp4_17(clk,  rst, ~stallM, flushM,  actual_takeE, actual_takeM);
    flopenrc #(1)  fp4_18(clk,  rst, ~stallM, flushM,  predict_wrong,predict_wrongM);
    
    
	//mem stage
	write_data write_data0(	.alucontrolE(alucontrolE),
							.aluoutE(aluoutE),
							.WriteDataE(srcb2E),
							.sig_writeE(sig_writeE),
							.WriteDataE_modified(WriteDataE_modified),
							.sig_enE(sig_enE)
	);

	mux4 #(32) resmux_new(aluoutM,readdataM,hi_oM,lo_oM,memtoregM,resultM);
    hilo_reg hilo_reg(clk,rst,{gprtohiE,gprtoloE},aluout64E[63:32],aluout64E[31:0],hi_oM,lo_oM);
	assign hiloM = {hi_oM, lo_oM};

    // MEM_WB flop
	flopr#(32) fp5_1(clk,rst,aluoutM,aluoutW);// fault
	flopr#(32) fp5_2(clk,rst,readdataM,readdataW);
	flopr#(5) fp5_3(clk,rst,writeregM,writeregW);
	flopr#(32) fp5_4(clk,rst,hi_oM,hi_oW);
	flopr#(32) fp5_5(clk,rst,lo_oM,lo_oW);
	flopr#(32) fp5_6(clk,rst,srcaM,srcaW);
	flopr#(2) fp5_7(clk,rst,memtoregM,memtoregW);
	flopr#(1) fp5_8(clk,rst,regwrite_enM,regwrite_enW);
	flopr#(8) fp5_9(clk,rst,alucontrolM,alucontrolW);
	flopr#(1) fp5_10(clk,rst,gprtohiM,gprtohiW);
	flopr#(1) fp5_11(clk,rst,gprtoloM,gprtoloW);
	flopr#(32) fp5_12(clk,rst,pcM,pcW);
	flopr#(32) fp5_13(clk,rst,resultM,resultW);



	//writeback stage
 	read_data read_data0(	.alucontrolW(alucontrolW),
							.readdataW(readdataW),
							.dataadrW(aluoutW),
							.readdataW_modified(readdataW_modified)
	);

// move to MEM stage already
//    hilo_reg hilo_reg(clk,rst,{gprtohiE,gprtoloE},aluout64E[63:32],aluout64E[31:0],hi_oM,lo_oM);
//	assign hiloM = {hi_oM, lo_oM};

//	mux4 #(32) resmux_new(aluoutW,readdataW,hi_oW,lo_oW,memtoregW,resultW);
//	mux2 #(32) resmux(aluoutW,readdataW,memtoregW,resultW);
    
    //DEBUG OUTPUT
    assign debug_wb_pc          = pcW;
    assign debug_wb_rf_wen      = {4{regwrite_enW & ~stallW}};
    assign debug_wb_rf_wnum     = writeregW;
    assign debug_wb_rf_wdata    = resultW;

endmodule
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
	input wire[31:0] readdataM,
	output wire [31:0]  debug_wb_pc,      
    output wire [3:0]   debug_wb_rf_wen,
    output wire [4:0]   debug_wb_rf_wnum, 
    output wire [31:0]  debug_wb_rf_wdata
    );
	

//閳挴鍟岄埆鎾晫閳挴鍟岄埆鎾晫閳挴鍟岄埆鎾晫閳挴鍟岄埆鎾晫閳挴鍟岄埆鎾晫閳挴鍟岄崥鍫濊嫙閸氬穯ontroller闁劌鍨庨惃鍕箾缁惧簱鍟岄埆鎾晫閳挴鍟岄埆鎾晫閳挴鍟岄埆鎾晫閳挴鍟岄埆鎾晫閳挴鍟岄埆鎾晫閳挴鍟岄敓锟??

	//decode stage
	wire [1:0] memtoregD;
	wire memwriteD,alusrcD,regdstD,regwriteD,gprtohiD,gprtoloD;
	//execute stage
	wire memwriteE,gprtohiE,gprtoloE;
	wire gprtohiM,gprtoloM;
	wire gprtohiW,gprtoloW;
//閳垟鍟堥埆鎴斿晥閳垟鍟堥埆鎴斿晥閳垟鍟堥埆鎴斿晥閳垟鍟堥埆鎴斿晥閳垟鍟堥埆鎴斿晥閳垟鍟堥埆鎴斿晥閳垟鍟堥埆鎴斿晥閳垟鍟堥埆鎴斿晥閳垟鍟堥埆鎴斿晥閳垟鍟堥埆鎴斿晥閳垟鍟堥埆鎴斿晥閳垟鍟堥埆鎴斿晥閳垟鍟堥埆鎴斿晥閳垟鍟堥埆鎴斿晥閳垟鍟堥敓锟??

	// 閸氬本顒為弬鏉款杻娴狅絿鐖?
	wire regdstE,alusrcE,pcsrcD,regwriteE,regwriteM,regwriteW;
	wire [1:0] memtoregE,memtoregM,memtoregW;


	wire [63:0] hilo;
 	//FD
	wire [31:0] pcplus4F;
	wire [31:0] pcnextbrFD,pcbranchD;
	wire pc_ce_reg;
	//decode stage
	wire jumpD,jumprD;
	wire [7:0] alucontrolD;

    wire [4:0] branch_judge_controlD;
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
	wire zeroE;
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
//    wire predictF,predictD, predictE, predict_wrong,predict_wrongM;
//    wire branch_takeM, branch_takeE;
//    // assign predictD = 1'b1;
//    // assign predictD = 1'b0;
//     assign predict_wrong = (zeroE != predictE);

	// decoder
	maindec md(
		opD,rsD,rtD,functD,
		memtoregD,memwriteD,branchD,alusrcD,regdstD,regwriteD,gprtohiD,gprtoloD,jumpD,jumprD
		);
	aludec alu_decoder0(
		opD,rsD,rtD,functD,
		alucontrolD,branch_judge_controlD
    );
    
//    //闁跨喐鏋婚幏鐑芥晸閺傘倖瀚归崜宥夋晸閺傘倖瀚?(bypass)
//    mux4 #(32) mux4_forward_aE(
//        rd1E,                       
//        resultM_without_rdata,
//        resultW,
//        pc_plus4D,                          // 閹笛囨晸閺傘倖瀚筳alr闁跨喐鏋婚幏绌揳l閹稿洭鏁撶粵瀣剁幢閸愭瑩鏁撶拠顐㈠煂$ra闁跨喍鑼庢潏鐐闁跨喐鏋婚幏鐑芥晸閺傘倖瀚归柨鐔告灮閹风兘鏁撻幑鍑ょ秶閹风兘鏁撻弬銈嗗鏉烆剚瀵氶柨鐔告灮閹风兘鏁撻幒銉閹烽攱妲ф穱銊╂晸鐞涙娼婚幏鐑芥晸閺傘倖瀚归柨鐔告灮閹疯渹绔撮柨鐔告灮閹烽攱瀵氶柨鐔告灮閹烽澧堕柨鐔活敎閸戙倖瀚归柨鐔虹グC+8闁跨喐鏋婚敓锟?? //闁跨喐鏋婚幏鐑芥晸閻ㄥ棙鍞婚幏鐤槈闁跨喐甯存潻鐔活嚋閹烽攱瀵氶柨鐔虹摂娑撳秹鏁撶紒鎾诡潶flush闁跨喐鏋婚幏鐑芥晸閺傘倖瀚筽lush_4D闁跨喐鏋婚幏鐑芥晸閺傘倖瀚?
//        {2{jumpE | branchE}} | forward_aE,  // 闁跨喐鏋婚幏绌峹e闁跨喖妯佺拋瑙勫闁跨喐鏋婚幏绌揳l闁跨喐鏋婚幏鐑芥晸閺傘倖瀚筳alr閹稿洭鏁撶粵瀣剁礉闁跨喐鏋婚幏鐑芥晸閺傘倖瀚筨xxzal閺冨爼鏁撻弬銈嗗jumpE | branchE== 1闁跨喐鏋婚幏鍑ゆ嫹?閿熶粙鏁撻弬銈嗗pc_plus4D闁跨喐鏋婚敓锟??

//        src_aE
//    );
//    mux4 #(32) mux4_forward_bE(
//        rd2E,                               //
//        resultM_without_rdata,                            //
//        resultW,                            // 
//        immE,                               //闁跨喐鏋婚幏鐑芥晸閺傘倖瀚归柨鐔告灮閿燂拷?
//        {2{alu_imm_selE}} | forward_bE,     //main_decoder闁跨喐鏋婚幏鐑芥晸閺傘倖瀚筧lu_imm_selE闁跨喕鍓奸崣鍑ょ秶閹风兘鏁撻弬銈嗗缁?绡磍u闁跨喕濡拋瑙勫闁跨喐鏋婚幏鐑芥晸閺傘倖瀚归柨鐔告灮閹风兘鏁撻弬銈嗗娑撴椽鏁撻弬銈嗗闁跨喐鏋婚幏鐑芥晸閺傘倖瀚?

//        src_bE
//    );
    
//    mux4 #(32) mux4_rs_valueE(rd1E, resultM_without_rdata, resultW, 32'b0, forward_aE, rs_valueE); //闁跨喐鏋婚幏鐑芥晸閺傘倖瀚归崜宥夋晸閻欙紕灏ㄩ幏鐑芥晸缁诧箷闁跨喍鑼庢潏鐐闁跨喐鏋婚幏鐑芥晸閺傘倖瀚归敓锟??
//    mux4 #(32) mux4_rt_valueE(rd2E, resultM_without_rdata, resultW, 32'b0, forward_bE, rt_valueE); //闁跨喐鏋婚幏鐑芥晸閺傘倖瀚归崜宥夋晸閻欙紕灏ㄩ幏鐑芥晸缁诧箹闁跨喍鑼庢潏鐐闁跨喐鏋婚幏鐑芥晸閺傘倖瀚归敓锟??


	//pipeline registers
	floprc #(16) regE(
		clk,rst,
		flushE,
		{memtoregD,memwriteD,alusrcD,regdstD,regwriteD,alucontrolD,gprtohiD,gprtoloD},
		{memtoregE,memwriteE,alusrcE,regdstE,regwriteE,alucontrolE,gprtohiE,gprtoloE}
		);
	flopr #(7) regM(
		clk,rst,
		// 濠⒀呭仜婵咖LU闁硅矇鍐ㄧ厬濞ｅ浄鎷??閿熻棄濞囧ù鑲╁閿燂拷???
		// 濠⒀呭仜婵咖LU闁硅矇鍐ㄧ厬濞ｅ浄鎷??閿熻棄濞囧ù鑲╁█閳ь剨鎷?
		{memtoregE,memwriteE,regwriteE,alucontrolE,gprtohiE,gprtoloE},
		{memtoregM,memwriteM,regwriteM,alucontrolM,gprtohiM,gprtoloM}
 		);
	flopr #(32) regW(
		clk,rst,
		// 濠⒀呭仜婵咖LU闁硅矇鍐ㄧ厬濞ｅ浄鎷??閿熻棄濞囧ù鑲╁閿燂拷???
		// 濠⒀呭仜婵咖LU闁硅矇鍐ㄧ厬濞ｅ浄鎷??閿熻棄濞囧ù鑲╁█閳ь剨鎷?
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
//	wire [31:0] pc_next_tmp;
//    mux4 #(32) mux4_pc(pcplus4F, pcbranchD, pcbranchM, pcplus4E, pc_sel, pc_next_tmp); 
//    // pc_jumpD <- jumpD & ~jump_conflictD
//    // pc_jumpE <- jump_conflictE
//    assign pc_next = jumpD & ~jump_conflictD ? pc_jumpD : 
//                        jump_conflictE ? pc_jumpE : pc_next_tmp;
                        
//    assign pc_sel = (branchM & ~succM & branch_takeM) ? 2'b10:
//                    (branchM & ~succM & ~branch_takeM) ? 2'b11:
//                    (branchD & ~branchM & pred_takeD ||
//                     branchD & branchM & succM & pred_takeD) ? 2'b01:
//                     2'b00;
	mux2 #(32) pcbrmux(pcplus4F,pcbranchD,pcsrcD,pcnextbrFD);
	mux2 #(32) pcmux(pcnextbrFD,
		pcjumpD,
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

	assign opD = instrD[31:26];
	assign rsD = instrD[25:21];
	assign rtD = instrD[20:16];
	assign rdD = instrD[15:11];
	assign functD = instrD[5:0];
	
	//jump
    wire jr, j;
    assign jr = ~(|instrD[31:26]) & ~(|(instrD[5:1] ^ 5'b00100)); //jr, jalr
    assign j = ~(|(instrD[31:27] ^ 5'b00001));                   //j, jal
    assign jumpD = jr | j;

    assign jump_conflictD = jr &&
                            ((regwriteE && rsD == writeregE) ||          
                            (regwriteM && rsD == writeregM));
    
    wire [31:0] pcjumpimmD;
    assign pcjumpimmD = {pcplus4D[31:28], instrD[25:0], 2'b00};

    assign pcjumpD = j ?  pcjumpimmD : srcaD;
	
	
	//execute stage
	assign pcplus4E =pcplus4D;
	//mux write reg
    mux4 #(5) mux4_reg_dst(rdE, rtE, 5'd31, 5'b0, regdstE, reg_writeE);
	// merge flopenrc
	id_ex id_ex0(
        .clk(clk),
        .rst(rst),
        .stallE(stallE),
        .flushE(flushE),
        .branch_judge_controlD(branch_judge_controlD),
        .branch_judge_controlE(branch_judge_controlE),
		.pc_plus4D(pcplus4D),
		.pc_plus4E(pcplus4E),
		.jump_conflictD(jump_conflictD),
		.jump_conflictE(jump_conflictE),
		.pcbranchD(pcbranchD),
		.pcbranchE(pcbranchE),
		.srcaD(srcaD), 
		.srcaE(srcaE),
		.signimmD(signimmD), 
		.signimmE(signimmE),
		.rsD(rsD), 
		.rsE(rsE),
		.rtD(rtD), 
		.rtE(rtE),
		.rdD(rdD), 
		.rdE(rdE),
		.hi_oD(hi_oD), 
		.hi_oE(hi_oE),
		.lo_oD(lo_oD), 
		.lo_oE(lo_oE)
		);

	mux3 #(32) forwardaemux(srcaE,resultW,aluoutM,forwardaE,srca2E);
	mux3 #(32) forwardbemux(srcbE,resultW,aluoutM,forwardbE,srcb2E);
	mux2 #(32) srcbmux(srcb2E,signimmE,alusrcE,srcb3E);
	// alu alu(srca2E,srcb3E,alucontrolE,hilo,aluoutE);
	alu alu0(.alu_num1(srca2E),
	         .alu_num2(srcb2E),
	         .alucontrol(alucontrolE),
			 .hilo(hilo),
			 .sa(sa),
	         .alu_out(aluoutE),
	         .alu_out_64(aluout64E), //闁跨喐鏋婚幏鐑芥晸閺傘倖瀚?64娴ｅ秹鏁撻崜璺劜閹风兘鏁撻弬銈嗗闁跨噦鎷??
	         .overflowE(),
	         .zeroE(),
	         .stall_div(stall_divE)
	);
	
	mux2 #(5) wrmux(rtE,rdE,regdstE,writeregE);
	//闁跨喐鏋婚幏鐑芥晸閺傘倖瀚筨ranch闁跨喐鏋婚幏鐑芥晸閿燂拷?
    branch_judge branch_judge0(
        .branch_judge_controlE(branch_judge_controlE),
        .srcaE(srca2E),
        .srcbE(srcb2E),
        .branch_takeE(branch_takeE)
    );
    
    assign branch_takeE = zeroE;
    //jump
	//    assign pc_jumpE = srcaE;
	//mem stage
	// 婢х偛濮炵拠璇差槱閿燂拷?
	write_data write_data0(	.alucontrolE(alucontrolE),
							.aluoutE(aluoutE),
							.WriteDataE(srcb2E),
							.sig_write(sig_write),
							.WriteDataE_modified(WriteDataE_modified)
	);
	//鍏ㄩ敓鏂ゆ嫹閿熸枻鎷穝tall

	// merge flopr in mem stage
	ex_mem ex_mem0(
		.clk(clk), .rst(rst),
		.aluoutE(aluoutE), .aluoutM(aluoutM),
		.writeregE(writeregE), .writeregM(writeregM),
		.aluout64E(aluout64E), .aluout64M(aluout64M),
		.srcaE(srcaE), .srcaM(srcaM),
		.hi_oE(hi_oE),.hi_oM(hi_oM),
		.pcbranchE(pcbranchE),.pcbranchM(pcbranchM)
	);
	//writeback stage
	// 婢х偛濮為崘娆忣槱閿燂拷?
 	read_data read_data0(	.alucontrolW(alucontrolW),
							.readdataW(readdataW),
							.dataadrW(aluoutW),
							.readdataW_modified(readdataW_modified)
	);


    // mem闁跨喖妯佸▓鍏哥缁涜瀚归柨鐔告灮閹风兘鏁撻弬銈嗗閸愭瑩鏁撻弬銈嗗hi lo闁跨喍鑼庢潏鐐闁跨喐鏋婚敓锟??
    hilo_reg hilo_reg_alu(clk,rst,gprtohiM,gprtoloM,aluout64M[63:32],aluout64M[31:0]);
    // merge flopr in WriteBack stage
	mem_wb mem_wb0(
		.clk(clk), .rst(rst),
		.aluoutM(aluoutM), 
		.aluoutW(aluoutW),
		.readdataM(readdataM), 
		.readdataW(readdataW),
		.writeregM(writeregM), 
		.writeregW(writeregW),
		.hi_oM(hi_oM), 
		.hi_oW(hi_oW),
		.lo_oM(lo_oM), 
		.lo_oW(lo_oW),
		.srcaM(srcaM), 
		.srcaW(srcaW)
	);

	mux4 #(32) resmux_new(aluoutW,readdataW,hi_oW,lo_oW,memtoregW,resultW);
//	mux2 #(32) resmux(aluoutW,readdataW,memtoregW,resultW);
    
    // DEBUG OUTPUT
//    assign debug_wb_pc          = pcW;
//    assign debug_wb_rf_wen      = {4{regwriteW & ~stallW}};
//    assign debug_wb_rf_wnum     = WriteRegW;
//    assign debug_wb_rf_wdata    = ResultW;
endmodule

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
	

//閳挴鍟岄埆鎾晫閳挴鍟岄埆鎾晫閳挴鍟岄埆鎾晫閳挴鍟岄埆鎾晫閳挴鍟岄埆鎾晫閳挴鍟岄崥鍫濊嫙閸氬穯ontroller闁劌鍨庨惃鍕箾缁惧簱鍟岄埆鎾晫閳挴鍟岄埆鎾晫閳挴鍟岄埆鎾晫閳挴鍟岄埆鎾晫閳挴鍟岄埆鎾晫閳挴鍟岄敓锟?????

	//decode stage
	wire [1:0] memtoregD;
	wire memwriteD,alusrcD,regdstD,regwriteD,gprtohiD,gprtoloD;
	//execute stage
	wire memwriteE,gprtohiE,gprtoloE;
	wire gprtohiM,gprtoloM;
	wire gprtohiW,gprtoloW;
//闁愁偅鍨熼崯鍫ュ焼閹存柨鏅ラ柍顐ｅ灍閸熷牓鍩嗛幋鏂挎櫏闁愁偅鍨熼崯鍫ュ焼閹存柨鏅ラ柍顐ｅ灍閸熷牓鍩嗛幋鏂挎櫏闁愁偅鍨熼崯鍫ュ焼閹存柨鏅ラ柍顐ｅ灍閸熷牓鍩嗛幋鏂挎櫏闁愁偅鍨熼崯鍫ュ焼閹存柨鏅ラ柍顐ｅ灍閸熷牓鍩嗛幋鏂挎櫏闁愁偅鍨熼崯鍫ュ焼閹存柨鏅ラ柍顐ｅ灍閸熷牓鍩嗛幋鏂挎櫏闁愁偅鍨熼崯鍫ュ焼閹存柨鏅ラ柍顐ｅ灍閸熷牓鍩嗛幋鏂挎櫏闁愁偅鍨熼崯鍫ュ焼閹存柨鏅ラ柍顐ｅ灍閸熷牓鍩嗛幋鏂挎櫏闁愁偅鍨熼崯鍫ユ晸閿?????

	// 闁告艾鏈鐐哄棘閺夋鏉诲ù鐙呯悼閿????
	wire regdstE,alusrcE,pcsrcD,
	wire [1:0] memtoregE,memtoregM,memtoregW;
	wire [1:0] pcsrcD;
	wire [63:0] hilo;
 	//FD
	wire [31:0] pcplus4F;
	wire [31:0] pcnextbrFD,pcbranchD;
	wire pc_ce_reg;
	//decode stage
	wire jumpD,jumprD;
	wire [7:0] alucontrolD;

    wire [7:0] branch_judge_controlD;
	wire [31:0] instrD;
	wire [31:0] pcnextFD,pcplus4D,pcjumpD;
	wire forwardaD,forwardbD;
	wire [5:0] opD,functD;
	wire [4:0] rsD,rtD,rdD;
	wire [31:0] signimmD,signimmshD;
	wire [31:0] srcaD,srca2D,srcbD,srcb2D;
	wire [31:0] pcD;
	wire regwriteD;
	// wire [31:0] hi_oD,lo_oD;
	//execute stage
	wire stall_divE;
	wire [7:0] alucontrolE;
	wire [31:0] pcplus4E;
	wire [31:0] pcbranchE;
	wire [1:0] forwardaE,forwardbE;
	wire [4:0] rsE,rtE,rdE;
	wire [4:0] writeregE;
	wire [31:0] signimmE;
	wire [31:0] srcaE,srca2E,srcbE,srcb2E,srcb3E,srcaM,srcaW;
	wire [31:0] aluoutE;
	wire zeroE;
	wire [63:0] aluout64E;
	wire [7:0] branch_judge_controlE;
	wire [31:0] hi_oE,lo_oE;
	wire [31:0] WriteDataE_modified;
	wire [31:0] pcE;
	wire regwriteE;
	//mem stage
	wire [4:0] writeregM;
	wire [31:0] hi_oM,lo_oM;
	wire [63:0] aluout64M;
	wire [31:0] pcM;
	wire [31:0] pcbranchM;
	wire [7:0] alucontrolM;
	wire regwriteM;
	//writeback stage
	wire [4:0] writeregW;
	wire [31:0] aluoutW,readdataW,resultW,hi_oW,lo_oW;
	wire [31:0] readdataW_modified;
    wire [31:0] pcW;
    wire [7:0] alucontrolW;
    wire regwriteW
	
	//hazard	
    wire stallF, stallD, stallE, stallW;
    wire flushF, flushD, flushE, flushW;
    wire [1:0] forward_aE, forward_bE;
    
    //predict
//    wire predictF,predictD, predictE, predict_wrong,predict_wrongM;
    wire branch_takeM, branch_takeE;
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
    
//    //闂佽法鍠愰弸濠氬箯閻戣姤鏅搁柡鍌樺?栫?氬綊宕滃澶嬫櫢闁哄倶鍊栭敓???(bypass)
//    mux4 #(32) mux4_forward_aE(
//        rd1E,                       
//        resultM_without_rdata,
//        resultW,
//        pc_plus4D,                          // 闁圭瑳鍥ㄦ櫢闁哄倶鍊栫?氱alr闂佽法鍠愰弸濠氬箯缁屾彸l闁圭ǹ娲弫鎾剁驳鐎ｅ墎骞㈤柛鎰懇閺佹挾鎷犻銏犵厒$ra闂佽法鍠嶉懠搴㈡綇閻愵剙顏堕梺璺ㄥ枑閺嬪骞忛悜鑺ユ櫢闁哄倶鍊栫?氬綊鏌ㄩ悢鍛婄伄闁归鍏橀弫鎾诲箲閸戙倗绉堕柟椋庡厴閺佹捇寮妶鍡楊伓閺夌儐鍓氱?垫岸鏌ㄩ悢鍛婄伄闁归鍏橀弫鎾诲箳閵夘垵顓洪柟鐑芥敱濡惭勭┍閵娾晜鏅搁悶娑欘殜濞煎骞忛悜鑺ユ櫢闁哄倶鍊栫?氬綊鏌ㄩ悢鍛婄伄闁圭柉娓圭粩鎾煥閻斿憡鐏柟鐑芥敱鐎垫岸鏌ㄩ悢鍛婄伄闁圭兘顥撴晶鍫曟煥閻旀椿鏁庨柛鎴欏?栫?氬綊鏌ㄩ悢铏广偘C+8闂佽法鍠愰弸濠氭晸閿????? //闂佽法鍠愰弸濠氬箯閻戣姤鏅搁柣銊ユ閸炲骞忛悿顖滄闂佽法鍠愮敮瀛樻交閻旀椿鍤嬮柟鐑芥敱鐎垫岸鏌ㄩ悢铏规憘濞戞挸绉归弫鎾剁磼閹捐娼秄lush闂佽法鍠愰弸濠氬箯閻戣姤鏅搁柡鍌樺?栫?氱lush_4D闂佽法鍠愰弸濠氬箯閻戣姤鏅搁柡鍌樺?栭敓???
//        {2{jumpE | branchE}} | forward_aE,  // 闂佽法鍠愰弸濠氬箯缁屽彻e闂佽法鍠栧Ο浣烘媼鐟欏嫬顏堕梺璺ㄥ枑閺嬪骞忕粚鎻砽闂佽法鍠愰弸濠氬箯閻戣姤鏅搁柡鍌樺?栫?氱alr闁圭ǹ娲弫鎾剁驳鐎ｅ墎绀夐梺璺ㄥ枑閺嬪骞忛悜鑺ユ櫢闁哄倶鍊栫?氱xxzal闁哄啫鐖奸弫鎾诲棘閵堝棗顏秊umpE | branchE== 1闂佽法鍠愰弸濠氬箯閸戙倖瀚??闁跨喍绮欓弫鎾诲棘閵堝棗顏秔c_plus4D闂佽法鍠愰弸濠氭晸閿?????

//        src_aE
//    );
//    mux4 #(32) mux4_forward_bE(
//        rd2E,                               //
//        resultM_without_rdata,                            //
//        resultW,                            // 
//        immE,                               //闂佽法鍠愰弸濠氬箯閻戣姤鏅搁柡鍌樺?栫?氬綊鏌ㄩ悢鍛婄伄闁跨噦鎷??
//        {2{alu_imm_selE}} | forward_bE,     //main_decoder闂佽法鍠愰弸濠氬箯閻戣姤鏅搁柡鍌樺?栫?氱lu_imm_selE闂佽法鍠曢崜濂稿矗閸戙倗绉堕柟椋庡厴閺佹捇寮妶鍡楊伓閿????缁＄u闂佽法鍠曟俊顓犳媼鐟欏嫬顏堕梺璺ㄥ枑閺嬪骞忛悜鑺ユ櫢闁哄倶鍊栫?氬綊鏌ㄩ悢鍛婄伄闁归鍏橀弫鎾诲棘閵堝棗顏跺☉鎾存そ閺佹捇寮妶鍡楊伓闂佽法鍠愰弸濠氬箯閻戣姤鏅搁柡鍌樺?栭敓???

//        src_bE
//    );
    
//    mux4 #(32) mux4_rs_valueE(rd1E, resultM_without_rdata, resultW, 32'b0, forward_aE, rs_valueE); //闂佽法鍠愰弸濠氬箯閻戣姤鏅搁柡鍌樺?栫?氬綊宕滃澶嬫櫢闁绘瑱绱曠亸銊╁箯閻戣姤鏅哥紒璇х闂佽法鍠嶉懠搴㈡綇閻愵剙顏堕梺璺ㄥ枑閺嬪骞忛悜鑺ユ櫢闁哄倶鍊栫?氬綊鏁撻敓????
//    mux4 #(32) mux4_rt_valueE(rd2E, resultM_without_rdata, resultW, 32'b0, forward_bE, rt_valueE); //闂佽法鍠愰弸濠氬箯閻戣姤鏅搁柡鍌樺?栫?氬綊宕滃澶嬫櫢闁绘瑱绱曠亸銊╁箯閻戣姤鏅哥紒璇х闂佽法鍠嶉懠搴㈡綇閻愵剙顏堕梺璺ㄥ枑閺嬪骞忛悜鑺ユ櫢闁哄倶鍊栫?氬綊鏁撻敓????


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

                        
//    assign pc_sel = (branchM & ~succM & branch_takeM) ? 2'b10:
//                    (branchM & ~succM & ~branch_takeM) ? 2'b11:
//                    (branchD & ~branchM & pred_takeD ||
//                     branchD & branchM & succM & pred_takeD) ? 2'b01:
//                     2'b00;

	//  you can't delete the next line  
	assign pcsrcD = {jumpD,branchD & (srca2D == srcb2D)};
	mux2 #(32) pcbrmux(pcplus4F,pcbranchD,pcsrcD,pcnextbrFD);
	// you can't delete the next code
	mux2 #(32) pcmux(pcnextbrFD,pcjumpD,jumpD,pcnextFD);
	// mux2 #(32) pcmux(pcnextbrFD,{pcplus4D[31:28], instrD[25:0], 2'b00},jumpD,pcnextFD);

		

	//regfile (operates in decode and writeback)
	// regfile rf(clk,regwriteW,rsD,rtD,writeregW,resultW,srcaD,srcbD);
	regfile regfile0(
	.clk(clk),
	.we3(regwriteW),
	.ra1(rsD), 
	.ra2(rtD), 
	.wa3(writeregW), 
	.wd3(resultW),

	.rd1(srcaD), 
	.rd2(srcbD)
    );

	//fetch stage logic
	pc #(32) pcreg(clk,rst,~stallF,pcnextFD,pcF,pc_ce_reg);
	adder pcadd1(pcF,32'b100,pcplus4F);
	// hilo_reg hilo_regD(clk,rst,{gprtohiW,gprtoloW},srcaW,srcaW,hi_oD,lo_oD);

	//decode stage
	flopenr #(32) r1D(clk,rst,~stallD,pcplus4F,pcplus4D);
	flopenrc #(32) r2D(clk,rst,~stallD,flushD,instrF,instrD);
	signext se(instrD[15:0],signimmD);
	sl2 immsh(signimmD,signimmshD);
	adder pcadd2(pcplus4D,signimmshD,pcbranchD);
	mux2 #(32) forwardamux(srcaD,aluoutM,forwardaD,srca2D);
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
	// assign pcplus4E =pcplus4D;
	//mux write reg
    mux4 #(5) mux4_reg_dst(rdE, rtE, 5'd31, 5'b0, regdstE, regwriteE);
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
        .srcbD(srcbD), 
		.srcbE(srcbE),
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
		.lo_oE(lo_oE),
		.memtoregD(memtoregD),
		.memtoregE(memtoregE),
		.memwriteD(memwriteD),
		.memwriteE(memwriteE),
		.alusrcD(alusrcD),
		.alusrcE(alusrcE),
		.regdstD(regdstD),
		.regdstE(regdstE),
		.regwriteD(regwriteD),
		.regwriteE(regwriteE),
		.alucontrolD(alucontrolD),
		.alucontrolE(alucontrolE),
		.gprtohiD(gprtohiD),
		.gprtohiE(gprtohiE),
		.gprtoloD(gprtoloD),
		.gprtoloE(gprtoloE),
		.pcD(pcD),
		.pcE(pcE)

		);

	mux3 #(32) forwardaemux(srcaE,resultW,aluoutM,forwardaE,srca2E);
	mux3 #(32) forwardbemux(srcbE,resultW,aluoutM,forwardbE,srcb2E);
	mux2 #(32) srcbmux(srcb2E,signimmE,alusrcE,srcb3E);
	// alu alu(srca2E,srcb3E,alucontrolE,hilo,aluoutE);
	alu alu0(.clk(clk),
			 .rst(rst),
			 .alu_num1(srca2E),
	         .alu_num2(srcb3E),
	         .alucontrol(alucontrolE),
			 .hilo(hilo),
			 .sa(sa),
			 .flushE(flushE),
	         .alu_out(aluoutE),
	         .alu_out_64(aluout64E), 
	         .overflowE(),
	         .zeroE(),
	         .stall_div(stall_divE)
	);
	
	mux2 #(5) wrmux(rtE,rdE,regdstE,writeregE);
	//闂佽法鍠愰弸濠氬箯閻戣姤鏅搁柡鍌樺?栫?氱ranch闂佽法鍠愰弸濠氬箯閻戣姤鏅搁柨鐕傛嫹?
    branch_judge branch_judge0(
        .branch_judge_controlE(branch_judge_controlE),
        .srcaE(srca2E),
        .srcbE(srcb2E),
        .branch_takeE(branch_takeE)
    );
    
    assign branch_takeE = zeroE;
    
	//mem stage
	// 濠⒀呭仜婵偟鎷犵拠宸П闁跨噦鎷??
	write_data write_data0(	.alucontrolE(alucontrolE),
							.aluoutE(aluoutE),
							.WriteDataE(srcb2E),
							.sig_write(sig_write),
							.WriteDataE_modified(WriteDataE_modified)
	);
	//閸忋劑鏁撻弬銈嗗闁跨喐鏋婚幏绌漷all

	// merge flopr in mem stage
	ex_mem ex_mem0(
		.clk(clk), 
		.rst(rst),
		.aluoutE(aluoutE), 
		.aluoutM(aluoutM),
		.writeregE(writeregE), 
		.writeregM(writeregM),
		.aluout64E(aluout64E), 
		.aluout64M(aluout64M),
		.srcaE(srcaE), 
		.srcaM(srcaM),
		.hi_oE(hi_oE),
		.hi_oM(hi_oM),
		.pcbranchE(pcbranchE),
		.pcbranchM(pcbranchM),
		.branch_takeE(branch_takeE),
		.branch_takeM(branch_takeM),
		.memtoregE(memtoregE),
		.memtoregM(memtoregM),
		.memwriteE(memwriteE),
		.memwriteM(memwriteM),
		.regwriteE(regwriteE),
		.regwriteM(regwriteM),
		.alucontrolE(alucontrolE),
		.alucontrolM(alucontrolM),
		.gprtohiE(gprtohiE),
		.gprtohiM(gprtohiM),
		.gprtoloE(gprtoloE),
		.gprtoloM(gprtoloM),
		.WriteDataE_modified(WriteDataE_modified),
		.writedataM(writedataM),
		.pcE(pcE),
		.pcM(pcM)
	);
	//writeback stage
	// 濠⒀呭仜婵偤宕樺▎蹇ｆП闁跨噦鎷??
 	read_data read_data0(	.alucontrolW(alucontrolW),
							.readdataW(readdataW),
							.dataadrW(aluoutW),
							.readdataW_modified(readdataW_modified)
	);


    // mem闂佽法鍠栧Ο浣糕枔閸忓摜顔掔紒娑滎潐鐎氬綊鏌ㄩ悢鍛婄伄闁归鍏橀弫鎾诲棘閵堝棗顏堕柛鎰懇閺佹捇寮妶鍡楊伓hi lo闂佽法鍠嶉懠搴㈡綇閻愵剙顏堕梺璺ㄥ枑閺嬪鏁撻敓????
    hilo_reg hilo_reg(clk,rst,{gprtohiM,gprtoloM},aluout64M[63:32],aluout64M[31:0],hi_oM,lo_oM);
	assign hilo = {hi_oM, lo_oM};
    // merge flopr in WriteBack stage
	mem_wb mem_wb0(
		.clk(clk), 
		.rst(rst),
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
		.srcaW(srcaW), 
		.memtoregM(memtoregM),
		.memtoregW(memtoregW),
		.regwriteM(regwriteM),
		.regwriteW(regwriteW),
		.alucontrolM(alucontrolM),
		.alucontrolW(alucontrolW),
		.gprtohiM(gprtohiM),
		.gprtohiW(gprtohiW),
		.gprtoloM(gprtoloM),
		.gprtoloW(gprtoloW),
		.pcM(pcM),
		.pcW(pcW)
	);

	mux4 #(32) resmux_new(aluoutW,readdataW,hi_oW,lo_oW,memtoregW,resultW);
//	mux2 #(32) resmux(aluoutW,readdataW,memtoregW,resultW);
    
    //DEBUG OUTPUT
    assign debug_wb_pc          = pcW;
    assign debug_wb_rf_wen      = {4{regwriteW & ~stallW}};
    assign debug_wb_rf_wnum     = writeregW;
    assign debug_wb_rf_wdata    = resultW;
endmodule    assign debug_wb_rf_wen      = {4{regwriteW & ~stallW}};
    assign debug_wb_rf_wnum     = writeregW;
    assign debug_wb_rf_wdata    = resultW;
endmodule
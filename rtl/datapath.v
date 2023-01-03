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
	

//鈫撯啌鈫撯啌鈫撯啌鈫撯啌鈫撯啌鈫撯啌鈫撯啌鈫撯啌鈫撯啌鈫撯啌鈫撯啌鍚堝苟鍚巆ontroller閮ㄥ垎鐨勮繛绾库啌鈫撯啌鈫撯啌鈫撯啌鈫撯啌鈫撯啌鈫撯啌鈫撯啌鈫撯啌鈫撯啌鈫撯啌锟�????

	//decode stage
	wire [1:0] memtoregD;
	wire memwriteD,alusrcD,regdstD,regwriteD,gprtohiD,gprtoloD;
	//execute stage
	wire memwriteE,gprtohiE,gprtoloE;
	wire gprtohiM,gprtoloM;
	wire gprtohiW,gprtoloW;
//鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈鈫戔啈锟�????

	// 鍚屾鏂板浠ｇ�???
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

    wire [7:0] branch_judge_controlD;
	wire [31:0] instrD;
	wire [31:0] pcnextFD,pcplus4D,pcjumpD;
	wire forwardaD,forwardbD;
	wire [5:0] opD,functD;
	wire [4:0] rsD,rtD,rdD;
	wire [31:0] signimmD,signimmshD;
	wire [31:0] srcaD,srca2D,srcbD,srcb2D;
	wire [31:0] pcD;
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
	//mem stage
	wire [4:0] writeregM;
	wire [31:0] hi_oM,lo_oM;
	wire [63:0] aluout64M;
	wire [31:0] pcM;
	wire [31:0] pcbranchM;
	wire [7:0] alucontrolM;
	//writeback stage
	wire [4:0] writeregW;
	wire [31:0] aluoutW,readdataW,resultW,hi_oW,lo_oW;
	wire [31:0] readdataW_modified;
    wire [31:0] pcW;
    wire [7:0] alucontrolW;
	
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
    
//    //éżç¸ćťéˇç˝ćéăĺŤšéĺśćéăďż???(bypass)
//    mux4 #(32) mux4_forward_aE(
//        rd1E,                       
//        resultM_without_rdata,
//        resultW,
//        pc_plus4D,                          // éľŃćéăĺŤšjalréżç¸ćťéˇçŠalé¸ĺŹćçťĺŹśç´ąéćŹćçî˘ĺ$raéżçśčćçŹĺŤšéżç¸ćťéˇç˝ćéăĺŤšéżç¸ćťéˇç˝ćéšĺ¤çśéˇç˝ćéăĺŤšćîĺŻéżç¸ćťéˇç˝ćéşăŻčŽŁéˇéć§§ćˇăŠćçćĽć˝ťéˇç˝ćéăĺŤšéżç¸ćťéˇčçŤ´éżç¸ćťéˇéĺŻéżç¸ćťéˇéŁĺ˘śéżçťîéăĺŤšéżçşçĽ°C+8éżç¸ćťéďż???? //éżç¸ćťéˇç˝ćé¨ĺĺťéˇçŻçéżç¸ĺ¸´ćŠçťîéˇéĺŻéżçşçćśĺśćçźćšîŚflushéżç¸ćťéˇç˝ćéăĺŤšplush_4Déżç¸ćťéˇç˝ćéăďż???
//        {2{jumpE | branchE}} | forward_aE,  // éżç¸ćťéˇçŠxeéżçźć¨çč§ĺŤšéżç¸ćťéˇçŠaléżç¸ćťéˇç˝ćéăĺŤšjalré¸ĺŹćçťĺŹśç´éżç¸ćťéˇç˝ćéăĺŤšbxxzaléĺ ćéăĺŤšjumpE | branchE== 1éżç¸ćťéˇĺ¤ćˇ?éäťćéăĺŤšpc_plus4Déżç¸ćťéďż????

//        src_aE
//    );
//    mux4 #(32) mux4_forward_bE(
//        rd2E,                               //
//        resultM_without_rdata,                            //
//        resultW,                            // 
//        immE,                               //éżç¸ćťéˇç˝ćéăĺŤšéżç¸ćťéďż˝?
//        {2{alu_imm_selE}} | forward_bE,     //main_decoderéżç¸ćťéˇç˝ćéăĺŤšalu_imm_selEéżçťĺźéĺ¤çśéˇç˝ćéăĺŤšďż???çŻ´luéżçťĺŚ­çč§ĺŤšéżç¸ćťéˇç˝ćéăĺŤšéżç¸ćťéˇç˝ćéăĺŤšćść´ŞćéăĺŤšéżç¸ćťéˇç˝ćéăďż???

//        src_bE
//    );
    
//    mux4 #(32) mux4_rs_valueE(rd1E, resultM_without_rdata, resultW, 32'b0, forward_aE, rs_valueE); //éżç¸ćťéˇç˝ćéăĺŤšéĺśćéďźĺ°¨éˇç˝ćçť˛ďšéżçśčćçŹĺŤšéżç¸ćťéˇç˝ćéăĺŤšéďż????
//    mux4 #(32) mux4_rt_valueE(rd2E, resultM_without_rdata, resultW, 32'b0, forward_bE, rt_valueE); //éżç¸ćťéˇç˝ćéăĺŤšéĺśćéďźĺ°¨éˇç˝ćçť˛ďšéżçśčćçŹĺŤšéżç¸ćťéˇç˝ćéăĺŤšéďż????


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

	//  you can't delete the next line  
	assign pcsrcD = branchD & (srca2D == srcb2D);
	mux2 #(32) pcbrmux(pcplus4F,pcbranchD,pcsrcD,pcnextbrFD);
	// you can't delete the next code
	mux2 #(32) pcmux(pcnextbrFD,pcjumpD,jumpD,pcnextFD);
	// mux2 #(32) pcmux(pcnextbrFD,{pcplus4D[31:28], instrD[25:0], 2'b00},jumpD,pcnextFD);

	// assign pcnextFD = pcplus4E;
		

	//regfile (operates in decode and writeback)
	regfile rf(clk,regwriteW,rsD,rtD,writeregW,resultW,srcaD,srcbD);

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
	         .alu_num2(srcb2E),
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
//		.hi_oE(hi_oE),
//		.hi_oM(hi_oM),
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
	// 婢х偛濮為崘娆忣槱閿燂拷?
 	read_data read_data0(	.alucontrolW(alucontrolW),
							.readdataW(readdataW),
							.dataadrW(aluoutW),
							.readdataW_modified(readdataW_modified)
	);


    // meméżçźć¨ĺ¨ĺ¸çŽťçťč§ĺŤšéżç¸ćťéˇç˝ćéăĺŤšéćŹćéăĺŤšhi loéżçśčćçŹĺŤšéżç¸ćťéďż????
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
endmodule
	);

	mux4 #(32) resmux_new(aluoutW,readdataW,hi_oW,lo_oW,memtoregW,resultW);
//	mux2 #(32) resmux(aluoutW,readdataW,memtoregW,resultW);
    
    //DEBUG OUTPUT
    assign debug_wb_pc          = pcW;
    assign debug_wb_rf_wen      = {4{regwriteW & ~stallW}};
    assign debug_wb_rf_wnum     = writeregW;
    assign debug_wb_rf_wdata    = resultW;
endmodule

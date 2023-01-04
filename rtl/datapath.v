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
	

//闁愁偅鎸撮崯�?勫焼閹绢垰鏅柍顐ｆ尨閸熷矂鍩嗛幘顖氭櫕闁愁偅鎸撮崯�?勫焼閹绢垰鏅柍顐ｆ尨閸熷矂鍩嗛幘顖氭櫕闁愁偅鎸撮崯�?勫焼閹绢垰鏅柍顐ｆ尨閸熷矂宕ラ崼婵婂珯闁告艾绌痮ntroller闂侇喓鍔岄崹搴ㄦ儍閸曨喚绠剧紒鎯х氨閸熷矂鍩嗛幘顖氭櫕闁愁偅鎸撮崯�?勫焼閹绢垰鏅柍顐ｆ尨閸熷矂鍩嗛幘顖氭櫕闁愁偅鎸撮崯�?勫焼閹绢垰鏅柍顐ｆ尨閸熷矂鍩嗛幘顖氭櫕闁愁偅鎸撮崯�?勬晸閿�?????

	//decode stage
	wire [1:0] memtoregD;
	wire memwriteD,alusrcD,regdstD,regwriteD,gprtohiD,gprtoloD;
	//execute stage
	wire memwriteE,gprtohiE,gprtoloE;
	wire gprtohiM,gprtoloM;
	wire gprtohiW,gprtoloW;
//闂佹剚鍋呴崹鐔煎疮閸儱鐒奸柟�?�樻煥閺呫儵鏌嶉锝呯亶闁哥喎鐗撻崺鍡涘箣閺傛寧娅忛梺鎰佸亝閸ㄧ喖宕崼銉ョ劶闁瑰瓨鏌ㄩ弲銉╂煃椤愶絽鐏嶉柛鐔风墦閸╁棝骞嬮弬鎸庢珡闂佹剚鍋呴崹鐔煎疮閸儱鐒奸柟�?�樻煥閺呫儵鏌嶉锝呯亶闁哥喎鐗撻崺鍡涘箣閺傛寧娅忛梺鎰佸亝閸ㄧ喖宕崼銉ョ劶闁瑰瓨鏌ㄩ弲銉╂煃椤愶絽鐏嶉柛鐔风墦閸╁棝骞嬮弬鎸庢珡闂佹剚鍋呴崹鐔煎疮閸儱鐒奸柟�?�樻煥閺呫儵鏌嶉锝呯亶闁哥喎鐗撻崺鍡涘箣閺傛寧娅忛梺鎰佸亝閸ㄧ喖宕崼銉ョ劶闁瑰瓨鏌ㄩ弲銉╂煃椤愶絽鐏嶉柛鐔风墦閸╁棝骞嬮弬鎸庢珡闂佹剚鍋呴崹鐔煎疮閸儱鐒奸柟�?�樻煥閺呫儵鏌嶉锝呯亶闁哥喎鐗撻崺鍡涘箣閺傛寧娅忛梺鎰佸亝閸ㄧ喖宕崼銉︽櫢闁�??????

	// 闂佸憡鑹鹃張顒勵敆閻愬搫妫橀柡澶嬵儥閺夎霉閻欏懐鎮奸柨????
	wire regdstE,alusrcE,pcsrcD;
	wire [1:0] memtoregE,memtoregM,memtoregW;
//	wire [1:0] pcsrcD;
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
    wire regwriteW;
	
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
    
//    //闂備浇娉曢崰鎰板几婵犳艾绠柣鎴ｅГ閺呮悂鏌￠崒妯�??鏍�?姘秺�?�曟粌顓兼径瀣闂佸搫鍊堕崐鏍晸???(bypass)
//    mux4 #(32) mux4_forward_aE(
//        rd1E,                       
//        resultM_without_rdata,
//        resultW,
//        pc_plus4D,                          // 闂佸湱鐟抽崶銊︽闂佸搫鍊堕崐鏍�??姘鳖劕alr闂備浇娉曢崰鎰板几婵犳艾绠紒灞惧礁l闂佸湱枪濞差參寮幘鍓侀┏閻庯絽澧庨獮銏ゆ煕閹邦厾鎳囬柡浣规尵閹风娀顢曢�?鐘靛�?$ra闂備浇娉曢崰宥夋嚑鎼淬垺缍囬柣鎰靛墮椤忓爼姊虹捄銊ユ瀾闁哄顭烽獮蹇涙�?�閼恒儲娅㈤梺鍝勫€堕崐鏍�?姘秺閺屻劑鎮㈤崨濠勪紕闂佸綊顥撻崗姗€寮幘璇茬闁告垯鍊楃粔鍫曟煙妞嬪骸鍘撮柡浣规崌瀵剟濡堕崱妤婁紦闁哄鍎愰崜姘�??鍨哺閺屻劑鎮㈤崨濠勪紕闂佸綊顥撻崗姗€寮幘璇茬闁靛鍨甸娲煙閻戣姤鏁辨俊鎯嫮鈹嶉柕濞炬櫆閺呮悂鎮跺☉娆樻疁婵炵厧顭烽獮蹇涙�?�閼恒儲娅㈤梺鍝勫€堕崐鏍�?姘秺閺屻劑鎮㈤崨濠勪紕闂佸湱鏌夊�?�鍦博閹绢喗鐓ラ柣鏂挎啞閻忣噣鏌熼悜鑺ユ暠閻庡灚宀搁弻銊╂偄閸涘﹦浼勯梺鍦厴椤ユ挻鏅堕崼鏇熺叆闁绘梹妞块弫搴ㄦ煕閹存�??鏍�?姘秺閺屻劑鎮㈤搹骞垮仒C+8闂備浇娉曢崰鎰板几婵犳碍鏅搁�?????? //闂備浇娉曢崰鎰板几婵犳艾绠柣鎴ｅГ閺呮悂鏌ｉ妸銉︻棡闁哥偛顭烽獮蹇涙偪椤栨粍顫嶉梻浣芥硶閸犳劗鏁€涙ɑ浜ら柣鏃€妞块崵�?�煙閻戣姤鏁遍悗鍨哺閺屻劑鎮㈤搹瑙勬啒婵炴垶鎸哥粔褰掑极閹惧墎纾奸柟鎹愵嚃濞肩lush闂備浇娉曢崰鎰板几婵犳艾绠柣鎴ｅГ閺呮悂鏌￠崒妯�??鏍�?姘鳖劧lush_4D闂備浇娉曢崰鎰板几婵犳艾绠柣鎴ｅГ閺呮悂鏌￠崒妯�??鏍�????
//        {2{jumpE | branchE}} | forward_aE,  // 闂備浇娉曢崰鎰板几婵犳艾绠紒灞藉交e闂備浇娉曢崰鏍熸担鐑樺閻熸瑥瀚鍫曟⒑鐠恒劌鏋戦柡瀣煼楠炲繒绮氶幓鐮介梻浣芥硶閸犳劙寮告繝姘闁绘垼濮ら弲鎼佹煛閸屾�??鏍�?姘鳖劕alr闂佸湱枪濞差參寮幘鍓侀┏閻庯絽澧庣粈澶愭⒑鐠恒劌鏋戦柡瀣煼楠炲繘鎮滈懞銉︽闂佸搫鍊堕崐鏍�?姘鳖劇xxzal闂佸搫鍟悥濂稿极閹捐妫橀柕鍫濇椤忕umpE | branchE== 1闂備浇娉曢崰鎰板几婵犳艾绠柛鎴欏€栫€�???闂佽法鍠嶇划娆撳极閹捐妫橀柕鍫濇椤忕c_plus4D闂備浇娉曢崰鎰板几婵犳碍鏅搁�??????

//        src_aE
//    );
//    mux4 #(32) mux4_forward_bE(
//        rd2E,                               //
//        resultM_without_rdata,                            //
//        resultW,                            // 
//        immE,                               //闂備浇娉曢崰鎰板几婵犳艾绠柣鎴ｅГ閺呮悂鏌￠崒妯�??鏍�?姘秺閺屻劑鎮㈤崨濠勪紕闂佽法鍣﹂幏??
//        {2{alu_imm_selE}} | forward_bE,     //main_decoder闂備浇娉曢崰鎰板几婵犳艾绠柣鎴ｅГ閺呮悂鏌￠崒妯�??鏍�?姘鳖劆lu_imm_selE闂備浇娉曢崰鏇㈠礈婵傜ǹ鐭楅柛鎴欏€楃粔鍫曟煙妞嬪骸鍘撮柡浣规崌�?�剟濡堕崱妤婁紦闁�?????缂侊紕顥抲闂備浇娉曢崰鏇熶繆椤撶姵濯奸悷娆忓椤忓爼姊虹捄銊ユ�?�闁哄顭烽獮蹇涙�?�閼恒儲娅㈤梺鍝勫€堕崐鏍�?姘秺閺屻劑鎮㈤崨濠勪紕闂佸綊顥撻崗姗€寮幘璇叉闁靛牆妫楅璺衡槈閹惧瓨銇濋柡浣规崌瀵剟濡堕崱妤婁紦闂備浇娉曢崰鎰板几婵犳艾绠柣鎴ｅГ閺呮悂鏌￠崒妯�?鏍�????

//        src_bE
//    );
    
//    mux4 #(32) mux4_rs_valueE(rd1E, resultM_without_rdata, resultW, 32'b0, forward_aE, rs_valueE); //闂備浇娉曢崰鎰板几婵犳艾绠柣鎴ｅГ閺呮悂鏌￠崒妯�??鏍�?姘秺�?�曟粌顓兼径瀣闂佺粯鐟辩槐鏇犱焊閵娾晛绠柣鎴ｅГ閺呭摜绱掔拠褏顔庨梻浣芥硶閸犲秹鎳犳惔銏＄秶闁绘劦鍓欓鍫曟⒑鐠恒劌鏋戦柡�?�煼楠炲繘鎮滈懞銉︽闂佸搫鍊堕崐鏍�?姘秺閺佹捇鏁�????
//    mux4 #(32) mux4_rt_valueE(rd2E, resultM_without_rdata, resultW, 32'b0, forward_bE, rt_valueE); //闂備浇娉曢崰鎰板几婵犳艾绠柣鎴ｅГ閺呮悂鏌￠崒妯�??鏍�?姘秺�?�曟粌顓兼径瀣闂佺粯鐟辩槐鏇犱焊閵娾晛绠柣鎴ｅГ閺呭摜绱掔拠褏顔愰梻浣芥硶閸犲秹鎳犳惔銏＄秶闁绘劦鍓欓鍫曟⒑鐠恒劌鏋戦柡�?�煼楠炲繘鎮滈懞銉︽闂佸搫鍊堕崐鏍�?姘秺閺佹捇鏁�????


	//hazard detection
	hazard h(
		//fetch stage
		.stallF(stallF),
		.flushF(flushF),
		//decode stage
		.rsD(rsD),.rtD(rtD),
		.branchD(branchD),
		.forwardaD(forwardaD),.forwardbD(forwardbD),
		.stallD(stallD),
		.flushD(flushD),
		//execute stage
		.stall_divE(stall_divE),
		.rsE(rsE),.rtE(rtE),
		.writeregE(writeregE),
		.regwriteE(regwriteE),
		.memtoregE(memtoregE),
		.forwardaE(forwardaE),.forwardbE(forwardbE),
		.flushE(flushE),.stallE(stallE),
		//mem stage
		.writeregM(writeregM),
		.regwriteM(regwriteM),
		.memtoregM(memtoregM),
		//write back stage
		.writeregW(writeregW),
		.regwriteW(regwriteW)
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
	.we3(regwriteM),
	.ra1(rsD), 
	.ra2(rtD), 
	.wa3(writeregM), 
	.wd3(resultM),

	.rd1(srcaD), 
	.rd2(srcbD)
    );

	//fetch stage logic
	pc #(32) pcreg(clk,rst,~stallF,pcnextFD,pcF,pc_ce_reg);
	adder pcadd1(pcF,32'b100,pcplus4F);
	// hilo_reg hilo_regD(clk,rst,{gprtohiW,gprtoloW},srcaW,srcaW,hi_oD,lo_oD);

	//decode stage
	// ��ǰһ��Ϊbranch��Ԥ���������ҪflushD
    // ����ǰԤ��Ҫ��, ��flushD
    // assign flushD = (branchE & predict_wrong);// | (predictD & branchD);
    // TODO: �����ӳٲۣ������ﲻ��flush
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
    mux4 #(5) mux4_reg_dst(rdE, rtE, 5'd31, 5'b0, regdstE, writeregM);
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
	//闂備浇娉曢崰鎰板几婵犳艾绠柣鎴ｅГ閺呮悂鏌￠崒妯�??鏍�?姘鳖劇ranch闂備浇娉曢崰鎰板几婵犳艾绠柣鎴ｅГ閺呮悂鏌ㄩ悤鍌涘?
    branch_judge branch_judge0(
        .branch_judge_controlE(branch_judge_controlE),
        .srcaE(srca2E),
        .srcbE(srcb2E),
        .branch_takeE(branch_takeE)
    );
    
    assign branch_takeE = zeroE;
    
	//mem stage
	// 婵犫拃鍛粶濠殿喚鍋熼幏鐘垫嫚�?�割喗袩闂佽法鍣﹂幏??
	write_data write_data0(	.alucontrolE(alucontrolE),
							.aluoutE(aluoutE),
							.WriteDataE(srcb2E),
							.sig_write(sig_write),
							.WriteDataE_modified(WriteDataE_modified)
	);
	//闁稿繈鍔戦弫鎾诲棘閵堝棗顏堕梺璺ㄥ枑閺嬪骞忕粚婕穉ll

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
	// 婵犫拃鍛粶濠殿喚鍋ゅ畷妯衡枎韫囷絾袩闂佽法鍣﹂�???
 	read_data read_data0(	.alucontrolW(alucontrolW),
							.readdataW(readdataW),
							.dataadrW(aluoutW),
							.readdataW_modified(readdataW_modified)
	);


    // mem闂備浇娉曢崰鏍熸担绯曟灁闁稿繐鎽滈鎺旂磼濞戞粠娼愰悗姘秺閺屻劑鎮㈤崨濠勪紕闂佸綊顥撻崗姗€寮幘璇叉闁靛牆妫楅鍫曟煕閹邦厾鎳囬柡浣规崌瀵剟濡堕崱妤婁紦hi lo闂備浇娉曢崰宥夋嚑鎼淬垺缍囬柣鎰靛墮椤忓爼姊虹捄銊ユ瀾闁哄顭烽弫鎾绘晸????
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
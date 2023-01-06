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
	

//éćĺé¸ćŽĺ´ŻĺŽ?ĺŤçźéšçť˘ĺ°éîŚćéĄď˝ĺ°¨é¸çˇçéŠĺĺšéĄć°­ćŤéćĺé¸ćŽĺ´ŻĺŽ?ĺŤçźéšçť˘ĺ°éîŚćéĄď˝ĺ°¨é¸çˇçéŠĺĺšéĄć°­ćŤéćĺé¸ćŽĺ´ŻĺŽ?ĺŤçźéšçť˘ĺ°éîŚćéĄď˝ĺ°¨é¸çˇçĺŽăŠĺ´źĺŠľĺŠçŻéĺčžçťçŽntrolleréäžĺéĺ˛ĺ´šć´ăŚĺé¸ć¨ĺçť ĺ§ç´éŻŃć°¨é¸çˇçéŠĺĺšéĄć°­ćŤéćĺé¸ćŽĺ´ŻĺŽ?ĺŤçźéšçť˘ĺ°éîŚćéĄď˝ĺ°¨é¸çˇçéŠĺĺšéĄć°­ćŤéćĺé¸ćŽĺ´ŻĺŽ?ĺŤçźéšçť˘ĺ°éîŚćéĄď˝ĺ°¨é¸çˇçéŠĺĺšéĄć°­ćŤéćĺé¸ćŽĺ´ŻĺŽ?ĺŹć¸éżďż˝?????

	//decode stage
	wire [1:0] memtoregD;
	wire memwriteD,alusrcD,regdstD,regwriteD,gprtohiD,gprtoloD;
	//execute stage
	wire memwriteE,gprtohiE,gprtoloE;
	wire gprtohiM,gprtoloM;
	wire gprtohiW,gprtoloW;
//éä˝šĺéĺ´ĺ´šéççŽé¸î ĺąéĺĽ¸ćç?ć¨ťçĽéşĺŤĺľéĺśîéĺŻäşśéĺĽĺéćťĺ´şéĄćśçŽŁéşĺĺŻ§ĺ¨ĺżć˘şé°ä˝¸äşé¸ă§ĺĺŽîĺ´źéă§ĺśéç°ç¨éăŠĺź˛éâçć¤¤ćśçľ˝éĺśćééŁĺ˘Śé¸âćŁéŞĺŹŽĺźŹé¸ĺş˘çĄéä˝šĺéĺ´ĺ´šéççŽé¸î ĺąéĺĽ¸ćç?ć¨ťçĽéşĺŤĺľéĺśîéĺŻäşśéĺĽĺéćťĺ´şéĄćśçŽŁéşĺĺŻ§ĺ¨ĺżć˘şé°ä˝¸äşé¸ă§ĺĺŽîĺ´źéă§ĺśéç°ç¨éăŠĺź˛éâçć¤¤ćśçľ˝éĺśćééŁĺ˘Śé¸âćŁéŞĺŹŽĺźŹé¸ĺş˘çĄéä˝šĺéĺ´ĺ´šéççŽé¸î ĺąéĺĽ¸ćç?ć¨ťçĽéşĺŤĺľéĺśîéĺŻäşśéĺĽĺéćťĺ´şéĄćśçŽŁéşĺĺŻ§ĺ¨ĺżć˘şé°ä˝¸äşé¸ă§ĺĺŽîĺ´źéă§ĺśéç°ç¨éăŠĺź˛éâçć¤¤ćśçľ˝éĺśćééŁĺ˘Śé¸âćŁéŞĺŹŽĺźŹé¸ĺş˘çĄéä˝šĺéĺ´ĺ´šéççŽé¸î ĺąéĺĽ¸ćç?ć¨ťçĽéşĺŤĺľéĺśîéĺŻäşśéĺĽĺéćťĺ´şéĄćśçŽŁéşĺĺŻ§ĺ¨ĺżć˘şé°ä˝¸äşé¸ă§ĺĺŽîĺ´źéď¸˝ćŤ˘éďż??????

	// éä˝¸ćĄéšéšĺźľéĄĺľćéťćŹćŤĺŚŤćŠćĄćžśĺŹľĺĽéşĺ¤î§ééťćŹćéŽĺĽ¸ć¨????
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
    
//    //éĺćľĺ¨ć˘ĺ´°é°ćżĺ ĺŠľçłčžçť îćŁé´ď˝ĐéşĺŽćéďż ĺ´ĺŚŻďż??éďż˝?ĺ§îç§şç?šćç˛éĄĺźĺžçŁîŁîéä˝¸ćŤéĺ ĺ´éîć¸???(bypass)
//    mux4 #(32) mux4_forward_aE(
//        rd1E,                       
//        resultM_without_rdata,
//        resultW,
//        pc_plus4D,                          // éä˝¸ćšąéć˝ĺ´śéď¸˝îéä˝¸ćŤéĺ ĺ´éďż??ĺ§éłĺalréĺćľĺ¨ć˘ĺ´°é°ćżĺ ĺŠľçłčžçť îç´çć§ç¤léä˝¸ćšąćŞćżĺˇŽĺĺŻŽîŚĺšéäžâéťĺşŻçľ˝ćž§ĺş¨çŽéăçéšéŚĺžéłĺŹćĄćľŁč§ĺ°ľéšéŁĺ¨éĄ˘ć˘ĺ§?ééĺ¸?$raéĺćľĺ¨ć˘ĺ´°ĺŽĽĺ¤ĺéźćˇŹĺşçźĺŹćŁé°éĺ˘Žć¤¤ĺżçźĺ§čšćéăŚçžéĺîéĄ­ç˝çŽčšćśĺ?ťéźćĺ˛ĺ¨ă¤ć˘şéĺŤâŹĺ ĺ´éďż˝?ĺ§îç§şéşĺąťĺéŽă¤ĺ´¨ćż ĺŞç´éä˝¸çśéĄĽćťĺ´ĺ§âŹĺŻŽîŚĺšçčŹîéĺĺŻéćĽç˛éŤćçĺŚĺŹŞéŞ¸éćŽćĄćľŁč§ĺ´çľîĺćżĄĺ ĺ´ąĺŚ¤ĺŠç´Śéĺîąéć°ĺ´ĺ§ďż??é¨î˘ĺşéşĺąťĺéŽă¤ĺ´¨ćż ĺŞç´éä˝¸çśéĄĽćťĺ´ĺ§âŹĺŻŽîŚĺšçčŹîééî˝é¨ç¸îĺ¨˛îçéťćŁĺ§¤éčž¨äżéŻîĺŤŽéšĺśććżçŹćŤéşĺŽćéŽčˇşâĺ¨ć¨ťçĺŠľçľĺ§éĄ­ç˝çŽčšćśĺ?ťéźćĺ˛ĺ¨ă¤ć˘şéĺŤâŹĺ ĺ´éďż˝?ĺ§îç§şéşĺąťĺéŽă¤ĺ´¨ćż ĺŞç´éä˝¸ćšąéĺ¤ă?éŚî ĺéšçť˘ĺéăŠćŁéćĺéťĺżŁĺŁéçźćéşăŚć éťĺşĄçĺŽćĺźťéâĺé¸ćśďšŚćľźĺŻć˘şéŚîĺ´ć¤¤ăŚćťéĺ ĺ´źéçşĺéçťć˘šĺŚĺĺźŤć´ăŚçéšĺ­ç??éďż˝?ĺ§îç§şéşĺąťĺéŽă¤ćšéŞĺŽäťC+8éĺćľĺ¨ć˘ĺ´°é°ćżĺ ĺŠľçłç˘éćć?????? //éĺćľĺ¨ć˘ĺ´°é°ćżĺ ĺŠľçłčžçť îćŁé´ď˝ĐéşĺŽćéď˝ĺŚ¸éď¸ťćŁĄéĺĽĺéĄ­ç˝çŽčšćśĺŞć¤¤ć ¨ç˛éĄŤĺść˘ťćľŁčĽçĄśé¸çłĺéîžâŹćśÉćľăćŁéâŹĺŚĺĺ´ľç?Łî˝çéťćŁĺ§¤ééćé¨î˘ĺşéşĺąťĺéŽă¤ćšçĺŹĺĺŠľç´ĺśé¸ĺĽç˛č¤°ććéšć§ĺ˘çşžĺĽ¸ćéšćľĺćżčŠîlushéĺćľĺ¨ć˘ĺ´°é°ćżĺ ĺŠľçłčžçť îćŁé´ď˝ĐéşĺŽćéďż ĺ´ĺŚŻďż??éďż˝?ĺ§éłĺ§lush_4Déĺćľĺ¨ć˘ĺ´°é°ćżĺ ĺŠľçłčžçť îćŁé´ď˝ĐéşĺŽćéďż ĺ´ĺŚŻďż??éîć????
//        {2{jumpE | branchE}} | forward_aE,  // éĺćľĺ¨ć˘ĺ´°é°ćżĺ ĺŠľçłčžçť îç´çčäş¤eéĺćľĺ¨ć˘ĺ´°éîŹç¸ćéć¨şîéťç¸çĽçîîéŤćâé ćĺéćŚćĄçŁîçźćĽ ç˛çšçťŽć°śĺšéŽäťć˘ťćľŁčĽçĄśé¸çłĺĺŻŽĺçšĺ§îîéçťĺźćżŽăĺź˛éźä˝šçé¸ĺąžĂ??éďż˝?ĺ§éłĺalréä˝¸ćšąćŞćżĺˇŽĺĺŻŽîŚĺšéäžâéťĺşŻçľ˝ćž§ĺşŁç˛ćžść­âé ćĺéćŚćĄçŁîçźćĽ ç˛çšéŽćťćéď¸˝îéä˝¸ćŤéĺ ĺ´éďż˝?ĺ§éłĺxxzaléä˝¸ćŤéîŚćĽćżç¨żćéšćî§ĺŚŤćŠćéŤćżîć¤¤ĺżîumpE | branchE== 1éĺćľĺ¨ć˘ĺ´°é°ćżĺ ĺŠľçłčžçť îćé´ćŹâŹć ŤâŹďż???éä˝˝ćłé ĺśĺĺ¨ćłćéšćî§ĺŚŤćŠćéŤćżîć¤¤ĺżîc_plus4Déĺćľĺ¨ć˘ĺ´°é°ćżĺ ĺŠľçłç˘éćć??????

//        src_aE
//    );
//    mux4 #(32) mux4_forward_bE(
//        rd2E,                               //
//        resultM_without_rdata,                            //
//        resultW,                            // 
//        immE,                               //éĺćľĺ¨ć˘ĺ´°é°ćżĺ ĺŠľçłčžçť îćŁé´ď˝ĐéşĺŽćéďż ĺ´ĺŚŻďż??éďż˝?ĺ§îç§şéşĺąťĺéŽă¤ĺ´¨ćż ĺŞç´éä˝˝ćłéŁďšĺš??
//        {2{alu_imm_selE}} | forward_bE,     //main_decoderéĺćľĺ¨ć˘ĺ´°é°ćżĺ ĺŠľçłčžçť îćŁé´ď˝ĐéşĺŽćéďż ĺ´ĺŚŻďż??éďż˝?ĺ§éłĺlu_imm_selEéĺćľĺ¨ć˘ĺ´°éă ç¤ĺŠľĺÇšé­ćĽćé´ćŹâŹćĽç˛éŤćçĺŚĺŹŞéŞ¸éćŽćĄćľŁč§ĺ´ç?ľîĺćżĄĺ ĺ´ąĺŚ¤ĺŠç´Śéďż?????çźäžç´éĄĽć˛éĺćľĺ¨ć˘ĺ´°éçśçšć¤¤ćśĺ§ľćżŻĺĽ¸ćˇĺ¨ĺżîŠć¤¤ĺżçźĺ§čšćéăŚç?žéĺîéĄ­ç˝çŽčšćśĺ?ťéźćĺ˛ĺ¨ă¤ć˘şéĺŤâŹĺ ĺ´éďż˝?ĺ§îç§şéşĺąťĺéŽă¤ĺ´¨ćż ĺŞç´éä˝¸çśéĄĽćťĺ´ĺ§âŹĺŻŽîŚĺšçĺîééçĺŚŤćĽîçşčĄĄć§éšć§ç¨éćżćĄćľŁč§ĺ´çľîĺćżĄĺ ĺ´ąĺŚ¤ĺŠç´Śéĺćľĺ¨ć˘ĺ´°é°ćżĺ ĺŠľçłčžçť îćŁé´ď˝ĐéşĺŽćéďż ĺ´ĺŚŻďż˝?éîć????

//        src_bE
//    );
    
//    mux4 #(32) mux4_rs_valueE(rd1E, resultM_without_rdata, resultW, 32'b0, forward_aE, rs_valueE); //éĺćľĺ¨ć˘ĺ´°é°ćżĺ ĺŠľçłčžçť îćŁé´ď˝ĐéşĺŽćéďż ĺ´ĺŚŻďż??éďż˝?ĺ§îç§şç?šćç˛éĄĺźĺžçŁîŁîéä˝şç˛ŻéčžŠć§éçąçéľĺ¨žćçť îćŁé´ď˝Đéşĺ­ćçťąćć č¤éĄĺş¨ć˘ťćľŁčĽçĄśé¸ç˛ç§šéłçłćéďźç§śéçťĺŚéćŹîéŤćâé ćĺéćŚćĄç?ŁîçźćĽ ç˛çšéŽćťćéď¸˝îéä˝¸ćŤéĺ ĺ´éďż˝?ĺ§îç§şéşä˝šćéďż˝????
//    mux4 #(32) mux4_rt_valueE(rd2E, resultM_without_rdata, resultW, 32'b0, forward_bE, rt_valueE); //éĺćľĺ¨ć˘ĺ´°é°ćżĺ ĺŠľçłčžçť îćŁé´ď˝ĐéşĺŽćéďż ĺ´ĺŚŻďż??éďż˝?ĺ§îç§şç?šćç˛éĄĺźĺžçŁîŁîéä˝şç˛ŻéčžŠć§éçąçéľĺ¨žćçť îćŁé´ď˝Đéşĺ­ćçťąćć č¤éĄć°ć˘ťćľŁčĽçĄśé¸ç˛ç§šéłçłćéďźç§śéçťĺŚéćŹîéŤćâé ćĺéćŚćĄç?ŁîçźćĽ ç˛çšéŽćťćéď¸˝îéä˝¸ćŤéĺ ĺ´éďż˝?ĺ§îç§şéşä˝šćéďż˝????


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
	.we3(regwrite_enW),
	.ra1(rsD), 
	.ra2(rtD), 
	.wa3(writeregW), 
	.wd3(resultW),
	.rd1(srcaD), 
	.rd2(srcbD)
    );

	//fetch stage logic
	pc #(32) pcreg(clk,rst,~stallF,pcnextFD,pcF,pc_ce_reg);
//	assign pcplus4F = pcF + 4;
	adder pcadd1(pcF,32'b100,pcplus4F);
	// hilo_reg hilo_regD(clk,rst,{gprtohiW,gprtoloW},srcaW,srcaW,hi_oD,lo_oD);

//IF_ID flop
    if_id if_id0(
        .clk(clk),
        .rst(rst),
        .stallD(stallD),
        .flushD(flushD),
        .pcF(pcF),
        .pc_plus4F(pcplus4F),
        .instrF(instrF),
        .intD(intD),
        .pcD(pcD),
        .pc_plus4D(pcplus4D),
        .instrD(instrD)
    );



	//decode stage
	// ČôÇ°ŇťĚőÎŞbranchÇŇÔ¤˛â´íÎóŁŹÔňĐčŇŞflushD
    // ČôľąÇ°Ô¤˛âŇŞĚř, ÔňflushD
    // assign flushD = (branchE & predict_wrong);// | (predictD & branchD);
    // TODO: ČôÓĐŃÓłŮ˛ŰŁŹÔňŐâŔď˛ťÄÜflush

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
	
	
	// ID_EX flop
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
	
	//execute stage
	//mux write reg
    // mux4 #(5) mux4_reg_dst(rdE, rtE, 5'd31, 5'b0, regdstE, writeregM);
	mux3 #(32) forwardaemux(srcaE,resultW,aluoutM,forwardaE,srca2E);
	mux3 #(32) forwardbemux(srcbE,resultW,aluoutM,forwardbE,srcb2E);
	mux2 #(32) srcbmux(srcb2E,signimmE,alusrcE,srcb3E);
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
	

    branch_judge branch_judge0(
        .branch_judge_controlE(branch_judge_controlE),
        .srcaE(srca2E),
        .srcbE(srcb2E),
        .branch_takeE(branch_takeE)
    );
    
    assign branch_takeE = zeroE;
    
    
    //EX_MEM flop
	flopr#(32) fp4_1(clk,rst,aluoutE,aluoutM);
	flopr#(5) fp4_2(clk,rst,writeregE,writeregM);
	flopr#(64) fp4_3(clk,rst,aluout64E,aluout64M);
	flopr#(32) fp4_4(clk,rst,srcaE,srcaM);
	flopr#(32) fp4_5(clk,rst,pcbranchE,pcbranchM);
	flopr#(1) fp4_6(clk,rst,branch_takeE,branch_takeM);
	flopr#(2) fp4_7(clk,rst,memtoregE,memtoregM);
	flopr#(1) fp4_8(clk,rst,memwriteE,memwriteM);
	flopr#(1) fp4_9(clk,rst,regwrite_enE,regwrite_enM);
	flopr#(8) fp4_10(clk,rst,alucontrolE,alucontrolM);
	flopr#(1) fp4_11(clk,rst,gprtohiE,gprtohiM);
	flopr#(1) fp4_12(clk,rst,gprtoloE,gprtoloM);
	flopr#(32) fp4_13(clk,rst,WriteDataE_modified,writedataM);
	flopr#(32) fp4_14(clk,rst,pcE,pcM);

    
    
	//mem stage
	// ĺŠľçŤćéîç˛śćż ćŽżĺéçźĺšéĺŤĺŤç?šĺ˛ĺč˘Šéä˝˝ćłéŁďšĺš??
	write_data write_data0(	.alucontrolE(alucontrolE),
							.aluoutE(aluoutE),
							.WriteDataE(srcb2E),
							.sig_write(sig_write),
							.WriteDataE_modified(WriteDataE_modified)
	);
	//éç¨żçšéćŚĺźŤéžčŻ˛ćŁéľĺ ćŁéĄĺ ć˘şçşăĽćéşĺŹŞîˇéŞĺżç˛ĺŠçŠll
    assign resultM = aluoutM;

    // MEM_WB flop
	flopr#(32) fp5_1(clk,rst,aluoutM,aluoutW);
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



	//writeback stage
	// ĺŠľçŤćéîç˛śćż ćŽżĺéăçˇĺŚŻčĄĄćéŤĺˇçľžč˘Šéä˝˝ćłéŁďšĺš???
 	read_data read_data0(	.alucontrolW(alucontrolW),
							.readdataW(readdataW),
							.dataadrW(aluoutW),
							.readdataW_modified(readdataW_modified)
	);


    // meméĺćľĺ¨ć˘ĺ´°éîŹç¸ćçťŻćçéç¨żçšé˝ćťîéşćçŁźćżćç˛ ĺ¨źć°ćĺ§îç§şéşĺąťĺéŽă¤ĺ´¨ćż ĺŞç´éä˝¸çśéĄĽćťĺ´ĺ§âŹĺŻŽîŚĺšçĺîééçĺŚŤćĽîéŤćçéšéŚĺžéłĺŹćĄćľŁč§ĺ´çľîĺćżĄĺ ĺ´ąĺŚ¤ĺŠç´Śhi loéĺćľĺ¨ć˘ĺ´°ĺŽĽĺ¤ĺéźćˇŹĺşçźĺŹćŁé°éĺ˘Žć¤¤ĺżçźĺ§čšćéăŚçžéĺîéĄ­ç˝ĺźŤéžçťć¸????
    hilo_reg hilo_reg(clk,rst,{gprtohiM,gprtoloM},aluout64M[63:32],aluout64M[31:0],hi_oM,lo_oM);
	assign hilo = {hi_oM, lo_oM};

	mux4 #(32) resmux_new(aluoutW,readdataW,hi_oW,lo_oW,memtoregW,resultW);
//	mux2 #(32) resmux(aluoutW,readdataW,memtoregW,resultW);
    
    //DEBUG OUTPUT
    assign debug_wb_pc          = pcW;
    assign debug_wb_rf_wen      = {4{regwriteW & ~stallW}};
    assign debug_wb_rf_wnum     = writeregW;
    assign debug_wb_rf_wdata    = resultW;
endmodule
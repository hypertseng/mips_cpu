`timescale 1ns / 1ps


`include "defines.vh"

module alu(
	input wire[31:0] alu_num1,alu_num2,
	input wire[7:0] alucontrol,
	input wire [63:0] hilo,

	output wire[31:0] alu_out,
	output wire[63:0] alu_out_64,
	output wire overflowE,
	output wire jumpE,
	output wire stall_div 
    );
	wire[31:0] alu_ans,

	// branch :  jump check
    assign jumpE = (alucontrol == `EXE_BEQ_OP) ? (alu_num1 == alu_num2):                       // == 0
                  (alucontrol == `EXE_BNE_OP) ? (alu_num1 != alu_num2):                       // != 0
                  (alucontrol == `EXE_BGTZ_OP) ? ((alu_num1[31]==1'b0) && (alu_num1!=32'b0)): // > 0 
                  (alucontrol == `EXE_BLEZ_OP) ? ((alu_num1[31]==1'b1) || (alu_num1==32'b0)): // <= 0
                  (alucontrol == `EXE_BLTZ_OP) ? (alu_num1[31] == 1'b1):                  // < 0
                  (alucontrol == `EXE_BGEZ_OP) ? (alu_num1[31] == 1'b0):                  // >= 0
                  // 下面两条是特殊指令 无论是否跳转 必须写GHR[31]
                  (alucontrol == `EXE_BLTZAL_OP) ? (alu_num1[31] == 1'b1):                // < 0
                  (alucontrol == `EXE_BGEZAL_OP) ? (alu_num1[31] == 1'b0):                // >= 0
                  (alu_ans == 32'b0);
	// overflow check
    wire overflow_add; // 用于检测溢出位
    wire overflow_sub;
    assign overflow_add = ( (alu_ans[31] & (~alu_num1[31] & ~alu_num2[31])) 
                || (~alu_ans[31] & (alu_num1[31] & alu_num2[31]))) &&(alucontrol == `EXE_ADD_OP || alucontrol == `EXE_ADDI_OP );
    assign overflow_sub = ( (alucontrol == `EXE_SUB_OP ) && 
                ((alu_ans[31] & (~alu_num1[31] & ~num2_reg[31])) || (~alu_ans[31] & (alu_num1[31] & num2_reg[31]))) 
                );
    assign overflowE = overflow_add || overflow_sub;
    assign alu_out = (overflowE == 1) ? 0:alu_ans;
    // div 
    wire [63:0] div_result;
    wire start_div, signed_div, div_ready;
    assign start_div  = (alucontrol==`EXE_DIVU_OP | alucontrol==`EXE_DIV_OP) ? 1'b1 : 1'b0;
    assign signed_div = (alucontrol==`EXE_DIV_OP) ? 1'b1 : 1'b0;
    assign div_ready  = ~stall_div;
    div div(~clk, rst, alu_num1, alu_num2, start_div, signed_div, stall_div, div_result); 
    
    

	always @(*) begin
		case(alucontrol)
			// 逻辑运算
			`EXE_AND_OP	:	alu_ans <= alu_num1 & alu_num2;
			`EXE_OR_OP	:	alu_ans <= alu_num1 | alu_num2;
			`EXE_XOR_OP	:	alu_ans <= alu_num1 ^ alu_num2;
			`EXE_NOR_OP	:	alu_ans <= ~(alu_num1 | alu_num2);
			// 逻辑立即数运�??
			`EXE_ANDI_OP:	alu_ans <= alu_num1 & {{16{1'b0}}, alu_num2[15:0]};
			`EXE_ORI_OP:	alu_ans <= alu_num1 | {{16{1'b0}}, alu_num2[15:0]};
			`EXE_XORI_OP:	alu_ans <= alu_num1 ^ {{16{1'b0}}, alu_num2[15:0]};
			`EXE_LUI_OP:	alu_ans <= {alu_num2[15:0], {16{1'b0}}};
			// 移位指令
			`EXE_SLL_OP: 	alu_ans <= alu_num2 << sa;
			`EXE_SRL_OP: 	alu_ans <= alu_num2 >> sa;
			`EXE_SRA_OP: 	alu_ans <= $signed(alu_num2) >>> sa;
			`EXE_SLLV_OP: 	alu_ans <= alu_num2 << alu_num1[4:0];
			`EXE_SRLV_OP: 	alu_ans <= alu_num2 >> alu_num1[4:0];
			`EXE_SRAV_OP: 	alu_ans <= $signed(alu_num2) >>> alu_num1[4:0];
			
			// 数据移动指令
			`EXE_MFHI_OP:	alu_ans <= hilo[63:32];
			`EXE_MFLO_OP:	alu_ans <= hilo[31:0];
			`EXE_MTHI_OP:	alu_ans <= alu_num1;
			`EXE_MTLO_OP:	alu_ans <= alu_num1;

			// 算术运算指令
			`EXE_ADD_OP:	alu_ans <= alu_num1 + alu_num2;
			`EXE_ADDU_OP:	alu_ans <= alu_num1 + alu_num2;
			`EXE_SUB_OP:	alu_ans <= alu_num1 - alu_num2;
			`EXE_SUBU_OP:	alu_ans <= alu_num1 - alu_num2;
			`EXE_SLT_OP:	alu_ans <= $signed(alu_num1) < $signed(alu_num2);
			`EXE_SLTU_OP:	alu_ans <= alu_num1 < alu_num2;
            `EXE_ADDI_OP:	alu_ans <= alu_num1 + alu_num2;
            `EXE_ADDIU_OP:	alu_ans <= alu_num1 + alu_num2;
            `EXE_SLTI_OP:	alu_ans <= $signed(alu_num1) < $signed(alu_num2);
            `EXE_SLTIU_OP:	alu_ans <= alu_num1 < alu_num2;
			
			`EXE_MULTU_OP:  alu_out_64 <= {32'b0, alu_num1} * {32'b0, alu_num2};
            `EXE_MULT_OP:   alu_out_64 <= $signed(alu_num1) * $signed(alu_num2);
            `EXE_DIV_OP,`EXE_DIVU_OP: alu_out_64 <= div_result;
			// 分支跳转指令
			`EXE_J_OP:		alu_ans <= alu_num1 + alu_num2;
			// `EXE_JR_OP:		alu_ans <= alu_num1 + alu_num2;
			`EXE_JAL_OP:	alu_ans <= pc_add4E + 32'b100;// 需要写pc+8到31号ra寄存器
			`EXE_JALR_OP:	alu_ans <= pc_add4E + 32'b100;// 需要写pc+8到31号rd寄存器
			 
			//b type
            `EXE_BEQ_OP:	alu_ans <= alu_num1 - alu_num2;
            `EXE_BNE_OP:	alu_ans <= alu_num1 - alu_num2;
            `EXE_BLTZAL_OP:	alu_ans <= pc_add4E + 32'b100  ;   // 需要写pc+8到31号ra寄存器
            `EXE_BGEZAL_OP:	alu_ans <= pc_add4E + 32'b100  ;   // 需要写pc+8到31号ra寄存器

            // 访存指令
            `EXE_LB_OP:		alu_ans <= alu_num1 + alu_num2;
            `EXE_LBU_OP:	alu_ans <= alu_num1 + alu_num2;
            `EXE_LH_OP:		alu_ans <= alu_num1 + alu_num2;
            `EXE_LHU_OP:	alu_ans <= alu_num1 + alu_num2;
            `EXE_LW_OP:		alu_ans <= alu_num1 + alu_num2;
            `EXE_SB_OP:		alu_ans <= alu_num1 + alu_num2;
            `EXE_SH_OP:		alu_ans <= alu_num1 + alu_num2;
            `EXE_SW_OP:		alu_ans <= alu_num1 + alu_num2;

			// 内陷指令

            // 特权指令
            `EXE_MTC0_OP: alu_ans <= alu_num2;
            // `EXE_MFC0_OP: alu_ans <= ;
            `EXE_ERET_OP: alu_ans <= 32'b0;
            default: begin
				alu_ans <= 32'b0;
				alu_out_64 <= 64'b0;
			end
	endcase
	end
endmodule

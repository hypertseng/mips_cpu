`timescale 1ns / 1ps


`include "defines.vh"
// module alu(
// 	input wire [31:0] alu_num1,
// 	input wire [31:0] alu_num2,
// 	input wire [4:0] sa,
// 	input wire [7:0]alucontrol,

// 	output reg [31:0] alu_out
// 	// output reg overflow,
// 	// output wire zero
//     );
module alu(
	input wire[31:0] alu_num1,alu_num2,
	input wire[7:0] alucontrol,
	
	output reg[31:0] alu_out,
	output reg overflow,
	output wire zero
    );
	always @(*) begin
		case(alucontrol)
			// 逻辑运算
			`EXE_AND_OP	:	alu_out <= alu_num1 & alu_num2;
			`EXE_OR_OP	:	alu_out <= alu_num1 | alu_num2;
			`EXE_XOR_OP	:	alu_out <= alu_num1 ^ alu_num2;
			`EXE_NOR_OP	:	alu_out <= ~(alu_num1 | alu_num2);
			// 逻辑立即数运�??
			`EXE_ANDI_OP:	alu_out <= alu_num1 & {{16{1'b0}}, alu_num2[15:0]};
			`EXE_ORI_OP:	alu_out <= alu_num1 | {{16{1'b0}}, alu_num2[15:0]};
			`EXE_XORI_OP:	alu_out <= alu_num1 ^ {{16{1'b0}}, alu_num2[15:0]};
			`EXE_LUI_OP:	alu_out <= {alu_num2[15:0], {16{1'b0}}};
			// 移位指令
//			`EXE_SLL_OP: 	alu_out <= alu_num2 << sa;
//			`EXE_SRL_OP: 	alu_out <= alu_num2 >> sa;
//			`EXE_SRA_OP: 	alu_out <= $signed(alu_num2) >>> sa;
			`EXE_SLLV_OP: 	alu_out <= alu_num2 << alu_num1[4:0];
			`EXE_SRLV_OP: 	alu_out <= alu_num2 >> alu_num1[4:0];
			`EXE_SRAV_OP: 	alu_out <= $signed(alu_num2) >>> alu_num1[4:0];
			
			// 数据移动指令
			// `EXE_MFHI_OP:	alu_out <= 
			// `EXE_MFLO_OP:	alu_out <= 
			// `EXE_MTHI_OP:	alu_out <= 
			// `EXE_MTLO_OP:	alu_out <= 

			// 算术运算指令
			`EXE_ADD_OP:	alu_out <= alu_num1 + alu_num2;
			`EXE_ADDU_OP:	alu_out <= alu_num1 + alu_num2;
			`EXE_SUB_OP:	alu_out <= alu_num1 - alu_num2;
			`EXE_SUBU_OP:	alu_out <= alu_num1 - alu_num2;
			`EXE_SLT_OP:	alu_out <= $signed(alu_num1) < $signed(alu_num2);
			`EXE_SLTU_OP:	alu_out <= alu_num1 < alu_num2;
            `EXE_ADDI_OP:	alu_out <= alu_num1 + alu_num2;
            `EXE_ADDIU_OP:	alu_out <= alu_num1 + alu_num2;
            `EXE_SLTI_OP:	alu_out <= $signed(alu_num1) < $signed(alu_num2);
            `EXE_SLTIU_OP:	alu_out <= alu_num1 < alu_num2;
			
			// 分支跳转指令
			`EXE_J_OP:		alu_out <= alu_num1 + alu_num2;
			// `EXE_JR_OP:		alu_out <= alu_num1 + alu_num2;
			// `EXE_JAL_OP:		alu_out <= alu_num1 + alu_num2;
			// `EXE_JALR_OP:	alu_out <= alu_num1 + alu_num2;
			 
			//b type
            `EXE_BEQ_OP:	alu_out <= alu_num1 - alu_num2;
            `EXE_BNE_OP:	alu_out <= alu_num1 - alu_num2;
            // `EXE_BLTZAL_OP:	alu_out <= pc_add4E + 32'b100  ;   // �???要写pc+8�???31号ra寄存�???
            // `EXE_BGEZAL_OP:	alu_out <= pc_add4E + 32'b100  ;   // �???要写pc+8�???31号ra寄存�???

            // 访存指令
            `EXE_LB_OP:		alu_out <= alu_num1 + alu_num2;
            `EXE_LBU_OP:	alu_out <= alu_num1 + alu_num2;
            `EXE_LH_OP:		alu_out <= alu_num1 + alu_num2;
            `EXE_LHU_OP:	alu_out <= alu_num1 + alu_num2;
            `EXE_LW_OP:		alu_out <= alu_num1 + alu_num2;
            `EXE_SB_OP:		alu_out <= alu_num1 + alu_num2;
            `EXE_SH_OP:		alu_out <= alu_num1 + alu_num2;
            `EXE_SW_OP:		alu_out <= alu_num1 + alu_num2;

			// 内陷指令

            // 特权指令
            `EXE_MTC0_OP: alu_out <= alu_num2;
            // `EXE_MFC0_OP: alu_out <= ;
            `EXE_ERET_OP: alu_out <= 32'b0;
            default: alu_out <= 32'b0;
	endcase
	end
endmodule

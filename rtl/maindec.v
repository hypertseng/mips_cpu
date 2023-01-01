`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/10/23 15:21:30
// Design Name: 
// Module Name: maindec
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

`include "defines.vh"
module maindec(
	input wire [5:0] op,
	input wire [4:0] rs,rt,
	input wire [5:0] funct,

	output wire memtoreg,memwrite,
	output wire branch,alusrc,
	output wire regdst,regwrite,
	output wire jump
    
	// input wire [5:0] op,
    // input wire[5:0] funct,
    // input wire [4:0] rs,
    // input wire[4:0] rt,
    // output wire regwrite,regdst,alusrc,branch,
    // output wire memwrite,memtoreg,
    // output wire al_regdst,
	// output wire jump,jumpr,     // 地址jump和寄存器值jump
    // output reg invalid, // 保留地址异常
    // output reg cp0write // 写入cp0
    );

	reg [5:0] main_signal;

    assign {regwrite,regdst,alusrc,branch,memwrite,memtoreg} = main_signal;
    always @(*) begin
		case(op)
			`EXE_NOP:
			case(funct)
				// 逻辑指令
				`EXE_AND, `EXE_OR, `EXE_XOR, `EXE_NOR: main_signal <= 6'b110000; // R-type
				// 移位指令
			    `EXE_SLL, `EXE_SRL, `EXE_SRA, `EXE_SLLV, `EXE_SRLV, `EXE_SRAV: main_signal <= 6'b110000; // R-type
				//TODO `EXE_MFHI `EXE_MTHI `EXE_MFLO `EXE_MTLO
                // Arithmetic inst
                `EXE_ADD, `EXE_ADDU, `EXE_SUB, `EXE_SUBU, `EXE_SLT, `EXE_SLTU, `EXE_MULT, `EXE_MULTU, `EXE_DIV, `EXE_DIVU: main_signal <= 6'b110000; // R-type
                
                `EXE_MFHI, `EXE_MFLO: main_signal <= 6'b110000;
                `EXE_MTHI, `EXE_MTLO: main_signal <= 6'b000000;
                `EXE_SYSCALL,`EXE_BREAK : main_signal <= 6'b000000;
                

                // j inst
                `EXE_JR:  main_signal <= 6'b000000;
                `EXE_JALR:main_signal <= 6'b110000;  // 选择rd作为写寄存器位置

                default:begin
                    main_signal <= 6'b000000;
                    // invalid = 1;
                end 
			endcase
			// logic inst
            `EXE_ANDI ,`EXE_XORI, `EXE_LUI, `EXE_ORI: main_signal <= 6'b101000; // Immediate
            
            `EXE_ADDI, `EXE_ADDIU ,`EXE_SLTI, `EXE_SLTIU: main_signal <= 6'b101000; // Immediate
            
            // branch inst
            `EXE_BEQ, `EXE_BGTZ, `EXE_BLEZ, `EXE_BNE    :main_signal <= 6'b000100    ;
            
            `EXE_REGIMM_INST: case(rt)
                `EXE_BLTZ   :main_signal <= 6'b000100      ;
                `EXE_BLTZAL :main_signal <= 6'b100100      ;
                `EXE_BGEZ   :main_signal <= 6'b000100      ;
                `EXE_BGEZAL :main_signal <= 6'b100100      ;
                // default: invalid = 1;
            endcase
            
            // j inst
            `EXE_J  : main_signal <= 6'b000000;
            `EXE_JAL: main_signal <= 6'b100000;

            // memory insts
            `EXE_LB : main_signal <= 6'b101011;
            `EXE_LBU: main_signal <= 6'b101011;
            `EXE_LH : main_signal <= 6'b101011;
            `EXE_LHU: main_signal <= 6'b101011;
            `EXE_LW : main_signal <= 6'b101011;  // lab4 lw
            `EXE_SB : main_signal <= 6'b001010;  
            `EXE_SH : main_signal <= 6'b001010;  
            `EXE_SW : main_signal <= 6'b001010;  // lab4 sw

            // 特权指令
            6'b010000 : case(rs)
                5'b00100:begin  // mtc0
                    // cp0write = 1;
                    main_signal <= 6'b000000;
                end 
                5'b00000: main_signal <= 6'b100000; // mtfc0
                5'b10000: main_signal <= 6'b000000; // eret TODO: 参�?�代码中regwrite�??1，这里不�??1
                default: begin
                    // invalid = 1;
                    main_signal <= 6'b000000;  // error op
                end 
            endcase

            default:begin
                // invalid = 1;
                main_signal <= 6'b000000;  // error op
            end 
		endcase
	end
endmodule

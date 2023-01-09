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

	output wire [1:0] memtoreg, //00->aluresult 01->readdata 10->hi 11->lo
	output wire memwrite,   // en signal
	output wire branch,     
    output wire alusrc,     // 0 -> reg, 1 -> imm 
    output wire regdst,    // 1->rt 0->rd
    output wire regwrite,   // en signal 
	output wire gprtohi,   //gprtohi GPR->hi
	output wire gprtolo,   //gprtolo GPR->lo
    
	// input wire [5:0] op,
    // input wire[5:0] funct,
    // input wire [4:0] rs,
    // input wire[4:0] rt,
    // output wire regwrite,regdst,alusrc,branch,
    // output wire memwrite,memtoreg,
    output wire write_al,
	output wire jump,jumpr     // 閸︽澘娼僯ump閸滃苯鐦庣�涙ê娅掗崐绯簎mp
    // output reg invalid, // 娣囨繄鏆�閸︽澘娼冨鍌氱埗
    // output reg cp0write // 閸愭瑥鍙哻p0
    );

	reg [8:0] main_signal;
    //閿熸枻鎷烽敓鏂ゆ嫹hilowrite閿熻剼鐚存嫹
    assign {regwrite,regdst,alusrc,branch,memwrite,memtoreg,gprtohi,gprtolo} = main_signal;
    // 閿熸枻鎷烽敓鏂ゆ嫹jump閿熻剼鐚存嫹
    assign jump = ((op == `EXE_J) || (op == `EXE_JAL)) ? 1 : 0;
    assign jumpr = ((op == `EXE_NOP) && ((funct == `EXE_JR) || (funct == `EXE_JALR))) ? 1 : 0;

    assign write_al = (((op == `EXE_REGIMM_INST) && (rt == `EXE_BLTZAL || rt == `EXE_BGEZAL)) // 閿熸枻鎷烽敓鏂ゆ嫹bzal鎸囬敓鏂ゆ嫹
                        || (op == `EXE_JAL)) ? 1 : 0;  // jal鎸囬敓鏂ゆ嫹
    
    
    always @(*) begin
		case(op)
			`EXE_NOP:
			case(funct)
				// logic instr
				`EXE_AND, `EXE_OR, `EXE_XOR, `EXE_NOR, 
			    `EXE_SLL, `EXE_SRL, `EXE_SRA, `EXE_SLLV, `EXE_SRLV, `EXE_SRAV,
				//TODO `EXE_MFHI `EXE_MTHI `EXE_MFLO `EXE_MTLO
                `EXE_ADD, `EXE_ADDU, `EXE_SUB, `EXE_SUBU, `EXE_SLT, `EXE_SLTU: main_signal <= 9'b10000_00_00; // R-type
                
                `EXE_MULT, `EXE_MULTU, `EXE_DIV, `EXE_DIVU: main_signal <= 9'b11000_00_11;
                
                `EXE_MFHI: main_signal <= 9'b10000_10_00;//  hi -> gpr
                `EXE_MFLO: main_signal <= 9'b10000_11_00;//  lo -> gpr
                `EXE_MTHI: main_signal <= 9'b01000_00_10;
                `EXE_MTLO: main_signal <= 9'b01000_00_01;
                
                `EXE_SYSCALL,`EXE_BREAK : main_signal <= 9'b01000_00_00;
                

                // j inst
                `EXE_JR:  main_signal <= 9'b01000_00_00;
                `EXE_JALR:main_signal <= 9'b10000_00_00;  // 闁�?�╮d娴ｆ粈璐熼崘娆忕槑鐎涙ê娅掓担宥囩�?

                default:begin
                    main_signal <= 9'b01000_00_00;
                    // invalid = 1;
                end 
			endcase
			// logic inst
            `EXE_ANDI ,`EXE_XORI, `EXE_LUI, `EXE_ORI: main_signal <= 9'b11100_00_00; // Immediate
            
            `EXE_ADDI, `EXE_ADDIU ,`EXE_SLTI, `EXE_SLTIU: main_signal <= 9'b11100_00_00; // Immediate
            
            // branch inst
            `EXE_BEQ, `EXE_BGTZ, `EXE_BLEZ, `EXE_BNE    :main_signal <= 9'b01010_00_00    ;
            
            `EXE_REGIMM_INST: case(rt)
                `EXE_BLTZ   :main_signal <= 9'b01010_00_00      ;
                `EXE_BLTZAL :main_signal <= 9'b11010_00_00      ;
                `EXE_BGEZ   :main_signal <= 9'b01010_00_00      ;
                `EXE_BGEZAL :main_signal <= 9'b11010_00_00      ;
                // default: invalid = 1;
            endcase
            
            // j inst
            `EXE_J  : main_signal <= 9'b01000_00_00;
            `EXE_JAL: main_signal <= 9'b11000_00_00;

            // memory insts
            `EXE_LB : main_signal <= 9'b11101_01_00;
            `EXE_LBU: main_signal <= 9'b11101_01_00;
            `EXE_LH : main_signal <= 9'b11101_01_00;
            `EXE_LHU: main_signal <= 9'b11101_01_00;
            `EXE_LW : main_signal <= 9'b11101_01_00;  // lab4 lw
            `EXE_SB : main_signal <= 9'b01101_00_00;  
            `EXE_SH : main_signal <= 9'b01101_00_00;  
            `EXE_SW : main_signal <= 9'b01101_00_00;  // lab4 sw

            // 閻楄娼堥幐鍥︽�?
            6'b010000 : case(rs)
                5'b00100:begin  // mtc0
                    // cp0write = 1;
                    main_signal <= 9'b01000_00_00;
                end 
                5'b00000: main_signal <= 9'b11000_00_00; // mtfc0
                5'b10000: main_signal <= 9'b01000_00_00; // eret TODO: 閸欏偊鎷�??閿熸垝鍞惍浣疯厬regwrite閿燂�?????1閿涘矁绻栭柌灞肩瑝閿燂拷????1
                default: begin
                    // invalid = 1;
                    main_signal <= 9'b01000_00_00;  // error op
                end 
            endcase

            default:begin
                // invalid = 1;
                main_signal <= 9'b01000_00_00;  // error op
            end 
		endcase
	end
endmodule

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

	output wire memwrite,
	output wire [1:0] memtoreg, //00为aluresult，01为readdata，10为hi，11为lo，这里已经包含了hilotogpr的信号
	output wire branch,alusrc,
	output wire regdst,regwrite,
	output wire jump,
	output wire gprtohi,  //新增gprtohi，代表GPR写入hi
	output wire gprtolo   //新增gprtolo，代表GPR写入lo
    
	// input wire [5:0] op,
    // input wire[5:0] funct,
    // input wire [4:0] rs,
    // input wire[4:0] rt,
    // output wire regwrite,regdst,alusrc,branch,
    // output wire memwrite,memtoreg,
    // output wire al_regdst,
	// output wire jump,jumpr,     // 鍦板潃jump鍜屽瘎瀛樺櫒鍊糺ump
    // output reg invalid, // 淇濈暀鍦板潃寮傚父
    // output reg cp0write // 鍐欏叆cp0
    );

	reg [8:0] main_signal;
    //新增hilowrite信号
    assign {regwrite,regdst,alusrc,branch,memwrite,memtoreg,gprtohi,gprtolo} = main_signal;
    always @(*) begin
		case(op)
			`EXE_NOP:
			case(funct)
				// 閫昏緫鎸囦护
				`EXE_AND, `EXE_OR, `EXE_XOR, `EXE_NOR: main_signal <= 9'b11000_00_00; // R-type
				// 绉讳綅鎸囦护
			    `EXE_SLL, `EXE_SRL, `EXE_SRA, `EXE_SLLV, `EXE_SRLV, `EXE_SRAV: main_signal <= 9'b11000_00_00; // R-type
				//TODO `EXE_MFHI `EXE_MTHI `EXE_MFLO `EXE_MTLO
                // Arithmetic inst
                `EXE_ADD, `EXE_ADDU, `EXE_SUB, `EXE_SUBU, `EXE_SLT, `EXE_SLTU: main_signal <= 9'b11000_00_00; // R-type
                `EXE_MULT, `EXE_MULTU, `EXE_DIV, `EXE_DIVU: main_signal <= 9'b11000_00_11;
                
                `EXE_MFHI: main_signal <= 9'b11000_10_00;//  hi -> gpr
                `EXE_MFLO: main_signal <= 9'b11000_11_00;//  lo -> gpr
                `EXE_MTHI: main_signal <= 9'b00000_00_10;
                `EXE_MTLO: main_signal <= 9'b00000_00_01;
                
                `EXE_SYSCALL,`EXE_BREAK : main_signal <= 9'b00000_00_00;
                

                // j inst
                `EXE_JR:  main_signal <= 9'b00000_00_00;
                `EXE_JALR:main_signal <= 9'b11000_00_00;  // 閫夋嫨rd浣滀负鍐欏瘎瀛樺櫒浣嶇疆

                default:begin
                    main_signal <= 9'b00000_00_00;
                    // invalid = 1;
                end 
			endcase
			// logic inst
            `EXE_ANDI ,`EXE_XORI, `EXE_LUI, `EXE_ORI: main_signal <= 9'b10100_00_00; // Immediate
            
            `EXE_ADDI, `EXE_ADDIU ,`EXE_SLTI, `EXE_SLTIU: main_signal <= 9'b10100_00_00; // Immediate
            
            // branch inst
            `EXE_BEQ, `EXE_BGTZ, `EXE_BLEZ, `EXE_BNE    :main_signal <= 9'b00010_00_00    ;
            
            `EXE_REGIMM_INST: case(rt)
                `EXE_BLTZ   :main_signal <= 9'b00010_00_00      ;
                `EXE_BLTZAL :main_signal <= 9'b10010_00_00      ;
                `EXE_BGEZ   :main_signal <= 9'b00010_00_00      ;
                `EXE_BGEZAL :main_signal <= 9'b10010_00_00      ;
                // default: invalid = 1;
            endcase
            
            // j inst
            `EXE_J  : main_signal <= 9'b0000_00_00;
            `EXE_JAL: main_signal <= 9'b1000_00_00;

            // memory insts
            `EXE_LB : main_signal <= 9'b10101_01_00;
            `EXE_LBU: main_signal <= 9'b10101_01_00;
            `EXE_LH : main_signal <= 9'b10101_01_00;
            `EXE_LHU: main_signal <= 9'b10101_01_00;
            `EXE_LW : main_signal <= 9'b10101_01_00;  // lab4 lw
            `EXE_SB : main_signal <= 9'b00101_01_00;  
            `EXE_SH : main_signal <= 9'b00101_01_00;  
            `EXE_SW : main_signal <= 9'b00101_01_00;  // lab4 sw

            // 鐗规潈鎸囦护
            6'b010000 : case(rs)
                5'b00100:begin  // mtc0
                    // cp0write = 1;
                    main_signal <= 9'b00000_00_00;
                end 
                5'b00000: main_signal <= 9'b10000_00_00; // mtfc0
                5'b10000: main_signal <= 9'b00000_00_00; // eret TODO: 鍙傦拷?锟戒唬鐮佷腑regwrite锟???1锛岃繖閲屼笉锟???1
                default: begin
                    // invalid = 1;
                    main_signal <= 9'b00000_00_00;  // error op
                end 
            endcase

            default:begin
                // invalid = 1;
                main_signal <= 9'b00000_00_00;  // error op
            end 
		endcase
	end
endmodule

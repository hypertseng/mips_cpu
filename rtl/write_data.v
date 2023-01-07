`include "defines.vh"
module write_data(
    input wire [7:0] alucontrolE,
	input wire [31:0] aluoutE,
	input wire [31:0] WriteDataE,
	output reg [3:0] sig_writeE,
	output wire[31:0] WriteDataE_modified,
	output reg sig_enE
    );
    // sig_write信号赋值
    always @ (*) 
	begin
		case (alucontrolE)
			`EXE_LW_OP,`EXE_LB_OP,`EXE_LBU_OP,`EXE_LH_OP,`EXE_LHU_OP:
            // 读指令 写使能赋为0
			begin
                sig_writeE <= 4'b0000;
				sig_enE <= 1;
			end
			`EXE_SW_OP:
            // SW 
			begin 
				case (aluoutE[1:0])
					2'b00: sig_writeE <= 4'b1111;
					default:  // 错误地址
					begin 
						sig_writeE <= 4'b0000;
					end
				endcase
				sig_enE <= 1;
			end

			`EXE_SH_OP:
            // SH
			begin
				case (aluoutE[1:0])
					2'b10: sig_writeE <= 4'b1100;
					2'b00: sig_writeE <= 4'b0011;
					default:// 错误地址
					begin 
						sig_writeE <= 4'b0000;
					end 
				endcase
				sig_enE <= 1;
			end

			`EXE_SB_OP:
            // SB
			begin
				case (aluoutE[1:0])
					2'b11: sig_writeE <= 4'b1000;
					2'b10: sig_writeE <= 4'b0100;
					2'b01: sig_writeE <= 4'b0010;
					2'b00: sig_writeE <= 4'b0001;
				endcase
				sig_enE <= 1;
			end
			// 其他无关指令
			default: 
			begin
				sig_writeE <= 4'b0000;
				sig_enE <= 0;
			end
		endcase
	end

	// 修改后的待写入数据赋值
    assign WriteDataE_modified = (sig_writeE ==  4'b0000 || sig_writeE ==  4'b1111)?WriteDataE: //字操作/无关操作无需处理
                                (sig_writeE ==  4'b1100 || sig_writeE ==  4'b0011)? {2{WriteDataE[15:0]}} : //半字操作，直接复制半字
                                {4{WriteDataE[7:0]}} ;  //字节操作，复制该字节

endmodule
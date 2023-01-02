`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/02 15:45:30
// Design Name: 
// Module Name: branch_judge
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


module branch_judge(
    input wire[7:0]branch_judge_controlE,
    input wire[31:0]srcaE,srcbE,
    output wire branch_takeE     // 是否跳转
    );
    
    assign branch_takeE = (branch_judge_controlE == `EXE_BEQ_OP) ? (srcaE == srcbE):               // == 0
                  (branch_judge_controlE == `EXE_BNE_OP) ? (srcaE != srcbE):                       // != 0
                  (branch_judge_controlE == `EXE_BGTZ_OP) ? ((srcaE[31]==1'b0) && (srcaE!=32'b0)): // > 0 
                  (branch_judge_controlE == `EXE_BLEZ_OP) ? ((srcaE[31]==1'b1) || (srcaE==32'b0)): // <= 0
                  (branch_judge_controlE == `EXE_BLTZ_OP) ? (srcaE[31] == 1'b1):                  // < 0
                  (branch_judge_controlE == `EXE_BGEZ_OP) ? (srcaE[31] == 1'b0):                  // >= 0
                  // 下面两条是特殊指令 无论是否跳转 必须写GHR[31]
                  (branch_judge_controlE == `EXE_BLTZAL_OP) ? (srcaE[31] == 1'b1):                // < 0
                  (branch_judge_controlE == `EXE_BGEZAL_OP) ? (srcaE[31] == 1'b0):                // >= 0
                  (1'b0);
endmodule

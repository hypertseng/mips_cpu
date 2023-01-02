module id_ex (
    input wire clk, rst,
    input wire stallE,
    input wire flushE,
    
    input wire [4:0] branch_judge_controlD,
    output reg [4:0] branch_judge_controlE,
    input wire [31:0] pc_plus4D,
    output reg [31:0] pc_plus4E,
    input wire jump_conflictD,
    output reg jump_conflictE,
    input wire [31:0] pcbranchD,
    output reg [31:0] pcbranchE
    input wire [31:0] srcaD,
    output reg [31:0] srcaE,
    input wire [31:0] srcbD,
    output reg [31:0] srcbE,
    input wire [31:0] signimmD,
    output reg [31:0] signimmE,
    input wire [4:0] rsD,
    output reg [4:0] rsE,
    input wire [4:0] rtD,
    output reg [4:0] rtE,
    input wire [4:0] rdD,
    output reg [4:0] rdE,
    input wire [31:0] hi_oD,
    output reg [31:0] hi_oE,
    input wire [31:0] lo_oD,
    output reg [31:0] lo_oE
    
);
    always @(posedge clk) begin
        if(rst | flushE) begin
            pc_plus4E <= 0;
            branch_judge_controlE <=0;   
            jump_conflictE <=0;   
            pcbranchE <= 0;
            srcaD <= 32'b0;
			srcbD <= 32'b0;
			signimmD <= 32'b0;
			rsD <= 5'b0;
			rtD <= 5'b0;
			rdD <= 5'b0;
			hi_oD <= 32'b0;
			lo_oD <= 32'b0;
        end 
        else if(~stallE) begin      
            pc_plus4E <= pc_plus4D;
            branch_judge_controlE <= branch_judge_controlD;
            jump_conflictE <=jump_conflictD;
            pcbranchE <= pcbranchD;
            srcaD <= srcaE;
			srcbD <= srcbE;
			signimmD <= signimmE;
			rsD <= rsE;
			rtD <= rtE;
			rdD <= rdE;
			hi_oD <= hi_oE;
			lo_oD <= lo_oE;
        end
    end
endmodule
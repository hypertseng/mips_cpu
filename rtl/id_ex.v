module id_ex (
    input wire clk, rst,
    input wire stallE,
    input wire flushE,
    
    input wire [7:0] branch_judge_controlD,
    output reg [7:0] branch_judge_controlE,
    input wire [31:0] pc_plus4D,
    output reg [31:0] pc_plus4E,
    input wire jump_conflictD,
    output reg jump_conflictE,
    input wire [31:0] pcbranchD,
    output reg [31:0] pcbranchE,
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


    input wire [1:0] memtoregD,
    output reg [1:0] memtoregE,
    input wire memwriteD,
    output reg memwriteE,
    input wire alusrcD,
    output reg alusrcE,
    input wire regdstD,
    output reg regdstE,
    input wire regwriteD,
    output reg regwriteE,
    input wire [7:0] alucontrolD,
    output reg [7:0] alucontrolE,
    input wire gprtohiD,
    output reg gprtohiE,
    input wire gprtoloD,
    output reg gprtoloE,
    input wire [31:0] pcD,
	output reg [31:0] pcE
    
);
    always @(posedge clk) begin
        if(rst | flushE) begin
            pc_plus4E <= 0;
            branch_judge_controlE <=0;   
            jump_conflictE <=0;   
            pcbranchE <= 0;
            srcaE <= 32'b0;
			srcbE <= 32'b0;
			signimmE <= 32'b0;
			rsE <= 5'b0;
			rtE <= 5'b0;
			rdE <= 5'b0;
			hi_oE <= 32'b0;
			lo_oE <= 32'b0;
            memtoregE <= 0;
            memwriteE <= 0;
            alusrcE <= 0;
            regdstE <= 0;
            regwriteE <= 0;
            alucontrolE <= 0;
            gprtohiE <= 0;
            gprtoloE <= 0;
            pcE <= 0;
        end 
        else if(~stallE) begin      
            pc_plus4E <= pc_plus4D;
            branch_judge_controlE <= branch_judge_controlD;
            jump_conflictE <=jump_conflictD;
            pcbranchE <= pcbranchD;
            srcaE <= srcaD;
			srcbE <= srcbD;
			signimmE <= signimmD;
			rsE <= rsD;
			rtE <= rtD;
			rdE <= rdD;
			hi_oE <= hi_oD;
			lo_oE <= lo_oD;
            memtoregE <= memtoregD;
            memwriteE <= memwriteD;
            alusrcE <= alusrcD;
            regdstE <= regdstD;
            regwriteE <= regwriteD;
            alucontrolE <= alucontrolD;
            gprtohiE <= gprtohiD;
            gprtoloE <= gprtoloD;
            pcE <= pcD;
        end
    end
endmodule
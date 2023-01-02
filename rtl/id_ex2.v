module id_ex2 (
	input wire clk,rst,flushE,

    input wire [31:0] srcaD,
    output wire [31:0] srcaE,
    input wire [31:0] srcbD,
    output wire [31:0] srcbE,
    input wire [31:0] signimmD,
    output wire [31:0] signimmE,
    input wire [4:0] rsD,
    output wire [4:0] rsE,
    input wire [4:0] rtD,
    output wire [4:0] rtE,
    input wire [4:0] rdD,
    output wire [4:0] rdE,
    input wire [31:0] hi_oD,
    output wire [31:0] hi_oE,
    input wire [31:0] lo_oD,
    output wire [31:0] lo_oE
	
    );

	always @(posedge clk,posedge rst) begin
		if(rst) begin
			srcaD <= 32'b0;
			srcbD <= 32'b0;
			signimmD <= 32'b0;
			rsD <= 5'b0;
			rtD <= 5'b0;
			rdD <= 5'b0;
			hi_oD <= 32'b0;
			lo_oD <= 32'b0;
		end else if (flushE)begin
			srcaD <= 32'b0;
			srcbD <= 32'b0;
			signimmD <= 32'b0;
			rsD <= 5'b0;
			rtD <= 5'b0;
			rdD <= 5'b0;
			hi_oD <= 32'b0;
			lo_oD <= 32'b0;
		end else begin 
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

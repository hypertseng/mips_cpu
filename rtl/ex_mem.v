module ex_mem (
	input wire clk,rst,

	input wire [31:0] aluoutE,
    output reg [31:0] aluoutM,
	input wire [4:0] writeregE,
    output reg [4:0] writeregM,
	input wire [63:0] aluout64E,
    output reg [63:0] aluout64M,
	input wire [31:0] srcaE,
    output reg [31:0] srcaM
	input wire [31:0] hi_oE,
    output reg [31:0] hi_oM
	input wire [31:0] pcbranchE,
    output reg [31:0] pcbranchM
    
    );
	always @(posedge clk,posedge rst) begin
		if(rst) begin
			aluoutM <= 0;
			writeregM <= 0;
			aluout64M <= 0;
			srcaM <= 0;
			hi_oM <= 0;
			pcbranchM <= 0;
		end else begin
			aluoutM <= aluoutE;
			writeregM <= writeregE;
			aluout64M <= aluout64E;
			srcaM <= srcaE;
			hi_oM <= hi_oE;
			pcbranchM <= pcbranchE;
		end
	end
endmodule

module ex_mem (
	input wire clk,rst,

	input wire [31:0] aluoutE,
    output reg [31:0] aluoutM,
	input wire [4:0] writeregE,
    output reg [4:0] writeregM,
	input wire [63:0] aluout64E,
    output reg [63:0] aluout64M,
	input wire [31:0] srcaE,
    output reg [31:0] srcaM,
	input wire [31:0] pcbranchE,
    output reg [31:0] pcbranchM,
    input wire branch_takeE,
    output reg branch_takeM,
    
	input wire [1:0] memtoregE,
    output reg [1:0] memtoregM,
	input wire memwriteE,
    output reg memwriteM,
	input wire regwrite_enE,
    output reg regwrite_enM,
	input wire [7:0] alucontrolE,
    output reg [7:0] alucontrolM,
	input wire gprtohiE,
    output reg gprtohiM,
	input wire gprtoloE,
    output reg gprtoloM,
	input wire [31:0] WriteDataE_modified,
	output reg [31:0] writedataM,
	input wire [31:0] pcE,
	output reg [31:0] pcM
    );
	always @(posedge clk,posedge rst) begin
		if(rst) begin
			aluoutM <= 0;
			writeregM <= 0;
			aluout64M <= 0;
			srcaM <= 0;
			// hi_oM <= 0;
			pcbranchM <= 0;
			branch_takeM <= 0;
			memtoregM <= 0;
			memwriteM <= 0;
			regwrite_enM <= 0;
			alucontrolM <= 0;
			gprtohiM <= 0;
			gprtoloM <= 0;
			writedataM <= 0;
			pcM <= 0;
		end else begin
			aluoutM <= aluoutE;
			writeregM <= writeregE;
			aluout64M <= aluout64E;
			srcaM <= srcaE;
			// hi_oM <= hi_oE;
			pcbranchM <= pcbranchE;
			branch_takeM <= branch_takeE;
			memtoregM <= memtoregE;
			memwriteM <= memwriteE;
			regwrite_enM <= regwrite_enE;
			alucontrolM <= alucontrolE;
			gprtohiM <= gprtohiE;
			gprtoloM <= gprtoloE;
			writedataM <= WriteDataE_modified;
			pcM <= pcE;
		end
	end
endmodule

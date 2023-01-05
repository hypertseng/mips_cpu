module mem_wb (
	input wire clk,rst,
	input wire [31:0] aluoutM,
    output reg [31:0] aluoutW,
	input wire [31:0] readdataM,
    output reg [31:0] readdataW,
	input wire [4:0] writeregM,
    output reg [4:0] writeregW,
	input wire [31:0] hi_oM,
    output reg [31:0] hi_oW,
	input wire [31:0] lo_oM,
    output reg [31:0] lo_oW,
	input wire [31:0] srcaM,
    output reg [31:0] srcaW, 

	input wire [1:0] memtoregM,
    output reg [1:0] memtoregW, 
	input wire regwrite_enM,
    output reg regwrite_enW, 
	input wire [7:0] alucontrolM,
    output reg [7:0] alucontrolW, 
	input wire gprtohiM,
    output reg gprtohiW, 
	input wire gprtoloM,
    output reg gprtoloW,
    input wire [31:0] pcM,
	output reg [31:0] pcW
    );
		always @(posedge clk,posedge rst) begin
		if(rst) begin
			aluoutW <= 0;
			readdataW <= 0;
			writeregW <= 0;
			hi_oW <= 0;
			lo_oW <= 0;
			srcaW <= 0;
			memtoregW <= 0;
			regwrite_enW <= 0;
			alucontrolW <= 0;
			gprtohiW <= 0;
			gprtoloW <= 0;
			pcW <= 0;
			
		end else begin
			aluoutW <= aluoutM;
			readdataW <= readdataM;
			writeregW <= writeregM;
			hi_oW <= hi_oM;
			lo_oW <= lo_oM;
			srcaW <= srcaM;
			memtoregW <= memtoregM;
			regwrite_enW <= regwrite_enM;
			alucontrolW <= alucontrolM;
			gprtohiW <= gprtohiM;
			gprtoloW <= gprtoloM;
			pcW <= pcM;
		end
	end
endmodule

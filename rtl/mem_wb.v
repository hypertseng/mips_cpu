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
    output reg [31:0] srcaW
    );
		always @(posedge clk,posedge rst) begin
		if(rst) begin
			aluoutW <= 0;
			readdataW <= 0;
			writeregW <= 0;
			hi_oW <= 0;
			lo_oW <= 0;
			srcaW <= 0;
			
		end else begin
			aluoutW <= aluoutM;
			readdataW <= readdataM;
			writeregW <= writeregM;
			hi_oW <= hi_oM;
			lo_oW <= lo_oM;
			srcaW <= srcaM;
			
		end
	end
endmodule

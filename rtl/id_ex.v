module id_ex (
    input wire clk, rst,
    input wire stallE,
    input wire flushE,

    input wire [31:0] pc_plus4D,
    
    output reg [31:0] pc_plus4E
    
);
    always @(posedge clk) begin
        if(rst | flushE) begin
            pc_plus4E <= 0;      
        end 
        else if(~stallE) begin      
            pc_plus4E <= pc_plus4D;
        end
    end
endmodule
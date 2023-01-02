module id_ex (
    input wire clk, rst,
    input wire stallE,
    input wire flushE,
    
    input wire[4:0] branch_judge_controlD,
    output reg[4:0] branch_judge_controlE,
    input wire [31:0] pc_plus4D,
    output reg [31:0] pc_plus4E,
    input wire jump_conflictD,
    output reg jump_conflictE,
    input wire[31:0] pcbranchD,
    output reg[31:0] pcbranchE
    
);
    always @(posedge clk) begin
        if(rst | flushE) begin
            pc_plus4E <= 0;
            branch_judge_controlE <=0;   
            jump_conflictE <=0;   
            pcbranchE <= 0;
        end 
        else if(~stallE) begin      
            pc_plus4E <= pc_plus4D;
            branch_judge_controlE <= branch_judge_controlD;
            jump_conflictE <=jump_conflictD;
            pcbranchE <= pcbranchD;
        end
    end
endmodule
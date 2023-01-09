`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/02 16:07:49
// Design Name: 
// Module Name: branch_predict_global
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

module branch_predict_global (
    input wire clk, rst,
    
    input wire flushD,
    input wire stallD,

    input wire [31:0] pcF, pcM,

    input wire branchD,
    input wire branchM,         // M�׶��Ƿ��Ƿ�ָ֧��
    input wire actual_takeM,    // ʵ���Ƿ���ת
    input wire actual_takeE,
    input wire pred_wrong, // Ԥ�����Ƿ���ȷ��memory�׶���Ҫ
    output wire pred_takeD,      // Ԥ���Ƿ���ת
    output wire pred_takeF
);

    // wire pred_takeF;   //Ԥ��
    reg pred_takeF_r; //�ѽ��������??

// �������??
    parameter Strongly_not_taken = 2'b00, Weakly_not_taken = 2'b01, Weakly_taken = 2'b11, Strongly_taken = 2'b10;
    parameter GHR_LENGTH = 8;

    reg [GHR_LENGTH-1:0] GHR_value;
    reg [GHR_LENGTH-1:0] GHR_value_old;

    reg [GHR_LENGTH-1:0] GHR_value_old_D;
    reg [GHR_LENGTH-1:0] GHR_value_old_E;
    reg [GHR_LENGTH-1:0] GHR_value_old_M;

    reg [1:0] PHT [(1<<GHR_LENGTH)-1:0];
    integer i,j;

    wire [(GHR_LENGTH-1):0] PHT_index;

// ---------------------------------------Ԥ���߼���Fetch�׶�---------------------------------------

    assign PHT_index = pcF[9:2] ^ GHR_value; // ʹ��XOR������?


    assign pred_takeF = PHT[PHT_index][1];      // ��ȡָ�׶�Ԥ���Ƿ����ת����������ˮ�ߴ��ݸ�����׶Ρ�

        // --------------------------pipeline------------------------------
            always @(posedge clk) begin
                if(rst | flushD) begin
                    pred_takeF_r <= 0;
                end
                else if(~stallD) begin
                    pred_takeF_r <= pred_takeF;
                end
            end
        // --------------------------pipeline------------------------------

// ---------------------------------------Ԥ���߼�����---------------------------------------

// ---------------------------------------BHT��ʼ���Լ����£�Memory�׶�---------------------------------------
    wire [(GHR_LENGTH-1):0] update_PHT_index;


    always@(posedge clk) begin
        if(rst) begin
            GHR_value <= 0; 
            GHR_value_old <= 0; // Ϊ����fetch�׶εõ�ghr��ֵ
        end
        else if(!stallD & branchD) begin // ����ָ����branch��û�б������Ϳ��Ը���ghrֵ����decode�׶�
            GHR_value_old <= GHR_value;
            GHR_value <= {GHR_value << 1, pred_takeD};
            
        end else if(pred_wrong && branchM) begin // �õ�Ԥ�����������Ԥ���Ǵ���??(memory �׶�)
            GHR_value <= {GHR_value_old <<1, actual_takeM};
            GHR_value_old <= GHR_value;
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            GHR_value_old_D <= 0;
            GHR_value_old_E <= 0;
            GHR_value_old_M <= 0;
        end
        else begin
            GHR_value_old_D <= GHR_value_old;
            GHR_value_old_E <= GHR_value_old_D;
            GHR_value_old_M <= GHR_value_old_E;
        end
    end

// ---------------------------------------BHT��ʼ���Լ����½���

    assign update_PHT_index = GHR_value_old_M ^ pcM[9:2];
// ---------------------------------------PHT��ʼ���Լ�����---------------------------------------
    always @(posedge clk) begin
        if(rst) begin
            //   for(i = 0; i < (1<<GHR_LENGTH); i=i+1) begin
            //       PHT[i] <= Weakly_taken;
            //   end
          PHT[(1<<GHR_LENGTH)-1:0] <= '{default: 2'b11};
        end
        else if(branchM) begin
            case(PHT[update_PHT_index])
                // �˴�Ӧ��������ĸ����߼��Ĵ���??
                Strongly_not_taken: begin
                    if(actual_takeM) begin
                        PHT[update_PHT_index] <= Weakly_not_taken;
                    end

                    else begin
                        PHT[update_PHT_index] <= PHT[update_PHT_index];
                    end
                end

                Weakly_not_taken: begin
                    if(actual_takeM) begin
                        PHT[update_PHT_index] <= Weakly_taken;
                    end

                    else begin
                        PHT[update_PHT_index] <= Strongly_not_taken;
                    end
                end

                Weakly_taken: begin
                    if(actual_takeM) begin
                        PHT[update_PHT_index] <= Strongly_taken;
                    end

                    else begin
                        PHT[update_PHT_index] <= Weakly_not_taken;
                    end
                end

                Strongly_taken: begin
                    if(actual_takeM) begin
                        PHT[update_PHT_index] <= PHT[update_PHT_index];
                    end

                    else begin
                        PHT[update_PHT_index] <= Weakly_taken;
                    end
                end

            endcase 
        end
    end
// ---------------------------------------PHT��ʼ���Լ����½���---------------------------------------

    // ����׶�������յ�Ԥ����
    assign pred_takeD = branchD & pred_takeF_r;  
endmodule
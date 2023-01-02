`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/05 22:35:14
// Design Name: 
// Module Name: divide_v1
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

module div(
    input               clk,
    input               rst,
    input [31:0]        a,
    input [31:0]        b,
    input               start,
    input               sign,
    output wire         stall_div,
    output [63:0]       result
    );

    reg [31:0] a_tmp,b_tmp;
    reg [63:0] SR;              //shift register
    reg [32:0] NEG_DIVISOR;    //���� 2's complement
    wire [31:0] REMAINER, QUOTIENT;
    assign REMAINER = SR[63:32];    //����
    assign QUOTIENT = SR[31: 0];    //��

    wire [31:0] divident_abs;
    wire [32:0] divisor_abs;
    wire [31:0] remainer, quotient;

    assign divident_abs = (sign & a[31]) ? ~a + 1'b1 : a;
    //���������뱻������ͬ
    assign remainer = (sign & a_tmp[31]) ? ~REMAINER + 1'b1 : REMAINER;
    assign quotient = sign & (a_tmp[31] ^ b_tmp[31]) ? ~QUOTIENT + 1'b1 : QUOTIENT;
    assign result = {remainer,quotient};

    wire CO;
    wire [32:0] sub_result;
    wire [32:0] mux_result;
    
    assign {CO,sub_result} = {1'b0,REMAINER} + NEG_DIVISOR;//sub
    assign mux_result = CO ? sub_result : {1'b0,REMAINER};//mux

    //״̬��
    reg [5:0] cnt;
    reg start_cnt;
    always @(posedge clk, posedge rst) begin
        if(rst) begin
            cnt <= 0;
            start_cnt <= 0;
        end
        else if(!start_cnt & start) begin
            cnt <= 1;
            start_cnt <= 1;
            //Register init
            a_tmp<=a;
            b_tmp<=b;
            SR[63:0] <= {31'b0,divident_abs,1'b0}; //����1bit
            NEG_DIVISOR <= (sign & b[31]) ? {1'b1,b} : ~{1'b0,b} + 1'b1; 
        end
        else if(start_cnt) begin
            if(cnt==32) begin
                cnt <= 0;
                start_cnt <= 0;
                //������
                SR[63:32] <= mux_result[31:0];
                SR[31:0] <= {SR[30:0],CO};
            end
            else begin
                cnt <= cnt + 1;
                SR[63:0] <= {mux_result[30:0],SR[31:0],CO}; // д������
            end
        end
    end
    
    assign stall_div = |cnt; //ֻ�е�cnt=0ʱ����ͣ
endmodule
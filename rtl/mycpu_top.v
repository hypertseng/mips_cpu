module mycpu_top(
    input clk,
    input resetn,  //low active

    //cpu inst sram
    output        inst_sram_en   ,
    output [3 :0] inst_sram_wen  ,
    output [31:0] inst_sram_addr ,
    output [31:0] inst_sram_wdata,
    input  [31:0] inst_sram_rdata,
    //cpu data sram
    output        data_sram_en   ,
    output [3 :0] data_sram_wen  ,
    output [31:0] data_sram_addr ,
    output [31:0] data_sram_wdata,
    input  [31:0] data_sram_rdata
);

// 閿燂拷?娑擃亙绶ラ敓锟�?
	wire [31:0] pc;
	wire [31:0] instr;
	wire memwrite;

    // 澧炲姞鍐欎娇鑳戒俊鍙�
    wire [3:0] sig_write;

	wire [31:0] aluout, writedata, readdata;
    datapath datapath(
        .clk(clk),
        .rst(~resetn),
        //instr
        // .inst_en(inst_en),
        .pcF(pc),                    //pcF
        .instrF(instr),              //instrF
        //data
        // .data_en(data_en),
        .memwriteM(memwrite),
        // 澧炲姞鍐欎娇鑳戒俊鍙�
        .sig_write(sig_write),
        .aluoutM(aluout),
        .writedataM(writedata),
        .readdataM(readdata)
    );

    assign inst_sram_en = 1'b1;     //婵″倹鐏夐張濉眓st_en閿涘苯姘ㄩ悽鈺st_en
    assign inst_sram_wen = 4'b0;
    assign inst_sram_addr = pc;
    assign inst_sram_wdata = 32'b0;
    assign instr = inst_sram_rdata;

    assign data_sram_en = 1'b1;     //婵″倹鐏夐張濉猘ta_en閿涘苯姘ㄩ悽鈺燼ta_en
    assign data_sram_wen = {4{memwrite}};
    assign data_sram_addr = aluout;
    assign data_sram_wdata = writedata;
    assign readdata = data_sram_rdata;

    //ascii
    instdec instdec(
        .instr(instr)
    );

endmodule
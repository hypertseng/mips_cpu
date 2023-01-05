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
    input  [31:0] data_sram_rdata,
    
    //debug signals
	output wire [31:0] debug_wb_pc,
	output wire [3 :0] debug_wb_rf_wen,
	output wire [4 :0] debug_wb_rf_wnum,
	output wire [31:0] debug_wb_rf_wdata
);

// 闁跨噦鎷??濞戞搩浜欑欢銉╂晸閿燂拷?
	wire [31:0] pc;
	wire [31:0] instr;
	wire [39:0] ascii;
	wire memwrite;

    // 婢х偛濮為崘娆庡▏閼虫垝淇婇崣锟?
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
        // 婢х偛濮為崘娆庡▏閼虫垝淇婇崣锟?
        .sig_write(sig_write),
        .aluoutM(aluout),
        .writedataM(writedata),
        .readdataM(readdata),

        // stall
        .i_stall(i_stall),
        .d_stall(d_stall),
        .longest_stall(longest_stall),

        .debug_wb_pc       (debug_wb_pc       ),  
        .debug_wb_rf_wen   (debug_wb_rf_wen   ),  
        .debug_wb_rf_wnum  (debug_wb_rf_wnum  ),  
        .debug_wb_rf_wdata (debug_wb_rf_wdata )        
    );

    // //inst sram to sram-like
    // i_sram2sraml i_sram_to_sram_like(
    //     .clk(clk), .rst(rst),
    //     //sram
    //     .inst_sram_en(inst_sram_en),
    //     .inst_sram_addr(inst_sram_addr),
    //     .inst_sram_rdata(inst_sram_rdata),
    //     .i_stall(i_stall),
    //     .longest_stall(longest_stall),

    //     //sram like
    //     .inst_req(inst_req), 
    //     .inst_wr(inst_wr),
    //     .inst_size(inst_size),
    //     .inst_addr(inst_addr),   
    //     .inst_wdata(inst_wdata),
    //     .inst_addr_ok(inst_addr_ok),
    //     .inst_data_ok(inst_data_ok),
    //     .inst_rdata(inst_rdata)
    // );

    // //data sram to sram-like
    // d_sram2sraml d_sram_to_sram_like(
    //     .clk(clk), .rst(rst),
    //     //sram
    //     .data_sram_en(data_sram_en),
    //     .data_sram_addr(data_sram_addr),
    //     .data_sram_rdata(data_sram_rdata),
    //     .data_sram_wen(data_sram_wen),
    //     .data_sram_wdata(data_sram_wdata),
    //     .d_stall(d_stall),
    //     .longest_stall(longest_stall),

    //     //sram like
    //     .data_req(data_req),    
    //     .data_wr(data_wr),
    //     .data_size(data_size),
    //     .data_addr(data_addr),   
    //     .data_wdata(data_wdata),
    //     .data_addr_ok(data_addr_ok),
    //     .data_data_ok(data_data_ok),
    //     .data_rdata(data_rdata)
    // );
    assign inst_sram_en = 1'b1;     //濠碘?冲?归悘澶愬嫉婵夌湏st_en闁挎稑鑻銊╂偨閳侯櫞st_en
    assign inst_sram_wen = 4'b0;
    assign inst_sram_addr = pc;
    assign inst_sram_wdata = 32'b0;
    assign instr = inst_sram_rdata;

    assign data_sram_en = 1'b1;     //濠碘?冲?归悘澶愬嫉婵夌寴ta_en闁挎稑鑻銊╂偨閳虹嚰ta_en
    assign data_sram_wen = sig_write;
    assign data_sram_addr = aluout;
    assign data_sram_wdata = writedata;
    assign readdata = data_sram_rdata;

    //ascii for debug
    instdec instdec(
        .instr(instr),
        .ascii(ascii)
    );

endmodule
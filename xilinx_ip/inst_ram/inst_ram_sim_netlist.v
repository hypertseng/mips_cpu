// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
// Date        : Sun Jan  1 19:06:11 2023
// Host        : LAPTOP-Zeng running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top inst_ram -prefix
//               inst_ram_ inst_ram_sim_netlist.v
// Design      : inst_ram
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tfgg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "inst_ram,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.1" *) 
(* NotValidForBitStream *)
module inst_ram
   (clka,
    rsta,
    ena,
    wea,
    addra,
    dina,
    douta,
    rsta_busy);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA RST" *) input rsta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [3:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [31:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;
  output rsta_busy;

  wire [31:0]addra;
  wire clka;
  wire [31:0]dina;
  wire [31:0]douta;
  wire ena;
  wire rsta;
  wire rsta_busy;
  wire [3:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_doutb_UNCONNECTED;
  wire [31:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "32" *) 
  (* C_ADDRB_WIDTH = "32" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "8" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "1" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "1" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "1" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.96495 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "1" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "inst_ram.mem" *) 
  (* C_INIT_FILE_NAME = "inst_ram.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "1024" *) 
  (* C_READ_DEPTH_B = "1024" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "1" *) 
  (* C_USE_BYTE_WEB = "1" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "4" *) 
  (* C_WEB_WIDTH = "4" *) 
  (* C_WRITE_DEPTH_A = "1024" *) 
  (* C_WRITE_DEPTH_B = "1024" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  inst_ram_blk_mem_gen_v8_4_5 U0
       (.addra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,addra[11:2],1'b0,1'b0}),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[31:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[31:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(rsta),
        .rsta_busy(rsta_busy),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[31:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web({1'b0,1'b0,1'b0,1'b0}));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
RgPKnWr9n0dGgttm3akiFhAlfB96usOQYxnEmPhGyTGg1AbizYAjGPWLXBWl50n/d0IA71ci4aJB
wt6mtfyNADm3ZReK7D3mKu037BOgxryoEwwf1kiC6q/PllxsdAgEMfQrfHJ3E2AzSpdYjoxVYito
y0JW6CUDcWvWa4WV0EA=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
M0l6KpOGH3jL8eRt3NCD7e2USYnkg5H9GAnE1PKmnjiouFN3Y8kjWA2PZDAQLm9UW+TsC1HeVlzO
WjNCHkjR/6ubCsIcWfpPZWdIuAenlsyq8Y9l6b8vMj8JSbDEOiFF/GHSbKsn22MJdDJKEhHFK6GV
s8gR2vywRFwG69gIRE4qGhVB+WIg8GJrDpDMYH6lCjMkTrjXuKDUcNlJN3NPLuhJ7tsditwf1pr5
moJRmGpJnip/rGm0g4o4A6ev4CtePjoao8C1wFtzHkERX9oenhh7cGjDMejU5IrLv8NxFnLj1FpB
9MuF1beTU20NI5oAn6zLiLiOtXjf0ghU3AN4DA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
hAsrUfp6Qgjm8yBjNYTEtQmVQmMxzL8TE/3oiQSxSI3+yEkXAbQCXkT9mo+LCdv+fGECOB0istHd
eLtbsiYbxjxNxYkXiUrRE5O+aSxynIray+uF9DJigTEUZu8JJXUbzxK4DDUu1Lm9tpGps4+Prz1m
0gkj13RT/Y/418s2VTw=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BP/54Wm/GJmb1jy0bxWJJX4aiKyiWPVh4X3VL30BQrmX4PlEsNKzBJH3Qu8IIYERfnFP0ifAgboa
vypMQ5Ed0BrMePGkWIgT6I8hxJCMFpHdkSK7m1giSKyZzFfTOrVqoNFXE+qdzLfY1J5hBWCvouYo
jllavK4N3gF9FLScH2AUWYVMcVth2QPaTAU2NLnAUNH8kgtBjBfc8/KbPPTznD1QNVqvFstzcbTA
hGQ1ETVPvINQ0KqxxAG5PRhtQD4+pC+hr/Tvk+RSvGyBOfy9zE86OXkJiYs9dSFhNiMFmCPL9DBO
se4OxNNC0/7aBtb1mkSEA9YFDYEb9jS7Jasy2A==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
SnzT9DVH3xlEN8nrr2YrlvTO5qj7L22d7WaBcuKyTaiHoIwwFHrC4HQbfs0TAwkdWcOgmJoATPSF
F6qm0KiddbrlERF3MfKUldeGBJtqLdX+zGw7+3JD7S+HB9dIMOFOHy+IiCZp1/Pz8epKpi238cel
rcVoJQKz406wmXDvOo8KsT+XhRLs9BVCrBErPGGXKYDk6NXAp0duOgQE9DbslzMU83M/kUC7uERV
tQW02240peKQFp2elEZC7Tetvgp0TaFTtJiKN45REi8GQUCKGa85JjNIk1qb/+k95TIIP1xrHirc
6iX7qbwnPetv8TVu2NjkZ0WDEK5RXdOXcxBwHA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
erkR82V0jX8ytva+9MzEs0c75Z7j7TsgxWRLNAUfbbU28i+U9YzuZlSfYU75M0f9jx1gvxtBrfKv
cNHVdkR+i5zfHDZsDwfMEEBhs8wzDCKqe+eex6BBEvlIOesCPXrr2RozQgaQ1PBh/os2Arfu+873
BjsVxFJkbhpzIqlddOo/XZV9Yi+eih7A7pXXEBR6IL7Poo4Ka49MiVQU0xJrDTm+ddOuMPDRRD7g
dsxS/uzdcBcO2myV6g/7YH/C2Ce9s6+UywJN/0JeXSqwA7bsBqqnfFicVAT0lckLopMLiuzK7dsN
EwhFeqoetciFrDIj9+o0xDMWBZhgNP1u68vURA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
R+BI65BKLT0I9hEtsxGnDyM5XY9gzULeTPOSDXvd3KWOzZJAx6C0xlbyZcFZhAEG/QIK2yd0wAi6
IUWxyF/sx3HsqKjhVi5KxnpuXDBOZVoj811O7JukedFVmDW7OHGtBkuiJ5X5irw7mfsEKRQmF/1i
V6lj9HYHZEjxtDeZjACsLY4y1QxWalSKT4HIMOHznBLL8dLbGMlS+ZmFuFn0gcwZavVl7gTkTtkf
W0gn01A9ru7NKsf+iLX0kj4dgItPu9N2g02M1vWQ9UUQEVvfV7lUc7GY1suibrD8aEkhH9S7lZ7n
bFsT4qxyvzg8ML6v4g4v7N6VuyhEtgFgNd725Q==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
jNUVKiwH68vHsU54idgvKwaVJcoxTUuxfgrQpbpmM/IpesWA3wHsGzYClwAxkKzw3KRnFyQqTWcZ
yj1EQ2CMBxlJ0kyNbZW8OK8pXzeigToZ0U6Aq3Gy+j7wBbhe83wE1Ygn82sK8dHTEulvaRLn/c5r
ispy1s7jMKIvYNzoUuZrgyBQyfaYmdqUia8XlQjFd+VwzhTXKwzvmaqHWyaHjfBKeCooO7+oUxMG
OJg83W54EVe9ronFQ8Wr9EOL8ia7qelCAgyQe/bC0HHCoMAm8apI7sX23iMR/wMiPP5V2bQzycy+
rBX/+SWkqSeIE1FLm+muFPvrE7iLwJaW8d1fzdFFjAZ5aIXArbWNfwbK8S0TczXc9lEzmpb69rwA
UJIrs4alo81qGQ32UFhjuMQjX75O9Od1HWHDj5PFaT/Ja5Ly+bK8Cc3gfO6dCE81m7d+B2JBZ/Hl
tBA19QuOAYwT2EIPOdpaVtCULb33cWODWu3qQFhZMmDzKTb3kwpcr0LL

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
MnzcA2swaxH1LRacKDou0ZmiiMRETbWIdHgeBgyQz7ILronsXLoB/C20WuFNGEVSiL2/51EZ6MXZ
vMHI8fFcMQCJcuTBDBibUMKv6bXI9s8fTbtrBZppbF/R1icG5JYhqmX4aRnv4W/dxJRjI2L35nLN
Y48E9OfgfkD1sr+IRwx8WEKFmUhuk8dLe0VOK7ywe3XEcneYvrz+HhPj16bGmNfMwNnDgZ3gKKZD
hRnys+jzvAX3HyISrErWXhMKrhWMxXeTNFJCqNQ0LWAVHQYwyKnF5xVpyXSuGNSIrva+QXqOrZBG
3VNLirNVtMRiKLfwZeMaqvswkqBDAa53utlAAA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
d0xXkKtsKM8GvXhDZr16p1+oE3uBtD04BJ76eGGIEj/CFECfHVy9qsJ43oSKjas0+AJr4GFFnVb6
X7gJV6MmX/OboC9ier5joUCGz0mxVzkRZK9a+LPEDcg0K6+cLE36kr+FfxW9Uk2816EHBCMCf5mK
A4eAhSmAb5Nq74F/q0quiG416npbny7faiQ+xmPDfYYiM3UuMKaD4iE8ODlz1w5xThPllWESf3LZ
NTkw6fozyTqZ47vvE21O3dgIGAY1v+C6BwlCK24VwPJa1xs9csY+qTk31j5jjAc1ExlB6QF7t9UH
lk70qdNPWxT87OH7kFT8UvPO1D6BTC3/WkDZfA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
LYhdzKTvo93uJrAaiP5OfCDuOnu2BSvPnxlv6I7h2n1+xHtj34LNNKzWEgOg9dUV9cYDaHYUjjEt
DKdWcz6mZ61d5qyxAhpv67fc90v7JVgtOAcT94/Yb+AuLxXFcGA6Gic7uoJtUgz6JmTnb22Dxdjc
KuIewDj4IOTfP8XGXKTaF+cNp0CFrQgTAcVSQFyLFxr0I/9h3S+GZLecA7ntEeHEOfCJzPvy0ddi
7MCdQWECLb+fXC0IAn8V95TumcpINiRAX1BHi9IGJ4QoMrb3jOCrPkFhDMTJj2aiImUWdi/l/0QE
d7wcXlgIEYVeoKYUOJ4mqy+zZPUbLNeOPADUDQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 32864)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif

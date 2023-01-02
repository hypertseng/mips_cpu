// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
// Date        : Sun Jan  1 19:10:04 2023
// Host        : LAPTOP-Zeng running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top data_ram -prefix
//               data_ram_ data_ram_sim_netlist.v
// Design      : data_ram
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tfgg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "data_ram,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.1" *) 
(* NotValidForBitStream *)
module data_ram
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
  (* C_INIT_FILE = "data_ram.mem" *) 
  (* C_INIT_FILE_NAME = "data_ram.mif" *) 
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
  data_ram_blk_mem_gen_v8_4_5 U0
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

`timescale 1ns/1ps
module e203_pad_top(
    input wire ext_clk_in,      //  clk from crystal, crystal has two pins, 202107 tape-out set to freq 50MHz
    input wire ext_clk_32768K,  //  32.768k from crystal
    //external jtag interface
    input wire ext_jtag_TCK_i_ival, //need to be pulled up
    input wire ext_jtag_TMS_i_ival,
    input wire ext_jtag_TDI_i_ival,

    output wire ext_jtag_TDO_o_oval,//The JTAG TDO is output have enable
    //external gpio interface
    inout wire [31:0] ext_gpio,
    //extern qspi
    output wire ext_qspi_cs,
    output wire ext_qspi_sck,
    inout wire ext_qspi_dq0,
    inout wire ext_qspi_dq1,
    inout wire ext_qspi_dq2,
    inout wire ext_qspi_dq3,

////////////////////////////////////
    // //extern rram spi
    // input wire ext_rram_spi_sck,
    // input wire ext_rram_spi_cs,
    // input wire ext_rram_spi_si,
    // output wire ext_rram_spi_so,
    // //extern rram POR and extclk
    // input wire ext_rram_por,      //  if not used, set 0 
    // input wire ext_rram_en_por,   //
    // input wire ext_rram_extclk,   //
    // inout wire ext_rram_moni1,
//////////////////////////////////

    //system reset signal
    input wire ext_rst_n,
    //pmu signal
    output wire ext_pmu_paden,  //used for debug
    output wire ext_pmu_padrst, 
    input wire ext_mcu_wakeup,//input from ext 
    //boot rom select
    input wire ext_boot_rom_sel,    //if low,start from ITCM; if high, start from flash by qspi
    input wire ext_dbgmode0,        //usually fixed to 1
    input wire ext_dbgmode1,
    input wire ext_dbgmode2 
);

  wire dut_io_pads_jtag_TCK_i_ival;
  wire dut_io_pads_jtag_TMS_i_ival;
  wire dut_io_pads_jtag_TDI_i_ival;
  wire dut_io_pads_jtag_TDO_o_oval;
  wire dut_io_pads_jtag_TDO_o_oe;
  wire dut_io_pads_gpio_0_i_ival;
  wire dut_io_pads_gpio_0_o_oval;
  wire dut_io_pads_gpio_0_o_oe;
  wire dut_io_pads_gpio_0_o_ie;
  wire dut_io_pads_gpio_0_o_pue;
  wire dut_io_pads_gpio_0_o_ds;
  wire dut_io_pads_gpio_1_i_ival;
  wire dut_io_pads_gpio_1_o_oval;
  wire dut_io_pads_gpio_1_o_oe;
  wire dut_io_pads_gpio_1_o_ie;
  wire dut_io_pads_gpio_1_o_pue;
  wire dut_io_pads_gpio_1_o_ds;
  wire dut_io_pads_gpio_2_i_ival;
  wire dut_io_pads_gpio_2_o_oval;
  wire dut_io_pads_gpio_2_o_oe;
  wire dut_io_pads_gpio_2_o_ie;
  wire dut_io_pads_gpio_2_o_pue;
  wire dut_io_pads_gpio_2_o_ds;
  wire dut_io_pads_gpio_3_i_ival;
  wire dut_io_pads_gpio_3_o_oval;
  wire dut_io_pads_gpio_3_o_oe;
  wire dut_io_pads_gpio_3_o_ie;
  wire dut_io_pads_gpio_3_o_pue;
  wire dut_io_pads_gpio_3_o_ds;
  wire dut_io_pads_gpio_4_i_ival;
  wire dut_io_pads_gpio_4_o_oval;
  wire dut_io_pads_gpio_4_o_oe;
  wire dut_io_pads_gpio_4_o_ie;
  wire dut_io_pads_gpio_4_o_pue;
  wire dut_io_pads_gpio_4_o_ds;
  wire dut_io_pads_gpio_5_i_ival;
  wire dut_io_pads_gpio_5_o_oval;
  wire dut_io_pads_gpio_5_o_oe;
  wire dut_io_pads_gpio_5_o_ie;
  wire dut_io_pads_gpio_5_o_pue;
  wire dut_io_pads_gpio_5_o_ds;
  wire dut_io_pads_gpio_6_i_ival;
  wire dut_io_pads_gpio_6_o_oval;
  wire dut_io_pads_gpio_6_o_oe;
  wire dut_io_pads_gpio_6_o_ie;
  wire dut_io_pads_gpio_6_o_pue;
  wire dut_io_pads_gpio_6_o_ds;
  wire dut_io_pads_gpio_7_i_ival;
  wire dut_io_pads_gpio_7_o_oval;
  wire dut_io_pads_gpio_7_o_oe;
  wire dut_io_pads_gpio_7_o_ie;
  wire dut_io_pads_gpio_7_o_pue;
  wire dut_io_pads_gpio_7_o_ds;
  wire dut_io_pads_gpio_8_i_ival;
  wire dut_io_pads_gpio_8_o_oval;
  wire dut_io_pads_gpio_8_o_oe;
  wire dut_io_pads_gpio_8_o_ie;
  wire dut_io_pads_gpio_8_o_pue;
  wire dut_io_pads_gpio_8_o_ds;
  wire dut_io_pads_gpio_9_i_ival;
  wire dut_io_pads_gpio_9_o_oval;
  wire dut_io_pads_gpio_9_o_oe;
  wire dut_io_pads_gpio_9_o_ie;
  wire dut_io_pads_gpio_9_o_pue;
  wire dut_io_pads_gpio_9_o_ds;
  wire dut_io_pads_gpio_10_i_ival;
  wire dut_io_pads_gpio_10_o_oval;
  wire dut_io_pads_gpio_10_o_oe;
  wire dut_io_pads_gpio_10_o_ie;
  wire dut_io_pads_gpio_10_o_pue;
  wire dut_io_pads_gpio_10_o_ds;
  wire dut_io_pads_gpio_11_i_ival;
  wire dut_io_pads_gpio_11_o_oval;
  wire dut_io_pads_gpio_11_o_oe;
  wire dut_io_pads_gpio_11_o_ie;
  wire dut_io_pads_gpio_11_o_pue;
  wire dut_io_pads_gpio_11_o_ds;
  wire dut_io_pads_gpio_12_i_ival;
  wire dut_io_pads_gpio_12_o_oval;
  wire dut_io_pads_gpio_12_o_oe;
  wire dut_io_pads_gpio_12_o_ie;
  wire dut_io_pads_gpio_12_o_pue;
  wire dut_io_pads_gpio_12_o_ds;
  wire dut_io_pads_gpio_13_i_ival;
  wire dut_io_pads_gpio_13_o_oval;
  wire dut_io_pads_gpio_13_o_oe;
  wire dut_io_pads_gpio_13_o_ie;
  wire dut_io_pads_gpio_13_o_pue;
  wire dut_io_pads_gpio_13_o_ds;
  wire dut_io_pads_gpio_14_i_ival;
  wire dut_io_pads_gpio_14_o_oval;
  wire dut_io_pads_gpio_14_o_oe;
  wire dut_io_pads_gpio_14_o_ie;
  wire dut_io_pads_gpio_14_o_pue;
  wire dut_io_pads_gpio_14_o_ds;
  wire dut_io_pads_gpio_15_i_ival;
  wire dut_io_pads_gpio_15_o_oval;
  wire dut_io_pads_gpio_15_o_oe;
  wire dut_io_pads_gpio_15_o_ie;
  wire dut_io_pads_gpio_15_o_pue;
  wire dut_io_pads_gpio_15_o_ds;
  wire dut_io_pads_gpio_16_i_ival;
  wire dut_io_pads_gpio_16_o_oval;
  wire dut_io_pads_gpio_16_o_oe;
  wire dut_io_pads_gpio_16_o_ie;
  wire dut_io_pads_gpio_16_o_pue;
  wire dut_io_pads_gpio_16_o_ds;
  wire dut_io_pads_gpio_17_i_ival;
  wire dut_io_pads_gpio_17_o_oval;
  wire dut_io_pads_gpio_17_o_oe;
  wire dut_io_pads_gpio_17_o_ie;
  wire dut_io_pads_gpio_17_o_pue;
  wire dut_io_pads_gpio_17_o_ds;
  wire dut_io_pads_gpio_18_i_ival;
  wire dut_io_pads_gpio_18_o_oval;
  wire dut_io_pads_gpio_18_o_oe;
  wire dut_io_pads_gpio_18_o_ie;
  wire dut_io_pads_gpio_18_o_pue;
  wire dut_io_pads_gpio_18_o_ds;
  wire dut_io_pads_gpio_19_i_ival;
  wire dut_io_pads_gpio_19_o_oval;
  wire dut_io_pads_gpio_19_o_oe;
  wire dut_io_pads_gpio_19_o_ie;
  wire dut_io_pads_gpio_19_o_pue;
  wire dut_io_pads_gpio_19_o_ds;
  wire dut_io_pads_gpio_20_i_ival;
  wire dut_io_pads_gpio_20_o_oval;
  wire dut_io_pads_gpio_20_o_oe;
  wire dut_io_pads_gpio_20_o_ie;
  wire dut_io_pads_gpio_20_o_pue;
  wire dut_io_pads_gpio_20_o_ds;
  wire dut_io_pads_gpio_21_i_ival;
  wire dut_io_pads_gpio_21_o_oval;
  wire dut_io_pads_gpio_21_o_oe;
  wire dut_io_pads_gpio_21_o_ie;
  wire dut_io_pads_gpio_21_o_pue;
  wire dut_io_pads_gpio_21_o_ds;
  wire dut_io_pads_gpio_22_i_ival;
  wire dut_io_pads_gpio_22_o_oval;
  wire dut_io_pads_gpio_22_o_oe;
  wire dut_io_pads_gpio_22_o_ie;
  wire dut_io_pads_gpio_22_o_pue;
  wire dut_io_pads_gpio_22_o_ds;
  wire dut_io_pads_gpio_23_i_ival;
  wire dut_io_pads_gpio_23_o_oval;
  wire dut_io_pads_gpio_23_o_oe;
  wire dut_io_pads_gpio_23_o_ie;
  wire dut_io_pads_gpio_23_o_pue;
  wire dut_io_pads_gpio_23_o_ds;
  wire dut_io_pads_gpio_24_i_ival;
  wire dut_io_pads_gpio_24_o_oval;
  wire dut_io_pads_gpio_24_o_oe;
  wire dut_io_pads_gpio_24_o_ie;
  wire dut_io_pads_gpio_24_o_pue;
  wire dut_io_pads_gpio_24_o_ds;
  wire dut_io_pads_gpio_25_i_ival;
  wire dut_io_pads_gpio_25_o_oval;
  wire dut_io_pads_gpio_25_o_oe;
  wire dut_io_pads_gpio_25_o_ie;
  wire dut_io_pads_gpio_25_o_pue;
  wire dut_io_pads_gpio_25_o_ds;
  wire dut_io_pads_gpio_26_i_ival;
  wire dut_io_pads_gpio_26_o_oval;
  wire dut_io_pads_gpio_26_o_oe;
  wire dut_io_pads_gpio_26_o_ie;
  wire dut_io_pads_gpio_26_o_pue;
  wire dut_io_pads_gpio_26_o_ds;
  wire dut_io_pads_gpio_27_i_ival;
  wire dut_io_pads_gpio_27_o_oval;
  wire dut_io_pads_gpio_27_o_oe;
  wire dut_io_pads_gpio_27_o_ie;
  wire dut_io_pads_gpio_27_o_pue;
  wire dut_io_pads_gpio_27_o_ds;
  wire dut_io_pads_gpio_28_i_ival;
  wire dut_io_pads_gpio_28_o_oval;
  wire dut_io_pads_gpio_28_o_oe;
  wire dut_io_pads_gpio_28_o_ie;
  wire dut_io_pads_gpio_28_o_pue;
  wire dut_io_pads_gpio_28_o_ds;
  wire dut_io_pads_gpio_29_i_ival;
  wire dut_io_pads_gpio_29_o_oval;
  wire dut_io_pads_gpio_29_o_oe;
  wire dut_io_pads_gpio_29_o_ie;
  wire dut_io_pads_gpio_29_o_pue;
  wire dut_io_pads_gpio_29_o_ds;
  wire dut_io_pads_gpio_30_i_ival;
  wire dut_io_pads_gpio_30_o_oval;
  wire dut_io_pads_gpio_30_o_oe;
  wire dut_io_pads_gpio_30_o_ie;
  wire dut_io_pads_gpio_30_o_pue;
  wire dut_io_pads_gpio_30_o_ds;
  wire dut_io_pads_gpio_31_i_ival;
  wire dut_io_pads_gpio_31_o_oval;
  wire dut_io_pads_gpio_31_o_oe;
  wire dut_io_pads_gpio_31_o_ie;
  wire dut_io_pads_gpio_31_o_pue;
  wire dut_io_pads_gpio_31_o_ds;
  wire dut_io_pads_qspi_sck_o_oval;
  wire dut_io_pads_qspi_dq_0_i_ival;
  wire dut_io_pads_qspi_dq_0_o_oval;
  wire dut_io_pads_qspi_dq_0_o_oe;
  wire dut_io_pads_qspi_dq_0_o_ie;
  wire dut_io_pads_qspi_dq_0_o_pue;
  wire dut_io_pads_qspi_dq_0_o_ds;
  wire dut_io_pads_qspi_dq_1_i_ival;
  wire dut_io_pads_qspi_dq_1_o_oval;
  wire dut_io_pads_qspi_dq_1_o_oe;
  wire dut_io_pads_qspi_dq_1_o_ie;
  wire dut_io_pads_qspi_dq_1_o_pue;
  wire dut_io_pads_qspi_dq_1_o_ds;
  wire dut_io_pads_qspi_dq_2_i_ival;
  wire dut_io_pads_qspi_dq_2_o_oval;
  wire dut_io_pads_qspi_dq_2_o_oe;
  wire dut_io_pads_qspi_dq_2_o_ie;
  wire dut_io_pads_qspi_dq_2_o_pue;
  wire dut_io_pads_qspi_dq_2_o_ds;
  wire dut_io_pads_qspi_dq_3_i_ival;
  wire dut_io_pads_qspi_dq_3_o_oval;
  wire dut_io_pads_qspi_dq_3_o_oe;
  wire dut_io_pads_qspi_dq_3_o_ie;
  wire dut_io_pads_qspi_dq_3_o_pue;
  wire dut_io_pads_qspi_dq_3_o_ds;
  wire dut_io_pads_qspi_cs_0_o_oval;
  wire dut_io_pads_ck_erst_n_i_ival;
  wire dut_io_pads_aon_pmu_dwakeup_n_i_ival;
  wire dut_io_pads_aon_pmu_vddpaden_o_oval;
  wire dut_io_pads_aon_pmu_padrst_o_oval ;
  wire dut_io_pads_bootrom_n_i_ival;
  wire dut_io_pads_dbgmode0_n_i_ival;
  wire dut_io_pads_dbgmode1_n_i_ival;
  wire dut_io_pads_dbgmode2_n_i_ival;
  wire clk_in;
  wire clk_32768K;
  wire clk_in_en;
  wire clk_32768K_en;

  // wire RRAM_SPI_CS  ;
  // wire RRAM_SPI_SCLK;
  // wire RRAM_SPI_SI  ;
  // wire RRAM_SPI_SO  ;

  // wire RRAM_POR   ; 
  // wire RRAM_EN_POR; 
  // wire RRAM_EXTCLK; 
  // wire RRAM_MONI1;

e203_soc_top u_e203_soc_top
  (
    .hfextclk(clk_in),
    .hfxoscen(clk_in_en),

    .lfextclk(clk_32768K), 
    .lfxoscen(clk_32768K_en),

    // .RRAM_SPI_CS         (RRAM_SPI_CS       ),
    // .RRAM_SPI_SCLK       (RRAM_SPI_SCLK     ),
    // .RRAM_SPI_SI         (RRAM_SPI_SI       ),
    // .RRAM_SPI_SO         (RRAM_SPI_SO       ),

    // .RRAM_POR               (RRAM_POR   ), 
	  // .RRAM_EN_POR            (RRAM_EN_POR), 
	  // .RRAM_EXTCLK            (RRAM_EXTCLK), 
    // .RRAM_MONI1             (RRAM_MONI1),

       // Note: this is the real SoC top AON domain slow clock
    .io_pads_jtag_TCK_i_ival(dut_io_pads_jtag_TCK_i_ival),
    .io_pads_jtag_TMS_i_ival(dut_io_pads_jtag_TMS_i_ival),
    .io_pads_jtag_TDI_i_ival(dut_io_pads_jtag_TDI_i_ival),
    .io_pads_jtag_TDO_o_oval(dut_io_pads_jtag_TDO_o_oval),
    .io_pads_jtag_TDO_o_oe(dut_io_pads_jtag_TDO_o_oe),
    .io_pads_gpio_0_i_ival(dut_io_pads_gpio_0_i_ival),
    .io_pads_gpio_0_o_oval(dut_io_pads_gpio_0_o_oval),
    .io_pads_gpio_0_o_oe(dut_io_pads_gpio_0_o_oe),
    .io_pads_gpio_0_o_ie(dut_io_pads_gpio_0_o_ie),
    .io_pads_gpio_0_o_pue(dut_io_pads_gpio_0_o_pue),
    .io_pads_gpio_0_o_ds(dut_io_pads_gpio_0_o_ds),
    .io_pads_gpio_1_i_ival(dut_io_pads_gpio_1_i_ival),
    .io_pads_gpio_1_o_oval(dut_io_pads_gpio_1_o_oval),
    .io_pads_gpio_1_o_oe(dut_io_pads_gpio_1_o_oe),
    .io_pads_gpio_1_o_ie(dut_io_pads_gpio_1_o_ie),
    .io_pads_gpio_1_o_pue(dut_io_pads_gpio_1_o_pue),
    .io_pads_gpio_1_o_ds(dut_io_pads_gpio_1_o_ds),
    .io_pads_gpio_2_i_ival(dut_io_pads_gpio_2_i_ival),
    .io_pads_gpio_2_o_oval(dut_io_pads_gpio_2_o_oval),
    .io_pads_gpio_2_o_oe(dut_io_pads_gpio_2_o_oe),
    .io_pads_gpio_2_o_ie(dut_io_pads_gpio_2_o_ie),
    .io_pads_gpio_2_o_pue(dut_io_pads_gpio_2_o_pue),
    .io_pads_gpio_2_o_ds(dut_io_pads_gpio_2_o_ds),
    .io_pads_gpio_3_i_ival(dut_io_pads_gpio_3_i_ival),
    .io_pads_gpio_3_o_oval(dut_io_pads_gpio_3_o_oval),
    .io_pads_gpio_3_o_oe(dut_io_pads_gpio_3_o_oe),
    .io_pads_gpio_3_o_ie(dut_io_pads_gpio_3_o_ie),
    .io_pads_gpio_3_o_pue(dut_io_pads_gpio_3_o_pue),
    .io_pads_gpio_3_o_ds(dut_io_pads_gpio_3_o_ds),
    .io_pads_gpio_4_i_ival(dut_io_pads_gpio_4_i_ival),
    .io_pads_gpio_4_o_oval(dut_io_pads_gpio_4_o_oval),
    .io_pads_gpio_4_o_oe(dut_io_pads_gpio_4_o_oe),
    .io_pads_gpio_4_o_ie(dut_io_pads_gpio_4_o_ie),
    .io_pads_gpio_4_o_pue(dut_io_pads_gpio_4_o_pue),
    .io_pads_gpio_4_o_ds(dut_io_pads_gpio_4_o_ds),
    .io_pads_gpio_5_i_ival(dut_io_pads_gpio_5_i_ival),
    .io_pads_gpio_5_o_oval(dut_io_pads_gpio_5_o_oval),
    .io_pads_gpio_5_o_oe(dut_io_pads_gpio_5_o_oe),
    .io_pads_gpio_5_o_ie(dut_io_pads_gpio_5_o_ie),
    .io_pads_gpio_5_o_pue(dut_io_pads_gpio_5_o_pue),
    .io_pads_gpio_5_o_ds(dut_io_pads_gpio_5_o_ds),
    .io_pads_gpio_6_i_ival(dut_io_pads_gpio_6_i_ival),
    .io_pads_gpio_6_o_oval(dut_io_pads_gpio_6_o_oval),
    .io_pads_gpio_6_o_oe(dut_io_pads_gpio_6_o_oe),
    .io_pads_gpio_6_o_ie(dut_io_pads_gpio_6_o_ie),
    .io_pads_gpio_6_o_pue(dut_io_pads_gpio_6_o_pue),
    .io_pads_gpio_6_o_ds(dut_io_pads_gpio_6_o_ds),
    .io_pads_gpio_7_i_ival(dut_io_pads_gpio_7_i_ival),
    .io_pads_gpio_7_o_oval(dut_io_pads_gpio_7_o_oval),
    .io_pads_gpio_7_o_oe(dut_io_pads_gpio_7_o_oe),
    .io_pads_gpio_7_o_ie(dut_io_pads_gpio_7_o_ie),
    .io_pads_gpio_7_o_pue(dut_io_pads_gpio_7_o_pue),
    .io_pads_gpio_7_o_ds(dut_io_pads_gpio_7_o_ds),
    .io_pads_gpio_8_i_ival(dut_io_pads_gpio_8_i_ival),
    .io_pads_gpio_8_o_oval(dut_io_pads_gpio_8_o_oval),
    .io_pads_gpio_8_o_oe(dut_io_pads_gpio_8_o_oe),
    .io_pads_gpio_8_o_ie(dut_io_pads_gpio_8_o_ie),
    .io_pads_gpio_8_o_pue(dut_io_pads_gpio_8_o_pue),
    .io_pads_gpio_8_o_ds(dut_io_pads_gpio_8_o_ds),
    .io_pads_gpio_9_i_ival(dut_io_pads_gpio_9_i_ival),
    .io_pads_gpio_9_o_oval(dut_io_pads_gpio_9_o_oval),
    .io_pads_gpio_9_o_oe(dut_io_pads_gpio_9_o_oe),
    .io_pads_gpio_9_o_ie(dut_io_pads_gpio_9_o_ie),
    .io_pads_gpio_9_o_pue(dut_io_pads_gpio_9_o_pue),
    .io_pads_gpio_9_o_ds(dut_io_pads_gpio_9_o_ds),
    .io_pads_gpio_10_i_ival(dut_io_pads_gpio_10_i_ival),
    .io_pads_gpio_10_o_oval(dut_io_pads_gpio_10_o_oval),
    .io_pads_gpio_10_o_oe(dut_io_pads_gpio_10_o_oe),
    .io_pads_gpio_10_o_ie(dut_io_pads_gpio_10_o_ie),
    .io_pads_gpio_10_o_pue(dut_io_pads_gpio_10_o_pue),
    .io_pads_gpio_10_o_ds(dut_io_pads_gpio_10_o_ds),
    .io_pads_gpio_11_i_ival(dut_io_pads_gpio_11_i_ival),
    .io_pads_gpio_11_o_oval(dut_io_pads_gpio_11_o_oval),
    .io_pads_gpio_11_o_oe(dut_io_pads_gpio_11_o_oe),
    .io_pads_gpio_11_o_ie(dut_io_pads_gpio_11_o_ie),
    .io_pads_gpio_11_o_pue(dut_io_pads_gpio_11_o_pue),
    .io_pads_gpio_11_o_ds(dut_io_pads_gpio_11_o_ds),
    .io_pads_gpio_12_i_ival(dut_io_pads_gpio_12_i_ival),
    .io_pads_gpio_12_o_oval(dut_io_pads_gpio_12_o_oval),
    .io_pads_gpio_12_o_oe(dut_io_pads_gpio_12_o_oe),
    .io_pads_gpio_12_o_ie(dut_io_pads_gpio_12_o_ie),
    .io_pads_gpio_12_o_pue(dut_io_pads_gpio_12_o_pue),
    .io_pads_gpio_12_o_ds(dut_io_pads_gpio_12_o_ds),
    .io_pads_gpio_13_i_ival(dut_io_pads_gpio_13_i_ival),
    .io_pads_gpio_13_o_oval(dut_io_pads_gpio_13_o_oval),
    .io_pads_gpio_13_o_oe(dut_io_pads_gpio_13_o_oe),
    .io_pads_gpio_13_o_ie(dut_io_pads_gpio_13_o_ie),
    .io_pads_gpio_13_o_pue(dut_io_pads_gpio_13_o_pue),
    .io_pads_gpio_13_o_ds(dut_io_pads_gpio_13_o_ds),
    .io_pads_gpio_14_i_ival(dut_io_pads_gpio_14_i_ival),
    .io_pads_gpio_14_o_oval(dut_io_pads_gpio_14_o_oval),
    .io_pads_gpio_14_o_oe(dut_io_pads_gpio_14_o_oe),
    .io_pads_gpio_14_o_ie(dut_io_pads_gpio_14_o_ie),
    .io_pads_gpio_14_o_pue(dut_io_pads_gpio_14_o_pue),
    .io_pads_gpio_14_o_ds(dut_io_pads_gpio_14_o_ds),
    .io_pads_gpio_15_i_ival(dut_io_pads_gpio_15_i_ival),
    .io_pads_gpio_15_o_oval(dut_io_pads_gpio_15_o_oval),
    .io_pads_gpio_15_o_oe(dut_io_pads_gpio_15_o_oe),
    .io_pads_gpio_15_o_ie(dut_io_pads_gpio_15_o_ie),
    .io_pads_gpio_15_o_pue(dut_io_pads_gpio_15_o_pue),
    .io_pads_gpio_15_o_ds(dut_io_pads_gpio_15_o_ds),
    .io_pads_gpio_16_i_ival(dut_io_pads_gpio_16_i_ival),
    .io_pads_gpio_16_o_oval(dut_io_pads_gpio_16_o_oval),
    .io_pads_gpio_16_o_oe(dut_io_pads_gpio_16_o_oe),
    .io_pads_gpio_16_o_ie(dut_io_pads_gpio_16_o_ie),
    .io_pads_gpio_16_o_pue(dut_io_pads_gpio_16_o_pue),
    .io_pads_gpio_16_o_ds(dut_io_pads_gpio_16_o_ds),
    .io_pads_gpio_17_i_ival(dut_io_pads_gpio_17_i_ival),
    .io_pads_gpio_17_o_oval(dut_io_pads_gpio_17_o_oval),
    .io_pads_gpio_17_o_oe(dut_io_pads_gpio_17_o_oe),
    .io_pads_gpio_17_o_ie(dut_io_pads_gpio_17_o_ie),
    .io_pads_gpio_17_o_pue(dut_io_pads_gpio_17_o_pue),
    .io_pads_gpio_17_o_ds(dut_io_pads_gpio_17_o_ds),
    .io_pads_gpio_18_i_ival(dut_io_pads_gpio_18_i_ival),
    .io_pads_gpio_18_o_oval(dut_io_pads_gpio_18_o_oval),
    .io_pads_gpio_18_o_oe(dut_io_pads_gpio_18_o_oe),
    .io_pads_gpio_18_o_ie(dut_io_pads_gpio_18_o_ie),
    .io_pads_gpio_18_o_pue(dut_io_pads_gpio_18_o_pue),
    .io_pads_gpio_18_o_ds(dut_io_pads_gpio_18_o_ds),
    .io_pads_gpio_19_i_ival(dut_io_pads_gpio_19_i_ival),
    .io_pads_gpio_19_o_oval(dut_io_pads_gpio_19_o_oval),
    .io_pads_gpio_19_o_oe(dut_io_pads_gpio_19_o_oe),
    .io_pads_gpio_19_o_ie(dut_io_pads_gpio_19_o_ie),
    .io_pads_gpio_19_o_pue(dut_io_pads_gpio_19_o_pue),
    .io_pads_gpio_19_o_ds(dut_io_pads_gpio_19_o_ds),
    .io_pads_gpio_20_i_ival(dut_io_pads_gpio_20_i_ival),
    .io_pads_gpio_20_o_oval(dut_io_pads_gpio_20_o_oval),
    .io_pads_gpio_20_o_oe(dut_io_pads_gpio_20_o_oe),
    .io_pads_gpio_20_o_ie(dut_io_pads_gpio_20_o_ie),
    .io_pads_gpio_20_o_pue(dut_io_pads_gpio_20_o_pue),
    .io_pads_gpio_20_o_ds(dut_io_pads_gpio_20_o_ds),
    .io_pads_gpio_21_i_ival(dut_io_pads_gpio_21_i_ival),
    .io_pads_gpio_21_o_oval(dut_io_pads_gpio_21_o_oval),
    .io_pads_gpio_21_o_oe(dut_io_pads_gpio_21_o_oe),
    .io_pads_gpio_21_o_ie(dut_io_pads_gpio_21_o_ie),
    .io_pads_gpio_21_o_pue(dut_io_pads_gpio_21_o_pue),
    .io_pads_gpio_21_o_ds(dut_io_pads_gpio_21_o_ds),
    .io_pads_gpio_22_i_ival(dut_io_pads_gpio_22_i_ival),
    .io_pads_gpio_22_o_oval(dut_io_pads_gpio_22_o_oval),
    .io_pads_gpio_22_o_oe(dut_io_pads_gpio_22_o_oe),
    .io_pads_gpio_22_o_ie(dut_io_pads_gpio_22_o_ie),
    .io_pads_gpio_22_o_pue(dut_io_pads_gpio_22_o_pue),
    .io_pads_gpio_22_o_ds(dut_io_pads_gpio_22_o_ds),
    .io_pads_gpio_23_i_ival(dut_io_pads_gpio_23_i_ival),
    .io_pads_gpio_23_o_oval(dut_io_pads_gpio_23_o_oval),
    .io_pads_gpio_23_o_oe(dut_io_pads_gpio_23_o_oe),
    .io_pads_gpio_23_o_ie(dut_io_pads_gpio_23_o_ie),
    .io_pads_gpio_23_o_pue(dut_io_pads_gpio_23_o_pue),
    .io_pads_gpio_23_o_ds(dut_io_pads_gpio_23_o_ds),
    .io_pads_gpio_24_i_ival(dut_io_pads_gpio_24_i_ival),
    .io_pads_gpio_24_o_oval(dut_io_pads_gpio_24_o_oval),
    .io_pads_gpio_24_o_oe(dut_io_pads_gpio_24_o_oe),
    .io_pads_gpio_24_o_ie(dut_io_pads_gpio_24_o_ie),
    .io_pads_gpio_24_o_pue(dut_io_pads_gpio_24_o_pue),
    .io_pads_gpio_24_o_ds(dut_io_pads_gpio_24_o_ds),
    .io_pads_gpio_25_i_ival(dut_io_pads_gpio_25_i_ival),
    .io_pads_gpio_25_o_oval(dut_io_pads_gpio_25_o_oval),
    .io_pads_gpio_25_o_oe(dut_io_pads_gpio_25_o_oe),
    .io_pads_gpio_25_o_ie(dut_io_pads_gpio_25_o_ie),
    .io_pads_gpio_25_o_pue(dut_io_pads_gpio_25_o_pue),
    .io_pads_gpio_25_o_ds(dut_io_pads_gpio_25_o_ds),
    .io_pads_gpio_26_i_ival(dut_io_pads_gpio_26_i_ival),
    .io_pads_gpio_26_o_oval(dut_io_pads_gpio_26_o_oval),
    .io_pads_gpio_26_o_oe(dut_io_pads_gpio_26_o_oe),
    .io_pads_gpio_26_o_ie(dut_io_pads_gpio_26_o_ie),
    .io_pads_gpio_26_o_pue(dut_io_pads_gpio_26_o_pue),
    .io_pads_gpio_26_o_ds(dut_io_pads_gpio_26_o_ds),
    .io_pads_gpio_27_i_ival(dut_io_pads_gpio_27_i_ival),
    .io_pads_gpio_27_o_oval(dut_io_pads_gpio_27_o_oval),
    .io_pads_gpio_27_o_oe(dut_io_pads_gpio_27_o_oe),
    .io_pads_gpio_27_o_ie(dut_io_pads_gpio_27_o_ie),
    .io_pads_gpio_27_o_pue(dut_io_pads_gpio_27_o_pue),
    .io_pads_gpio_27_o_ds(dut_io_pads_gpio_27_o_ds),
    .io_pads_gpio_28_i_ival(dut_io_pads_gpio_28_i_ival),
    .io_pads_gpio_28_o_oval(dut_io_pads_gpio_28_o_oval),
    .io_pads_gpio_28_o_oe(dut_io_pads_gpio_28_o_oe),
    .io_pads_gpio_28_o_ie(dut_io_pads_gpio_28_o_ie),
    .io_pads_gpio_28_o_pue(dut_io_pads_gpio_28_o_pue),
    .io_pads_gpio_28_o_ds(dut_io_pads_gpio_28_o_ds),
    .io_pads_gpio_29_i_ival(dut_io_pads_gpio_29_i_ival),
    .io_pads_gpio_29_o_oval(dut_io_pads_gpio_29_o_oval),
    .io_pads_gpio_29_o_oe(dut_io_pads_gpio_29_o_oe),
    .io_pads_gpio_29_o_ie(dut_io_pads_gpio_29_o_ie),
    .io_pads_gpio_29_o_pue(dut_io_pads_gpio_29_o_pue),
    .io_pads_gpio_29_o_ds(dut_io_pads_gpio_29_o_ds),
    .io_pads_gpio_30_i_ival(dut_io_pads_gpio_30_i_ival),
    .io_pads_gpio_30_o_oval(dut_io_pads_gpio_30_o_oval),
    .io_pads_gpio_30_o_oe(dut_io_pads_gpio_30_o_oe),
    .io_pads_gpio_30_o_ie(dut_io_pads_gpio_30_o_ie),
    .io_pads_gpio_30_o_pue(dut_io_pads_gpio_30_o_pue),
    .io_pads_gpio_30_o_ds(dut_io_pads_gpio_30_o_ds),
    .io_pads_gpio_31_i_ival(dut_io_pads_gpio_31_i_ival),
    .io_pads_gpio_31_o_oval(dut_io_pads_gpio_31_o_oval),
    .io_pads_gpio_31_o_oe(dut_io_pads_gpio_31_o_oe),
    .io_pads_gpio_31_o_ie(dut_io_pads_gpio_31_o_ie),
    .io_pads_gpio_31_o_pue(dut_io_pads_gpio_31_o_pue),
    .io_pads_gpio_31_o_ds(dut_io_pads_gpio_31_o_ds),
    .io_pads_qspi_sck_o_oval(dut_io_pads_qspi_sck_o_oval),
    .io_pads_qspi_dq_0_i_ival(dut_io_pads_qspi_dq_0_i_ival),
    .io_pads_qspi_dq_0_o_oval(dut_io_pads_qspi_dq_0_o_oval),
    .io_pads_qspi_dq_0_o_oe(dut_io_pads_qspi_dq_0_o_oe),
    .io_pads_qspi_dq_0_o_ie(dut_io_pads_qspi_dq_0_o_ie),
    .io_pads_qspi_dq_0_o_pue(dut_io_pads_qspi_dq_0_o_pue),
    .io_pads_qspi_dq_0_o_ds(dut_io_pads_qspi_dq_0_o_ds),
    .io_pads_qspi_dq_1_i_ival(dut_io_pads_qspi_dq_1_i_ival),
    .io_pads_qspi_dq_1_o_oval(dut_io_pads_qspi_dq_1_o_oval),
    .io_pads_qspi_dq_1_o_oe(dut_io_pads_qspi_dq_1_o_oe),
    .io_pads_qspi_dq_1_o_ie(dut_io_pads_qspi_dq_1_o_ie),
    .io_pads_qspi_dq_1_o_pue(dut_io_pads_qspi_dq_1_o_pue),
    .io_pads_qspi_dq_1_o_ds(dut_io_pads_qspi_dq_1_o_ds),
    .io_pads_qspi_dq_2_i_ival(dut_io_pads_qspi_dq_2_i_ival),
    .io_pads_qspi_dq_2_o_oval(dut_io_pads_qspi_dq_2_o_oval),
    .io_pads_qspi_dq_2_o_oe(dut_io_pads_qspi_dq_2_o_oe),
    .io_pads_qspi_dq_2_o_ie(dut_io_pads_qspi_dq_2_o_ie),
    .io_pads_qspi_dq_2_o_pue(dut_io_pads_qspi_dq_2_o_pue),
    .io_pads_qspi_dq_2_o_ds(dut_io_pads_qspi_dq_2_o_ds),
    .io_pads_qspi_dq_3_i_ival(dut_io_pads_qspi_dq_3_i_ival),
    .io_pads_qspi_dq_3_o_oval(dut_io_pads_qspi_dq_3_o_oval),
    .io_pads_qspi_dq_3_o_oe(dut_io_pads_qspi_dq_3_o_oe),
    .io_pads_qspi_dq_3_o_ie(dut_io_pads_qspi_dq_3_o_ie),
    .io_pads_qspi_dq_3_o_pue(dut_io_pads_qspi_dq_3_o_pue),
    .io_pads_qspi_dq_3_o_ds(dut_io_pads_qspi_dq_3_o_ds),
    .io_pads_qspi_cs_0_o_oval(dut_io_pads_qspi_cs_0_o_oval),
       // Note: this is the real SoC top level reset signal
    .io_pads_aon_erst_n_i_ival(dut_io_pads_ck_erst_n_i_ival),
    .io_pads_aon_pmu_dwakeup_n_i_ival(dut_io_pads_aon_pmu_dwakeup_n_i_ival),
    .io_pads_aon_pmu_vddpaden_o_oval(dut_io_pads_aon_pmu_vddpaden_o_oval),

    .io_pads_aon_pmu_padrst_o_oval    (dut_io_pads_aon_pmu_padrst_o_oval ),

    .io_pads_bootrom_n_i_ival       (dut_io_pads_bootrom_n_i_ival),

    .io_pads_dbgmode0_n_i_ival       (dut_io_pads_dbgmode0_n_i_ival),
    .io_pads_dbgmode1_n_i_ival       (dut_io_pads_dbgmode1_n_i_ival),
    .io_pads_dbgmode2_n_i_ival       (dut_io_pads_dbgmode2_n_i_ival) 
  );



/************** clk pads instance without enable signal***************/
PBCU8RNC_X hclk_buf(.PAD(ext_clk_in),.IE(1'b1),.OEN(1'b1),.REN(1'b0),.I(),.C(clk_in));	//is input, need to be pull-up
PBCU8RNC_X lclk_buf(.PAD(ext_clk_32768K),.IE(1'b1),.OEN(1'b1),.REN(1'b0),.I(),.C(clk_32768K));


/************** jtag pads instance ***************/
PBCU8RNC_X jtag_tck_buf_i(.PAD(ext_jtag_TCK_i_ival),.IE(1'b1),.OEN(1'b1),.REN(1'b0),.I(),.C(dut_io_pads_jtag_TCK_i_ival));//is input, need to be pull-up
PBCU8RNC_X jtag_tms_buf_i(.PAD(ext_jtag_TMS_i_ival),.IE(1'b1),.OEN(1'b1),.REN(1'b0),.I(),.C(dut_io_pads_jtag_TMS_i_ival));
PBCU8RNC_X jtag_tdi_buf_i(.PAD(ext_jtag_TDI_i_ival),.IE(1'b1),.OEN(1'b1),.REN(1'b0),.I(),.C(dut_io_pads_jtag_TDI_i_ival));


PBCU8RNC_X jtag_tdo_buf_o(.PAD(ext_jtag_TDO_o_oval),.IE(1'b0),.OEN(~dut_io_pads_jtag_TDO_o_oe),.REN(1'b0),.I(dut_io_pads_jtag_TDO_o_oval),.C());//jtag_TDO has enable


/************** system reset pad input***************/
PBCU8RNC_X reset_buf_i(.PAD(ext_rst_n),.IE(1'b1),.OEN(1'b1),.REN(1'b0),.I(),.C(dut_io_pads_ck_erst_n_i_ival));//is input, need to be pull-up


/************** gpio pads instance ***************/ //The GPIO are all bidir pad have enables
PB4SCUD12RNC_X GPIO_buf_0 (.PAD(ext_gpio[0]),.OEN(~dut_io_pads_gpio_0_o_oe),.PU(dut_io_pads_gpio_0_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_0_o_oval),.IE(dut_io_pads_gpio_0_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_0_o_ds),.DS1(dut_io_pads_gpio_0_o_ds),.C(dut_io_pads_gpio_0_i_ival));
PB4SCUD12RNC_X GPIO_buf_1 (.PAD(ext_gpio[1]),.OEN(~dut_io_pads_gpio_1_o_oe),.PU(dut_io_pads_gpio_1_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_1_o_oval),.IE(dut_io_pads_gpio_1_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_1_o_ds),.DS1(dut_io_pads_gpio_1_o_ds),.C(dut_io_pads_gpio_1_i_ival));
PB4SCUD12RNC_X GPIO_buf_2 (.PAD(ext_gpio[2]),.OEN(~dut_io_pads_gpio_2_o_oe),.PU(dut_io_pads_gpio_2_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_2_o_oval),.IE(dut_io_pads_gpio_2_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_2_o_ds),.DS1(dut_io_pads_gpio_2_o_ds),.C(dut_io_pads_gpio_2_i_ival));
PB4SCUD12RNC_X GPIO_buf_3 (.PAD(ext_gpio[3]),.OEN(~dut_io_pads_gpio_3_o_oe),.PU(dut_io_pads_gpio_3_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_3_o_oval),.IE(dut_io_pads_gpio_3_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_3_o_ds),.DS1(dut_io_pads_gpio_3_o_ds),.C(dut_io_pads_gpio_3_i_ival));
PB4SCUD12RNC_X GPIO_buf_4 (.PAD(ext_gpio[4]),.OEN(~dut_io_pads_gpio_4_o_oe),.PU(dut_io_pads_gpio_4_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_4_o_oval),.IE(dut_io_pads_gpio_4_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_4_o_ds),.DS1(dut_io_pads_gpio_4_o_ds),.C(dut_io_pads_gpio_4_i_ival));
PB4SCUD12RNC_X GPIO_buf_5 (.PAD(ext_gpio[5]),.OEN(~dut_io_pads_gpio_5_o_oe),.PU(dut_io_pads_gpio_5_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_5_o_oval),.IE(dut_io_pads_gpio_5_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_5_o_ds),.DS1(dut_io_pads_gpio_5_o_ds),.C(dut_io_pads_gpio_5_i_ival));
PB4SCUD12RNC_X GPIO_buf_6 (.PAD(ext_gpio[6]),.OEN(~dut_io_pads_gpio_6_o_oe),.PU(dut_io_pads_gpio_6_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_6_o_oval),.IE(dut_io_pads_gpio_6_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_6_o_ds),.DS1(dut_io_pads_gpio_6_o_ds),.C(dut_io_pads_gpio_6_i_ival));
PB4SCUD12RNC_X GPIO_buf_7 (.PAD(ext_gpio[7]),.OEN(~dut_io_pads_gpio_7_o_oe),.PU(dut_io_pads_gpio_7_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_7_o_oval),.IE(dut_io_pads_gpio_7_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_7_o_ds),.DS1(dut_io_pads_gpio_7_o_ds),.C(dut_io_pads_gpio_7_i_ival));
PB4SCUD12RNC_X GPIO_buf_8 (.PAD(ext_gpio[8]),.OEN(~dut_io_pads_gpio_8_o_oe),.PU(dut_io_pads_gpio_8_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_8_o_oval),.IE(dut_io_pads_gpio_8_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_8_o_ds),.DS1(dut_io_pads_gpio_8_o_ds),.C(dut_io_pads_gpio_8_i_ival));
PB4SCUD12RNC_X GPIO_buf_9 (.PAD(ext_gpio[9]),.OEN(~dut_io_pads_gpio_9_o_oe),.PU(dut_io_pads_gpio_9_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_9_o_oval),.IE(dut_io_pads_gpio_9_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_9_o_ds),.DS1(dut_io_pads_gpio_9_o_ds),.C(dut_io_pads_gpio_9_i_ival));
PB4SCUD12RNC_X GPIO_buf_10(.PAD(ext_gpio[10]),.OEN(~dut_io_pads_gpio_10_o_oe),.PU(dut_io_pads_gpio_10_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_10_o_oval),.IE(dut_io_pads_gpio_10_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_10_o_ds),.DS1(dut_io_pads_gpio_10_o_ds),.C(dut_io_pads_gpio_10_i_ival));
PB4SCUD12RNC_X GPIO_buf_11(.PAD(ext_gpio[11]),.OEN(~dut_io_pads_gpio_11_o_oe),.PU(dut_io_pads_gpio_11_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_11_o_oval),.IE(dut_io_pads_gpio_11_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_11_o_ds),.DS1(dut_io_pads_gpio_11_o_ds),.C(dut_io_pads_gpio_11_i_ival));
PB4SCUD12RNC_X GPIO_buf_12(.PAD(ext_gpio[12]),.OEN(~dut_io_pads_gpio_12_o_oe),.PU(dut_io_pads_gpio_12_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_12_o_oval),.IE(dut_io_pads_gpio_12_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_12_o_ds),.DS1(dut_io_pads_gpio_12_o_ds),.C(dut_io_pads_gpio_12_i_ival));
PB4SCUD12RNC_X GPIO_buf_13(.PAD(ext_gpio[13]),.OEN(~dut_io_pads_gpio_13_o_oe),.PU(dut_io_pads_gpio_13_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_13_o_oval),.IE(dut_io_pads_gpio_13_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_13_o_ds),.DS1(dut_io_pads_gpio_13_o_ds),.C(dut_io_pads_gpio_13_i_ival));
PB4SCUD12RNC_X GPIO_buf_14(.PAD(ext_gpio[14]),.OEN(~dut_io_pads_gpio_14_o_oe),.PU(dut_io_pads_gpio_14_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_14_o_oval),.IE(dut_io_pads_gpio_14_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_14_o_ds),.DS1(dut_io_pads_gpio_14_o_ds),.C(dut_io_pads_gpio_14_i_ival));
PB4SCUD12RNC_X GPIO_buf_15(.PAD(ext_gpio[15]),.OEN(~dut_io_pads_gpio_15_o_oe),.PU(dut_io_pads_gpio_15_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_15_o_oval),.IE(dut_io_pads_gpio_15_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_15_o_ds),.DS1(dut_io_pads_gpio_15_o_ds),.C(dut_io_pads_gpio_15_i_ival));
PB4SCUD12RNC_X GPIO_buf_16(.PAD(ext_gpio[16]),.OEN(~dut_io_pads_gpio_16_o_oe),.PU(dut_io_pads_gpio_16_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_16_o_oval),.IE(dut_io_pads_gpio_16_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_16_o_ds),.DS1(dut_io_pads_gpio_16_o_ds),.C(dut_io_pads_gpio_16_i_ival));
PB4SCUD12RNC_X GPIO_buf_17(.PAD(ext_gpio[17]),.OEN(~dut_io_pads_gpio_17_o_oe),.PU(dut_io_pads_gpio_17_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_17_o_oval),.IE(dut_io_pads_gpio_17_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_17_o_ds),.DS1(dut_io_pads_gpio_17_o_ds),.C(dut_io_pads_gpio_17_i_ival));
PB4SCUD12RNC_X GPIO_buf_18(.PAD(ext_gpio[18]),.OEN(~dut_io_pads_gpio_18_o_oe),.PU(dut_io_pads_gpio_18_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_18_o_oval),.IE(dut_io_pads_gpio_18_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_18_o_ds),.DS1(dut_io_pads_gpio_18_o_ds),.C(dut_io_pads_gpio_18_i_ival));
PB4SCUD12RNC_X GPIO_buf_19(.PAD(ext_gpio[19]),.OEN(~dut_io_pads_gpio_19_o_oe),.PU(dut_io_pads_gpio_19_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_19_o_oval),.IE(dut_io_pads_gpio_19_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_19_o_ds),.DS1(dut_io_pads_gpio_19_o_ds),.C(dut_io_pads_gpio_19_i_ival));
PB4SCUD12RNC_X GPIO_buf_20(.PAD(ext_gpio[20]),.OEN(~dut_io_pads_gpio_20_o_oe),.PU(dut_io_pads_gpio_20_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_20_o_oval),.IE(dut_io_pads_gpio_20_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_20_o_ds),.DS1(dut_io_pads_gpio_20_o_ds),.C(dut_io_pads_gpio_20_i_ival));
PB4SCUD12RNC_X GPIO_buf_21(.PAD(ext_gpio[21]),.OEN(~dut_io_pads_gpio_21_o_oe),.PU(dut_io_pads_gpio_21_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_21_o_oval),.IE(dut_io_pads_gpio_21_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_21_o_ds),.DS1(dut_io_pads_gpio_21_o_ds),.C(dut_io_pads_gpio_21_i_ival));
PB4SCUD12RNC_X GPIO_buf_22(.PAD(ext_gpio[22]),.OEN(~dut_io_pads_gpio_22_o_oe),.PU(dut_io_pads_gpio_22_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_22_o_oval),.IE(dut_io_pads_gpio_22_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_22_o_ds),.DS1(dut_io_pads_gpio_22_o_ds),.C(dut_io_pads_gpio_22_i_ival));
PB4SCUD12RNC_X GPIO_buf_23(.PAD(ext_gpio[23]),.OEN(~dut_io_pads_gpio_23_o_oe),.PU(dut_io_pads_gpio_23_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_23_o_oval),.IE(dut_io_pads_gpio_23_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_23_o_ds),.DS1(dut_io_pads_gpio_23_o_ds),.C(dut_io_pads_gpio_23_i_ival));
PB4SCUD12RNC_X GPIO_buf_24(.PAD(ext_gpio[24]),.OEN(~dut_io_pads_gpio_24_o_oe),.PU(dut_io_pads_gpio_24_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_24_o_oval),.IE(dut_io_pads_gpio_24_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_24_o_ds),.DS1(dut_io_pads_gpio_24_o_ds),.C(dut_io_pads_gpio_24_i_ival));
PB4SCUD12RNC_X GPIO_buf_25(.PAD(ext_gpio[25]),.OEN(~dut_io_pads_gpio_25_o_oe),.PU(dut_io_pads_gpio_25_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_25_o_oval),.IE(dut_io_pads_gpio_25_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_25_o_ds),.DS1(dut_io_pads_gpio_25_o_ds),.C(dut_io_pads_gpio_25_i_ival));
PB4SCUD12RNC_X GPIO_buf_26(.PAD(ext_gpio[26]),.OEN(~dut_io_pads_gpio_26_o_oe),.PU(dut_io_pads_gpio_26_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_26_o_oval),.IE(dut_io_pads_gpio_26_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_26_o_ds),.DS1(dut_io_pads_gpio_26_o_ds),.C(dut_io_pads_gpio_26_i_ival));
PB4SCUD12RNC_X GPIO_buf_27(.PAD(ext_gpio[27]),.OEN(~dut_io_pads_gpio_27_o_oe),.PU(dut_io_pads_gpio_27_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_27_o_oval),.IE(dut_io_pads_gpio_27_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_27_o_ds),.DS1(dut_io_pads_gpio_27_o_ds),.C(dut_io_pads_gpio_27_i_ival));
PB4SCUD12RNC_X GPIO_buf_28(.PAD(ext_gpio[28]),.OEN(~dut_io_pads_gpio_28_o_oe),.PU(dut_io_pads_gpio_28_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_28_o_oval),.IE(dut_io_pads_gpio_28_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_28_o_ds),.DS1(dut_io_pads_gpio_28_o_ds),.C(dut_io_pads_gpio_28_i_ival));
PB4SCUD12RNC_X GPIO_buf_29(.PAD(ext_gpio[29]),.OEN(~dut_io_pads_gpio_29_o_oe),.PU(dut_io_pads_gpio_29_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_29_o_oval),.IE(dut_io_pads_gpio_29_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_29_o_ds),.DS1(dut_io_pads_gpio_29_o_ds),.C(dut_io_pads_gpio_29_i_ival));
PB4SCUD12RNC_X GPIO_buf_30(.PAD(ext_gpio[30]),.OEN(~dut_io_pads_gpio_30_o_oe),.PU(dut_io_pads_gpio_30_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_30_o_oval),.IE(dut_io_pads_gpio_30_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_30_o_ds),.DS1(dut_io_pads_gpio_30_o_ds),.C(dut_io_pads_gpio_30_i_ival));
PB4SCUD12RNC_X GPIO_buf_31(.PAD(ext_gpio[31]),.OEN(~dut_io_pads_gpio_31_o_oe),.PU(dut_io_pads_gpio_31_o_pue),.PD(1'b0),.I(dut_io_pads_gpio_31_o_oval),.IE(dut_io_pads_gpio_31_o_ie),.ST(1'b0),.DS0(dut_io_pads_gpio_31_o_ds),.DS1(dut_io_pads_gpio_31_o_ds),.C(dut_io_pads_gpio_31_i_ival));


/************** QSPI pads instance ***************/
PBCU8RNC_X qspi_sck_buf_o(.PAD(ext_qspi_sck),.IE(1'b0),.OEN(1'b0),.REN(1'b0),.I(dut_io_pads_qspi_sck_o_oval),.C());//QSPI SCK and CS is output without enable
PBCU8RNC_X qspi_cs_buf_o(.PAD(ext_qspi_cs),.IE(1'b0),.OEN(1'b0),.REN(1'b0),.I(dut_io_pads_qspi_cs_0_o_oval),.C());

PB4SCUD12RNC_X qspi_dq0_buf_io(.PAD(ext_qspi_dq0),.OEN(~dut_io_pads_qspi_dq_0_o_oe),.PU(dut_io_pads_qspi_dq_0_o_pue),.PD(1'b0),.I(dut_io_pads_qspi_dq_0_o_oval),.IE(dut_io_pads_qspi_dq_0_o_ie),.ST(1'b0),.DS0(dut_io_pads_qspi_dq_0_o_ds),.DS1(dut_io_pads_qspi_dq_0_o_ds),.C(dut_io_pads_qspi_dq_0_i_ival));//QSPI DQ is bidir I/O with enable, and need pull-up enable
PB4SCUD12RNC_X qspi_dq1_buf_io(.PAD(ext_qspi_dq1),.OEN(~dut_io_pads_qspi_dq_1_o_oe),.PU(dut_io_pads_qspi_dq_1_o_pue),.PD(1'b0),.I(dut_io_pads_qspi_dq_1_o_oval),.IE(dut_io_pads_qspi_dq_1_o_ie),.ST(1'b0),.DS0(dut_io_pads_qspi_dq_1_o_ds),.DS1(dut_io_pads_qspi_dq_1_o_ds),.C(dut_io_pads_qspi_dq_1_i_ival));
PB4SCUD12RNC_X qspi_dq2_buf_io(.PAD(ext_qspi_dq2),.OEN(~dut_io_pads_qspi_dq_2_o_oe),.PU(dut_io_pads_qspi_dq_2_o_pue),.PD(1'b0),.I(dut_io_pads_qspi_dq_2_o_oval),.IE(dut_io_pads_qspi_dq_2_o_ie),.ST(1'b0),.DS0(dut_io_pads_qspi_dq_2_o_ds),.DS1(dut_io_pads_qspi_dq_2_o_ds),.C(dut_io_pads_qspi_dq_2_i_ival));
PB4SCUD12RNC_X qspi_dq3_buf_io(.PAD(ext_qspi_dq3),.OEN(~dut_io_pads_qspi_dq_3_o_oe),.PU(dut_io_pads_qspi_dq_3_o_pue),.PD(1'b0),.I(dut_io_pads_qspi_dq_3_o_oval),.IE(dut_io_pads_qspi_dq_3_o_ie),.ST(1'b0),.DS0(dut_io_pads_qspi_dq_3_o_ds),.DS1(dut_io_pads_qspi_dq_3_o_ds),.C(dut_io_pads_qspi_dq_3_i_ival));


/************** pmu Indication signal pad ***************/
PBCU8RNC_X pmu_vddpaden_buf_o(.PAD(ext_pmu_paden),.IE(1'b0),.OEN(1'b0),.REN(1'b0),.I(dut_io_pads_aon_pmu_vddpaden_o_oval),.C()); // PMU output is just output without enable
PBCU8RNC_X pmu_padrst_buf_o(.PAD(ext_pmu_padrst),.IE(1'b0),.OEN(1'b0),.REN(1'b0),.I(dut_io_pads_aon_pmu_padrst_o_oval),.C()); 

PBCU8RNC_X pmu_dwakeup_buf_i(.PAD(ext_mcu_wakeup),.IE(1'b1),.OEN(1'b1),.REN(1'b0),.I(),.C(dut_io_pads_aon_pmu_dwakeup_n_i_ival));//dwakeup is input need to be pull-up by default


/************** model select***************/
PBCU8RNC_X bootrom_buf_i(.PAD(ext_boot_rom_sel),.IE(1'b1),.OEN(1'b1),.REN(1'b0),.I(),.C(dut_io_pads_bootrom_n_i_ival));// dbgmode are inputs need to be pull-up by default
PBCU8RNC_X dbgmode0_buf_i(.PAD(ext_dbgmode0),.IE(1'b1),.OEN(1'b1),.REN(1'b0),.I(),.C(dut_io_pads_dbgmode0_n_i_ival));
PBCU8RNC_X dbgmode1_buf_i(.PAD(ext_dbgmode1),.IE(1'b1),.OEN(1'b1),.REN(1'b0),.I(),.C(dut_io_pads_dbgmode1_n_i_ival));
PBCU8RNC_X dbgmode2_buf_i(.PAD(ext_dbgmode2),.IE(1'b1),.OEN(1'b1),.REN(1'b0),.I(),.C(dut_io_pads_dbgmode2_n_i_ival));


// /************** RRAM SPI pads instance ***************/
// PBCU8RNC_X rram_spi_sclk_buf_i(.PAD(ext_rram_spi_sck),.IE(1'b1),.OEN(1'b1),.REN(1'b0),.I(),.C(RRAM_SPI_SCLK));// spi sclk,cs,si are inputs need to be pull-up by default
// PBCU8RNC_X rram_spi_cs_buf_i(.PAD(ext_rram_spi_cs),.IE(1'b1),.OEN(1'b1),.REN(1'b0),.I(),.C(RRAM_SPI_CS));
// PBCU8RNC_X rram_spi_si_buf_i(.PAD(ext_rram_spi_si),.IE(1'b1),.OEN(1'b1),.REN(1'b0),.I(),.C(RRAM_SPI_SI));

// PBCU8RNC_X rram_spi_so_buf_o(.PAD(ext_rram_spi_so),.IE(1'b0),.OEN(1'b0),.REN(1'b0),.I(RRAM_SPI_SO),.C()); // spi so is output without enable


// /************** extern rram POR and extclk pads instance ***************/
// PBCU8RNC_X rram_por_buf_i(.PAD(ext_rram_por),.IE(1'b1),.OEN(1'b1),.REN(1'b0),.I(),.C(RRAM_POR));// rram extclk, por, por_en are inputs need to be pull-up by default
// PBCU8RNC_X rram_en_por_buf_i(.PAD(ext_rram_en_por),.IE(1'b1),.OEN(1'b1),.REN(1'b0),.I(),.C(RRAM_EN_POR));
// PBCU8RNC_X rram_extclk_buf_i(.PAD(ext_rram_extclk),.IE(1'b1),.OEN(1'b1),.REN(1'b0),.I(),.C(RRAM_EXTCLK));
// PANA2APRNC_X rram_moni1_buf_io(.PAD(ext_rram_moni1));   //analog singal


endmodule
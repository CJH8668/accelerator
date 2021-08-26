`timescale 1ns/1ps
`include "e203_defines.v"
// `define CPU_TOP u_e203_pad_top.u_e203_soc_top.u_e203_subsys_top.u_e203_subsys_main.u_e203_cpu_top
// `define EXU_PAD `CPU_TOP.u_e203_cpu.u_e203_core.u_e203_exu
`define FLASH u_spiflash

module tb_top();
reg rst_n;
reg clk_in,clk_32768K;

always #10    clk_in = ~clk_in;                 // 50 MHz
always #15258.789 clk_32768K = ~clk_32768K;     // 32.768 KHz

initial begin
    rst_n = 1; clk_in=1; clk_32768K=1;
    #10 rst_n = 0;
    #4000 rst_n = 1;
end

initial begin
    $vcdpluson;
    $fsdbDumpfile("float.fsdb");
    $fsdbDumpvars(0,tb_top);
    #500_000_000 $finish;
end

initial begin
    $readmemh("../scripts/float.verilog",`FLASH.memory);
    $display("Flash 0x00: %h", `FLASH.memory[32'h0000_0000]);
    $display("Flash 0x01: %h", `FLASH.memory[32'h0000_0001]);
    $display("Flash 0x02: %h", `FLASH.memory[32'h0000_0002]);
    $display("Flash 0x03: %h", `FLASH.memory[32'h0000_0003]);
    $display("Flash 0x04: %h", `FLASH.memory[32'h0000_0004]);
    $display("Flash 0x05: %h", `FLASH.memory[32'h0000_0005]);
    $display("Flash 0x06: %h", `FLASH.memory[32'h0000_0006]);
    $display("Flash 0x07: %h", `FLASH.memory[32'h0000_0007]);
    $display("Flash 0x16: %h", `FLASH.memory[32'h0000_0016]);
    $display("Flash 0x20: %h", `FLASH.memory[32'h0000_0020]);
    // for( integer i = 0; i < 300 ; i = i + 1 )
    //     $display("Flash 0x%h: %h %h %h %h", i + 32'h286, `FLASH.memory[32'h0010_0003+i*4], `FLASH.memory[32'h0010_0002+i*4], `FLASH.memory[32'h0010_0001+i*4], `FLASH.memory[32'h0010_0000+i*4]);
end

// wire [`E203_PC_SIZE-1:0] pc = `EXU_PAD.u_e203_exu_commit.alu_cmt_i_pc;        //pc地址
// wire [`E203_PC_SIZE-1:0] pc_vld = `EXU_PAD.u_e203_exu_commit.alu_cmt_i_valid; //执行有效

wire qspi_cs;
wire qspi_sck;
wire qspi_dq0;
wire qspi_dq1;
wire qspi_dq2;
wire qspi_dq3;

e203_pad_top u_e203_pad_top(
    .ext_clk_in(clk_in),
    .ext_clk_32768K(clk_32768K),
    .ext_rst_n(rst_n),
    .ext_jtag_TCK_i_ival(1'b0),
    .ext_jtag_TMS_i_ival(1'b1),
    .ext_jtag_TDI_i_ival(1'b1),
    .ext_jtag_TDO_o_oval(),
    .ext_gpio(),
    .ext_qspi_cs(qspi_cs),
    .ext_qspi_sck(qspi_sck),
    .ext_qspi_dq0(qspi_dq0),
    .ext_qspi_dq1(qspi_dq1),
    .ext_qspi_dq2(qspi_dq2),
    .ext_qspi_dq3(qspi_dq3),
    .ext_pmu_paden(),
    .ext_pmu_padrst(),
    .ext_mcu_wakeup(1'b1),
    .ext_boot_rom_sel(1'b1),
    .ext_dbgmode0(1'b1),
    .ext_dbgmode1(1'b1),
    .ext_dbgmode2(1'b1) 
);

spiflash u_spiflash(
    .csb(qspi_cs),
    .clk(qspi_sck),
    .io0(qspi_dq0),
    .io1(qspi_dq1),
    .io2(qspi_dq2),
    .io3(qspi_dq3)
);


endmodule

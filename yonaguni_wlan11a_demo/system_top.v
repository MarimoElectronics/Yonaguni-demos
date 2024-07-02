// ***************************************************************************
// ***************************************************************************
// Copyright 2014 - 2017 (c) Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsibilities that he or she has by using this source/core.
//
// This core is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.
//
// Redistribution and use of source or resulting binaries, with or without modification
// of this file, are permitted under one of the following two license terms:
//
//   1. The GNU General Public License version 2 as published by the
//      Free Software Foundation, which can be found in the top level directory
//      of this repository (LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository (LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/master/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module system_top (

  // clock and resets

  // hps-ddr

  output  [ 14:0]       ddr3_a,
  output  [  2:0]       ddr3_ba,
  output                ddr3_reset_n,
  output                ddr3_ck_p,
  output                ddr3_ck_n,
  output                ddr3_cke,
  output                ddr3_cs_n,
  output                ddr3_ras_n,
  output                ddr3_cas_n,
  output                ddr3_we_n,
  inout   [ 31:0]       ddr3_dq,
  inout   [  3:0]       ddr3_dqs_p,
  inout   [  3:0]       ddr3_dqs_n,
  output  [  3:0]       ddr3_dm,
  output                ddr3_odt,
  input                 ddr3_rzq,

  // hps-qspi

  output                qspi_ss0,
  output                qspi_clk,
  inout   [  3:0]       qspi_io,

  // hps-sdio

  output                sdio_clk,
  inout                 sdio_cmd,
  inout   [  3:0]       sdio_d,

  // hps-usb

  input                 usb1_clk,
  output                usb1_stp,
  input                 usb1_dir,
  input                 usb1_nxt,
  inout   [  7:0]       usb1_d,

  // hps-uart

  input                 uart0_rx,
  output                uart0_tx,

  // adau 1761

  output                i2s_mclk,
  output                i2s_bclk,
  output                i2s_lrclk,
  output                i2s_sdata_out,
  input                 i2s_sdata_in,

  // iic interface

  inout                 scl,
  inout                 sda,
  output                ga0,
  output                ga1,

  // spi interface

  output                spi_clk,
  output                spi_dio,
  input                 spi_do,
  output                spi_en,


  input                 dev_clk_out,

  inout                 dgpio_0,
  inout                 dgpio_1,
  inout                 dgpio_2,
  inout                 dgpio_3,
  inout                 dgpio_4,
  inout                 dgpio_5,
  inout                 dgpio_6,
  inout                 dgpio_7,
  inout                 dgpio_8,
  inout                 dgpio_9,
  inout                 dgpio_10,
  inout                 dgpio_11,

  inout                 gp_int,
  inout                 mode,
  inout                 reset_trx,

  // physical interface
  input                 rx1_dclk_in_p,
  output                rx1_enable,
  input                 rx1_idata_in_p,
  input                 rx1_qdata_in_p,
  input                 rx1_strobe_in_p,

  input                 rx2_dclk_in_p,
  output                rx2_enable,
  input                 rx2_idata_in_p,
  input                 rx2_qdata_in_p,
  input                 rx2_strobe_in_p,

  output                tx1_dclk_out_p,
  input                 tx1_dclk_in_p,
  output                tx1_enable,
  output                tx1_idata_out_p,
  output                tx1_qdata_out_p,
  output                tx1_strobe_out_p,

  output                tx2_dclk_out_p,
  input                 tx2_dclk_in_p,
  output                tx2_enable,
  output                tx2_idata_out_p,
  output                tx2_qdata_out_p,
  output                tx2_strobe_out_p,

  input                 vccio_is_25, // Low:VCCIO is 1.8V / High:vccio is 2.5V
  output                vccio_err,
  input   [  3:0]       dip_sw,
  input   [  1:0]       btn_sw,
  output  [  3:0]       led,
  inout   [ 15:0]       gpio_bd
);

  // internal signals
  wire              sys_resetn;

  wire    [7:0]     gpio_bd_i;
  wire    [3:0]     gpio_bd_o;

  wire    [63:0]    gpio_i;
  wire    [63:0]    gpio_o;
  wire              gpio_rx1_enable_in;
  wire              gpio_rx2_enable_in;
  wire              gpio_tx1_enable_in;
  wire              gpio_tx2_enable_in;
  wire              sys_clk;

  wire              i2c0_out_data;
  wire              i2c0_sda;
  wire              i2c0_out_clk;
  wire              i2c0_scl_in_clk;

  reg               r_i2s_mclk;

  wire    [31:0]    wran11a_tx_ctrl;
  wire    [31:0]    wran11a_tx_sts;
  wire              wran11a_tx_on;

  wire    [31:0]    wran11a_rx_ctrl;
  wire    [31:0]    wran11a_rx_sts;
  wire              wran11a_rx_decode_end;

  //audio clock output
  assign i2s_mclk = r_i2s_mclk;

   // i2s MCLK
  always @ (posedge dev_clk_out) begin
    r_i2s_mclk <= ~r_i2s_mclk;
  end

  // defaults
  assign vccio_err = vccio_is_25;   //Turns on the error LED, when VCCIO is 1.8V in LVDS mode.

  // assignments

  assign gpio_i[54:32] = gpio_o[54:32];
  assign gpio_i[55]    = 1'b0;
  assign gpio_i[63:56] = gpio_o[63:56];

  // board stuff (max-v-u21)

  assign gpio_i[31:12] = gpio_o[31:12];
  assign gpio_i[11: 4] = gpio_bd_i;
  assign gpio_i[ 3: 0] = gpio_o[ 3: 0];

  assign gpio_bd_o = gpio_o[3:0];

  // input and output pin assign
  assign gpio_bd_i[5:2] = dip_sw;
  assign gpio_bd_i[1:0] = btn_sw;
  assign led = gpio_bd_o[3:0];
  assign gpio_bd = gpio_o[31:16];

  assign ga0 = 1'b0;
  assign ga1 = 1'b0;

  ALT_IOBUF scl_iobuf (.i(1'b0), .oe(i2c0_out_clk), .o(i2c0_scl_in_clk), .io(scl));
  ALT_IOBUF sda_iobuf (.i(1'b0), .oe(i2c0_out_data), .o(i2c0_sda), .io(sda));

  // platform designer instantiation
  system_bd i_system_bd (
    .clk_50mhz_clk(sys_clk),
    .sys_clk_clk (sys_clk),

    .sys_gpio_bd_in_port (gpio_i[31:0]),
    .sys_gpio_bd_out_port (gpio_o[31:0]),
    .sys_gpio_in_export (gpio_i[63:32]),
    .sys_gpio_out_export (gpio_o[63:32]),

    .sys_hps_memory_mem_a (ddr3_a),
    .sys_hps_memory_mem_ba (ddr3_ba),
    .sys_hps_memory_mem_ck (ddr3_ck_p),
    .sys_hps_memory_mem_ck_n (ddr3_ck_n),
    .sys_hps_memory_mem_cke (ddr3_cke),
    .sys_hps_memory_mem_cs_n (ddr3_cs_n),
    .sys_hps_memory_mem_ras_n (ddr3_ras_n),
    .sys_hps_memory_mem_cas_n (ddr3_cas_n),
    .sys_hps_memory_mem_we_n (ddr3_we_n),
    .sys_hps_memory_mem_reset_n (ddr3_reset_n),
    .sys_hps_memory_mem_dq (ddr3_dq),
    .sys_hps_memory_mem_dqs (ddr3_dqs_p),
    .sys_hps_memory_mem_dqs_n (ddr3_dqs_n),
    .sys_hps_memory_mem_odt (ddr3_odt),
    .sys_hps_memory_mem_dm (ddr3_dm),
    .sys_hps_memory_oct_rzqin (ddr3_rzq),

    .sys_hps_hps_io_hps_io_qspi_inst_IO0 (qspi_io[0]),
    .sys_hps_hps_io_hps_io_qspi_inst_IO1 (qspi_io[1]),
    .sys_hps_hps_io_hps_io_qspi_inst_IO2 (qspi_io[2]),
    .sys_hps_hps_io_hps_io_qspi_inst_IO3 (qspi_io[3]),
    .sys_hps_hps_io_hps_io_qspi_inst_SS0 (qspi_ss0),
    .sys_hps_hps_io_hps_io_qspi_inst_CLK (qspi_clk),
    .sys_hps_hps_io_hps_io_sdio_inst_CMD (sdio_cmd),
    .sys_hps_hps_io_hps_io_sdio_inst_D0 (sdio_d[0]),
    .sys_hps_hps_io_hps_io_sdio_inst_D1 (sdio_d[1]),
    .sys_hps_hps_io_hps_io_sdio_inst_CLK (sdio_clk),
    .sys_hps_hps_io_hps_io_sdio_inst_D2 (sdio_d[2]),
    .sys_hps_hps_io_hps_io_sdio_inst_D3 (sdio_d[3]),
    .sys_hps_hps_io_hps_io_usb1_inst_D0 (usb1_d[0]),
    .sys_hps_hps_io_hps_io_usb1_inst_D1 (usb1_d[1]),
    .sys_hps_hps_io_hps_io_usb1_inst_D2 (usb1_d[2]),
    .sys_hps_hps_io_hps_io_usb1_inst_D3 (usb1_d[3]),
    .sys_hps_hps_io_hps_io_usb1_inst_D4 (usb1_d[4]),
    .sys_hps_hps_io_hps_io_usb1_inst_D5 (usb1_d[5]),
    .sys_hps_hps_io_hps_io_usb1_inst_D6 (usb1_d[6]),
    .sys_hps_hps_io_hps_io_usb1_inst_D7 (usb1_d[7]),
    .sys_hps_hps_io_hps_io_usb1_inst_CLK (usb1_clk),
    .sys_hps_hps_io_hps_io_usb1_inst_STP (usb1_stp),
    .sys_hps_hps_io_hps_io_usb1_inst_DIR (usb1_dir),
    .sys_hps_hps_io_hps_io_usb1_inst_NXT (usb1_nxt),
    .sys_hps_hps_io_hps_io_uart0_inst_RX (uart0_rx),
    .sys_hps_hps_io_hps_io_uart0_inst_TX (uart0_tx),

    .sys_rstn_reset_n (sys_resetn),
    .sys_hps_h2f_reset_reset_n (sys_resetn),

    .adrv9001_if_rx1_dclk_in_p_dclk_in (rx1_dclk_in_p),
    .adrv9001_if_rx1_idata_in_p_idata1 (rx1_idata_in_p),
    .adrv9001_if_rx1_qdata_in_p_qdata3 (rx1_qdata_in_p),
    .adrv9001_if_rx1_strobe_in_p_strobe_in (rx1_strobe_in_p),
    .adrv9001_if_rx2_dclk_in_p_dclk_in (rx2_dclk_in_p),
    .adrv9001_if_rx2_idata_in_p_idata1 (rx2_idata_in_p),
    .adrv9001_if_rx2_qdata_in_p_qdata3 (rx2_qdata_in_p),
    .adrv9001_if_rx2_strobe_in_p_strobe_in (rx2_strobe_in_p),
    .adrv9001_if_tx1_dclk_out_p_dclk_out (tx1_dclk_out_p),
    .adrv9001_if_tx1_dclk_in_p_dclk_in (tx1_dclk_in_p),
    .adrv9001_if_tx1_idata_out_p_idata1 (tx1_idata_out_p),
    .adrv9001_if_tx1_qdata_out_p_qdata3 (tx1_qdata_out_p),
    .adrv9001_if_tx1_strobe_out_p_strobe_out (tx1_strobe_out_p),
    .adrv9001_if_tx2_dclk_out_p_dclk_out (tx2_dclk_out_p),
    .adrv9001_if_tx2_dclk_in_p_dclk_in (tx2_dclk_in_p),
    .adrv9001_if_tx2_idata_out_p_idata1 (tx2_idata_out_p),
    .adrv9001_if_tx2_qdata_out_p_qdata3 (tx2_qdata_out_p),
    .adrv9001_if_tx2_strobe_out_p_strobe_out (tx2_strobe_out_p),

    .adrv9001_if_rx1_enable (rx1_enable),
    .adrv9001_if_rx2_enable (rx2_enable),
    .adrv9001_if_tx1_enable (tx1_enable),
    .adrv9001_if_tx2_enable (tx2_enable),

    .adrv9001_tdd_if_rx1_enable_in (gpio_rx1_enable_in),
    .adrv9001_tdd_if_rx2_enable_in (gpio_rx2_enable_in),
    .adrv9001_tdd_if_tx1_enable_in (gpio_tx1_enable_in),
    .adrv9001_tdd_if_tx2_enable_in (gpio_tx2_enable_in),
    .adrv9001_tdd_if_tdd_sync_in   (1'b0),

    // WLAN11a signals
    // Tx control
    .wlan11a_tx_ctrl_external_connection_export (wran11a_tx_ctrl      ),
    .wlan11a_tx_control_control_in              (wran11a_tx_ctrl      ),
    // Tx status
    .wlan11a_tx_sts_external_connection_export  (wran11a_tx_sts       ),
    .wlan11a_tx_status_status_out               (wran11a_tx_sts       ),
    // Rx control
    .wlan11a_rx_ctrl_external_connection_export (wran11a_rx_ctrl      ),
    .wlan11a_rx_control_control                 (wran11a_rx_ctrl      ),
    // Rx status
    .wlan11a_rx_sts_external_connection_export  (wran11a_rx_sts       ),
    .wlan11a_rx_status_status_out               (wran11a_rx_sts       ),
    // constant input
    .wlan11a_rx_is_sim_is_sim_in      (1'b0),
    .wlan11a_tx_clk_enable_clk_enable (1'b1),
    .wlan11a_rx_clk_enable_clk_enable (1'b1),
    // monitor output
    .wlan11a_tx_monitor_monitor (          ),  // for degug. connect gpio_bd[ 7: 0]
    .wlan11a_rx_monitor_monitor (          ),  // for degug. connect gpio_bd[15: 8]

    .sys_spi_MISO (spi_do),
    .sys_spi_MOSI (spi_dio),
    .sys_spi_SCLK (spi_clk),
    .sys_spi_SS_n (spi_en),

    .sys_hps_i2c0_out_data  (i2c0_out_data),
    .sys_hps_i2c0_sda       (i2c0_sda),
    .sys_hps_i2c0_clk_clk   (i2c0_out_clk),
    .sys_hps_i2c0_scl_in_clk(i2c0_scl_in_clk),

    .i2s_sdata_i  (i2s_sdata_in      ),
    .i2s_sdata_o  (i2s_sdata_out     ),
    .i2s_bclk_o   (i2s_bclk          ),
    .i2s_lrclk_o  (i2s_lrclk         ),
    .i2s_clk_clk  (r_i2s_mclk        ),

    .adrv9001_gpio_export({gpio_tx2_enable_in,
                           gpio_tx1_enable_in,
                           gpio_rx2_enable_in,
                           gpio_rx1_enable_in,
                           reset_trx,
                           mode,
                           gp_int,
                           dgpio_11,
                           dgpio_10,
                           dgpio_9,
                           dgpio_8,
                           dgpio_7,
                           dgpio_6,
                           dgpio_5,
                           dgpio_4,
                           dgpio_3,
                           dgpio_2,
                           dgpio_1,
                           dgpio_0})
  );

endmodule

// ***************************************************************************
// ***************************************************************************

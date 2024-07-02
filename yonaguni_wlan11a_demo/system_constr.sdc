
create_clock -period {20.000 ns} -name sys_clk  [get_ports {sys_clk}]
create_clock -period 20.833 -name usb1_clk [get_ports {usb1_clk}]
create_clock -period 81.380 -name dev_clk_out [get_ports {dev_clk_out}]
# for WLAN11a demo design, LSSI Interface clock is 640MHz
#create_clock -period  2.702 -name rx1_dclk_in_p [get_ports {rx1_dclk_in_p}]
#create_clock -period  2.702 -name rx2_dclk_in_p [get_ports {rx2_dclk_in_p}]
create_clock -period  3.125 -name rx1_dclk_in_p [get_ports {rx1_dclk_in_p}]
create_clock -period  3.125 -name rx2_dclk_in_p [get_ports {rx2_dclk_in_p}]
# create_clock -period  2.702 -name tx1_dclk_in_p [get_ports {tx1_dclk_in_p}]
# create_clock -period  2.702 -name tx2_dclk_in_p [get_ports {tx2_dclk_in_p}]

derive_pll_clocks
derive_clock_uncertainty

set_false_path -from [get_registers *altera_reset_synchronizer:alt_rst_sync_uq1|altera_reset_synchronizer_int_chain_out*]

## -----------------------------------------------------------------------------
## set_input_delay setting of ADRV 9002 LSSI             |  min(ns)  |  max(ns)
## -----------------------------------------------------------------------------
## Tdelay of ADRV9002                                    |  0.0      |  0.2
## -----------------------------------------------------------------------------

## -----------------------------------------------------------------------------
## set_output_delay setting of ADRV9002 LSSI             |  min(ns)  |  max(ns)
## -----------------------------------------------------------------------------
## Tsetup of ADRV9002                                    |  0.0      |  0.2
## Thold  of ADRV9002                                    |  0.0      |  0.3
## -----------------------------------------------------------------------------
# Note: The setup/hold time between the clock and the data is adjusted using the
# programmable delay of the ADRV9002.
# ADRV9001 SSI has configurable delay cells on LVDS/CMOS in and out circuits which
# can allow users to small adjust the phase relationship between strobe/data and clock,
# the adjustable phase delay cell is approximate 90 ps per step for LVD mode and 170 ps
# per step for CMOS mode, the maximum adjustable step is 7.
#
# Note: The SSI rate is limited to a maximum of 740 Mbps on Yonaguni. This limitation is
# the maximum operating frequency of the Cyclone V SoC.

## -----------------------------------------------------------------------------
## set_false_path
## -----------------------------------------------------------------------------
set_false_path -from {*up_adc_common:core_enabled.i_up_adc_common|up_adc_r1_mode*}
set_false_path -from {*up_dac_common:core_enabled.i_up_dac_common|up_dac_r1_mode*}
# for WLAN11a demo design
set_false_path -from {*wlan11a_rx_ctrl|data_out*}
set_false_path -from {*wlan11a_tx_ctrl|data_out*}
set_false_path -to {*wlan11a_rx_sts|readdata*}
set_false_path -to {*wlan11a_tx_sts|readdata*}

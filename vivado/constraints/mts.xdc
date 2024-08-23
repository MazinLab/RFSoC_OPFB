# Constrain MTS Clock Pins
set_property PACKAGE_PIN AP18 [get_ports {PL_SYSREF_clk_p[0]}]
set_property PACKAGE_PIN AN11 [get_ports {PL_CLK_clk_p[0]}]

set_property IOSTANDARD LVDS [get_ports {PL_CLK_clk_p[0]}]
set_property IOSTANDARD LVDS [get_ports {PL_CLK_clk_n[0]}]
set_property IOSTANDARD LVDS [get_ports {PL_SYSREF_clk_p[0]}]
set_property IOSTANDARD LVDS [get_ports {PL_SYSREF_clk_n[0]}]

set_property PACKAGE_PIN AH13 [get_ports {pps_trig}]
set_property IOSTANDARD LVCMOS18 [get_ports {pps_trig}]

set_property PACKAGE_PIN AJ13 [get_ports {pps_comp}]
set_property IOSTANDARD LVCMOS18 [get_ports {pps_comp}]

# Constrain PL SYSREF and Refclks
create_clock -period 1.953125 -name PL_CLK_clk [get_ports PL_CLK_clk_p]

set_input_delay -clock [get_clocks PL_CLK_clk] -min -add_delay 2.000 [get_ports PL_SYSREF_clk_p]
set_input_delay -clock [get_clocks PL_CLK_clk] -max -add_delay 2.031 [get_ports PL_SYSREF_clk_p]

set_max_delay -from [get_pins {gen3_top_i/Clocktree/SynchronizeSYSREF/inst/xsingle/syncstages_ff_reg[1]/C}] 1.0
set_max_delay -from [get_pins {gen3_top_i/Clocktree/SynchronizeSYSREF/inst/xsingle/src_ff_reg/C}] 1.0
set_max_delay -from [get_ports {pps_trig}] 1.0
set_max_delay -from [get_ports {pps_comp}] 1.0

set_property CLOCK_DEDICATED_ROUTE ANY_CMT_COLUMN [get_nets {gen3_top_i/Clocktree/BUFG_PL_CLK/BUFG_O[0]}]


# Synthesis Guidance
#set_property BLOCK_SYNTH.RETIMING 1 [get_cells gen3_top_i/capture/ddr4_0/*]
#set_property BLOCK_SYNTH.STRATEGY {PERFORMANCE_OPTIMIZED} [get_cells gen3_top_i/capture/ddr4_0/*]

#set_property BLOCK_SYNTH.RETIMING 1 [get_cells {gen3_top_i/rfdc/usp_rf_data_converter_0/*}]
#set_property BLOCK_SYNTH.STRATEGY {PERFORMANCE_OPTIMIZED} [get_cells {gen3_top_i/rfdc/usp_rf_data_converter_0/*}]

#set_property BLOCK_SYNTH.RETIMING 1 [get_cells {gen3_top_i/DACCDC*/axis_dwidth_converter_0/*}]
#set_property BLOCK_SYNTH.STRATEGY {PERFORMANCE_OPTIMIZED} [get_cells {gen3_top_i/DACCDC*/axis_dwidth_converter_0/*}]

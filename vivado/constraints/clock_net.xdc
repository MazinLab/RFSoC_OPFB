# Promote Clock Nets to Global Clock Buffers
#set_property CLOCK_BUFFER_TYPE BUFG [get_nets {gen3_top_i/Clocktree/AXI_100_RESET/interconnect_aresetn[0]}]
#set_property CLOCK_BUFFER_TYPE BUFG [get_nets {gen3_top_i/Clocktree/PL_RF_256_Reset/interconnect_aresetn[0]}]
#set_property CLOCK_BUFFER_TYPE BUFG [get_nets {gen3_top_i/Clocktree/PL_RF_512_Reset/interconnect_aresetn[0]}]
#set_property CLOCK_BUFFER_TYPE BUFG [get_nets {gen3_top_i/photon_pipe/opfb/adc_to_opfb_0/inst/process_lanes_U0/regslice_both_lanes_V_data_V_U/even_delay_Array_ce0}]
#set_property CLOCK_BUFFER_TYPE BUFG [get_nets {gen3_top_i/photon_pipe/opfb/adc_to_opfb_0/inst/process_lanes_U0/regslice_both_lanes_V_data_V_U/odd_delay_Array_ce0}]
#set_property CLOCK_BUFFER_TYPE BUFG [get_nets {gen3_top_i/photon_pipe/reschan/dds_ddc_center/inst/grp_phase_sincos_LUT_*/accumulator_TVALID_0}]

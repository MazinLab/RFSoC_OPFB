# Set False Paths
set_false_path -from [get_pins {gen3_top_i/Clocktree/AXI_100_RESET/U0/BSR_OUT_DFF[*].*/C}]

set_false_path -from [get_ports {pps_trig}]
set_false_path -from [get_ports {pps_comp}]


#set_false_path -from [get_pins {gen3_top_i/Clocktree/PL_RF_512_Reset/U0/*BSR_OUT_DFF[*].*/C}] -to [get_pins -of_objects [get_cells -hier -regexp .*dactable.*] -leaf -filter {REF_PIN_NAME=~R}]
#set_false_path -from [get_pins {gen3_top_i/Clocktree/PL_RF_512_Reset/U0/*BSR_OUT_DFF[*].*/C}] -to [get_pins -of_objects [get_cells -hier -regexp .*trigger_system.*] -leaf -filter {REF_PIN_NAME=~R}]
#set_false_path -from [get_pins {gen3_top_i/Clocktree/PL_RF_512_Reset/U0/*BSR_OUT_DFF[*].*/C}] -to [get_pins -of_objects [get_cells -hier -regexp .*photon_pipe.*] -leaf -filter {REF_PIN_NAME=~R}]
#set_false_path -from [get_pins {gen3_top_i/Clocktree/PL_RF_512_Reset/U0/*BSR_OUT_DFF[*].*/C}] -to [get_pins -of_objects [get_cells -hier -regexp .*pps_synchronizer_con.*] -leaf -filter {REF_PIN_NAME=~R}]

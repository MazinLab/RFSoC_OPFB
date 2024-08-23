# Placement Guidance
#create_pblock daccdc_spineleft
#resize_pblock [get_pblocks daccdc_spineleft] -add {CLOCKREGION_X2Y4:CLOCKREGION_X3Y5}
#add_cells_to_pblock [get_pblocks daccdc_spineleft] [get_cells -quiet [list gen3_top_i/DACCDC0/axis_clock_converter_0 gen3_top_i/DACCDC1/axis_clock_converter_0]]

#create_pblock daccdc_spineright
#resize_pblock [get_pblocks daccdc_spineright] -add {CLOCKREGION_X4Y4:CLOCKREGION_X5Y5}
#add_cells_to_pblock [get_pblocks daccdc_spineright] [get_cells -quiet [list gen3_top_i/DACCDC0/axis_dwidth_converter_0 gen3_top_i/DACCDC1/axis_dwidth_converter_0]]

#create_pblock ddr4_pblock
#add_cells_to_pblock [get_pblocks ddr4_pblock] [get_cells -quiet [list gen3_top_i/capture/ddr4_0]]
#resize_pblock [get_pblocks ddr4_pblock] -add {SLICE_X86Y240:SLICE_X89Y359 SLICE_X38Y180:SLICE_X85Y359}
#resize_pblock [get_pblocks ddr4_pblock] -add {DSP48E2_X16Y96:DSP48E2_X17Y143 DSP48E2_X6Y72:DSP48E2_X15Y143}
#resize_pblock [get_pblocks ddr4_pblock] -add {RAMB18_X4Y72:RAMB18_X8Y143}
#resize_pblock [get_pblocks ddr4_pblock] -add {RAMB36_X4Y36:RAMB36_X8Y71}
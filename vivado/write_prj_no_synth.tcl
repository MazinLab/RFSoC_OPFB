 # Vivado 2021.2

# OPFB Project

set prj_dir "."
set iprepo_dir $prj_dir/../ip

set prj_name "opfb_dma_test"
set bd_name "OPFB_DMA_Test"

# create project
create_project $prj_name $prj_dir/$prj_name -part xczu28dr-ffvg1517-2-e

# Set project properties
set obj [current_project]
set_property -name "board_part" -value "xilinx.com:zcu111:part0:1.2" -objects $obj

# Set IP repository path
set_property ip_repo_paths $iprepo_dir [current_project]
set_property target_language Verilog [current_project]
update_ip_catalog

source $prj_dir/../bd/$bd_name.tcl
make_wrapper -files [get_files $prj_dir/$prj_name/$prj_name.srcs/sources_1/bd/$bd_name/$bd_name.bd] -top
add_files -norecurse $prj_dir/$prj_name/$prj_name.srcs/sources_1/bd/$bd_name/hdl/${bd_name}_wrapper.v
update_compile_order -fileset sources_1

# Change Synth and Imp Settings to improve timing performance
set_property strategy Flow_PerfOptimized_high [get_runs synth_1]
set_property STEPS.SYNTH_DESIGN.ARGS.RETIMING true [get_runs synth_1]
set_property strategy Performance_ExtraTimingOpt [get_runs impl_1]
set_property STEPS.PHYS_OPT_DESIGN.ARGS.DIRECTIVE AggressiveExplore [get_runs impl_1]
set_property STEPS.POST_ROUTE_PHYS_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]
set_property STEPS.POST_ROUTE_PHYS_OPT_DESIGN.ARGS.DIRECTIVE AggressiveExplore [get_runs impl_1]

#launch_runs impl_1 -jobs 4 -to_step write_bitstream
#wait_on_run impl_1

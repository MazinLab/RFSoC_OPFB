 # Vivado 2021.2

# OPFB Project

set prj_dir "."
set ip_repo $prj_dir/../ip

set prj_name "opfb_streaming_test"
set bd_name "opfb_streaming"

# create project
create_project $prj_name $prj_dir/$prj_name -part xczu28dr-ffvg1517-2-e

# Set project properties
set obj [current_project]
set_property -name "board_part" -value "xilinx.com:zcu111:part0:1.2" -objects $obj

# Set IP repository paths
set obj [get_filesets sources_1]
set_property "ip_repo_paths" "[file normalize "${ip_repo}"]" $obj

# Rebuild user ip_repo's index before adding any source files
update_ip_catalog -rebuild

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
 set files [list \
  [file normalize "${ip_repo}/wb2axip/rtl/sfifo.v"] \
  [file normalize "${ip_repo}/wb2axip/rtl/axis2mm.v"] \
  [file normalize "${ip_repo}/wb2axip/rtl/skidbuffer.v"] \
    ]
add_files -norecurse -fileset $obj $files


source $prj_dir/../bd/$bd_name.tcl

# Generate HDL Wrapper
make_wrapper -files [get_files ${prj_dir}/${prj_name}/${prj_name}.srcs/sources_1/bd/${bd_name}/${bd_name}.bd] -top
add_files -norecurse ${prj_dir}/${prj_name}/${prj_name}.srcs/sources_1/bd/${bd_name}/hdl/${bd_name}_wrapper.v
update_compile_order -fileset sources_1

set_property top ${bd_name}_wrapper [current_fileset]
update_compile_order -fileset sources_1

# Change Synth and Imp Settings for phys-opt (helps axigmem in capture)
set_property strategy Flow_PerfOptimized_high [get_runs synth_1]
set_property STEPS.SYNTH_DESIGN.ARGS.RETIMING true [get_runs synth_1]
set_property strategy Performance_ExtraTimingOpt [get_runs impl_1]
set_property STEPS.PHYS_OPT_DESIGN.ARGS.DIRECTIVE AggressiveExplore [get_runs impl_1]
set_property STEPS.POST_ROUTE_PHYS_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]
set_property STEPS.POST_ROUTE_PHYS_OPT_DESIGN.ARGS.DIRECTIVE AggressiveExplore [get_runs impl_1]


#Uncomment below to run through bitstream generation
#update_compile_order -fileset sources_1
#launch_runs impl_1 -to_step write_bitstream -jobs 4
#wait_on_run impl_1
                             

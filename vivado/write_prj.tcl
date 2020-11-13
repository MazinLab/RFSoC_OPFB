 # Vivado 2019.2

# OPFB Project

set prj_dir "."
set iprepo_dir $prj_dir/../ip

set prj_name "opfb_timing_opt"
set bd_name "OPFB_TimingOpt"

create_project $prj_name $prj_dir/$prj_name -part xczu28dr-ffvg1517-2-e
set_property board_part xilinx.com:zcu111:part0:1.1 [current_project]
set_property ip_repo_paths $iprepo_dir [current_project]
set_property target_language Verilog [current_project]
update_ip_catalog

source $prj_dir/../bd/$bd_name.tcl
make_wrapper -files [get_files $prj_dir/$prj_name/$prj_name.srcs/sources_1/bd/$bd_name/$bd_name.bd] -top
add_files -norecurse $prj_dir/$prj_name/$prj_name.srcs/sources_1/bd/$bd_name/hdl/${bd_name}_wrapper.v
update_compile_order -fileset sources_1

launch_runs impl_1 -jobs 2 -to_step write_bitstream
wait_on_run impl_1

#file mkdir $prj_dir/overlay
#file copy -force $prj_dir/$prj_name/$prj_name.runs/impl_1/${bd_name}_wrapper.bit $prj_dir/overlay/rfdc_snapshot.bit
#file copy -force $prj_dir/$prj_name/$prj_name.srcs/sources_1/bd/$bd_name/hw_handoff/$bd_name.hwh $prj_dir/overlay/rfdc_snapshot.hwh

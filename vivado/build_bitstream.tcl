set design_name [lindex $argv 0]

# Open project
open_project ./${design_name}_prj/${design_name}_prj.xpr
open_bd_design ./${design_name}_prj/${design_name}_prj.srcs/sources_1/bd/${design_name}/${design_name}.bd

# Call implement
launch_runs impl_1 -to_step write_bitstream -jobs 32
wait_on_run impl_1

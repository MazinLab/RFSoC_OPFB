# Makefile

vivado_dir := vivado

all: vivado_prj

vivado_prj:
	cd $(vivado_dir); vivado -mode batch -nojournal -nolog -source write_prj.tcl

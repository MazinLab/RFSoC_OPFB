# Makefile

vivado_dir := vivado

all: board_files vivado_prj build_bitstream

board_files:
	wget "https://www.realdigital.org/downloads/9d2af32116d5420d25da904f6a06bb1f.zip" --no-check-certificate -O bf.zip && \
	unzip bf.zip -d board_files && rm bf.zip

vivado_prj:
	cd $(vivado_dir); vivado -mode batch -nojournal -nolog -source write_prj.tcl

build_bitstream:
	cd $(vivdado_dir); vivado -mode batch -source build_bitstream.tcl -notrace -tclargs opfb_streaming

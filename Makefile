# Makefile

ip_dir := ip
vivado_dir := vivado

all: generate_ip vivado_prj

generate_ip:
	cd $(ip_dir)/adc-to-opfb; vivado_hls -f script.tcl
	cd $(ip_dir)/opfb-fir-cfg; vivado_hls -f script.tcl
	cd $(ip_dir)/opfb-fir-to-fft; vivado_hls -f script.tcl
	cd $(ip_dir)/pkg-fft-output; vivado_hls -f script.tcl
	cd $(ip_dir)/ssrfft_16x4096/matlab; sysgen -r "auto_generate"

vivado_prj:
	cd $(vivado_dir); vivado -mode batch -nojournal -nolog -source write_prj.tcl

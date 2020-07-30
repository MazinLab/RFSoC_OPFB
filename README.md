# 4096 Channel 2/1 Oversampled 4 GHz Polyphase Filterbank on the Xilinx RFSoC

[Introduction](https://github.com/MazinLab/RFSoC_OPFB#introduction)

[Project Structure](https://github.com/MazinLab/RFSoC_OPFB#project-structure)

[Install and Requirements](https://github.com/MazinLab/RFSoC_OPFB#install-and-requirements)

[Running the Project](https://github.com/MazinLab/RFSoC_OPFB#running-the-project)

[Downloading the Project Source](https://github.com/MazinLab/RFSoC_OPFB#downloading-the-project-source)

[Building the Project](https://github.com/MazinLab/RFSoC_OPFB#building-the-project)

## Introduction

This project creates a polyphase channelizer capable of migrating 4 GHz of incoming RF bandwidth to 4096, 1 MHz channels with 2/1 oversampling. The projects runs on the Xilinx ZCU111 and uses approximatly 20% of the chip. The design involves two custom blocks made using Vivado HLS 2019.2 and one block exported from System Generator version 2019.2. The remaining blocks can be found in the Xilinx blockset in Vivado Design Suite 2019.2. Data is generated and visualized in a Jupyter Notebook hosted on the embedded CPU before being sent to and from the channelizer via DMA using the PYNQ framework.

## Project Structure
This project is built using Vivado Design Suite + Vivado HLS + System Generator versions 2019.2.

The `bd` directory contains block design `.tcl` scripts which can be sourced from within Vivado to rebuild the top level overlay design from which the bit stream is generated.

The `bit` directoy contains the `.bit` and `.hwh` files used to program the FPGA.

The `filter` directory contains the `.coe` files used to program the Xilinx filters.

The `ip` directory contains repositories for all the custom ip modules used in the firmware.

The `py` directory contains the Jupyter Notebook to run the project on the board.

## Install and Requirements

### Hardware
You will need a ZCU111 with a [PYNQ image](http://www.pynq.io/board.html) (this project was tested using v2.5) see the [PYNQ Docs](https://pynq.readthedocs.io/en/v2.5.1/) for download and setup information.

### Software
The Jupyter Notebok relies on functions specified in the [MKIDGen3](https://github.com/MazinLab/MKIDGen3/tree/master) and [FPBinary](https://github.com/smlgit/fpbinary) repositories. To install these on the board, first be sure the board is running PYNQ and is connected to the internet then run
```
$ pip install -e git+https://github.com/mazinlab/mkidgen3.git@develop#egg=mkidgen3
$ pip install fpbinary
```
### FPGA Files
The last thing needed to run the project on the board are the pre-compiled FPGA Files. Move `bd/opfb_test.tcl`, `bit/opfb_test.hwh`, and `bit/opfb_test.bit` to the same location on the board. The Jupyter Notebook `opfb_test.ipynb` must also be on the board. To acheive full notebook functionality, transfer the `filter` directory over as well. Note one of the more efficient ways to do this is to transfer a compressed directory containing the files mentioned above.

## Running the Project
Navigate to the board's Jupyter Notebook server. Run the `opfb_test.ipynb` notebook. Be sure to specify the correct path to the overlay files and the filter coefficient files in the notebook.

## Downloading the Project Source

This project makes use of git submodules to track individual IP block repositories. To clone the repository and initialize and update the submodules including nested submodules run the command:
```
$ git clone --recurse-submodules https://github.com/MazinLab/RFSoC_OPFB.git
```
If you already cloned the repo you can accomplish the same thing by running:
```
$ git submodule update --init --recursive
```
You should see individual folders in `ip/` populated with their source files, build scripts, etc. For more information on git submodules check out [the docs](https://git-scm.com/book/en/v2/Git-Tools-Submodules).

## Building the Project

The top-level `Makefile` will rebuild the entire project by first regenerating the [Vivado HLS](https://github.com/MazinLab/RFSoC_OPFB#hls) IPs and then the [Sysgen](https://github.com/MazinLab/RFSoC_OPFB#system-generator) IP and finally synthesizing and implementing the project in [Vivado](https://github.com/MazinLab/RFSoC_OPFB#vivado) batch mode (as opposed to gui). The script requires you to have Vivado Design Suite (2019.2) including Vivado HLS (2019.2) and SystemGenerator (2019.2/MATLAB R2019b) with the proper paths set. To be sure your Vivado paths are configred correcly, run
```
$ source <XILINX_PATH>/Vivado/2019.2/settings64.sh
```
The `sysgen` script called by the `Makefile` is located in the `<XILINX_PATH>/Vivado/2019.2/bin` directory and requires the MATLAB executable can be found in your Linux system's `$PATH` environment variable. See Vivado install guides for more information on downloading, installing, and configuring Vivado Design Suite and System Generator. Presuming the programs are installed and configured appropriatly, you can build the project with
```
$ cd /<path_to_RFSoC_OPFB>
$ make
```
### HLS

The HLS blocks can be modified by adapting the C++ source files in `ip/<HLS_Block_Name>/src` and the part number, synthesis stragety, and export style can be modified by adapting the HLS build script in `ip/<HLS_Block_Name>/script.tcl`. As is, the build script will create a project with the same name as the HLS Block and export the IP to `ip/<HLS_Block_Name>/<HLS_Block_Name>/solution1/impl/ip/`. The name and version of the exported IP can be changed from the default `MazinLab_mkidgen3_<HLS_Block_Name>_0_1` in the build script. It is recommended to change at least the version to keep track of project history.

### System Generator

The SSR FFT can be modified by changing `ip/ssrfft_16x4096/matlab/ssrfft_16x4096_axis.slx`. The part number, clock speed, and export style can be modified by clicking on the System Generator token in the `.slx`. In order to be sure Vivado can find the regenerated IP, set the 'target directory' field in the System Generator token to `<path_to_RFSoC_OPFB>/ip/ssrfft_16x4096`. The `Makefile` generates this IP by running the `ip/ssrfft_16x4096/matlab/auto_generate.m` script which opens `ssrfft_16x4096_axis.slx`, presses 'Generate', and closes the design without saving. This will result in the creation of the packaged IP in `ip/ssrfft_16x4096/ip`. To manage multiple versions, update the version number in 'Settings' next to 'Compilation' in the System Generator token or change the `.slx` file name (also update `auto_generate.m` if using the build script).

### Vivado

The `Makefile` sources `vivado/write_prj.tcl` which creates a vivado project `vivado/opfb_proj`, adds the `ip/` repository, sources the `bd/opfb_test.tcl` overlay block diagram, and generates the bitstream `opfb_test_wrapper.bit`. To test the rebuilt overlay on the board you will need to transfer the block design which Vivado will export to something like `vivado/opfb_proj/opfb_proj.srcs/sources_1/bd/opfb_test/hw_handoff/opfb_test_bd.tcl`, the hardware handoff file which can be found in something like `vivado/opfb_proj/opfb_proj.srcs/sources_1/bd/opfb_test/hw_handoff/opfb_test.hwh` and the bitstream which will be located in something like `vivado/opfb_proj/opfb_proj.runs/impl_1/opfb_test_wrapper.bit`.

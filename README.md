# 4096 Channel 2/1 Oversampled 4 GHz Polyphase Filterbank on the Xilinx RFSoC

[Introduction](https://github.com/MazinLab/RFSoC_OPFB#introduction)

[Project Structure](https://github.com/MazinLab/RFSoC_OPFB#project-structure)

[Install and Requirements](https://github.com/MazinLab/RFSoC_OPFB#install-and-requirements)

[Running the Project](https://github.com/MazinLab/RFSoC_OPFB#running-the-project)

[Downloading the Project Source](https://github.com/MazinLab/RFSoC_OPFB#downloading-the-project-source)

[Building the Project](https://github.com/MazinLab/RFSoC_OPFB#building-the-project)

## Introduction

This project creates a polyphase channelizer capable of migrating 4 GHz of incoming RF bandwidth to 4096, 1 MHz channels with 2/1 oversampling. The projects runs on the Xilinx ZCU111 and uses approximatly 20% of the chip. The original OPFB block was tested using synthetic data fed through the core using a DMA engine transfering individual packets of data. That project is tagged as [512 MHz OPFB Initial Release](https://github.com/MazinLab/RFSoC_OPFB/releases/tag/v1.0) and is associated with [this paper](https://ieeexplore.ieee.org/document/9336352). The OPFB was intended to injest data streaming from 2, 4 GSPS ADCs. This version has been upgraded to used the integrated RF Data converter to generate and sample the data in hardware loopback. The OPFB block is the same except the filter is now 4 taps per branch instead of 8 which halves the core LUTRAM utilization. The design involves multiple blocks made using Vitis HLS 2020.1 and one block exported from System Generator version 2019.2. The remaining blocks can be found in the Xilinx blockset in Vivado Design Suite 2021.2. Data is generated in a Jupyter Notebook hosted on the embedded CPU before being written to device URAM as a waveform look-up-table. Two RFSoC DACs output the waveform which is then sampled by two RFSoC ADCs (all running at 4.096 GSPS). The data freely streams through the OPFB channelizer. At the user's request, the output channels are captured to the PL DDR4 and visualized in a Jupyter Notebook using the PYNQ framework.

## Project Structure
This project is built using Vivado Design Suite 2021.2 + Vitis HLS 2020.1 + System Generator 2019.2.

The `bd` directory contains block design `.tcl` script which can be sourced from within Vivado to rebuild the top level overlay design from which the bit stream is generated.

The `bit` directoy contains the `.bit` and `.hwh` files used to program the FPGA.

The `filter` directory contains the `.coe` files used to program the Xilinx filters.

The `ip` directory contains repositories for all the custom ip modules used in the firmware including the source files and exported IP.

The `py` directory contains the Jupyter Notebook to run the project on the board.

## Install and Requirements

### Hardware
You will need a ZCU111 with a [PYNQ image](https://github.com/Xilinx/ZCU111-PYNQ/releases) (this project was tested using v2.7) see the [PYNQ Docs](https://pynq.readthedocs.io/en/v2.7.0/getting_started.html#zynq-zynq-ultrascale-and-zynq-rfsoc) for download and setup information.

### Software
The Jupyter Notebok relies on functions specified in the [MKIDGen3](https://github.com/MazinLab/MKIDGen3) repository. To install it on the board, first be sure the board is running PYNQ and is connected to the internet then run
```
cd ~
mkdir ~/src
git clone https://github/com/mazinlab/mkidgen3.git ~/src/
cd ~/src/mkidgen3
git checkout develop
sudo pip3 install -e ~/src/mkidgen3
```
*Note this project was tested with [MKIDGen3](https://github.com/MazinLab/MKIDGen3) commit hash [8040a0a](https://github.com/MazinLab/MKIDGen3/commit/8040a0a199fce029f0f15dd5c810257b4c19ed6a).*
### FPGA Files
The last thing needed to run the project on the board are the pre-compiled FPGA Files. Move `bit/opfb_streaming.hwh`,`bit/opfb_streaming.bit`, and the Jupyter Notebook `py/opfb_demo.ipynb` to the same location on the board.

## Running the Project
Navigate to the board's Jupyter Notebook server. Run the `opfb_demo.ipynb` notebook.

## Downloading the Project Source

This project makes use of git submodules to track individual IP block repositories. To clone the repository and initialize and update the submodules including nested submodules run the command:
```
git clone --recurse-submodules https://github.com/MazinLab/RFSoC_OPFB.git
```
If you already cloned the repo you can accomplish the same thing by running:
```
git submodule update --init --recursive
```
You should see individual folders in `ip/` populated with their source files, build scripts, etc. For more information on git submodules check out [the docs](https://git-scm.com/book/en/v2/Git-Tools-Submodules).

## Building the Project

The top-level `Makefile` will rebuild the project and run synthesis and implementation in Vivado batch mode. The script requires you to have Vivado Design Suite 2021.2 with the proper paths set. To be sure your Vivado paths are configred correcly, run
```
source <XILINX_PATH>/Vivado/2021.2/settings64.sh
```
Presuming the programs are installed and configured appropriatly, you can build the project with
```
cd /<path_to_RFSoC_OPFB>
make
```

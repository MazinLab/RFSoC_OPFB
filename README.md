# 4096 Channel 2/1 Oversampled 4 GHz Polyphase Filterbank on the Xilinx RFSoC

[Introduction](https://github.com/MazinLab/RFSoC_OPFB#introduction)

[Project Structure](https://github.com/MazinLab/RFSoC_OPFB#project-structure)

[Install and Requirements](https://github.com/MazinLab/RFSoC_OPFB#install-and-requirements)

[Running the Project](https://github.com/MazinLab/RFSoC_OPFB#running-the-project)

[Downloading the Project Source](https://github.com/MazinLab/RFSoC_OPFB#downloading-the-project-source)

[Building the Project](https://github.com/MazinLab/RFSoC_OPFB#building-the-project)

## Introduction
This project creates a polyphase channelizer capable of migrating 4 GHz of incoming RF bandwidth to 4096, 1 MHz channels with 2/1 oversampling. The design involves multiple blocks made using Vitis HLS (2020.1+) and one block exported from System Generator (2019.2+). The remaining blocks can be found in the Xilinx blockset in Vivado Design Suite (2021.2+). 

### Historical Context
The first versions of this project were made to run on the Xilinx ZCU111. The OPFB block was first verified using synthetic data fed through the core using a DMA engine transferring individual packets of data. That project is tagged as [512 MHz OPFB Initial Release (ZCU111)](https://github.com/MazinLab/RFSoC_OPFB/releases/tag/v1.0) and is associated with [this paper](https://ieeexplore.ieee.org/document/9336352). The original ZCU111 project was updated to demonstrate the OPFB operating in streaming mode and uses the integrated RF Data converter to generate and sample the data in hardware loopback. This ZCU111 Project is tagged as [512 MHz Streaming OPFB (ZCU111)](https://github.com/MazinLab/RFSoC_OPFB/releases/tag/v2.0) and is also preserved on the `zcu111_legacy` [branch](https://github.com/MazinLab/RFSoC_OPFB/tree/zcu111_legacy). Refer to the legacy branch for instructions specific to the earlier ZCU111-based projects.

The current verison of the design is built to run on the [Xilinx RFSoC 4x2](https://www.realdigital.org/hardware/rfsoc-4x2) in RF Data Converter loopback. Data is generated in a Jupyter Notebook hosted on the embedded CPU before being written to device URAM as a waveform look-up-table. The two DACs output the waveform which is then sampled by two RFSoC ADCs (all running at 4.096 GSPS). The data freely streams through the OPFB channelizer. At the user's request, the output channels are captured to the PL DDR4 and visualized in a Jupyter Notebook using the PYNQ framework. 


## What is an OPFB?
If you're wondering what an OPFB is, how it works, or why you should use it, I suggest looking through the materials in the `learning` directory. [Polyphase\_Explanation.pdf](https://github.com/MazinLab/RFSoC_OPFB/blob/master/learning/Polyphase_Explanantion.pdf) is a summary note I made to document key takeaways and figures and includes an explanation of the differences between Polyphase Filter Banks (PFBs) and Oversampled Polyphase Filter Banks (OPFBs). This note is largly based off of work done by Fred Harris. [OPFB\_Exploration.ipynb](https://github.com/MazinLab/RFSoC_OPFB/blob/master/learning/OPFB_Exploration.ipynb) is an interactive Jupyter Notebook capable of arbitrary oversampling, channel-size, etc. and includes cells demonstrating how the filter is designed and characterized. For more information on how to efficiently implement an OPFB on an FPGA, please read [the paper](https://ieeexplore.ieee.org/document/9336352).

## Project Structure
This project is built using Vivado Design Suite 2022.1 + Vitis HLS 2022.1 + System Generator 2019.2.

The `bd` directory contains block design `.tcl` script which can be sourced from within Vivado to rebuild the top level overlay design from which the bit stream is generated.

The `bit` directoy contains the `.bit` and `.hwh` files used to program the FPGA.

The `filter` directory contains the `.coe` files used to program the Xilinx filters.

The `ip` directory contains repositories for all the custom ip modules used in the firmware including the source files and exported IP.

The `py` directory contains the Jupyter Notebook to run the project on the board.

## Install and Requirements

### Hardware
You will need a RFSoC4x2 with a suitable image. It's possible to use the stock [PYNQ 3.0.1 image](https://www.pynq.io/boards.html); however, users will have to modify the memory reservation to make the DDR4 accessible to `pynq.allocate`. This can be done at run-time and there are a few examples of this such as the [Kria-PYNQ repo](https://github.com/Xilinx/Kria-PYNQ/tree/main) (see `/dts`), the [RFSoC-MTS repo](https://github.com/Xilinx/RFSoC-MTS/tree/main/boards/RFSoC4x2/dts), and a [thread discussion](https://discuss.pynq.io/t/how-to-allocate-pl-ddr4-on-rfsoc4x2-in-pynq-3-0-1/5586). For simplicity, we make our custom RFSoC4x2 image available [here](https://drive.google.com/file/d/13B8tchLYTMF_U6HLexjQW8cSzbOQCzSq/view?usp=sharing) and recommend downloading this image and flashing it to your SD card. See the [PYNQ Docs](https://www.rfsoc-pynq.io/rfsoc_4x2_getting_started.html) for more detailed setup information.

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

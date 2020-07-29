# 4096 Channel 2/1 Oversampled 4 GHz Polyphase Filterbank on the Xilinx RFSoC

## Introduction

This project creates a polyphase channelizer capable of migrating 4 GHz of incoming RF bandwidth to 4096 1 MHz channels with 2/1 oversampling. The projects runs on the Xilinx ZCU111 and uses approximatly 20% of the chip. The design involves two custom blocks made using Vivado HLS. The remaining blocks can be found in the Xilinx blockset in Vivado Design Suite and System Generator versions 2019.1+. Data is generated and visualized in a Jupyter Notebook hosted on the embedded CPU before being sent to and from the channelizer via DMA using the PYNQ framework.

## Project Structure
This project is built using Vivado Design Suite + Vivado HLS + System Generator version 2019.2.

The `ip` directory contains repositories for all the ip modules used in the firmware.

The `bd` directory contains block design .tcl scripts which can be sourced from within Vivado to rebuild the top level overlay design from which the bit stream is generated.

The `py` directory contains the jupyter notebook to run the project.

The `filter` directory contains the .coe files used to program the Xilinx filters

The `bit` directoy contains the .bit and .hwh files used to program the FPGA.
## Install and Requirements

### Hardware
You will need a ZCU111 with a [PYNQ image](http://www.pynq.io/board.html) (this project was tested using v2.5) see the [PYNQ Docs](https://pynq.readthedocs.io/en/v2.5.1/) for download and setup information.

### Software
The Jupyter Notebok relies on functions specified in the [MKIDGen3](https://github.com/MazinLab/MKIDGen3/tree/master) and [FPBinary](https://github.com/smlgit/fpbinary). To install these on the board, first be sure the board is running PYNQ and is connected to the internet then run
```
pip install -e git+https://github.com/mazinlab/mkidgen3.git@develop#egg=mkidgen3
pip install fpbinary
```
### FPGA Files
The last thing needed to run the project on the board are the pre-compiled FPGA Files. Move `opfb_test.hwh`, `opfb_test.tcl`, and `opfb_test.bit` to the same location on the board. The Jupyter Notebook `opfb_test.ipynb` must also be on the board. To acheive full functionality, transfer the filter coefficient files as well. Note one of the more efficient ways to do this is to scp a compressed directory containing the files mentioned above.

### Running the project
Navigate to the board's jupyter notebook server. Run the `opfb_test.ipynb` notebook. Be sure to specify the correct path to the overlay files and the filter coefficient files.

## Downloading and Modifying the Project Source

This project makes use of git submodules to track individual IP block repositories. To clone the repository and initialize and update the submodules including nested submodules run the command:
```
$ git clone --recurse-submodules https://github.com/MazinLab/RFSoC_OPFB.git
```
If you already cloned the repo you can accomplish the same thing by running:
```
$ git submodule update --init --recursive
```
For more information on git submodules check out [the docs](https://git-scm.com/book/en/v2/Git-Tools-Submodules).


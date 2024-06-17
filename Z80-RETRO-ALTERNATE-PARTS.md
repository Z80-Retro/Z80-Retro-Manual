# Z80-Retro Alternative Parts

[Back](./README.md)

It is recommended that you watch the video on alternate flash and SRAM chip 
options first!

Also if you're unsure, ask your questions on the Discord.

- Videos:
  - _Video Link: [Z80 Retro #65 - Alternate FLASH and SRAM chip options for the Retro](https://www.youtube.com/watch?v=V7FokYS09ag)_

## Alternate Parts

Some parts can be reliably swapped out.  The current list of known alternatives
is:

### 2063 - Z80-Retro

| Orig Part Num | Part Desc 
| ---           | ---       
| U2            | AS6C4008 - 4 mbit / 512K x 8bit SRAM 
| U3            | SST39SF010 - 4 mbit / 512K x 8bit FLASH ROM 

- U2 - SRAM

   - AS6C1008 - 1mbit / 128K x 8bit SRAM 
        This option requires that the bank select latch logic in firmware
        software is updated.  Details are described in detail in the linked
        video.  Basically, pin A17 must always be a 1 - ensure that the bank
        selector is always > 0xC0

        The top 4 bits of GPOUT select the bank.

- U3 - FLASH

    - UV-Erasable EPROM like the 27C010-70.  Note:
        that this device can not be programmed with the Raspberry PI Programmer
        adapter board: [2065-Z80-programmer](https://github.com/Z80-Retro/2065-Z80-programmer)


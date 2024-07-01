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

## Ribbon Cables

The [2063-Z80 README](https://github.com/Z80-Retro/2063-Z80) document lists some
sources for DIY Ribbon Cable assembly.  Should you prefer to purchase premade
parts, here are some links current (as at 2024-06-29).  Should these links ever
die, we have tried to provide valid search terms to find similar replacement
items.

Unfortunately, it's hard to tell from Amazon or Ebay listings what the pin
mappings are.  These two specific links have been tested and reported to be
known good and working by one of our community members in Discord.

There is some configurability available through the J1 and J8 jumpber blocks on
the 2063-Z80 board which allow for reassignment some of the rx and tx pins.
Check the schematic carefully.

- Serial Port Cables:
    DB9 RS232 Serial Female to 10 Pin Female Ribbon Cable Connector Adapter
    2.54mm Pitch 30cm Length
    Length [https://www.amazon.com/dp/B07Q2WCJZF?th=1](https://www.amazon.com/dp/B07Q2WCJZF?th=1)

- Printer Cable:
    uxcell IDC Wire Flat Ribbon Cable DB25 Female to FC-26 Female Connector 
    2.54mm Pitch 20cm Length, 2pcs [https://www.amazon.com/dp/B07SC1KJ5K](https://www.amazon.com/dp/B07SC1KJ5K)


# Z80-Retro Firmware Installation Guide

[Back](./README.md)

## Prerequisites

In order to compile the firmware you must have completed the steps described in
[Z80-Retro Development Environment](./Z80-RETRO-DEVEVELOPMENT.md)

The firmware executes on the Flash after a system reset or at power on assuming
the reset logic is working correctly.  Either way, its task is to copy the
first 16KB from partition 1 of the SD Card into at 0xC000 then
jump to 0xC000 and begin execution from there.  The low memory bank is set to
bank 14 at this time.

## Compiling Firmware

The firmware is in the [2063-Z80-cpm](https://github.com/Z80-Retro/2063-Z80-cpm.git)
repository.

```bash
$ cd 2063-Z80-cpm
$ git checkout main
$ cd boot
$ make world

... build output ...

$ ls -gG
total 108
-rw-r--r-- 1   407 Apr 18 11:25 Makefile
-rw-r--r-- 1   305 Apr 18 11:25 README.md
-rw-r--r-- 1 11856 Apr 18 11:25 firmware.asm
-rw-r--r-- 1  2471 Apr 18 11:28 firmware.bin
-rw-r--r-- 1 80818 Apr 18 11:28 firmware.lst
-rw-r--r-- 1  1498 Apr 18 11:28 firmware.sym
```

The `firmware.bin` file is ready in the `boot/` directory to be burned on to
your flash chip now.

## Installing Firmware

Installing the firmware requires that you have a some means by which to program
the SST39SF010 flash chip.  You can follow the guides to build the Raspberry Pi
programmer board and hook that up to the Z80-Retro or you can program the chip
using one of the commercially available chip programmers.

Typically, you won't need to program the flash that often unless you are
intending to develop and test custom firmware.  The process for that is beyond
the scope of this manual.

### Using the Raspberry Pi Programmer

The main benefit of using this programmer board is that you can program your
flash in-system.  That means that you don't need to pull the flash chip from the
Z80-Retro to program it.  It takes control of the Z80 address and data buses
while it programs the flash.

The process for this is described well in these videos.

- _Video Link:  [Z80 Retro #9 - FLASH Programmer](https://youtu.be/7DjiD5pvCqc)_
- _Video Link: [Z80 Retro #10 - FLASH Programmer Software](https://youtu.be/w5LYCHml4A8)_

### Using an XGPro TL866ii Plus

This method requires that you carefully pull the flash chip out of the
Z80-Retro.  Be careful as it's very easy to bend the IC Pins when pulling chips
out of their sockets.

The manufacture supplied software for the XGPro runs on windows only.  There is
an open source project on [GitLab](https://gitlab.com/DavidGriffith/minipro) that
you can clone, build and use to program your chips.  Follow the usage
instructions in that repository.

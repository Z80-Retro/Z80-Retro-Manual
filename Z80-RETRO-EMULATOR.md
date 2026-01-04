# Using the Etched Pixels Emulator Kit

[Back](./README.md)

The Etched Pixels Emulator kit supports the "Z80-Retro!" along with many other
homebrew projects.  

## Clone and Build

Clone the Etched Pixels Emulator Kit github repository here from here:
[https://github.com/EtchedPixels/EmulatorKit](https://github.com/EtchedPixels/EmulatorKit)

```bash
$ cd EmulatorKit
$ make 2063 2063_sdl2
```

Compilation takes a while as it compiles all the emulators for the different
supported projects.

Now that you have the emulator binary you should be ready to go.

## Preparing the firmware and the SDCard image

You will need to prepare the firmware image and the SD Card image for use
with the emulator.  As we don't have a real formatted SD Card to work with
we need to create an SDcard.img file that will have the correctly formatted
partitions on it.

### Build the 2063-Z80-cpm Project

First do a build of the whole project from the root directory of the
2063-z80-cpm project.

```bash
$ cd 2063-Z80-cpm
$ make clean
$ make
```

This will create the following binaries needed for the next steps:

- 2063-Z80-cpm/boot/firmware.bin
- 2063-Z80-cpm/filesystem/drive.img

### Create the SD Card Image

#### !!! WARNING !!! ####

**This process can damage your host file system if you get it wrong.  Make sure
you only format the loop device after setting it up.**

This step is a bit more complicated and these steps are definitely ONLY going
to work on a Linux host.

Start by making a new folder so that we don't overwrite anything important.

```bash
$ mkdir emulator
$ cd emulator
```

Copy the `firmware.bin` file into the working directory and truncating it to 16KB.

```bash
$ cd emulator
$ cp ../../2063-Z80-cpm/boot/firmware.bin ./
$ truncate --size=16K firmware.bin
```

Copy the `drive.img` to the working directory.

```bash
$ cd emulator
$ cp ../../2063-Z80-cpm/filesystem/drive.img ./
```

Create an empty `sdcard.img` file in the working directory.

```bash
dd if=/dev/zero of=sdcard.img bs=1M count=129
```

Partition the sdcard image.

```bash
parted -s sdcard.img mklabel msdos
parted -s sdcard.img mkpart primary 1 135
```

Mount the sdcard image into the kernel loopback device using the `losetup` command.  You must use sudo for this step.

```bash
sudo losetup -Pf --show sdcard.img
```

Observe which loopback device was created.  It is probably `/dev/loop0` but it might not be.  Whatever it is make sure the matching device name is used in the next step.

```bash
sudo chown ${USER}:${USER} /dev/loop0p1
```

Copy the `drive.img` into the first partition of the mounted sdcard.img at
/dev/loop0p1 taking care to use the correct loopback device discovered in the
previous steps.

```bash
sudo dd if=drive.img of=/dev/loop0p1 bs=512
```

Now you have the sdcard image ready for use with the emulator.

## Running the Emulator

To distinguish this "Z80-Retro!" project from a different
Z80-Retro project, the author has named the emulator `2063` after the board
number.

For convenience make a couple of symlinks.

```bash
$ cd emulator
$ ln -s <path/to/emulator-kit/>2063
$ ln -s <path/to/emulator-kit/>2063_sdl2
```

Run the emulator in text only mode.

```bash
$ ./2063 -r firmware.bin -S sdcard.img
```

```text
Z80 Retro Board 2063.3
git: v20230317.1-0-g8bcf644 2023-03-17 22:20:02 -0500
build: 2023-04-23 18:03:16+12:00

Booting SD card partition 1

Partition Table:
C1BE: 00 20 21 00 7F 71 21 10 00 08 00 00 00 00 04 00
C1CE: 00 71 22 10 06 BC 3D 3F 00 08 04 00 00 98 0B 00
C1DE: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
C1EE: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Partition 1 starting block number: 00000800
Partition 1 number of blocks:      00040000

Loading 0x20 512-byte blocks into 0xC000 - 0xFFFF
................................

Z80 Retro BIOS Copyright (C) 2021 John Winans
CP/M 2.2 Copyright (C) 1979 Digital Research
git: v20230317.1-0-g8bcf644 2023-03-17 22:20:02 -0500
build: 2023-04-22 17:56:49+12:00

NOTICE: rw_dmcache library installed.

a>
```

Run the emulator in text + graphics mode

```bash
./2063_sdl2 -r firmware.bin -S sdcard.img -T

```

Exit the emulator by typing `CTRL+\`  or in graphics mode by closing the TMS9918 window.


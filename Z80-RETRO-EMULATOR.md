# Using the Etched Pixels Emulator Kit

[Back](./README.md)

The Etched Pixels Emulator kit supports the "Z80-Retro!" along with many other
homebrew projects.  

## Clone and Build

Clone the Etched Pixels Emulator Kit github repository here from here:
[https://github.com/EtchedPixels/EmulatorKit](https://github.com/EtchedPixels/EmulatorKit)

```bash
$ cd EmulatorKit
$ make
< compilation takes a while>
$ cp 2063 ../2063-Z80-cpm
```

Compilation takes a while as it compiles all the emulators for the different
supported projects.

Now that you have the emulator binary you should be ready to go.

## Preparing the firmware and the sdcard image

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

### Create the ROM Image

The emulator expects the firmware image to be exactly 16KB in size.  Use the
`truncate` command in Linux to do that.

```bash
$ cd 2063-Z80-cpm/boot
$ truncate -s 16K firmware.bin
$ hexdump -C firmware.bin| tail -n 3
000009b0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00004000
```

Validate that the last line is 00004000 (0x4000 in hex) or 16K.

### Create the SD Card Image

#### !!! WARNING !!! ####

**This process can damage your host file system if you get it wrong.  Make sure
you only format the loop device after setting it up.**

This step is a bit more complicated and these steps are definitely ONLY going
to work on a Linux host.

```bash
$ cd 2063-Z80-cpm/filesystem

$ dd if=/dev/zero of=SDcard.img bs=1024 count=512000

$ sudo losetup -Pf SDcard.img
```

At this point you want to verify the loopback device that was created by the
`losetup` command.  You will need it in the next step.

```bash
$ sudo losetup --all | grep SDcard
/dev/loop12: [2050]:7215475 (/home/davelatham/dev/retro/2063-Z80-cpm/filesystem/SDcard.img)
```

The Loopback Device Setup tool `losetup` can be found here:
[https://man7.org/linux/man-pages/man8/losetup.8.html](https://man7.org/linux/man-pages/man8/losetup.8.html)

In my case here, the loopback device is `/dev/loop12` so that's what I will use.
You must use the device name your system reports.

```bash
$ (
echo n  # Add a new partition
echo p  # Primary partition
echo 1  # Partition number
echo    # First sector (Accept default)
echo +128M # Last sector (Accept default: varies)
echo n  # Add a new partition
echo p  # Primary partition
echo 2  # Partition number
echo    # First sector (Accept default)
echo    # Last sector (Accept default: varies)
echo t  # Partition Type
echo 1  # First partition
echo db # Tpye = CP/M
echo t  # Partition Type
echo 2  # Second partition
echo 06 # Fat 16
echo w  # Write changes
) | sudo fdisk /dev/loop12
```

Whew! Now that you have an image file with partitions on it, you can copy the
`drive.img` CP/M file system on to it.

You should still be in the `2063-Z80-cpm/filesystem` directory.

```bash
$ sudo mkfs.msdos /dev/loop12p1
$ sudo mkfs.msdos /dev/loop12p2
$ sudo dd if=drive.img of=/dev/loop12p1 bs=512
```

Finally unmount the loopback disk.

```bash
$ sudo losetup -d /dev/loop12
```

You should now have a 500MB SDcard.img file.

## Running the Emulator

To distinguish this "Z80-Retro!" project from a different
Z80-Retro project, the author has named the emulator `2063` after the board
number.

```bash
$ cd 2063-Z80-cpm
$ ./2063 -r boot/firmware.bin -S filesystem/SDcard.img

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

Exit the emulator by typing `CTRL+\`

# Z80-Retro Software Setup Guide

[Back](./README.md)

The Retro filesystem provided by the example filesystem GitHub repository
contains some useful utilities needed to get going.

There are many other CP/M software resources on the internet that are usually
compatible with the Z80-Retro!

This guide explains how to set up the SD Card with CP/M.

## TL;DR

These are all the steps requried to compile and make an SD Card that you can use
to boot the Z80 Retro!  The detailed steps are explained in more detail below.

```text
$ sudo apt-get update
$ sudo apt-get install build-essential z80asm cpmtools
$ git clone --recurse-submodules https://github.com/Z80-Retro/2063-Z80-cpm.git
$ cd 2063-Z80-cpm/
$ make world
```

Before proceeding you must prepare your SD Card so that it has one partition.

Make sure that the device name is correct for your system and SD Card.  See the
section below on "Peparing the SD Card" for details.

```text
sudo dd if=/dev/zero of=/dev/<your_device_name> bs=512 count=10
$ (
echo n  # Add a new partition
echo p  # Primary partition
echo 1  # Partition number
echo    # First sector (Accept default)
echo +128M # Last sector (Accept default: varies)
echo w
) | sudo fdisk /dev/<your_device_name>
```

Edit `Make.local` with the correct build SD_HOSTNAME and SD_DEV for your system
and SD card.  

```text
$ cd filesystem
$ cp Make.default Make.local
$ vim Make.local
```

Now you can run `make burn`

```text
$ make burn
```

Your SD Card is ready with the default content for booting CP/M.

## Detailed Instructions

### Install Dependancies

As described in [Z80-Retro Development Environment](./Z80-RETRO-DEVEVELOPMENT.md)
make sure you have installed the compiler, cpmtools and general essential build
tools for your system.  On Ubuntu and a Raspberry PI the commands to do this are

```text
$ sudo apt-get update
$ sudo apt-get install build-essential z80asm cpmtools
```

### Clone the Repository

If you have not yet cloned the CPM repository as described in [Z80-Retro Development Environment](./Z80-RETRO-DEVEVELOPMENT.md)
then do so now.  This step also pulls in the CP/M2.2 source
code.  For that to work you must include the `--recurse-submodules` command
argument.

```text
$ git clone --recurse-submodules https://github.com/Z80-Retro/2063-Z80-cpm.git
$ cd 2063-Z80-cpm/
```

### Compile CP/M

The first step is to compile CP/M and create a binary image of the CP/M drive
that you can copy to your SD Card.

```text
$ cd 2063-Z80-cpm
$ git checkout main
$ make world

... build output ...

$ ls -gG filesystem/drive.img
-rw-rw-r-- 1 409600 May 25 08:19 filesystem/drive.img
```

After preparing the SD Card the `drive.img` image can be copied to it.

### Preparing the SD Card

The process for this step is described in the [README-SD.md](https://github.com/Z80-Retro/2063-Z80-cpm/blob/main/README-SD.md).

#### WARNING: This process can overwrite your entire host PC volume.  Proceed carefully

In summary the steps are as follows:

* Find the SD Card device name

    There are a few different ways to do this.  The most common method on a
    linux system is to run the `dmesg` command which shows kernel events.
    When you insert a card into the SD Card slot on your system, you will find
    references to it in the output of a dmesg command call.

    ```text
    $ dmesg | tail -n 10
    [1544787.364682] sd 6:0:0:1: [sdd] 30916608 512-byte logical blocks: (15.8 GB/14.7 GiB)
    [1544787.365736] sd 6:0:0:1: [sdd] Write Protect is off
    [1544787.365738] sd 6:0:0:1: [sdd] Mode Sense: 23 00 00 00
    [1544787.366475] sd 6:0:0:0: [sdc] Attached SCSI removable disk
    [1544787.367845] sd 6:0:0:1: [sdd] Write cache: disabled, read cache: disabled, doesn't support DPO or FUA
    [1544787.385887]  sdd: sdd1
    [1544787.398816] sd 6:0:0:2: [sde] Attached SCSI removable disk
    [1544787.412898] sd 6:0:0:1: [sdd] Attached SCSI removable disk
    [1545018.496679]  sdd: sdd1
    [1545023.074094]  sdd: sdd1
    ```

    Here, on my system, I can see that a 16GB disk was mounted on sdd.  You can
    safely verify by running `fdisk --list /dev/sdd` where `sdd` is the device
    name you found in the output of `dmesg`.

    ```text
    $ sudo fdisk --list /dev/sdd
    Disk /dev/sdd: 14.76 GiB, 15829303296 bytes, 30916608 sectors
    Disk model: Micro SD
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0x00000000

    Device     Boot Start      End  Sectors  Size Id Type
    /dev/sdd1        8192 30916607 30908416 14.8G  c W95 FAT32 (LBA)
    ```

    Now that you are sure that /dev/sdd is the device you want to partition,
    you can proceed.  Be careful to always use this device name on the same
    system.  If you choose to run this process on a different system, make sure
    that you first verify the device name with `dmesg` and `fdisk --list`

    From now on all commands that require the device name will be shown with
    `<your_device_name>`.  You need to substiture this with your actual device
    name.

* Wipe out the master boot record.  This effectively clears any and all existing
    partition tables from the SD Card.  BE CAREFUL!!!

   ```text
   sudo dd if=/dev/zero of=/dev/<your_device_name> bs=512 count=10
   ```

* Create a a single partition on the SD Card using fdisk.  The repo contians a
    readme document called README-SD.md that goes into this this more detail and
    uses a different tool called `parted` to create the parittion.

    ```text
    $ (
    echo n  # Add a new partition
    echo p  # Primary partition
    echo 1  # Partition number
    echo    # First sector (Accept default)
    echo +128M # Last sector (Accept default: varies)
    echo w
    ) | sudo fdisk /dev/<your_device_name>
    ```

    Your SD Card is now ready to have CPM copied to Partition 1.

### Copy CP/M to the SD Card

This step describes how to copy the base OS onto the SD Card.

* [ ] TODO: Add section with instructions building multiple CP/M drives using
    the z80-disk-maker repository.

The `make world` recipe compiles 3 main features:

* boot/firmware.bin - Firmware for the FLASH ROM.
* retro/retro.bin - BIOS and Base OS
* filesystem/drive.img - BIOS and Base OS plus some other utilities. - Drive A.

You copy the `filesystem/drive.img` which contains some of the example programs
that you have seen John talk about in his videos.

#### Using the included Makefile to copy drive.img to your SD Card

You will find a file, `filesystem/Make.default` that configures Make for a
Raspberry PI.  You can override the details in this file by copying it to
`filesystem/Make.local` and editing the details in the new `Make.local` to match
your own system.  You need to alter the following settings:

```text
$ cd filesystem
$ cat Make.local
# A set of default values of things that might be of
# interest to more than one Makefile.

DISKDEF=z80-retro-8k-8m

# For normal use on a plain Raspberry PI
SD_DEV=/dev/sdd1

# This is used before burning an SD card image to make sure we are on the correct host!
SD_HOSTNAME=minecraft01
```

As you can see on my system, my `SD_HOSTNAME` is set to `minecreaft01` which
happens to be the hostname of my Ubuntu server where I am doing this work.

The device name on my system where SD Card shows up is `/dev/sdd` and the first
partition on that SD Card, now that I have made a partition using the above
commands is `/dev/sdd1`.

With this in place it's now a matter of running `make burn` to copy the OS to
to the SD Card.

### Burn the OS to the SD Card

```text
$ cd filesystem/
$ make burn
sudo dd if=drive.img of=/dev/sdd1 bs=512 conv=fsync
800+0 records in
800+0 records out
409600 bytes (410 kB, 400 KiB) copied, 0.0252067 s, 16.2 MB/s
```

Now eject your SD Card and try it out on the Retro.
If everything works, you should see something like this on your terminal:

```text
##############################################################################
Z80 Retro Board 2063.3
      git: v20230312.1-16-gef7b3f7 2023-05-04 21:48:53 -0500
    build: 2023-05-13 17:21:25+12:00

Booting SD card partition 1

Partition Table:
C1BE: 00 04 01 04 83 05 82 06 00 08 00 00 00 00 04 00
C1CE: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
C1DE: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
C1EE: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Partition 1 starting block number: 00000800
Partition 1 number of blocks:      00040000

Loading 0x20 512-byte blocks into 0xC000 - 0xFFFF
................................

Z80 Retro BIOS Copyright (C) 2021 John Winans
CP/M 2.2 Copyright (C) 1979 Digital Research
  git: v20230317.1-0-g8bcf644 2023-03-17 22:20:02 -0500
build: 2023-05-24 13:04:35+12:00

NOTICE: rw_dmcache library installed.

a>
```

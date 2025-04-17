# Z80-Retro Software Set Up Guide

[Back](./README.md)

The Retro file system provided by the example file system GitHub repository
contains some useful utilities needed to get going.

There are many other CP/M software resources on the internet that are usually
compatible with the Z80-Retro!

This guide explains how to set up the SD Card with CP/M.

## Compile CP/M

The first step is to compile CP/M and create a binary image of the CP/M drive
that you can copy to your SD Card.

```bash
$ cd 2063-Z80-cpm
$ git checkout main
$ make world

... build output ...

$ ls -gG boot/firmware.bin
-rw-rw-r-- 1 2472 May 24 12:34 boot/firmware.bin

$ ls -gG retro/retro.bin
-rw-rw-r-- 1 15196 May 24 12:34 retro/retro.bin

$ ls -gG filesystem/drive.img
-rw-rw-r-- 1 409600 Jun 21 15:16 filesystem/drive.img
```

After preparing the SD Card the `drive.img` image can be copied to it.

## Preparing the SD Card

The process for this step is described in the [README-SD.md](https://github.com/Z80-Retro/2063-Z80-cpm/blob/main/README-SD.md).

### WARNING: This process can overwrite your entire host PC volume.  Proceed carefully.

In summary the steps are as follows:

* Find the SD Card device name

    There are a few different ways to do this.  The most common method on a
    linux system is to run the `dmesg` command which shows kernel events.
    When you insert a card into the SD Card slot on your system, you will find
    references to it in the output of a dmesg command call.

    ```bash
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

    ```bash
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

* Wipe out the master boot record

   ```bash
   sudo dd if=/dev/zero of=/dev/sdd bs=512 count=10
   ```

* Create a single partition on the SD Card.

    (Copied from the README-SD.md on the repo - but ensuring that the drive is
    correct for this author's system.)

    ```bash
    sudo parted /dev/sdd
    (parted) mklabel msdos
    (parted) mkpart primary 1 135
    (parted) print
    Model: Generic MassStorageClass (scsi)
    Disk /dev/sdd: 15.6GB
    Sector size (logical/physical): 512B/512B
    Partition Table: msdos
    Disk Flags:

    Number  Start   End    Size   Type     File system  Flags
    1      1049kB  135MB  134MB  primary               lba

    (parted) q
    ```

## Copy CP/M to the SD Card

This step describes how to copy the base OS onto the SD Card.

* [ ] TODO: Add section with instructions building multiple CP/M drives using
    the z80-disk-maker repository.

The `make world` recipe compiles 3 main features:

* boot/firmware.bin - Firmware for the FLASH ROM.
* retro/retro.bin - BIOS and Base OS
* filesystem/retro.img - BIOS and Base OS plus some other utilities. - Drive A.

You could go ahead and copy just the BIOS + CP/M onto the SD Card, but without
some of the extra utilities it could be difficult to get started.  Our
recommendation is to copy the `filesystem/drive.img` which contains some of the example
programs that you have seen John talk about in his videos.

### Using the included Makefile to copy drive.img to your SD Card

The `filesystem/Makefile` does include a burn recipe that is designed to be run
on a Raspberry Pi.  Specifically, John's Raspberry Pi.  This guide explains how
to work with your SD Card on your system using the Linux commands directly.

If you wish to use the Makefile and the `make burn` recipe, you will need to
alter the `burn` recipe to include the correct host name and disk device name for
your system.

### Using native Linux commands to copy the drive.img to your SD Card

Copy `drive.img` to your partitioned SD Card using the dd command.

```bash
$ cd 2063-Z80-cpm
$ sudo dd if=filesystem/drive.img of=/dev/sdd1 bs=512 conv=fsync
```

Now eject your SD Card and try it out on the Retro.
If everything works, you should see something like this on your terminal:

```bash
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

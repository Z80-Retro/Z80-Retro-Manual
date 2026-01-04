# Z80-Retro Development Environment

[Back](./README.md)

In order to get set up on your Retro you will need to compile the firmware, CP/M
OS and user applications.  These are all Z80 assembly to start with and some
of the user programs later on are written in C.

These instructions are to get your local development environment set up in
preparation for the compilation steps later on.

## Linux

The development environment is based on having access to a Linux based operating
system.  These instructions cover Linux OS Variants based on the Debian package
manager such as Ubuntu and Raspian OS.

### Using a Raspberry PI?

It is recommended to use a Raspberry Pi for interfacing with your Z80-Retro! so
that your experience matches the videos as closley as possible.

Detailed instructions for setting up your Raspberry Pi SDCard can be found at
[https://github.com/johnwinans/raspberry-pi-install](https://github.com/johnwinans/raspberry-pi-install).

Once you have a working Linux environment (Pi or otherwise) you will need to install the packages listed in the next section.

### Install Build Dependencies

```bash
$ sudo apt-get update
$ sudo apt-get upgrade
$ sudo apt-get install build-essential z80asm cpmtools srecord parted
```

Test that you are able to compile Z80 Assembly code by creating the following
source code file and assembling it.  If your code assembles and generates a hex
file that matches the one listed, you know you are good to go.

```bash
$ cat hello.asm
bdos:   equ     0x0005          ; BDOS Sys Request
print:  equ     0x09            ; BDOS Print String function

        org     0x0100

        ld      c,print
        ld      de, message
        call    bdos
        ret
message:
        db      0x0d,0x0a,'Hello, World!',0x0a,0x0d,'$'
```

Assemble with z80asm.  There should be no errors.

```bash
$ z80asm -o hello.com --list=hello.lst hello.asm
```

Check that a listing file and a com file were generated.

```bash
$ ls
hello.asm  hello.com  hello.lst
```

Check the listing file.

```bash
$ cat hello.lst
# File hello.asm
0000                    bdos:   equ     0x0005          ; BDOS Sys Request
0000                    print:  equ     0x09            ; BDOS Print String function
0000
0000                            org     0x0100
0100
0100 0e 09                      ld      c,print
0102 11 09 01                   ld      de, message
0105 cd 05 00                   call    bdos
0108 c9                         ret
0109                    message:
0109 0d 0a .. 0a 0d ..          db      0x0d,0x0a,'Hello, World!',0x0a,0x0d,'$'
# End of file hello.asm
011b
```

Check the hex for the com file.

```bash
$ hexdump -C hello.com
00000000  0e 09 11 09 01 cd 05 00  c9 0d 0a 48 65 6c 6c 6f  |...........Hello|
00000010  2c 20 57 6f 72 6c 64 21  0a 0d 24                 |, World!..$|
0000001b
```

Before moving on, now is a good time to create a `hello.hex` (intel hex)
version of the binary file.  We will use this later on in the manual to
demonstrate how to transfer a file across the serial port using PIP.

```bash
srec_cat hello.com -binary -offset 0x0100 -address-length=2 -CRLF -output hello.hex -intel
```

The intel hex file should look like this:

```bash
$ cat hello.hex
:1B0100000E09110901CD0500C90D0A48656C6C6F2C20576F726C64210A0D245C
:00000001FF
```

If this all looks good, you can choose to delete the following 3 files.  Keep
the `hello.hex` one.

- hello.asm
- hello.lst
- hello.com

### Working Directory Set-Up

The best way to organize the code on your computer is to follow the same pattern
as John does.  Set up a folder beneath which you will run all your projects.

```bash
$ cd $HOME          # Start out in your home directory.
$ mkdir z80-retro   # Create a folder for your work
$ cd z80-retro      # navigate to the new folder
```

From now on this document will assume that your current working directory will
always be the z80-retro directory created in this step.

### Clone Repositories

```bash
$ git clone --recurse-submodules https://github.com/Z80-Retro/2063-Z80-cpm.git
$ git clone https://github.com/Z80-Retro/example-filesystem.git
$ git clone https://github.com/Z80-Retro/Z80-Retro-disk-maker.git
```

Note that the first repository requires that you supply the
`--recurse-submodules` option to the clone command so that git will also
fetch the source code for the CP/M OS and XMODEM and additional utilities.

You are now ready to proceed to [compiling and installing the firmware](./Z80-RETRO-FIRMWARE.md).

# Z80-Retro Memory

[Back](./README.md)

## Z80 Memory

- _Video Link: [Z80 Retro #7 - 512K Bank Selected Memory](https://www.youtube.com/watch?v=zrnZkAMAh6A)_

As the Z80 processor has a 16bit wide address bus, it can only address 64K of
memory.  This will include both the boot ROM and the static RAM combined.

The Z80 Boot ROM is designed to load the operating system from the SD Card and
save it into RAM.  When that task is complete, it disables the ROM and enters
the operating system.  Thus, and for the purposes of this section of the manual,
any talk of memory will refer to memory in SRAM unless otherwise noted.

## Banked Memory Layout

The Z80 Retro SRAM is a 512K SRAM device.  It can be divided down into 16 blocks
of 32K.  The memory select logic is responsible for enabling or disabling banks
of RAM such that the CPU has access to a total of 64K of RAM at all times.

| BANK | START   | END     | COMMENT / USAGE
|------|---------|---------|----------------
|15    | 0x78000 | 0x7FFFF | ALWAYS enabled for addresses 0x8000 to 0xFFFF
|14    | 0x70000 | 0x77FFF | Default Low bank assigned by firmware
|13    | 0x68000 | 0x6FFFF |
|12    | 0x60000 | 0x67FFF |
|11    | 0x58000 | 0x5FFFF |
|10    | 0x50000 | 0x57FFF |
|09    | 0x48000 | 0x4FFFF |
|08    | 0x40000 | 0x47FFF |
|07    | 0x38000 | 0x3FFFF |
|06    | 0x30000 | 0x37FFF |
|05    | 0x28000 | 0x2FFFF |
|04    | 0x20000 | 0x27FFF |
|03    | 0x18000 | 0x1FFFF |
|02    | 0x10000 | 0x17FFF |
|01    | 0x08000 | 0x0FFFF |
|00    | 0x00000 | 0x07FFF |

Bank 15 is always enabled whenever the CPU addresses anything in the 0x8000 to
0xFFFF address range.  This is also called the HIGH Bank.

The remaining 15 Banks (0-14) can be selected into the LOW Bank or addresses
from (0x0000 to 0x7FFF).  For example, if bank 05 is selected and the CPU reads
from address 0x100 that read will be made against address 0x28000 + 0x100 =
0x28100 in the SRAM device.  The CPU has no idea that happened as from its
perspective it wants to read 0x100.  The memory select logic is deciding which
bank of memory in the SRAM range to retrieve that data from.

## The BANK Selection Logic

Address lines 15 - 18 on the SRAM chip provide the memory division down to
16x32K banks.  These 4 address lines are driven by 4 or gates where each line is
ORed together with A15 from the CPU.  Thus, if the CPU is requesting data from
the high half of memory (0x8000 - 0xFFFF), A15 will be a 1 and a 1 OR x is
always = 1.  In this case, all 4 lines 15-18 on the SRAM chip will be ones and
that maps to the address range 0x78000 - 0x7FFFF (or bank 15)

In the case where the CPU is requesting something from the low half of memory
(0x0000 - 0x7FFF) then the other half of those OR Gates will determine which of
the SRAM address lines 15-18 are enabled and so a bank is selected.

The GPIO OUT Latch (74HC374) holds the value for the bank selection bits in the
4 most significant bits of its data.  Programmers can set the values of these
4 bits to set the current memory bank.

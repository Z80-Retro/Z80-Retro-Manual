# Z80-Retro IO Ports

[Back](./README.md)

This table provides a list of the assigned IO ports in the Z80 Retro and some
of the additional daughter boards including the VDP.

Information checked against schematics and in the CPM IO library and example
VDP Code.

- [2063-z80.pdf](https://github.com/Z80-Retro/2063-Z80/blob/main/2063-Z80.pdf)
- [2063-z80-cpm IO Lib](https://github.com/Z80-Retro/2063-Z80-cpm/blob/main/lib/io.asm)
- [FLEADiP](https://github.com/dennowiggle/FLEADiP#z80-io-port-addresses)

|Port Range | Programmed Port | Board                      |Description
|---------- |---------------- |-------------------------   |------------
|00-0F      | 00              | 2063-Z80                   | GP IO In
|10-1F      | 10              | 2063-Z80                   | GP IO Out
|20-2F      | 20              | 2063-Z80                   | Printer Data Out
|30-3F      | 30              | 2063-Z80                   | SIO Port A - Data
|30-3F      | 31              | 2063-Z80                   | SIO Port B - Data
|30-3F      | 32              | 2063-Z80                   | SIO Port A - Control
|30-3F      | 33              | 2063-Z80                   | SIO Port B - Control
|40-4F      | 40              | 2063-Z80                   | CTC Port 0
|40-4F      | 41              | 2063-Z80                   | CTC Port 1
|40-4F      | 42              | 2063-Z80                   | CTC Port 2
|40-4F      | 43              | 2063-Z80                   | CTC Port 3
|50-5F      | 50              | FLEADiP                    | FPGA Address Register
|50-5F      | 51              | FLEADiP                    | FPGA Data Register
|50-5F      | 58-5F           | Z80 Retro TL16C550C Card   | 16550 Registers
|60-6F      |                 |                            | 
|70-7F      | 70              | 2063-Z80                   | Flash Disable
|80-8F      | 80              | 2068-Z80-TMS9118 / FLEADiP | TMS9118 VRAM
|80-8F      | 81              | 2068-Z80-TMS9118 / FLEADip | TMS9118 REGISTER
|90-9F      |                 | 2068-Z80-TMS9118           | 
|A0-AF      | A4              | FLEADiP                    | ESP Programmer
|A0-AF      | A8              | 2068-Z80-TMS9118 / FLEADiP | Joystick 0 (J3)
|A0-AF      | A9              | 2068-Z80-TMS9118 / FLEADiP | Joystick 1 (J4)
|B0-BF      |                 |                            | 
|C0-CF      |                 |                            |
|D0-DF      |                 |                            |
|E0-EF      |                 |                            |
|F0-FF      |                 |                            |

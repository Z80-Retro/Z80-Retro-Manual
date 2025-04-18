# Z80-Retro Hardware Build Guide

[Back](./README.md)

This document is not a "how to solder things" document nor is it going to get
into the intricacies of surface mount soldering techniques.

That said, here are some tips:

- Videos:
  - _Video Link: [Z80 Retro #33 - v4rc1 Full Build and Test pt.
    1](https://youtu.be/X0ApysAFA7k)_
  - _Video Link: [Z80 Retro #34 - v4rc1 Full Build and Test pt.
    2](https://youtu.be/aZyimz6YkGY)_

- Use good quality, machined sockets for the full can oscillators.
- Watch out when ordering the resistors.  They need to be the 1/8 watt type.
  They are very small.  The more common 1/4 watt type will not fit well on the
  board.  You can make them work, but it's gonna be messy.
- If you're struggling with the surface mounted SD Card socket, have a look at
  the SparkFun breakout board option. - Details in section below.
- An alternative to soldering the SMD parts with a soldering iron is to use
  solder paste and a hot air gun.  If you have a hot air rework station, we have
  had reports of success with _#4 Sn42Bi58 138C_ paste which can be found on
  Amazon.  You want the low melting point stuff which will make it easier to
  heat the board up sufficiently for the paste to begin flowing.
- Some people even use sockets for the resistor networks.  This does raise them
  up slightly but as resistor networks are more expensive, you might want to
  consider using a socket for them too.
- Use ceramic MLCC Capacitors for the un-polarised capacitors.  An assortment
  can be purchased from
  [Amazon](https://www.amazon.com/ceramic-capacitor-kit/s?k=ceramic+capacitor+kit).
  Don't use tantalum capacitors like I did in the RS232 circuit.  While they do
  work, they are polarised so care should be taken to install them correctly and
  they are sensitive to voltage spikes and the risk of them popping is high.
  **DON'T USE THEM.** They are censored in the image below.  - See [ICL3232CPZ
  Capacitors](#icl3232cpz-capacitors) for an example of how they should be
  installed.
- Make sure your oscillator cans are oriented correctly.  Pin 1 is pointed to by
  the orange arrows on the image below.
- You can use the cheaper socket types for everything but the oscillator cans.
  (I used machined sockets because I am a nerd.)  It's not required.

## As Built CPU Board

![Photo of Z80 Retro As Built](./assets/z80-retro-as-built.jpg)

## Jumper Settings

There are 5 sets of jumpers on the Z80-Retro marked in Yellow in the above
image.

<!-- markdownlint-disable -->
|Silk Screen      |Function                                                     |Default Config
|---------------- |------------------------------------------------------------ |---------------
|J1 - CONSOLE (A) |Primary serial connection to host PC                         |TX-PIN2,RX-PIN3
|J8 - AUX (B)     |Used for auxiliary serial connections                        |Unpopulated
|J11 - SIO/CTC    |Set SIO or CTC as clock source for CONSOLE (A) and AUX (B)   |Both set to X2
|J12              |Select a different bank on the Flash.                        |Unpopulated
|J9 - USER1       |General user input.  Assigned to bit 5 on GP Input.          |Unpopulated
<!-- markdownlint-restore -->

## [ICL3232CPZ Capacitors](#icl3232cpz-capacitors)

For the 6 capacitors sandwiched between the ICL3232CPZ (U12) and the SIO (U5) it
can be a little tricky to know which value goes where.  Thanks to Bob("The
Professor") on Discord for providing this illustration.

![Annoted PCB Layout showing ICL3232
capacitors](./assets/z80-retro-ic3232-capcitors.jpg)

And here is a how they look installed.  Thanks again to Bob ("The Professor").

![Cropped Closup Of ICL3232 capacitors installed](./assets/z80-retro-ic3232-asbuilt.jpg)

## The Do Not Populate Resistors

A future release of the board will most likely have these components removed
from the schematic and PCB.  But for now, do not populate R15 and R16.

## SparkFun SDCard Breakout Board

The J10 connector is designed to accept a SparkFun Level Shifting microSD
Breakout board.  This board will take care of level shifting between 5v and the
3.3v required for the SDCard.

There is no problem with populating all the components which would allow for
using either the on-board SDCard socket (J2) _or_ the SparkFun breakout board.
(J10).  You can _not_ use both at the same time.

If your intention is to _NEVER USE_ the surface mounted J2 SDCard socket, then
you don't need to populate the resistor divider network or the voltage
regulator underneath the board.

List of Do Not Populate when _ONLY USING_ the SparkFun Breakout board.

- J2  - SDCard socket
- R1  - R6 - Resistor divider network
- R7  - MISO Pull-up resistor
- C17 - Bypass Capacitor
- U20 - Voltage regulator 5v down to 3.3v
- C18, C19, C24 - Capacitors required by the voltage regulator.

If you ever choose to populate the J2 SDCard socket, then you should also
populate all the other related components from the above list.  You never know
who, in the future, will be using your board and they might want to use that
socket if it's present on the board.

- [https://www.sparkfun.com/sparkfun-level-shifting-microsd-breakout.html](https://www.sparkfun.com/sparkfun-level-shifting-microsd-breakout.html)
- [https://www.digikey.co.nz/en/products/detail/sparkfun-electronics/DEV-13743/5881845](https://www.digikey.co.nz/en/products/detail/sparkfun-electronics/DEV-13743/5881845)

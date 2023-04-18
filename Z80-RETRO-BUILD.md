# Z80-Retro Hardware Build Guide

[Back](./README.md)

This document is not a "how to solder things" document nor is it going to get
into the intracacies of surfacemount soldering techniques.

That said, here are some tips:

- Videos:
  - _Video Link: [Z80 Retro #33 - v4rc1 Full Build and Test pt. 1](https://youtu.be/X0ApysAFA7k)_
  - _Video Link: [Z80 Retro #34 - v4rc1 Full Build and Test pt. 2](https://youtu.be/aZyimz6YkGY)_

- Use good quality, machined sockets for the full can oscilators.
- If you're struggling with the surfacemounted SD Card socket, have a look at
the sparkfun breakout board option.
- Some people even use sockets for the resistor networks.  This does raise them
up slightly but as resistor networks are more expensive, you might want to
consider using a socket for them too.
- Use ceramic MMCC Capacitors for the unpolarised capacititors.  An assortment
can be purchased from [Amazon](https://www.amazon.com/ceramic-capacitor-kit/s?k=ceramic+capacitor+kit).
Don't use tantalum capacitors like I did in the RS232 circuit.  While they do
work, they are polarised so care should be taken to install them correctly and
they are sensitive to voltage spikes and the risk of them popping is high.
**DON'T USE THEM.**
They are censored in the image below.

- Make sure your oscilator cans are oriented correctly.  Pin 1 is pointed to by
the orange arrows on the image below.

## As Built CPU Board

![Photo of Z80 Retro As Built](./assets/z80-retro-as-built.jpg)

## Jumper Settings

There are 5 sets of jumpers on the Z80-Retro marked in Yellow in the above
image.
<!-- markdownlint-disable -->
|Silk Screen     |Function                                                           |Default Config
|----------------|-------------------------------------------------------------------|---------------
|J1 - CONSOLE (A)|Primary serial connection to host PC pin configuration.            |TX-PIN2,RX-PIN3
|J8 - AUX (B)    |Used for auxilary serial connections                               |Unpopulated
|J11 - SIO/CTC   |Used to set SIO or CTC as clock source for CONSOLE (A) and AUX (B) |Both set to X2
|J12             |Used to select a different bank on the Flash.                      |Unpopulated
|J9 - USER1      |General user input.  Assigned to bit 5 on GP Input.                |Unpopulated
<!-- markdownlint-restore -->

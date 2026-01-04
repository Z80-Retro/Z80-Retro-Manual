# Transferring Files to CP/M

[Back](./README.md)

There are a few different ways one can transfer files to CP/M over the serial
connection.

- `pip` over the existing serial connection
- `xmodem` over the existing serial connection
- `nhget / nhput` over the auxiliary serial connection

## Use PIP to Transfer a File

In the [Z80-Retro Development Environment](./Z80-RETRO-DEVELOPMENT.md) you made
a small CP/M "hello world" application.  At the end of that process you created
an Intel hex version of the `hello.com` binary called `hello.hex`.

We can use the installed `pip.com` application to transfer intel hex files.
Before trying, you will need to configure your terminal to delay between each
character you send.  This is because your host machine can send the data much
faster than the Z80-Retro! can process it.

In Minicom you can set the character delay as follow:

While in Minicom, type `<CTRL+A> T` and the following popup will appear.

```text
+---------------[Terminal settings]----------------+
|                                                  |
| A -      Terminal emulation : VT102              |
| B -     Backspace key sends : BS                 |
| C -          Status line is : enabled            |
| D -   Newline tx delay (ms) : 0                  |
| E -          ENQ answerback : Minicom2.8         |
| F - Character tx delay (ms) : 0                  |
|    Change which setting?                         |
|                                                  |
+--------------------------------------------------+
```

Press `F` to change the `Character tx delay (ms) : 0` to 5.  Backspace to
delete the `0`, `5` to set the value and `<ENTER> <ENTER>` to return to your
Minicom session.

You only need to perform this step when you want to paste data into the
console.  This might be useful if you are pasting BASIC source code into BBC
BASIC or MBASIC.

Once you have your transmit delay set to 5 ms, you can now use PIP to copy the Intel hex data from the serial console into a file.

You might also need to instruct Minicom to add a LINEFEED and CARRIAGE RETURN.  Do this with:

- Linefeed: `<CTRL+A> A`
- Carriage Return: `<CTRL+A> U`

Look at the bottom left of the window and you will see if the commands have worked or not.  You repeat the same steps to disable them later.


```text
a>pip hello.hex=con:

<PASTE INTEL HEX DATA>
:1B0100000E09110901CD0500C90D0A48656C6C6F2C20576F726C64210A0D245C
:00000001FF<ENTER>
<CTRL+Z>

a>type hello.hex


:1B0100000E09110901CD0500C90D0A48656C6C6F2C20576F726C64210A0D245C
:00000001FF


a>
```

Its now safe to reset your Linefeed, Carriage return and transmit delay values.

Note the `<ENTER>` and `CTRL+Z` at the end.  You need to hit `CTRL+Z` to let
PIP know that you are finished.

Once you have created the Intel hex file on the CP/M drive, you can convert it
to a `.com` file with:

```text
a>load hello

FIRST ADDRESS 0100
LAST  ADDRESS 011A
BYTES READ    001B
RECORDS WRITTEN 01
```

And test it with:

```text
a>hello

Hello, World!
```

A far more convenient method of transferring files is to use the included
Xmodem utility.

## Use XMODEM to Transfer a File

The `xr.com` utility will let you transfer any files at a faster rate across
the serial connection.  This example shows how to load the `xs.com` binary file
that was also compiled in the xmodem repository.

```text
a>xr hello.hex
CP/M XR - Xmodem receive v0.2
Checking for previous file... no file found
Start transfer
```

Press `<CTRL+A> S` to send a file.  The Upload popup will appear.  Use the
arrow keys to select `Xmodem` and press <ENTER>.

```text
+-[Upload]--+
| zmodem    |
| ymodem    |
| xmodem    |
| kermit    |
| ascii     |
+-----------+
```

Then use the arrow keys to navigate the host machine filesystem to find the
file you want to upload.  In this case `hello.hex`.

- Arrow keys to move up and down.
- `<SPACE>` `<SPACE>` to enter a directory.
- `<SPACE>` to select the file you want.
- `<ENTER>` to confirm uploading the file.

A dialog will appear showing the file being transferred along with some
statistics about the transfer.

```text
+----------------[xmodem upload - Press CTRL-C to quit]----------------+
|Sending HELLO.HEX, 0 blocks: Give your local XMODEM receive command no|
|w.                                                                    |
|Bytes Sent:    128   BPS:86                                           |
|                                                                      |
|Transfer complete                                                     |
|                                                                      |
| READY: press any key to continue...                                  |
+----------------------------------------------------------------------+

File HELLO.HEX received successfully

a>
```

The `xs.com` utility is for receiving files from CP/M to the host computer and
works in a very similar manner to `xr.com`.


# Makes a PDF
# Assumes you have installed pandoc and required libraries.
# Tested on Ubuntu
#
# sudo apt install pandoc texlive-latex-recommended texlive-latex-extra
#

.PHONY: all

all:
	mkdir -pv artifacts
	pandoc -s -o artifacts/z80-retro-manual.pdf \
		-V papersize:"a4paper" \
		-V geometry:margin=1.75cm \
		--top-level-division=chapter \
		"README.md" \
		"PREFACE.md" \
		"Z80-RETRO-ARCHITECTURE.md" \
		"Z80-RETRO-BUILD.md" \
		"Z80-RETRO-MEMORY.md" \
		"Z80-RETRO-DEVELOPMENT.md" \
		"Z80-RETRO-FIRMWARE.md" \
		"Z80-RETRO-INSTALL-CPM.md" \
		"Z80-RETRO-FILE-XFER.md" \
		"Z80-RETRO-IO-PORTS.md" \
		"Z80-RETRO-VDP-BUILD.md" \
		"Z80-RETRO-EMULATOR.md" \
		"Z80-RETRO-ORG-AND-GIT.md" \
		"GNU Free Documentation License.md"

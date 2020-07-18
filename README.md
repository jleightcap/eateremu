# eateremu
A modular, cycle-accurate emulator for Ben Eater's 8-bit breadboard computer written in Verilog allowing for easy expansion and testing.

# Usage
Write machine code to `ram.v`.

To monitor output register status, run `make`; to monitor bus, all register, and control word status, run `make verbose`.

Run program with `./eatermu_tb`.

# Design
The CPU architecture is an implementation of [Ben Eater's design](https://eater.net/8bit), but allows for easy implementation of modifications and common expansions such as a reset control signal and 8-bit memory addressing.

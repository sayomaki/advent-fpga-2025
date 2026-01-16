# AoC 2025 FPGA/Hardcaml

This project contains code written for solving AoC projects in RTL (Verilog) and Hardcaml.

**Completed puzzles:**
- [x] Day 2 (part 1)

## Setup Instructions
Follow the instructions in the Hardcaml template project for Hardcaml setup. 
Then, run the following to build and synthesis verilog for testing and evaluation.

**Run tests:** `make test`  
**Synthesis RTL:** `make verilog`

## Project Structure
- `bin` - Hardcaml executables to generate RTL
- `src` - Hardcaml source files for each day, along with a wrapper. Also includes the original hardcaml template example
- `test` - Testsuite containing Hardcaml simulation and expected waveforms
- `fpga` - Verilog wrapper code to test/evaluate on real FPGA hardware

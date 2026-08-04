# Sources, References and Tools Used

> A comprehensive list of all resources referenced during the design, implementation, simulation, and documentation of the PISO Shift Register FPGA project.

---

## Textbooks and Standards

| # | Source | How It Was Used |
|---|---|---|
| 1 | **IEEE Std 1076-2008** — *Standard VHDL Language Reference Manual* | The authoritative VHDL language reference. Used for correct syntax of `generic`, `port`, `process`, `rising_edge`, asynchronous reset inference, and `STD_LOGIC_VECTOR` operations. |
| 2 | **P. J. Ashenden** — *The Designer's Guide to VHDL*, 3rd ed., Morgan Kaufmann, 2008 | Referenced for best practices in writing synthesizable VHDL, structural vs. behavioural modelling, and testbench methodology. |
| 3 | **Pong P. Chu** — *RTL Hardware Design Using VHDL*, Wiley-IEEE Press, 2006 | Used as the primary reference for RTL design patterns, including shift register architectures, clock-enable techniques, and counter-based clock dividers. |
| 4 | **M. M. Mano and M. D. Ciletti** — *Digital Design: With an Introduction to Verilog HDL*, 5th ed., Pearson, 2013 | Referenced for foundational theory on shift registers (PISO, SIPO, SISO, PIPO), state machines, and timing analysis concepts. |

---

## Hardware Documentation

| # | Source | Link | How It Was Used |
|---|---|---|---|
| 5 | **Digilent Inc.** — *Nexys 4 DDR Reference Manual* | [reference.digilentinc.com/nexys4-ddr](https://reference.digilentinc.com/nexys4-ddr) | Pin mapping for switches (SW0-SW7), buttons (CPU_RESETN, BTNC), LEDs (LD0-LD1), and 100 MHz oscillator (E3). The XDC constraints file is derived directly from this document. |
| 6 | **Xilinx Inc.** — *7 Series FPGAs Data Sheet: Overview (DS180)* | [xilinx.com/.../ds180](https://www.xilinx.com/support/documentation/data_sheets/ds180_7Series_Overview.pdf) | Referenced for Artix-7 XC7A100T device specifications: available LUTs (63,400), flip-flops (126,800), I/O banks, BUFG count, and power characteristics. |

---

## Software and EDA Tools

| # | Tool | Version | Purpose |
|---|---|---|---|
| 7 | **Xilinx Vivado Design Suite** | 2022.1 | Complete FPGA design flow — project creation, VHDL synthesis, implementation (place and route), bitstream generation, hardware programming via JTAG. |
| 8 | **Vivado Simulator (xsim)** | Integrated in Vivado 2022.1 | Behavioural simulation of the testbench (`tb.vhd`). Waveform viewer used to capture and verify signal transitions. |
| 9 | **Vivado Constraints Editor** | Integrated in Vivado 2022.1 | Creation and validation of the XDC pin constraints file (`nexys4ddr_piso.xdc`). |

---

## Xilinx Application Notes and User Guides

| # | Document | How It Was Used |
|---|---|---|
| 10 | **UG903** — *Vivado Design Suite User Guide: Using Constraints*, Xilinx, 2022 | Referenced for correct XDC constraint syntax: `set_property`, `create_clock`, `get_ports`, `PACKAGE_PIN`, and `IOSTANDARD` directives used in the constraints file. |
| 11 | **UG901** — *Vivado Design Suite User Guide: Synthesis*, Xilinx | Understanding how Vivado infers clock divider logic, async-reset flip-flops (`RTL_REG_ASYNC`), and shift register primitives from VHDL code. |
| 12 | **UG906** — *Vivado Design Suite User Guide: Design Analysis and Closure Techniques*, Xilinx | Interpreting the post-implementation timing reports (WNS, TNS, failing endpoints) and resource utilisation summaries. |

---

## Design Methodology and Concepts

| Concept | Source | Application in This Project |
|---|---|---|
| **PISO Shift Register** | Mano and Ciletti, Ch. 6; Pong P. Chu, Ch. 4 | Core architecture — 8-bit parallel load, MSB-first serial output, configurable width generic. |
| **Clock Division** | Pong P. Chu, Ch. 13 | 26-bit counter producing ~1.49 Hz from 100 MHz. No PLL/MMCM — pure RTL divider for simplicity. |
| **Asynchronous Reset** | IEEE 1076-2008, Section 10.2; Ashenden, Ch. 5 | Active-low async reset on all registers using `if reset = '0'` before `elsif rising_edge(...)`. |
| **Testbench Design** | Ashenden, Ch. 16; Pong P. Chu, Ch. 2 | Stimulus process with reset phase, two test patterns (`0xAB`, `0xCC`), and `wait until busy = '0'` synchronisation. |
| **XDC Pin Constraints** | UG903; Nexys 4 DDR Reference Manual | Mapping VHDL port signals to physical FPGA pins with appropriate IOSTANDARD (LVCMOS33). |
| **Timing Closure** | UG906 | Verifying WNS (+7.355 ns), TNS (0 ns), and zero failing endpoints post-implementation. |

---

## Documentation Tools

| Tool | Purpose |
|---|---|
| **LaTeX** (pdfLaTeX) | Full project report (`main.tex`) with professional formatting, code listings, tables, and figures. |
| **`listings` package** | Syntax-highlighted VHDL and XDC code listings in the LaTeX report. |
| **`hyperref` package** | Clickable cross-references and URLs in the PDF report. |

---

## Quick Reference Links

- [Nexys 4 DDR Reference Manual](https://reference.digilentinc.com/nexys4-ddr)
- [Artix-7 Data Sheet (DS180)](https://www.xilinx.com/support/documentation/data_sheets/ds180_7Series_Overview.pdf)
- [Vivado Constraints Guide (UG903)](https://docs.amd.com/r/en-US/ug903-vivado-using-constraints)
- [Vivado Synthesis Guide (UG901)](https://docs.amd.com/r/en-US/ug901-vivado-synthesis)
- [VHDL IEEE 1076-2008](https://standards.ieee.org/standard/1076-2008.html)
- [Nexys 4 DDR Product Page (Digilent)](https://digilent.com/shop/nexys-4-ddr-artix-7-fpga-trainer-board-recommended-for-ece-curriculum/)
- [Vivado Download (AMD/Xilinx)](https://www.xilinx.com/support/download.html)

---

> **Note:** All IP logic (clock divider, shift register) was implemented manually in VHDL. No third-party IP cores, external libraries, or generated code was used in this project.

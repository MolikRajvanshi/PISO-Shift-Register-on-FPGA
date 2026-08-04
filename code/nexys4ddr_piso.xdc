## =========================================================
## 100 MHz Onboard Clock
## =========================================================
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk -period 10.000 -waveform {0 5} [get_ports clk]

## =========================================================
## SWITCHES (Parallel Input - 8 bit)  SW0-SW7
## =========================================================
set_property -dict { PACKAGE_PIN J15 IOSTANDARD LVCMOS33 } [get_ports {parallel_in[0]}]
set_property -dict { PACKAGE_PIN L16 IOSTANDARD LVCMOS33 } [get_ports {parallel_in[1]}]
set_property -dict { PACKAGE_PIN M13 IOSTANDARD LVCMOS33 } [get_ports {parallel_in[2]}]
set_property -dict { PACKAGE_PIN R15 IOSTANDARD LVCMOS33 } [get_ports {parallel_in[3]}]
set_property -dict { PACKAGE_PIN R17 IOSTANDARD LVCMOS33 } [get_ports {parallel_in[4]}]
set_property -dict { PACKAGE_PIN T18 IOSTANDARD LVCMOS33 } [get_ports {parallel_in[5]}]
set_property -dict { PACKAGE_PIN U18 IOSTANDARD LVCMOS33 } [get_ports {parallel_in[6]}]
set_property -dict { PACKAGE_PIN R13 IOSTANDARD LVCMOS33 } [get_ports {parallel_in[7]}]

## =========================================================
## BUTTONS
## =========================================================
## CPU_RESETN (ACTIVE LOW RESET)
set_property -dict { PACKAGE_PIN C12 IOSTANDARD LVCMOS33 } [get_ports reset]
## Center Button (Load Trigger)
set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports load]

## =========================================================
## LEDs
## =========================================================
## LED0 -> Serial Output
set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [get_ports serial_out]
## LED1 -> Busy Signal
set_property -dict { PACKAGE_PIN K15 IOSTANDARD LVCMOS33 } [get_ports busy]

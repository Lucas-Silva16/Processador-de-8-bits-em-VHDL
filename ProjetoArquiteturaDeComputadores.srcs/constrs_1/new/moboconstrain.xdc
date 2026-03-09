set_property PACKAGE_PIN E3 [get_ports CLK]
set_property IOSTANDARD LVCMOS33 [get_ports CLK]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} [get_ports CLK]

#Reset
set_property PACKAGE_PIN N17 [get_ports RESET]
set_property IOSTANDARD LVCMOS33 [get_ports RESET]

#PIN - Entradas (Botões)
set_property PACKAGE_PIN J15 [get_ports {PIN[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {PIN[0]}]

set_property PACKAGE_PIN L16 [get_ports {PIN[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {PIN[1]}]

set_property PACKAGE_PIN M13 [get_ports {PIN[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {PIN[2]}]

set_property PACKAGE_PIN R15 [get_ports {PIN[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {PIN[3]}]

set_property PACKAGE_PIN R17 [get_ports {PIN[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {PIN[4]}]

set_property PACKAGE_PIN T18 [get_ports {PIN[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {PIN[5]}]

set_property PACKAGE_PIN U18 [get_ports {PIN[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {PIN[6]}]

set_property PACKAGE_PIN R13 [get_ports {PIN[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {PIN[7]}]

#POUT - Saídas (LEDs)
set_property PACKAGE_PIN H17 [get_ports {POUT[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {POUT[0]}]

set_property PACKAGE_PIN K15 [get_ports {POUT[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {POUT[1]}]

set_property PACKAGE_PIN J13 [get_ports {POUT[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {POUT[2]}]

set_property PACKAGE_PIN N14 [get_ports {POUT[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {POUT[3]}]

set_property PACKAGE_PIN R18 [get_ports {POUT[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {POUT[4]}]
set_property PACKAGE_PIN V17 [get_ports {POUT[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {POUT[5]}]

set_property PACKAGE_PIN U17 [get_ports {POUT[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {POUT[6]}]


set_property PACKAGE_PIN U16 [get_ports {POUT[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {POUT[7]}]
#RTL Design and UVM Verification of an Address-Based Switch

This project implements a 1-to-2 address-based switch using Verilog RTL and verifies the design using a UVM-based verification environment.

The switch receives an address and data transaction and routes it to one of two output channels based on a configurable address boundary.

Addresses 0 to ADDR_DIV → Output A
Addresses greater than ADDR_DIV → Output B
vld = 0 or rst = 1 → Outputs are cleared

The default address division is ADDR_DIV = 100.

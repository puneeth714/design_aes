# Crete make file to run verilog file in iverilog simulator
# Makefile

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog
VERILOG_SOURCES += $(PWD)/../../src/subBytes/s_box.v

WAVES ?= 1
# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = galois_inverse_2
# MODULE is the basename of the Python test file

# PWD=$(shell pwd)/src
MODULE = subBytes_s_box_galoise_inverse

# COMPILE_ARGS+=-Pshift_register.WIDTH=8
# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim

clean::
	rm -r  __pycache__ results.xml
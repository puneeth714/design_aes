#!/usr/bin/env python

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer
from utils.galois_field_math import rijndael_inverse


@cocotb.test()
async def subBytes_s_box_galoise_inverse_tb(dut):
    # the dut has single input in and output out
    for i in range(1, 256):
        dut.inp.value = i
        await Timer(100, units='ns')
        value = rijndael_inverse(i)
        #print(f"input={hex(i)} output={dut.out.value} it is going to be ")
        assert hex(dut.out.value) == hex(value), f"Not equal at {hex(value)} and {hex(dut.out.value)}"
        # await for the output to change from xx to the value
        print(f"input={hex(i)} output={dut.out.value} it is going to be {hex(value)}")


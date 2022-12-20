#!/usr/bin/env python

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer
from utils.galois_field_math import galois_multiplication

@cocotb.test()
async def subBytes_s_box_galoise_multiplication_tb(dut):
    # dut has a and b as inputs and c as output
    for i in range(1,255):
        dut.a.value=i
        for j in range(1,255):
            dut.b.value=j
            await Timer(10,units='ns')
            print(f"a={hex(i)} b={hex(j)}, output={str(dut.c.value)}")
            # print(type(dut.c.value))
            val = galois_multiplication(i, j)
            assert str(dut.c.value) == val, f"Not equal at {val}" 

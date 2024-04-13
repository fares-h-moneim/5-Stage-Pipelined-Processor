vsim -gui work.processor
add wave sim:/processor/*
add wave -position 56  sim:/processor/FetchBlock1/clk
add wave -position 57  sim:/processor/FetchBlock1/rst
add wave -position 58  sim:/processor/FetchBlock1/instruction
add wave -position 59  sim:/processor/FetchBlock1/immediate
add wave -position 60  sim:/processor/FetchBlock1/PC_OUT
add wave -position 61  sim:/processor/FetchBlock1/PC_IN
add wave -position 62  sim:/processor/FetchBlock1/internal_instruction
add wave -position 63  sim:/processor/FetchBlock1/IncrementTwo
add wave -position 64  sim:/processor/FetchBlock1/internal_PC
force -freeze sim:/processor/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/Rst 1 0
mem load -filltype value -filldata {0001000000100010 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(0)
mem load -filltype value -filldata 00000000000000000000000000000000 -fillradix symbolic /processor/Registers/ram(0)
mem load -filltype value -filldata 00000000000000000000000000000001 -fillradix symbolic /processor/Registers/ram(1)



mem load -filltype value -filldata 1100000000000000 -fillradix symbolic /processor/FetchBlock1/IM1/mem(1)
mem load -filltype value -filldata 1100000000000000 -fillradix symbolic /processor/FetchBlock1/IM1/mem(3)
mem load -filltype value -filldata 0001000000100010 -fillradix symbolic /processor/FetchBlock1/IM1/mem(2)
mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(0)
force -freeze sim:/processor/Rst 0 0
mem load -filltype value -filldata 11111111111111111111111111111111 -fillradix symbolic /processor/Registers/ram(0)
force -freeze sim:/processor/Rst 1 0
mem load -filltype value -filldata {11111111111111111111111111111110 } -fillradix symbolic /processor/Registers/ram(0)
force -freeze sim:/processor/Rst 1 0
run

force -freeze sim:/processor/Rst 0 0
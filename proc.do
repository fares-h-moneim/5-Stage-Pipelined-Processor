vsim -gui work.processor
mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(0)
mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(1)
mem load -filltype value -filldata {0001000000100010 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(2)
mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(3)
mem load -filltype value -filldata {1100000000000000  } -fillradix symbolic /processor/FetchBlock1/IM1/mem(4)
add wave sim:/processor/*
force -freeze sim:/processor/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/Rst 1 0
run
run
force -freeze sim:/processor/Rst 0 0
mem load -filltype value -filldata 00000000000000000000000000000101 -fillradix symbolic /processor/Registers/ram(0)
mem load -filltype value -filldata 00000000000000000000000000000110 -fillradix symbolic /processor/Registers/ram(1)
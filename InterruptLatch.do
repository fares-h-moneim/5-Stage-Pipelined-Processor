vsim -gui work.interruptlatch

add wave sim:/interruptlatch/*
add wave -position end sim:/interruptlatch/line__16/*

force -freeze sim:/interruptlatch/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/interruptlatch/rst 1 0
run
force -freeze sim:/interruptlatch/rst 0 0
force -freeze sim:/interruptlatch/instruction 0000000000000000 0
run
force -freeze sim:/interruptlatch/instruction 1000110000000000 0
run
force -freeze sim:/interruptlatch/instruction 1100110000000000 0
force -freeze sim:/interruptlatch/interrupt 1 0
run
force -freeze sim:/interruptlatch/interrupt 0 0
force -freeze sim:/interruptlatch/instruction 0000000000000001 0
run
force -freeze sim:/interruptlatch/instruction 0000000000000001 0
run
force -freeze sim:/interruptlatch/instruction 0000000000000001 0
run
force -freeze sim:/interruptlatch/instruction 0000000000000001 0
run
force -freeze sim:/interruptlatch/instruction 0000000000000001 0
run
force -freeze sim:/interruptlatch/instruction 0000000000000001 0
run
force -freeze sim:/interruptlatch/instruction 0000000000000001 0
run
force -freeze sim:/interruptlatch/instruction 0000000000000001 0
run
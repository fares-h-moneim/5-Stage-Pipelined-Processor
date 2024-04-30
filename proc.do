vsim -gui work.processor
do binaryCommands.do

add wave sim:/processor/Clk
add wave sim:/processor/Rst
add wave sim:/processor/FetchBlock1/PC_OUT
add wave sim:/processor/execute_zero_out
add wave sim:/processor/execute_negative_out
add wave sim:/processor/execute_overflow_out
add wave sim:/processor/execute_carry_out
add wave sim:/processor/DecodeBlock1/RegisterFile1/ram
add wave sim:/processor/InPort
add wave sim:/processor/OutPort

force -freeze sim:/processor/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/Rst 1 0
force -freeze sim:/processor/InPort x\"0\" 0
force -freeze sim:/processor/OutPort x\"0\" 0
run
force -freeze sim:/processor/Rst 0 0
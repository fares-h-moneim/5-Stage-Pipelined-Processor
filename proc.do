vsim -gui work.processor
do binaryCommands.do

add wave sim:/processor/ForwardingUnit1/*
add wave sim:/processor/ExecuteBlock1/AluIn1
add wave sim:/processor/ExecuteBlock1/AluIn2
add wave sim:/processor/*

force -freeze sim:/processor/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/Rst 1 0
force -freeze sim:/processor/InPort x\"0\" 0
force -freeze sim:/processor/OutPort x\"0\" 0
run
force -freeze sim:/processor/Rst 0 0
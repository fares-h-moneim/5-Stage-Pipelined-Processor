vsim -gui work.processor
do binaryCommands.do

add wave -position 24 sim:/processor/DataMemory1/ProtectedMemory1/*
add wave sim:/processor/ForwardingUnit1/*
add wave sim:/processor/ExecuteBlock1/AluIn1
add wave sim:/processor/ExecuteBlock1/AluIn2
add wave sim:/processor/*

force -freeze sim:/processor/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/Rst 1 0
force -freeze sim:/processor/InPort x\"0\" 0
run


force -freeze sim:/processor/Rst 0 0
force -freeze sim:/processor/InPort x\"19\" 0
run
force -freeze sim:/processor/InPort x\"FFFFFFFF\" 0
run
force -freeze sim:/processor/InPort x\"FFFFF320\" 0
run
run
run
run
run
run
run
run
force -freeze sim:/processor/InPort x\"10\" 0
run
run
run
run
run
run
run
run
run
run
force -freeze sim:/processor/InPort x\"10\" 0
run
force -freeze sim:/processor/InPort x\"19\" 0
run
run
run
run
run
run
run
run
force -freeze sim:/processor/InPort x\"211\" 0
run
run
run
run
run
run
run
run
force -freeze sim:/processor/InPort x\"100\" 0
run
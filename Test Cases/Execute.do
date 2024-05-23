vsim -gui work.execute
add wave sim:/execute/*
force -freeze sim:/execute/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/execute/reset 1 0
force -freeze sim:/execute/reset 0 0
force -freeze sim:/execute/AluSrc 0 0
force -freeze sim:/execute/ReadData1 x\"1524\" 0
force -freeze sim:/execute/ReadData2 x\"5687\" 0
force -freeze sim:/execute/Immediate x\"6584\" 0
force -freeze sim:/execute/AluSelector 0000 0
run
force -freeze sim:/execute/AluSelector 0001 0
run
force -freeze sim:/execute/AluSelector 0010 0
run
force -freeze sim:/execute/AluSelector 0011 0
run
force -freeze sim:/execute/AluSelector 0100 0
run
force -freeze sim:/execute/AluSelector 0101 0
run
force -freeze sim:/execute/ReadData2 x\"1524\" 0
run
force -freeze sim:/execute/ReadData2 x\"1487\" 0
force -freeze sim:/execute/AluSelector 0110 0
run
force -freeze sim:/execute/AluSelector 0111 0
run
force -freeze sim:/execute/AluSelector 1000 0
force -freeze sim:/execute/AluSelector 1000 0
run

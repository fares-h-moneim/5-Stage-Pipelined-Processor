vsim -gui work.alu
add wave sim:/alu/*
force -freeze sim:/alu/A x\"1\" 0
force -freeze sim:/alu/B x\"1\" 0
force -freeze sim:/alu/Sel 0000 0
run
force -freeze sim:/alu/Sel 0001 0
run
force -freeze sim:/alu/Sel 0010 0
run
force -freeze sim:/alu/Sel 0011 0
run
force -freeze sim:/alu/Sel 0100 0
run
force -freeze sim:/alu/Sel 0101 0
run
force -freeze sim:/alu/Sel 0110 0
run
force -freeze sim:/alu/Sel 0111 0
run
force -freeze sim:/alu/Sel 1000 0
run
force -freeze sim:/alu/Sel 1001 0
run
add wave -position end  sim:/control/Opcode
add wave -position end  sim:/control/AluSelector
add wave -position end  sim:/control/AluSrc
add wave -position end  sim:/control/MemWrite
add wave -position end  sim:/control/MemRead
add wave -position end  sim:/control/MemToReg
add wave -position end  sim:/control/RegWrite
add wave -position end  sim:/control/SpPointers
add wave -position end  sim:/control/ProtectWrite
add wave -position end  sim:/control/Branching
force -freeze sim:/control/Opcode 000000 0
run
force -freeze sim:/control/Opcode 000001 0
run
force -freeze sim:/control/Opcode 000010 0
run
force -freeze sim:/control/Opcode 000011 0
run
force -freeze sim:/control/Opcode 000100 0
run
force -freeze sim:/control/Opcode 000101 0
run
force -freeze sim:/control/Opcode 000110 0
run
force -freeze sim:/control/Opcode 000111 0
run
force -freeze sim:/control/Opcode 001000 0
run
force -freeze sim:/control/Opcode 001001 0
run
force -freeze sim:/control/Opcode 001010 0
run
force -freeze sim:/control/Opcode 001011 0
run
force -freeze sim:/control/Opcode 001100 0
run
force -freeze sim:/control/Opcode 001101 0
run
force -freeze sim:/control/Opcode 010010 0
run
force -freeze sim:/control/Opcode 010011 0
run
force -freeze sim:/control/Opcode 010100 0
run
force -freeze sim:/control/Opcode 010101 0
run
force -freeze sim:/control/Opcode 010110 0
run
force -freeze sim:/control/Opcode 010111 0
run
force -freeze sim:/control/Opcode 011000 0
run
force -freeze sim:/control/Opcode 100000 0
run
force -freeze sim:/control/Opcode 100001 0
run
force -freeze sim:/control/Opcode 100010 0
run
force -freeze sim:/control/Opcode 100011 0
run
force -freeze sim:/control/Opcode 100100 0
run
force -freeze sim:/control/Opcode 110000 0
run
force -freeze sim:/control/Opcode 110001 0
run
force -freeze sim:/control/Opcode 110010 0
run
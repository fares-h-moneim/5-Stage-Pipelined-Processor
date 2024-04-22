vsim -gui work.processor

# LDM R0, 1
mem load -filltype value -filldata {0100100000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(0)
mem load -filltype value -filldata {0000000000000001 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(1)

# LDM R1, AAAA
mem load -filltype value -filldata {0100100000010000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(2)
mem load -filltype value -filldata {1010101010101010 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(3)

# LDM R2, FFFF
mem load -filltype value -filldata {0100100000100000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(4)
mem load -filltype value -filldata {1111111111111111 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(5)

# DEC R0
mem load -filltype value -filldata {0000110000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(6)

# MOV R4, R1
mem load -filltype value -filldata {0010010011000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(7)

# NOT R1
mem load -filltype value -filldata {0000000010010000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(8)

# MOV R3, R0
mem load -filltype value -filldata {0010010000110000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(9)

# DEC R0
mem load -filltype value -filldata {0000110000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(10)

# CMP R4, R2
mem load -filltype value -filldata {0010111000000100 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(11)

# OR R5, R1, R4
mem load -filltype value -filldata {0001100011011000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(12)

# MOV R6, R0
mem load -filltype value -filldata {0010010001100000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(13)

# CMP R2, R4
mem load -filltype value -filldata {0010110100001000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(14)

# CMP R5, R0
mem load -filltype value -filldata {0010111010000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(15)

# OR R7, R4, R3
mem load -filltype value -filldata {0001101001110110 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(16)

# NOT R6
mem load -filltype value -filldata {0000001101100000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(17)

# DEC R0
mem load -filltype value -filldata {0000110000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(18)


add wave sim:/processor/*
force -freeze sim:/processor/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/Rst 1 0
run
force -freeze sim:/processor/Rst 0 0
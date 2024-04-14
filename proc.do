vsim -gui work.processor
mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(0)
mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(1)

# LDM R0, 1
mem load -filltype value -filldata {0100100000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(2)
mem load -filltype value -filldata {0000000000000001 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(3)

mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(4)
mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(5)

# LDM R1, AAAA
mem load -filltype value -filldata {0100100000010000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(6)
mem load -filltype value -filldata {1010101010101010 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(7)

mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(8)
mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(9)

# LDM R2, FFFF
mem load -filltype value -filldata {0100100000100000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(10)
mem load -filltype value -filldata {1111111111111111 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(11)

mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(12)
mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(13)

# DEC R0
mem load -filltype value -filldata {0000110000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(14)

mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(15)
mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(16)

# MOV R4, R1
mem load -filltype value -filldata {0010010011000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(17)

mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(18)
mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(19)

# NOT R1
mem load -filltype value -filldata {0000000010010000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(20)

mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(21)
mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(22)

# MOV R3, R0
mem load -filltype value -filldata {0010010000110000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(23)

mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(24)
mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(25)

# DEC R0
mem load -filltype value -filldata {0000110000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(26)

mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(27)
mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(28)

# CMP R4, R2
mem load -filltype value -filldata {0010111000000100 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(29)

mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(30)
mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(31)

# OR R5, R1, R4
mem load -filltype value -filldata {0001100011011000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(32)

mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(33)
mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(34)

# MOV R6, R0
mem load -filltype value -filldata {0010010001100000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(35)

mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(36)
mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(37)

# CMP R2, R4
mem load -filltype value -filldata {0010110100001000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(38)

mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(39)
mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(40)

# CMP R5, R0
mem load -filltype value -filldata {0010111010000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(38)

mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(39)
mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(40)

# OR R7, R4, R3
mem load -filltype value -filldata {0001101001110110 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(41)

mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(42)
mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(43)

# NOT R6
mem load -filltype value -filldata {0000001101100000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(44)

mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(45)
mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(46)

# DEC R0
mem load -filltype value -filldata {0000110000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(47)

mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(48)
mem load -filltype value -filldata {1100000000000000 } -fillradix symbolic /processor/FetchBlock1/IM1/mem(49)


add wave sim:/processor/*
force -freeze sim:/processor/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/Rst 1 0
run
force -freeze sim:/processor/Rst 0 0
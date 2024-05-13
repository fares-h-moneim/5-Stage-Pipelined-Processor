ThreeOperands = {
    "ADD",
    "SUB",
    "AND",
    "OR",
    "XOR",
}

Rd_Rd = {
    "NOT",
    "NEG",
    "INC",
    "DEC",
}

Rd = {
    "IN",
    "OUT",
}

Jumps = {
    "CALL",
    "JMP",
    "JZ",
}
noOperands = {"NOP", "INT", "RTI"}

commands = {
    "NOT": "000000",
    "NEG": "000001",
    "INC": "000010",
    "DEC": "000011",
    "ADD": "000100",
    "SUB": "000101",
    "OR": "000110",
    "XOR": "000111",
    "AND": "001000",
    "MOV": "001001",
    "SWAP": "001010",
    "CMP": "001011",
    "ADDI": "001100",
    "SUBI": "001101",
    "LDM": "010010",
    "LDD": "010011",
    "STD": "010100",
    "POP": "010101",
    "PUSH": "010110",
    "PROTECT": "010111",
    "FREE": "011000",
    "JZ": "100000",
    "JMP": "100001",
    "CALL": "100010",
    "RET": "100011",
    "NOP": "110000",
    "OUT": "110001",
    "IN": "110010",
    "INT": "110011",
    "RTI": "110100",
}

operands = {
    "R0": "000",
    "R1": "001",
    "R2": "010",
    "R3": "011",
    "R4": "100",
    "R5": "101",
    "R6": "110",
    "R7": "111",
}


hexaToBinary = {
    "0": "0000",
    "1": "0001",
    "2": "0010",
    "3": "0011",
    "4": "0100",
    "5": "0101",
    "6": "0110",
    "7": "0111",
    "8": "1000",
    "9": "1001",
    "A": "1010",
    "B": "1011",
    "C": "1100",
    "D": "1101",
    "E": "1110",
    "F": "1111",
}


def hex_to_binary(hex_string):
    binary_result = ""
    while len(hex_string) < 4:
        hex_string = "0" + hex_string
    for char in hex_string.upper():
        if char in hexaToBinary:
            binary_result += hexaToBinary[char]
        else:
            raise ValueError("Invalid hexadecimal character detected")
    return binary_result


file2 = open("binaryCommands.do", "w")
file2.write("")
file2.close()
file2 = open("binaryCommands.do", "a")


def check_org(instruction):
    global org
    global file2
    file2.write(
        f"mem load -filltype value -filldata {{0000000000000000}} -fillradix symbolic /processor/FetchBlock1/IM1/mem({org})\n"
    )
    org += 1
    file2.write(
        f"mem load -filltype value -filldata {{{hex_to_binary(instruction)+' '}}} -fillradix symbolic /processor/FetchBlock1/IM1/mem({org})\n"
    )
    org += 1


def removeComments(Line):
    for char in Line:
        if char == "#":
            return Line[: Line.index(char)]
    return line


file1 = open("Commands.txt", "r")
Lines = file1.readlines()


instructions = []
editedInstructions = []


for line in Lines:
    line = line.strip()
    line = removeComments(line)

    if line == "":
        continue
    if line[0] == "#":
        continue

    instructions.append(line)

file1.close()
for instruction in instructions:
    instruction = instruction.replace(",", " ")
    instruction = instruction.split(" ")
    editedInstructions.append(instruction)

removedSpacesInstr = []
for instruction in editedInstructions:
    tempList = []
    for item in instruction:
        if item == "":
            continue
        item = item.upper()
        tempList.append(item)
    removedSpacesInstr.append(tempList)


org = 0
isImmidiate = False
isInstruction = False

for instruction in removedSpacesInstr:
    temp = ""

    if instruction[0] in noOperands:
        temp += commands[instruction[0]]
        temp += "0000000000"
        isInstruction = True

    elif instruction[0] in Rd:
        print(instruction)
        temp += commands[instruction[0]]
        temp += "000"
        temp += operands[instruction[1]]
        temp += "0000"
        isInstruction = True

    elif instruction[0] in Jumps:
        print(instruction)
        temp += commands[instruction[0]]
        temp += operands[instruction[1]]
        temp += "0000000"
        isInstruction = True

    elif instruction[0] == "RET":
        print(instruction)
        temp += commands[instruction[0]]
        temp += "0000000000"
        isInstruction = True

    elif instruction[0] == "POP" or instruction[0] == "PUSH":
        print(instruction)
        temp += commands[instruction[0]]
        temp += "000000"
        temp += operands[instruction[1]]
        temp += "0"
        isInstruction = True

    elif instruction[0] == "PROTECT" or instruction[0] == "FREE":
        print(instruction)
        temp += commands[instruction[0]]
        temp += operands[instruction[1]]
        temp += "0000000"
        isInstruction = True

    elif instruction[0] in ThreeOperands:
        print(instruction)
        temp += commands[instruction[0]]  # op
        temp += operands[instruction[2]]  # s1
        temp += operands[instruction[1]]  # d
        temp += operands[instruction[3]]  # s2
        temp += "0"
        isInstruction = True

    elif instruction[0] in Rd_Rd:
        print(instruction)
        temp += commands[instruction[0]]  # op
        temp += operands[instruction[1]]  # d
        temp += operands[instruction[1]]  # d
        temp += "0000"
        isInstruction = True

    elif instruction[0] == "MOV":
        print("MOV")
        print(instruction)
        temp += commands[instruction[0]]  # op
        temp += operands[instruction[2]]  # d
        temp += operands[instruction[1]]  # d
        temp += "0000"
        isInstruction = True

    elif instruction[0] == "SWAP":
        print("SWAP")
        print(instruction)
        temp += commands[instruction[0]]  # op
        temp += operands[instruction[1]]  # d
        temp += operands[instruction[1]]  # d
        temp += operands[instruction[2]]  # d
        temp += "0"
        isInstruction = True

    elif instruction[0] == "CMP":
        print("CMP")
        print(instruction)
        temp += commands[instruction[0]]  # op
        temp += operands[instruction[1]]  # d
        temp += "000"
        temp += operands[instruction[2]]  # d
        temp += "0"
        print(temp)
        isInstruction = True

    elif instruction[0] == "ADDI" or instruction[0] == "SUBI":
        print("ADDI or SUBI")
        print(instruction)
        isImmidiate = True
        temp += commands[instruction[0]]
        temp += operands[instruction[2]]
        temp += operands[instruction[1]]
        temp += "0000"
        immediate = hex_to_binary(instruction[3])
        isInstruction = True

    elif instruction[0] == "LDM":
        print("LDM")
        print(instruction)
        isImmidiate = True
        temp += commands[instruction[0]]
        temp += "000"
        temp += operands[instruction[1]]
        temp += "0000"
        immediate = hex_to_binary(instruction[2])
        isInstruction = True

    elif instruction[0] == "LDD":
        print("LDD")
        new_lst = [item for sublist in instruction for item in sublist.split("(")]
        new_lst = [item.replace(")", "") for item in new_lst]
        instruction = new_lst
        print(instruction)
        isImmidiate = True
        temp += commands[instruction[0]]
        temp += operands[instruction[3]]
        temp += operands[instruction[1]]
        temp += "0000"
        immediate = hex_to_binary(instruction[2])
        isInstruction = True

    elif instruction[0] == "STD":
        print("STD")
        new_lst = [item for sublist in instruction for item in sublist.split("(")]
        new_lst = [item.replace(")", "") for item in new_lst]
        instruction = new_lst
        print(instruction)
        isImmidiate = True
        temp += commands[instruction[0]]
        temp += operands[instruction[3]]
        temp += "000"
        temp += operands[instruction[1]]
        temp += "0"
        immediate = hex_to_binary(instruction[2])
        isInstruction = True

    if instruction[0] == ".ORG":
        org = int(instruction[1], 16)
        continue
    elif instruction[0][0] in hexaToBinary and not isInstruction:
        check_org(instruction[0])
    else:
        file2.write(
            # f"mem load -filltype value -filldata {{{temp+' '}}} -fillradix binary /processor/fetchStagee/instructions/ram({org})\n"
            f"mem load -filltype value -filldata {{{temp+' '}}} -fillradix symbolic /processor/FetchBlock1/IM1/mem({org})\n"
        )
        org += 1
        if isImmidiate:
            file2.write(
                # f"mem load -filltype value -filldata {{{immediate+' '}}} -fillradix hexadecimal /processor/fetchStagee/instructions/ram({org})\n"
                f"mem load -filltype value -filldata {{{immediate+' '}}} -fillradix symbolic /processor/FetchBlock1/IM1/mem({org})\n"
            )
            org += 1
            isImmidiate = False
    isInstruction = False

file2.close()

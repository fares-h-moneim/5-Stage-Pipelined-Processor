# 5 Stage Harvard Architecture Pipelined Processor
<div align="center">
    <img src="https://cdn.dribbble.com/users/1366606/screenshots/8075231/media/e971c24ffcfc453ec6c21accb4acbec8.gif" width="300" />
</div>

## Architecture
Note: Click the image for higher quality (Click open with draw.io to interact and zoom)

<a href="https://drive.google.com/file/d/1gNEX3eCRZ3R11BlOIeyV_1dLyXfIoX4l/view" target="_blank">![Diagram](./Diagram.drawio.svg)</a>

## Instruction Set Architecture

### 👨‍💻 Instructions

- NOP (No operation)
- ALU
    - One Operand
        1. **NOT** Rdst
        2. **NEG** Rdst
        3. **INC** Rdst
        4. **DEC** Rdst
    - Two Operands
        1. **ADD** Rdst, Rsrc1, Rsrc2 
        2. **SUB** Rdst, Rsrc1, Rsrc2
        3. **AND** Rdst, Rsrc1, Rsrc2
        4. **OR** Rdst, Rsrc1, Rsrc2
        5. **XOR** Rdst, Rsrc1, Rsrc2 
        6. **CMP** Rsrc1, Rsrc2
        7. **SWAP** Rdst, Rsrc
        8. **MOV** Rdst, Rsrc
- Immediate
    1. **ADDI** Rdst, Rsrc1, Imm
    2. **SUBI** Rdst, Rsrc1, Imm
    3. **LDM** Rdst, Imm
- Conditional JMP
    1. **JZ** Rdst
- Unconditional JMP
    1. **JMP** Rdst
    2. **CALL** Rdst
    3. **RET** Rdst
    4. **RTI** Rdst
- DATA Operations
    1. **IN** Rdst 
    2. **OUT** Rdst
    3. **PUSH** Rdst
    4. **POP** Rdst
    5. **LDD** Rdst, EA(Rsrc1)
    6. **STD** Rdst, EA(Rsrc1)
- Memory Security (FREE/PROTECT)
    1. **FREE** Rsrc
    2. **PROTECT** Rsrc
- Input Signals (RESET/INT)
    1. **Reset**
    2. **Interrupt**
<hr>

### 📄 Instructions Bit Details

| No | Base Code | Type | Instruction | Subcode |
|----|-----------|------|-------------|---------|
| 1  |     00    | R-Type | NOT  | 0000 |
| 2  |     00    | R-Type | NEG  | 0001 |
| 3  |     00    | R-Type | INC  | 0010 |
| 4  |     00    | R-Type | DEC  | 0011 |
| 5  |     00    | R-Type | ADD  | 0100 |
| 6  |     00    | R-Type | SUB  | 0101 |
| 7  |     00    | R-Type | OR   | 0110 |
| 8  |     00    | R-Type | XOR  | 0111 |
| 9  |     00    | R-Type | AND  | 1000 |
| 10 |     00    | R-Type | MOV  | 1001 |
| 11 |     00    | R-Type | SWAP | 1010 |
| 12 |     00    | R-Type | CMP  | 1011 |
| 13 |     00    | R-Type | ADDI | 1100 |
| 14 |     00    | R-Type | SUBI | 1101 |
|  					   	                |
| 15 |     01    | I-Type | LDM  | 0000 |
| 16 |     01    | I-Type | LDD  | 0001 |
| 17 |     01    | I-Type | STD  | 0010 |
| 18 |     01    | I-Type | POP  | 0011 |
| 19 |     01    | I-Type | PUSH | 0100 |
| 20 |     01    | I-Type |PROTECT| 0101 |
| 21 |     01    | I-Type | FREE  | 0110 |
|  					   	                |
| 22 |     10    | J-Type | JZ   | 0000 |
| 23 |     10    | J-Type | JMP  | 0001 |
| 24 |     10    | J-Type | CALL | 0010 |
| 25 |     10    | J-Type | RET  | 0011 |
|  					   	                |
| 26 |     11    | Special| NOP  | 0000 |
| 27 |     11    | Special| OUT  | 0001 |
| 28 |     11    | Special| IN   | 0010 |
| 29 |     11    | Special| INT  | 0011 |
| 30 |     11    | Special| RTI  | 0100 |

<hr>

### Project Document: [Project CMP301 Spring24.pdf](https://drive.google.com/file/d/17U7R_q8giNUnOumMk2kJQas2t6kr-Ozq/view?usp=sharing)

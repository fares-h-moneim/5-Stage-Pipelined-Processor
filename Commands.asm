.org 0
10

.org 2
900

.org 900
IN R7
AND R0, R0, R0
OUT R3
RTI
ADD R1, R2, R3

.org 10
IN R1
IN R2
IN R3
IN R4
Push R4
JMP R1
INC R1

.org 30
AND R5, R1, R5
JZ R2
IN R3

.org 50
JZ R1
NOT R5
CMP R5,R5
IN R1
JZ R1
ADD R1, R2, R3

.org 60
IN R1
JZ R1
JMP R1
INC R1

.ORG 70
ADDI R1, R1, 10 #R1=80
CMP R1, R1      # Z=1, N=0
PUSH R1         # SP=FFB, M[FFC]=80
POP R1          # SP=FFD, R1=80
JZ R1           # Taken
INC R1 

.ORG 80
#check destination forwarding
IN  R6           #R6=700, flag no change
JMP R6           #jump taken

#check on load use
.ORG 700
ADD R7, R0, R1             #R7=80
POP R6           #R6=300, SP=FFF, try hardware interrupt here
Call R6         #SP=FFD, M[FFF, FFE]=next PC
INC R6         #R6=401, this statement shouldn't be executed till call returns, C--> 0, N-->0,Z-->0
NOP
NOP

.ORG 300
ADD R6,R3,R6     #R6=400
ADD R1,R1,R2     #R1=D0, C->0,N=0, Z=0
RET
ADD R1, R1, R1   #this shouldnot be executed - try hardware interrupt when this is at fetch

.ORG 500
NOP
NOP

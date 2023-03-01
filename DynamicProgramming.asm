myData		SEGMENT PARA 'data'
    n			DW 500
    RES         DB 500 DUP ('$')	
	ARR		    DW 500 DUP('$')
myData		ENDS

myStack		SEGMENT PARA STACK 'stack'
			DW 500 DUP(?)
myStack		ENDS

myCode2     SEGMENT PARA 'code2'
            ASSUME CS:myCode2 , DS:myData , SS:myStack

DNUM		PROC FAR
			PUSH CX
			PUSH BX
			PUSH DI			
			PUSH BP
			PUSH AX
			
			MOV BP,SP
			MOV CX,[BP+14]
			SUB CX,3
			
			XOR SI,SI
			MOV ARR[SI],0
			ADD SI,2
			MOV ARR[SI],1
			ADD SI,2
			MOV ARR[SI],1

L1:		ADD SI,2
			MOV BX,SI
			SUB BX,2
			MOV AX,ARR[BX]
			MOV BX,AX
			SAL BX,1
			MOV AX,ARR[BX]
			MOV ARR[SI],AX
			
			MOV DI,SI
			SUB DI,4
			MOV BX,ARR[DI]
			MOV DI,SI
			SAR DI,1
			DEC DI
			SUB DI,BX
			SAL DI,1
			MOV AX,ARR[DI]
			ADD ARR[SI],AX
			MOV AX,ARR[SI]
			LOOP L1
			
			MOV [BP+14],AX
			
			POP AX
			POP BP
			POP DI
			POP BX
			POP CX
			RET
	
DNUM 		ENDP
myCode2 	ENDS

  


myCode		SEGMENT PARA 'code'
			ASSUME CS:myCode, SS:myStack, DS:myData
			
PRINTINT	PROC NEAR
			
			MOV BP, SP
			MOV AX, [BP+2]
			LEA SI, RES		
			MOV CX, 0
			MOV BX, 10

L2: 		MOV DX,0
			DIV BX
			ADD DL,30H
			PUSH DX
			INC CX
			CMP AX,9
			JG L2
     
			ADD AL,30H
			MOV [SI],AL
     
L3: 		POP AX
			INC SI
			MOV [SI],AL
			LOOP L3
			
			LEA DX,RES
			MOV AH,9
			INT 21H
            
			MOV AH,4CH
			INT 21H 
			
			RET 2
PRINTINT	ENDP

MAIN			PROC FAR

			PUSH DS
			XOR AX,AX
			PUSH AX
			MOV AX,myData
			MOV DS,AX			
			
			
			PUSH n
			CALL DNUM
			CALL PRINTINT
			
			
			RETF
MAIN		ENDP
myCode		ENDS
			END MAIN
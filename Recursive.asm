myData		SEGMENT PARA 'data'
    n			DW 10
    RES         DB 10 DUP ('$')	
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
			MOV DI,[BP+14]
			MOV AX,DI
			
			CMP AX,3
			JB LABEL1
			
			DEC AX
			PUSH AX
			CALL DNUM
			CALL DNUM
			POP BX	
			MOV CX,DI
			SUB CX,2
			PUSH CX
			CALL DNUM
			POP CX
			SUB AX,CX
			PUSH AX
			CALL DNUM
			POP AX
			ADD AX,BX	
			MOV [BP+14],AX	
			JMP RETURN

LABEL1:		CMP AX,0
			JA LABEL2
			MOV AX,0
			MOV [BP+14],AX
			JMP RETURN

LABEL2:		MOV AX,1
			MOV [BP+14],AX
			JMP RETURN

RETURN:		POP AX
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

MAIN		PROC FAR

			PUSH DS
			XOR AX,AX
			PUSH AX
			MOV AX,datam
			MOV DS,AX			
			
			
			PUSH n
			CALL DNUM
			CALL PRINTINT
			
			
			RETF
MAIN		ENDP
myCode		ENDS
			END MAIN
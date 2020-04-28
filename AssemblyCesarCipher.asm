TITLE PGM_1: CASE CONVERSTION PROGRAM

.MODEL SMALL
.STACK 100H
.DATA

CR EQU 0DH
LF EQU 0AH

MSG1 DB 'ENTER A LOWER CASE LETTER $'
MSG2 DB 0DH,0AH, 'IN UPPER CASE ITS IS: '
CHAR DB ?,'$'

.CODE

MAIN PROC
    ;INITALIZE DS
    MOV AX, @DATA       ;get data segment
    MOV DS,AX           ;initailize DS

    MOV AH,1            ;read character function
    INT 21H             ;read a small letter into AL
    MOV AL,BL
    SUB BL,30h
    
    go:
    ;print user prompt
    LEA DX,MSG1         ;get first message
    MOV AH,9            ;display sting function
    INT 21H            ;display first message 




    ;input a char and cover to upper case
    MOV AH,1            ;read character function
    INT 21H             ;read a small letter into AL
    add AL, BL         ;convert it to upper case
    MOV CHAR, AL        ;and store it

    ;display on the next line
    LEA DX,MSG2         ;get second message
    MOV AH,9            ;display message and uppercase
    INT 21H             ;letter in front
    MOV dl, 10

    ;yeni satir
    MOV ah, 02h
    INT 21h
    MOV dl, 13
    MOV ah, 02h
    INT 21h

    jmp go



    ;DOS EXIT
    MOV AH,4CH
    INT 21H             ;dos exit

MAIN ENDP
    END MAIN
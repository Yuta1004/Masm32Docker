        .686
        .model flat, c
        .stack 100h

printf  PROTO arg1:Ptr Byte, printlist:VARARG
scanf   PROTO arg2:Ptr Byte, inputlist:VARARG

        .data
in1fmt  byte "%d",0
msg0fmt byte 0Ah,"%s",0
msg1fmt byte 0Ah,"%s%d",0Ah,0Ah,0
msg0    byte "Enter an integer: ",0
msg1    byte "The integer is: ",0
number  sdword ?

        .code
main    proc
        INVOKE printf, ADDR msg0fmt, ADDR msg0
        INVOKE scanf, ADDR in1fmt, ADDR number
        INVOKE printf, ADDR msg1fmt, ADDR msg1, number
        mov eax, 0
        ret
main    endp
        end

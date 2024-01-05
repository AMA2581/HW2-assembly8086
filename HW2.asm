
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.data 
    array dw 10 dup(?) 
    size dw 10
    sum dw 0   
    ten dw 10
    msg1 db "Enter 10 Number: $" 
    
    
    
.code
    main proc
        mov ax , @data
        mov ds , ax
        call input_array
        ret
        main endp
    
    input_array proc
        mov ah , 9
        mov dx , offset msg1
        int 21h
        lea bx ,array
        mov cx , size
        push bx 
        mov dx, 0
        mov dl, 1  
        mov bx , 0
                 
        ; This is a loop for getting an numbers from input
        input_loop:
            mov ah, 1
            int 21h
            cmp al, ' '
            je proc_num
            sub al, '0'
            inc bl
            mov ah, 0
            push ax
            jmp input_loop
            
            ; Processsing the numbers so we can add them to the array
            ; The final number will be in DH
            proc_num:  
                cmp bl, 0
                je next_num
                pop ax
                mul dl
                add dh, al
                mov al, dl
                push dx
                mul ten 
                pop dx
                mov dl, al 
                dec bl
                jmp proc_num 
            
            ; Getting ready for the next number of the array
            ; Storing the DH into memory that BX points at       
            next_num:  
                pop bx
                mov [bx], dh
                add bx, 2
                push bx
                mov dx, 0
                mov dl, 1 
                mov bx, 0
                
                loop input_loop            
        ret
        input_array endp

ret





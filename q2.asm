;Question 2: Assembly Array Calculation.


section .data
    ;declare four unsigned integer values in an array
    numbers dd 8, 16, 24, 32

section .text
    global _main

_main:
    ;load the second element of the array into EAX
    mov eax, [numbers + 4]
; bug 1: i mistakenloy typed in 8 
;fix: i need the second element so i have to use 4.
    ;set EBX to 4 for multiplication
    mov ebx, 4 
    ;bug2: typed in 5
    ;fix: typed it back to 4
    mul  ebx
    
    ;bug3: i accidently put incorrect division value
    ;fix: the assesment requires me to multiply the second element by 4 not 5.
    ;multiply EAX by EBX using unsigned multiplication
    ;set EBX to 8 for division
    mov ebx, 8

    ;divide the calculated value by EBX
    div ebx
    ;store the quotient back into the second array element
    mov [numbers + 4], eax
    ;bug4: i had inputed the value as 8
    ;fix:i had to put 8
    ;bug5: i used ebx instead of eax to store result
    ;fix: changed ebx to eax contains the quotient


    ;set the exit system call number
    mov rax, 0x2000001
    ;set the exit status to zero
    mov rdi, 1
    ;execute the system call
    syscall

;the code is complete but seems like i have made an error somewhere will do further working on it
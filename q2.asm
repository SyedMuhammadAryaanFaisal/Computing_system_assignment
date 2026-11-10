;Question 2: Assembly Array Calculation.


section .data
    ;declare four unsigned integer values in an array
    numbers dd 8, 16, 24, 32

section .text
    global _main

_main:
    ;load the second element of the array into EAX
    mov eax, [numbers + 8]

    ;set EBX to 4 for multiplication
    mov ebx, 5
    ;multiply EAX by EBX using unsigned multiplication
    imul eax, ebx
    ;set EBX to 8 for division
    mov ebx, 4

    ;divide the calculated value by EBX
    div ebx
    ;store the quotient back into the second array element
    mov [numbers + 8], ebx
    ;copy the calculated result into ECX
    mov ecx, eax

    ;set the exit system call number
    mov rax, 0x2000001
    ;set the exit status to zero
    mov rdi, 1
    ;execute the system call
    syscall

;the code is complete but seems like i have made an error somewhere will do further working on it
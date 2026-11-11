
; Question 2: Assembly Array Calculation.

section .data
    ; Declare four unsigned integer values in an array
    numbers dd 8, 16, 24, 32

    ; Change 1: Added a result variable to store the printable answer.
    ; Explanation: The result variable will hold the ASCII character for 8
    ; followed by 10, which represents a new line.
    result db 0, 10

section .text
    global _main

_main:
    ; Load the second element of the array into EAX
    lea r8, [rel numbers]
    mov eax, [r8 + 4]

    ; Bug 1: I mistakenly typed in 8.
    ; Fix: I need the second element, so I have to use 4.

    ; Set EBX to 4 for multiplication
    mov ebx, 4

    ; Bug 2: I typed in 5.
    ; Fix: Changed it back to 4.
    mul ebx

    ; Bug 3: I accidentally used the incorrect division value.
    ; Fix: Changed the division value to 8.

    ; Set EBX to 8 for division
    mov ebx, 8

    ; Divide the calculated value by EBX
    div ebx

    ; Store the quotient back into the second array element
    mov [r8 + 4], eax

    ; Bug 4: I originally used the wrong array offset.
    ; Fix: Used +4 to access the second element.

    ; Bug 5: I originally used EBX instead of EAX.
    ; Fix: Used EAX because it contains the quotient.

    ; Change 2: Convert the numerical answer into an ASCII character.
    ; Explanation: Adding 48 converts the number 8 into its ASCII value.
    add eax, 48
    mov [rel result], al

    ; Change 3: Added code to display the answer in the termin.
    ; Explanation: The write system call displays the contents of result.
    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel result]
    mov rdx, 2
    syscall

    ; Change 4: Restored the normal exit status to zero.
    ; Explanation: The program now prints the answer instead of using
    ; the calculated value as its exit status.
    mov rax, 0x2000001
    mov rdi, 0
    syscall

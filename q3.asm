; B[i] = (A[i]*3 + 1) + (C[i]*2 + 1) + (A[i] + C[i]) / 2
default rel     ; use RIP-relative addressing (required on macOS)
global _main
global _done    ; exported so the debugger can break on it

section .data
A db 2,4,6,8,10,12,14,16,18,20   ; input array A (unsigned 8-bit elements)
C db 4,6,8,10,12,14,16,18,20,22  ; input array C (unsigned 8-bit elements)

section .bss
B resb 10 ; output array B, one byte per result
;bugs:B was declared with "resb 5", reserving only 5 bytes, but the loop writes up to 10 results, anything past the 5th byte lands outside B 
; fix:reserve 10 bytes (one per element, i = 0..9) with "resb 10".

section .text
_main:
    lea  r8,  [A] ; r8  = address of A
    lea  r9,  [C] 
    ; r9  = address of C
    lea  rdi, [B]
    ; rdi = address of B
    xor  esi, esi 
    ; esi = i = 0, the loop index

.loop:
    ;term 1: A[i]*3 + 1
    movzx eax, byte [r8 + rsi]
    ; load A[i], zero-extended to 32 bits (unsigned)
    mov ebx, 3 
    ; multiplier
    mul ebx 
    ; EDX:EAX = A[i] * 3
    inc eax 
    ; add the +1
    mov ecx, eax 
    ; ECX holds the running total
    ;term 2: C[i]*2 + 1
    movzx eax, byte [r9 + rsi]; load C[i], zero-extended
    mov   ebx, 2 ; multiplier
    mul   ebx
    ; EDX:EAX = C[i] * 2
    inc eax ;adds the +1
    ; bugs: the "+ 1" in (C[i]*2 + 1) was never added, term 1 has its"inc eax" but term 2 went straight from the multiply to combining the result
    ; fix:  add "inc eax" right after the multiply, as term 1 does.
    add ecx, eax 
    ;bug:"mov ecx, eax" overwrote the running total in ecx
    ;fix: now using "add ecx, eax"
    ; add this term into the running total
    ;term 3: (A[i] + C[i]) / 2 
    movzx eax, byte [r8 + rsi] ; load A[i]
    movzx ebx, byte [r9 + rsi]  
    ; load C[i]
    add   eax, ebx
    ; EAX = A[i] + C[i]
    xor edx, edx
    mov ebx, 2
    div ebx
    ;bug: "shr eax, 1" does the division with a shift, the assignment requires the div instruction
    ;fix: use unsigned div, div divides "edx:edx" by the operand so "edx" must be zero first
    add   ecx, eax
    ; add quotient to the running total
    ;store the result
    mov   [rdi + rsi], ch
    ; B[i] = result (fits in one byte)
    ;loop control
    inc   esi 
    ; i++
    cmp   esi, 9
    ; compare i with the limit
    jb    .loop
    ; repeat while i is below the limit (i = 0..9)

_done:
    ;exit(0) via the macOS BSD syscall
    mov   eax, 0x2000001
    ; syscall number for exit (0x2000000 + 1)
    xor   edi, edi 
    ; exit code 0
    syscall
    ;bug: its still not giving any output even tho the assembler and everything is working just fine
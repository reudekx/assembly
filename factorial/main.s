default rel

extern scanf
extern printf

section .data
    prompt db "Enter n: ", 0
    format db "%d", 0
    result db "factorial(%d) = %d", 10, 0

section .text
    global main

factorial:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    cmp edi, 1
    jle .base_case

    mov dword [rbp-4], edi
    dec edi
    call factorial

    imul eax, [rbp-4]
    leave
    ret

.base_case:
    mov eax, 1
    leave
    ret

main:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    lea rdi, [prompt]
    xor eax, eax
    call printf wrt ..plt

    lea rdi, [format]
    lea rsi, [rbp-8]
    xor eax, eax
    call scanf wrt ..plt

    mov edi, [rbp-8]
    call factorial
    mov dword [rbp-4], eax

    lea rdi, [result]
    mov esi, dword [rbp-8]
    mov edx, dword [rbp-4]
    xor eax, eax
    call printf wrt ..plt

    xor eax, eax
    leave
    ret
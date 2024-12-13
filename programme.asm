section .data
    text1 db "What is your name ?  ", 0
    text2 db "Hello,  ", 0
    newline db 10

section .bss
    name resb 32

section .text
    global _start

_start:
    call _printText1
    call _getName
    call _printText2
    call _printName

    mov rax, 60
    mov rdi, 0
    syscall

_printText1:
    mov rax, 1
    mov rdi, 1
    mov rsi, text1
    mov rdx, 18
    syscall
    ret

_getName:
    mov rax, 0
    mov rdi, 0
    mov rsi, name
    mov rdx, 32
    syscall
    ret

_printText2:
    mov rax, 1
    mov rdi, 1
    mov rsi, text2
    mov rdx, 7
    syscall
    ret

_printName:
    mov rax, 1
    mov rdi, 1
    mov rsi, name
    mov rdx, 32
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall
    ret


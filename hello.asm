section .data
    hello db 'Hello, World!',0xA  ; String with newline

section .text
    global _start

_start:
    ; write(1, hello, 14)
    mov eax, 4          ; syscall number for sys_write
    mov ebx, 1          ; file descriptor (stdout)
    mov ecx, hello      ; pointer to message
    mov edx, 14         ; message length
    int 0x80            ; call kernel

    ; exit(0)
    mov eax, 1          ; syscall number for sys_exit
    xor ebx, ebx        ; exit code 0
    int 0x80

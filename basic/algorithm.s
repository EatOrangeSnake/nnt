# This source file is part of the nnt project.
# Achieve the algorithm of NNT type.

# The size of NNT number structure is `sizeof(size_t) * 2`
# The first `sizeof(size_t)` bytes is the data part,
# and the second `sizeof(size_t)` bytes is the length part.

.text

.extern malloc@plt
.extern realloc@plt

.global ot_nnt_add
# add two NNT numbers
# use the fastcall calling convention
# input:
# %rdi, %rsi: the first NNT number
# %rdx, %rcx: the second NNT number
# output:
# %rax, %rdx: the result NNT number
ot_nnt_add:
    cmp %rcx, %rsi
    jle _ot_nnt_add_swap
        xchg %rdx, %rdi
        xchg %rcx, %rsi
    _ot_nnt_add_swap:

    push %r15
    mov %rdi, %r15
    push %r14
    mov %rsi, %r14
    push %r13
    mov %rdx, %r13
    push %r12
    mov %rcx, %r12

    mov %r14, %rdi
    call malloc@plt

    xor %rsi, %rsi
    xor %dl, %dl
    lea _ot_nnt_add_loop(%rip), %r10
    _ot_nnt_add_loop:
        cmp %r12, %rsi
        jl _ot_nnt_add_continue
            lea _ot_nnt_add_once(%rip), %r10
            jmp _ot_nnt_add_once
        _ot_nnt_add_continue:

        add (%r13, %rsi, 1), %dl
        setc %dh

        inc %dl
        setz %cl
        add %cl, %dh

        jmp _ot_nnt_add_twice
    _ot_nnt_add_once:
        cmp %r14, %rsi
        jnl _ot_nnt_add_end

        _ot_nnt_add_twice:
        add (%r15, %rsi, 1), %dl
        setc %cl
        add %cl, %dh

        mov %dl, (%rax, %rsi, 1)
        shr $8, %dx
        inc %rsi
    jmp *%r10

    _ot_nnt_add_end:
    test %dl, %dl
    jz _ot_nnt_add_ret
        dec %dl
        mov %dl, %r12b
        mov %rax, %rdi
        inc %rsi
        call realloc@plt
        mov %r12b, (%rax, %r14, 1)
        inc %r14
    _ot_nnt_add_ret:
    mov %r14, %rdx
    pop %r12
    pop %r13
    pop %r14
    pop %r15
    ret

.section .data
a:
.long 7

b:
.long 9

.section .text
.global _start
_start:

mov a, %eax
mov b, %ebx

pushl %ebx
pushl %eax

call multiply
add $8, %esp

mov %eax, %ebx
jmp _end

_end:
mov $1, %eax

int $0x80

# Multiply 2 numbers!
# Pass a, b -> in order: b,a
# Expect ans at eax
# Save reg and restore stack

# Handles required:
# Negative numbers.
# Zero

.type multiply,@function
multiply:

    push %ebp
    mov %esp, %ebp

    mov 12(%ebp), %eax
    mov 8(%ebp), %ebx

    and %ebx, %eax

    cmp $0, %eax
    je _mult_zero_ans # ans is zero

    mov 12(%ebp), %ecx # ecx holds base value
    
    xor %eax, %eax # Quick zero eax.
    jmp multiply_loop

multiply_loop:

    add %ecx, %eax
    decl %ebx

    cmp $0, %ebx
    je _mult_ret

    jmp multiply_loop

_mult_zero_ans:

    mov $0, %eax
    jmp _mult_ret

_mult_ret:

    # eax already has ans so go back to caller

    mov %ebp, %esp
    popl %ebp
    ret
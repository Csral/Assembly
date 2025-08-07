.section .data
a:
.long 2

b:
.long 5

# Expected ans -> 2^5 = 32

.section .text
.global _start
_start:

mov a, %eax
mov b, %ebx

pushl %ebx
pushl %eax

call power_fn
add $8, %esp

# eax has ans
mov %eax, %ebx

mov $1, %eax
int $0x80

# Returns the ans in eax register
# Expects num, power parameter -> Push in opp dirn
# Save registers before calling.
# Local variables will be cleared.
# Cannot calculate -ve powers or fractional powers

.type power_fn,@function
power_fn:

    pushl %ebp
    mov %esp, %ebp

    # ebp + 12 = power, ebp + 8 = base

    mov 12(%ebp), %ebx

    cmp $0, %ebx
    jle power_neg

    # edx -> base no.
    mov 8(%ebp), %edx

    jmp power_loop

power_loop:

    # By now, ebx has power. eax should have return value!
    # For the sake of learning, lets update stack directly!

    # Current result into eax
    mov 8(%ebp), %eax

    imul %edx, %eax

    # Store back in stack!
    mov %eax, 8(%ebp)

    decl %ebx
    cmp $1, %ebx
    jg power_loop

    # eq to zero

    mov 8(%ebp), %eax
    mov %ebp, %esp # restore stack.
    popl %ebp

    ret # return

power_neg:

    mov $1, %eax

    # restore stack and return

    mov %ebp, %esp
    popl %ebp

    ret

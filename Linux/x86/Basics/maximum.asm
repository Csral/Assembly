.section .data
arr:
.long 10, 20, 99, 30, 40, 90, 50, 70, 60, 80, 0
# 0 marks end

.section .text
.globl _start

_start:

# Eax -> Holds current element in array
# Edi -> index
# Ebx -> Maximum found (Yet)

mov $0, %edi
mov arr(, %edi, 4), %eax # can also be written as -> mov arr(0,%edi,2). Moves 2 bytes at edi index from arr.
mov %eax, %ebx # Assume max = current

loop_maximum:

    # Run until current element = 0.

    inc %edi
    mov arr(, %edi, 4), %eax

    cmp $0, %eax
    je _end # End process if eax is 0.

    cmp %eax, %ebx
    jge loop_maximum # Ignore if ebx has bigger value!

    # Update otherwise
    mov %eax, %ebx
    jmp loop_maximum

_end:

    mov $1, %eax
    # return code = ebx = maximum value

    int $0x80

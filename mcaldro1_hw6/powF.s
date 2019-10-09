.file	"powF.c"
	.text
	.globl	powF
	.type	powF, @function
powF:
.LFB0:
	.cfi_startproc 
	pushq	%rbp -- Write: pushes return value onto the stack
	.cfi_def_cfa_offset 16 -- Offset is being set to 16
	.cfi_offset 6, -16 -- Previous register is saved at offset of -16
	movq	%rsp, %rbp -- Write: sets the base pointer to the stack pointer
	.cfi_def_cfa_register 6 -- Sets 6 as the register to use
	subq	$16, %rsp -- Create: allocates 16 bytes for the stack
	movl	%edi, -4(%rbp) -- Write: moves pow onto stack
	movl	%esi, -8(%rbp) -- Write: moves base onto stack
	cmpl	$0, -4(%rbp) -- check to see if(0==pow)
	jne	.L2 -- recursive case, calls powF(pow-1, base)
	movl	$1, %eax -- base case, puts 1 into return register
	jmp	.L3 -- returns from powF
.L2:
	movl	-4(%rbp), %eax -- Write: moves pow into register %eax
	leal	-1(%rax), %edx -- Write: loads the value of %rax into register %edx
	movl	-8(%rbp), %eax -- Write: moves base into register %eax
	movl	%eax, %esi -- Write: moves base into register %esi
	movl	%edx, %edi -- Write: moves pow-1 into register %edi
	call	powF -- call powF function
	imull	-8(%rbp), %eax -- Write: multiplies return register %eax by powF(pow-1, base)
.L3:
	leave
	.cfi_def_cfa 7, 8 -- Delete: Deallocates memory used on the stack
	ret
	.cfi_endproc -- end of function
.LFE0:
	.size	powF, .-powF
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
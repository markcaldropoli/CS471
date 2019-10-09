	.file	"powF.c"
	.text
	.p2align 4,,15
	.globl	powF
	.type	powF, @function
powF:
.LFB11:
	.cfi_startproc
	movl	$1, %eax
	testl	%edi, %edi
	je	.L1
	.p2align 4,,10
	.p2align 3
.L2:
	imull	%esi, %eax
	subl	$1, %edi
	jne	.L2
.L1:
	ret
	.cfi_endproc
.LFE11:
	.size	powF, .-powF
	.ident	"GCC: (Debian 8.3.0-6) 8.3.0"
	.section	.note.GNU-stack,"",@progbits

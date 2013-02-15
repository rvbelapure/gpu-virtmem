	.file	"libci.c"
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.text
.Ltext0:
	.data
	.align 4
	.type	cudaErrorDL, @object
	.size	cudaErrorDL, 4
cudaErrorDL:
	.long	30
	.local	cuda_err
	.comm	cuda_err,4,4
	.local	regHostVarsTab
	.comm	regHostVarsTab,8,8
	.align 4
	.type	LOCAL_EXEC, @object
	.size	LOCAL_EXEC, 4
LOCAL_EXEC:
	.long	1
	.local	CUR_DEV
	.comm	CUR_DEV,4,4
	.section	.rodata
	.align 16
	.type	__FUNCTION__.9917, @object
	.size	__FUNCTION__.9917, 16
__FUNCTION__.9917:
	.string	"l_handleDlError"
.LC0:
	.string	"%s.%d: %s\n"
	.text
.globl l_handleDlError
	.type	l_handleDlError, @function
l_handleDlError:
.LFB13:
	.file 1 "interposer/libci.c"
	.loc 1 93 0
	pushq	%rbp
.LCFI0:
	movq	%rsp, %rbp
.LCFI1:
	subq	$16, %rsp
.LCFI2:
	.loc 1 95 0
	movl	$0, -4(%rbp)
	.loc 1 97 0
	call	dlerror@PLT
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L2
	.loc 1 98 0
	movq	-16(%rbp), %rcx
	movl	$98, %edx
	leaq	__FUNCTION__.9917(%rip), %rsi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	.loc 1 99 0
	movl	$-1, -4(%rbp)
.L2:
	.loc 1 102 0
	movl	-4(%rbp), %eax
	.loc 1 103 0
	leave
	ret
.LFE13:
	.size	l_handleDlError, .-l_handleDlError
	.section	.rodata
.LC1:
	.string	">>>>>>>>>> %s\n"
	.text
.globl l_printFuncSig
	.type	l_printFuncSig, @function
l_printFuncSig:
.LFB14:
	.loc 1 110 0
	pushq	%rbp
.LCFI3:
	movq	%rsp, %rbp
.LCFI4:
	subq	$16, %rsp
.LCFI5:
	movq	%rdi, -8(%rbp)
	.loc 1 111 0
	movq	-8(%rbp), %rsi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	.loc 1 113 0
	movl	$0, %eax
	.loc 1 114 0
	leave
	ret
.LFE14:
	.size	l_printFuncSig, .-l_printFuncSig
	.section	.rodata
	.align 8
.LC2:
	.string	">>>>>>>>>> Implemented >>>>>>>>>>: %s\n"
	.text
.globl l_printFuncSigImpl
	.type	l_printFuncSigImpl, @function
l_printFuncSigImpl:
.LFB15:
	.loc 1 121 0
	pushq	%rbp
.LCFI6:
	movq	%rsp, %rbp
.LCFI7:
	subq	$16, %rsp
.LCFI8:
	movq	%rdi, -8(%rbp)
	.loc 1 122 0
	movq	-8(%rbp), %rsi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	.loc 1 124 0
	movl	$0, %eax
	.loc 1 125 0
	leave
	ret
.LFE15:
	.size	l_printFuncSigImpl, .-l_printFuncSigImpl
.globl l_setMetThrReq
	.type	l_setMetThrReq, @function
l_setMetThrReq:
.LFB16:
	.loc 1 132 0
	pushq	%rbp
.LCFI9:
	movq	%rsp, %rbp
.LCFI10:
	pushq	%rbx
.LCFI11:
	subq	$24, %rsp
.LCFI12:
	movq	%rdi, -16(%rbp)
	movw	%si, -20(%rbp)
	.loc 1 133 0
	movq	-16(%rbp), %rax
	movq	(%rax), %rdx
	movzwl	-20(%rbp), %eax
	movw	%ax, (%rdx)
	.loc 1 134 0
	movq	-16(%rbp), %rax
	movq	(%rax), %rbx
	call	pthread_self@PLT
	movq	%rax, 8(%rbx)
	.loc 1 135 0
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movb	$2, 16(%rax)
	.loc 1 136 0
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movl	$30, 88(%rax)
	.loc 1 138 0
	movl	$0, %eax
	.loc 1 139 0
	addq	$24, %rsp
	popq	%rbx
	leave
	ret
.LFE16:
	.size	l_setMetThrReq, .-l_setMetThrReq
	.section	.rodata
	.align 8
.LC3:
	.string	">>>>>>>>>> Implemented >>>>>>>>>>: %s (id = %d)\n"
	.text
.globl l_remoteInitMetThrReq
	.type	l_remoteInitMetThrReq, @function
l_remoteInitMetThrReq:
.LFB17:
	.loc 1 152 0
	pushq	%rbp
.LCFI13:
	movq	%rsp, %rbp
.LCFI14:
	pushq	%rbx
.LCFI15:
	subq	$40, %rsp
.LCFI16:
	movq	%rdi, -16(%rbp)
	movq	%rdx, -32(%rbp)
	movw	%si, -20(%rbp)
	.loc 1 153 0
	movzwl	-20(%rbp), %edx
	movq	-32(%rbp), %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	.loc 1 156 0
	movq	-32(%rbp), %rdi
	leaq	cuda_err(%rip), %rsi
	call	callocCudaPacket@PLT
	movq	%rax, %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, (%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L12
	.loc 1 157 0
	movl	$-1, -36(%rbp)
	jmp	.L14
.L12:
	.loc 1 160 0
	movq	-16(%rbp), %rax
	movq	(%rax), %rdx
	movzwl	-20(%rbp), %eax
	movw	%ax, (%rdx)
	.loc 1 161 0
	movq	-16(%rbp), %rax
	movq	(%rax), %rbx
	call	pthread_self@PLT
	movq	%rax, 8(%rbx)
	.loc 1 162 0
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movb	$2, 16(%rax)
	.loc 1 163 0
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movl	$30, 88(%rax)
	.loc 1 165 0
	movl	$0, -36(%rbp)
.L14:
	movl	-36(%rbp), %eax
	.loc 1 166 0
	addq	$40, %rsp
	popq	%rbx
	leave
	ret
.LFE17:
	.size	l_remoteInitMetThrReq, .-l_remoteInitMetThrReq
	.section	.rodata
	.align 16
	.type	__FUNCTION__.9965, @object
	.size	__FUNCTION__.9965, 16
__FUNCTION__.9965:
	.string	"rcudaThreadExit"
.LC4:
	.string	"INFO"
.LC5:
	.string	"%s <%d> %s[%d]: "
.LC6:
	.string	"__OK__ (asynchronous)"
.LC7:
	.string	"WARNING"
	.align 8
.LC8:
	.string	"__ERROR__ Return from asynchronous rpc with the wrong return value."
	.text
.globl rcudaThreadExit
	.type	rcudaThreadExit, @function
rcudaThreadExit:
.LFB18:
	.loc 1 183 0
	pushq	%rbp
.LCFI17:
	movq	%rsp, %rbp
.LCFI18:
	subq	$32, %rsp
.LCFI19:
	.loc 1 186 0
	leaq	-8(%rbp), %rdi
	leaq	__FUNCTION__.9965(%rip), %rdx
	movl	$16, %esi
	call	l_remoteInitMetThrReq@PLT
	cmpl	$-1, %eax
	jne	.L17
	.loc 1 188 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -20(%rbp)
	jmp	.L19
.L17:
	.loc 1 192 0
	movq	-8(%rbp), %rdi
	call	nvbackCudaThreadExit_rpc@PLT
	testl	%eax, %eax
	jne	.L20
	.loc 1 193 0
	movl	$193, %r8d
	leaq	__FUNCTION__.9965(%rip), %rcx
	movl	$4, %edx
	leaq	.LC4(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC6(%rip), %rdi
	call	puts@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 194 0
	movq	-8(%rbp), %rax
	movl	88(%rax), %eax
	movl	%eax, cuda_err(%rip)
	jmp	.L22
.L20:
	.loc 1 196 0
	movl	$196, %r8d
	leaq	__FUNCTION__.9965(%rip), %rcx
	movl	$2, %edx
	leaq	.LC7(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC8(%rip), %rdi
	call	puts@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 197 0
	movl	$30, cuda_err(%rip)
.L22:
	.loc 1 200 0
	movq	-8(%rbp), %rdi
	call	free@PLT
	.loc 1 202 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -20(%rbp)
.L19:
	movl	-20(%rbp), %eax
	.loc 1 204 0
	leave
	ret
.LFE18:
	.size	rcudaThreadExit, .-rcudaThreadExit
	.local	pFunc.9987
	.comm	pFunc.9987,8,8
	.section	.rodata
	.align 16
	.type	__FUNCTION__.9986, @object
	.size	__FUNCTION__.9986, 16
__FUNCTION__.9986:
	.string	"lcudaThreadExit"
.LC9:
	.string	"cudaThreadExit"
	.text
.globl lcudaThreadExit
	.type	lcudaThreadExit, @function
lcudaThreadExit:
.LFB19:
	.loc 1 206 0
	pushq	%rbp
.LCFI20:
	movq	%rsp, %rbp
.LCFI21:
	subq	$16, %rsp
.LCFI22:
	.loc 1 208 0
	leaq	__FUNCTION__.9986(%rip), %rdi
	call	l_printFuncSigImpl@PLT
	.loc 1 212 0
	movq	pFunc.9987(%rip), %rax
	testq	%rax, %rax
	jne	.L25
	.loc 1 213 0
	leaq	.LC9(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.9987(%rip)
	.loc 1 215 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L25
	.loc 1 216 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -4(%rbp)
	jmp	.L28
.L25:
	.loc 1 219 0
	movq	pFunc.9987(%rip), %rax
	call	*%rax
	movl	%eax, -4(%rbp)
.L28:
	movl	-4(%rbp), %eax
	.loc 1 220 0
	leave
	ret
.LFE19:
	.size	lcudaThreadExit, .-lcudaThreadExit
.globl cudaThreadExit
	.type	cudaThreadExit, @function
cudaThreadExit:
.LFB20:
	.loc 1 222 0
	pushq	%rbp
.LCFI23:
	movq	%rsp, %rbp
.LCFI24:
	subq	$16, %rsp
.LCFI25:
	.loc 1 224 0
	movl	LOCAL_EXEC(%rip), %eax
	cmpl	$1, %eax
	jne	.L31
	call	lcudaThreadExit@PLT
	movl	%eax, -4(%rbp)
	jmp	.L33
.L31:
	call	rcudaThreadExit@PLT
	movl	%eax, -4(%rbp)
.L33:
	movl	-4(%rbp), %eax
	.loc 1 225 0
	leave
	ret
.LFE20:
	.size	cudaThreadExit, .-cudaThreadExit
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10016, @object
	.size	__FUNCTION__.10016, 23
__FUNCTION__.10016:
	.string	"rcudaThreadSynchronize"
.LC10:
	.string	"__OK__ ; return from RPC "
	.align 8
.LC11:
	.string	"__ERROR__ Return from rpc with the wrong return value."
	.text
.globl rcudaThreadSynchronize
	.type	rcudaThreadSynchronize, @function
rcudaThreadSynchronize:
.LFB21:
	.loc 1 227 0
	pushq	%rbp
.LCFI26:
	movq	%rsp, %rbp
.LCFI27:
	subq	$32, %rsp
.LCFI28:
	movl	%edi, -20(%rbp)
	.loc 1 230 0
	leaq	-8(%rbp), %rdi
	leaq	__FUNCTION__.10016(%rip), %rdx
	movl	$15, %esi
	call	l_remoteInitMetThrReq@PLT
	cmpl	$-1, %eax
	jne	.L36
	.loc 1 231 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -24(%rbp)
	jmp	.L38
.L36:
	.loc 1 235 0
	movq	-8(%rbp), %rdi
	movl	-20(%rbp), %esi
	call	nvbackCudaThreadSynchronize_rpc@PLT
	testl	%eax, %eax
	jne	.L39
	.loc 1 236 0
	movl	$236, %r8d
	leaq	__FUNCTION__.10016(%rip), %rcx
	movl	$4, %edx
	leaq	.LC4(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC10(%rip), %rdi
	call	puts@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 237 0
	movq	-8(%rbp), %rax
	movl	88(%rax), %eax
	movl	%eax, cuda_err(%rip)
	jmp	.L41
.L39:
	.loc 1 239 0
	movl	$239, %r8d
	leaq	__FUNCTION__.10016(%rip), %rcx
	movl	$2, %edx
	leaq	.LC7(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC11(%rip), %rdi
	call	puts@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 240 0
	movl	$30, cuda_err(%rip)
.L41:
	.loc 1 243 0
	movq	-8(%rbp), %rdi
	call	free@PLT
	.loc 1 245 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -24(%rbp)
.L38:
	movl	-24(%rbp), %eax
	.loc 1 246 0
	leave
	ret
.LFE21:
	.size	rcudaThreadSynchronize, .-rcudaThreadSynchronize
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10038, @object
	.size	__FUNCTION__.10038, 23
__FUNCTION__.10038:
	.string	"lcudaThreadSynchronize"
	.local	pFunc.10037
	.comm	pFunc.10037,8,8
.LC12:
	.string	"cudaThreadSynchronize"
	.text
.globl lcudaThreadSynchronize
	.type	lcudaThreadSynchronize, @function
lcudaThreadSynchronize:
.LFB22:
	.loc 1 248 0
	pushq	%rbp
.LCFI29:
	movq	%rsp, %rbp
.LCFI30:
	subq	$16, %rsp
.LCFI31:
	.loc 1 252 0
	leaq	__FUNCTION__.10038(%rip), %rdi
	call	l_printFuncSigImpl@PLT
	.loc 1 254 0
	movq	pFunc.10037(%rip), %rax
	testq	%rax, %rax
	jne	.L44
	.loc 1 255 0
	leaq	.LC12(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10037(%rip)
	.loc 1 257 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L44
	.loc 1 258 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -4(%rbp)
	jmp	.L47
.L44:
	.loc 1 261 0
	movq	pFunc.10037(%rip), %rax
	call	*%rax
	movl	%eax, -4(%rbp)
.L47:
	movl	-4(%rbp), %eax
	.loc 1 262 0
	leave
	ret
.LFE22:
	.size	lcudaThreadSynchronize, .-lcudaThreadSynchronize
.globl cudaThreadSynchronize
	.type	cudaThreadSynchronize, @function
cudaThreadSynchronize:
.LFB23:
	.loc 1 271 0
	pushq	%rbp
.LCFI32:
	movq	%rsp, %rbp
.LCFI33:
	subq	$16, %rsp
.LCFI34:
	.loc 1 273 0
	movl	CUR_DEV(%rip), %eax
	cmpl	$1, %eax
	jg	.L50
	.loc 1 274 0
	call	lcudaThreadSynchronize@PLT
	movl	%eax, -4(%rbp)
	jmp	.L52
.L50:
	.loc 1 276 0
	movl	CUR_DEV(%rip), %edx
	movl	%edx, %eax
	shrl	$31, %eax
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, %edi
	call	rcudaThreadSynchronize@PLT
	movl	%eax, -4(%rbp)
.L52:
	.loc 1 277 0
	movl	-4(%rbp), %eax
	.loc 1 278 0
	leave
	ret
.LFE23:
	.size	cudaThreadSynchronize, .-cudaThreadSynchronize
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10073, @object
	.size	__FUNCTION__.10073, 19
__FUNCTION__.10073:
	.string	"cudaThreadSetLimit"
	.local	pFunc.10072
	.comm	pFunc.10072,8,8
.LC13:
	.string	"cudaThreadSetLimit"
	.text
.globl cudaThreadSetLimit
	.type	cudaThreadSetLimit, @function
cudaThreadSetLimit:
.LFB24:
	.loc 1 280 0
	pushq	%rbp
.LCFI35:
	movq	%rsp, %rbp
.LCFI36:
	subq	$32, %rsp
.LCFI37:
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 284 0
	movq	pFunc.10072(%rip), %rax
	testq	%rax, %rax
	jne	.L55
	.loc 1 285 0
	leaq	.LC13(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10072(%rip)
	.loc 1 287 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L55
	.loc 1 288 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -20(%rbp)
	jmp	.L58
.L55:
	.loc 1 291 0
	leaq	__FUNCTION__.10073(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 293 0
	movq	pFunc.10072(%rip), %rax
	movq	-16(%rbp), %rsi
	movl	-4(%rbp), %edi
	call	*%rax
	movl	%eax, -20(%rbp)
.L58:
	movl	-20(%rbp), %eax
	.loc 1 294 0
	leave
	ret
.LFE24:
	.size	cudaThreadSetLimit, .-cudaThreadSetLimit
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10094, @object
	.size	__FUNCTION__.10094, 19
__FUNCTION__.10094:
	.string	"cudaThreadGetLimit"
	.local	pFunc.10093
	.comm	pFunc.10093,8,8
.LC14:
	.string	"cudaThreadGetLimit"
	.text
.globl cudaThreadGetLimit
	.type	cudaThreadGetLimit, @function
cudaThreadGetLimit:
.LFB25:
	.loc 1 296 0
	pushq	%rbp
.LCFI38:
	movq	%rsp, %rbp
.LCFI39:
	subq	$16, %rsp
.LCFI40:
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	.loc 1 300 0
	movq	pFunc.10093(%rip), %rax
	testq	%rax, %rax
	jne	.L61
	.loc 1 301 0
	leaq	.LC14(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10093(%rip)
	.loc 1 303 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L61
	.loc 1 304 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -16(%rbp)
	jmp	.L64
.L61:
	.loc 1 307 0
	leaq	__FUNCTION__.10094(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 309 0
	movq	pFunc.10093(%rip), %rax
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -16(%rbp)
.L64:
	movl	-16(%rbp), %eax
	.loc 1 310 0
	leave
	ret
.LFE25:
	.size	cudaThreadGetLimit, .-cudaThreadGetLimit
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10113, @object
	.size	__FUNCTION__.10113, 25
__FUNCTION__.10113:
	.string	"cudaThreadGetCacheConfig"
	.local	pFunc.10112
	.comm	pFunc.10112,8,8
.LC15:
	.string	"cudaThreadGetCacheConfig"
	.text
.globl cudaThreadGetCacheConfig
	.type	cudaThreadGetCacheConfig, @function
cudaThreadGetCacheConfig:
.LFB26:
	.loc 1 312 0
	pushq	%rbp
.LCFI41:
	movq	%rsp, %rbp
.LCFI42:
	subq	$16, %rsp
.LCFI43:
	movq	%rdi, -8(%rbp)
	.loc 1 316 0
	movq	pFunc.10112(%rip), %rax
	testq	%rax, %rax
	jne	.L67
	.loc 1 317 0
	leaq	.LC15(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10112(%rip)
	.loc 1 319 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L67
	.loc 1 320 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -12(%rbp)
	jmp	.L70
.L67:
	.loc 1 323 0
	leaq	__FUNCTION__.10113(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 325 0
	movq	pFunc.10112(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -12(%rbp)
.L70:
	movl	-12(%rbp), %eax
	.loc 1 326 0
	leave
	ret
.LFE26:
	.size	cudaThreadGetCacheConfig, .-cudaThreadGetCacheConfig
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10132, @object
	.size	__FUNCTION__.10132, 25
__FUNCTION__.10132:
	.string	"cudaThreadSetCacheConfig"
	.local	pFunc.10131
	.comm	pFunc.10131,8,8
.LC16:
	.string	"cudaThreadSetCacheConfig"
	.text
.globl cudaThreadSetCacheConfig
	.type	cudaThreadSetCacheConfig, @function
cudaThreadSetCacheConfig:
.LFB27:
	.loc 1 327 0
	pushq	%rbp
.LCFI44:
	movq	%rsp, %rbp
.LCFI45:
	subq	$16, %rsp
.LCFI46:
	movl	%edi, -4(%rbp)
	.loc 1 331 0
	movq	pFunc.10131(%rip), %rax
	testq	%rax, %rax
	jne	.L73
	.loc 1 332 0
	leaq	.LC16(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10131(%rip)
	.loc 1 334 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L73
	.loc 1 335 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -8(%rbp)
	jmp	.L76
.L73:
	.loc 1 338 0
	leaq	__FUNCTION__.10132(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 340 0
	movq	pFunc.10131(%rip), %rax
	movl	-4(%rbp), %edi
	call	*%rax
	movl	%eax, -8(%rbp)
.L76:
	movl	-8(%rbp), %eax
	.loc 1 341 0
	leave
	ret
.LFE27:
	.size	cudaThreadSetCacheConfig, .-cudaThreadSetCacheConfig
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10148, @object
	.size	__FUNCTION__.10148, 18
__FUNCTION__.10148:
	.string	"rcudaGetLastError"
.LC17:
	.string	"DEBUG"
	.align 8
.LC18:
	.string	">>>>>>>>>> Implemented >>>>>>>>>>: %s (no id)\n"
	.text
.globl rcudaGetLastError
	.type	rcudaGetLastError, @function
rcudaGetLastError:
.LFB28:
	.loc 1 343 0
	pushq	%rbp
.LCFI47:
	movq	%rsp, %rbp
.LCFI48:
	.loc 1 344 0
	movl	$344, %r8d
	leaq	__FUNCTION__.10148(%rip), %rcx
	movl	$5, %edx
	leaq	.LC17(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	__FUNCTION__.10148(%rip), %rsi
	leaq	.LC18(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 346 0
	movl	cuda_err(%rip), %eax
	.loc 1 347 0
	leave
	ret
.LFE28:
	.size	rcudaGetLastError, .-rcudaGetLastError
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10158, @object
	.size	__FUNCTION__.10158, 18
__FUNCTION__.10158:
	.string	"lcudaGetLastError"
	.local	pFunc.10157
	.comm	pFunc.10157,8,8
.LC19:
	.string	"cudaGetLastError"
	.text
.globl lcudaGetLastError
	.type	lcudaGetLastError, @function
lcudaGetLastError:
.LFB29:
	.loc 1 349 0
	pushq	%rbp
.LCFI49:
	movq	%rsp, %rbp
.LCFI50:
	subq	$16, %rsp
.LCFI51:
	.loc 1 353 0
	leaq	__FUNCTION__.10158(%rip), %rdi
	call	l_printFuncSigImpl@PLT
	.loc 1 355 0
	movq	pFunc.10157(%rip), %rax
	testq	%rax, %rax
	jne	.L81
	.loc 1 356 0
	leaq	.LC19(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10157(%rip)
	.loc 1 358 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L81
	.loc 1 359 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -4(%rbp)
	jmp	.L84
.L81:
	.loc 1 362 0
	movq	pFunc.10157(%rip), %rax
	call	*%rax
	movl	%eax, -4(%rbp)
.L84:
	movl	-4(%rbp), %eax
	.loc 1 363 0
	leave
	ret
.LFE29:
	.size	lcudaGetLastError, .-lcudaGetLastError
.globl cudaGetLastError
	.type	cudaGetLastError, @function
cudaGetLastError:
.LFB30:
	.loc 1 366 0
	pushq	%rbp
.LCFI52:
	movq	%rsp, %rbp
.LCFI53:
	subq	$16, %rsp
.LCFI54:
	.loc 1 367 0
	movl	LOCAL_EXEC(%rip), %eax
	cmpl	$1, %eax
	jne	.L87
	call	lcudaGetLastError@PLT
	movl	%eax, -4(%rbp)
	jmp	.L89
.L87:
	call	rcudaGetLastError@PLT
	movl	%eax, -4(%rbp)
.L89:
	movl	-4(%rbp), %eax
	.loc 1 368 0
	leave
	ret
.LFE30:
	.size	cudaGetLastError, .-cudaGetLastError
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10189, @object
	.size	__FUNCTION__.10189, 20
__FUNCTION__.10189:
	.string	"cudaPeekAtLastError"
	.local	pFunc.10188
	.comm	pFunc.10188,8,8
.LC20:
	.string	"cudaPeekAtLastError"
	.text
.globl cudaPeekAtLastError
	.type	cudaPeekAtLastError, @function
cudaPeekAtLastError:
.LFB31:
	.loc 1 371 0
	pushq	%rbp
.LCFI55:
	movq	%rsp, %rbp
.LCFI56:
	subq	$16, %rsp
.LCFI57:
	.loc 1 375 0
	movq	pFunc.10188(%rip), %rax
	testq	%rax, %rax
	jne	.L92
	.loc 1 376 0
	leaq	.LC20(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10188(%rip)
	.loc 1 378 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L92
	.loc 1 379 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -4(%rbp)
	jmp	.L95
.L92:
	.loc 1 382 0
	leaq	__FUNCTION__.10189(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 384 0
	movq	pFunc.10188(%rip), %rax
	call	*%rax
	movl	%eax, -4(%rbp)
.L95:
	movl	-4(%rbp), %eax
	.loc 1 385 0
	leave
	ret
.LFE31:
	.size	cudaPeekAtLastError, .-cudaPeekAtLastError
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10208, @object
	.size	__FUNCTION__.10208, 19
__FUNCTION__.10208:
	.string	"cudaGetErrorString"
	.local	pFunc.10207
	.comm	pFunc.10207,8,8
.LC21:
	.string	"cudaGetErrorString"
.LC22:
	.string	"DL error"
	.text
.globl cudaGetErrorString
	.type	cudaGetErrorString, @function
cudaGetErrorString:
.LFB32:
	.loc 1 386 0
	pushq	%rbp
.LCFI58:
	movq	%rsp, %rbp
.LCFI59:
	subq	$16, %rsp
.LCFI60:
	movl	%edi, -4(%rbp)
	.loc 1 390 0
	movq	pFunc.10207(%rip), %rax
	testq	%rax, %rax
	jne	.L98
	.loc 1 391 0
	leaq	.LC21(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10207(%rip)
	.loc 1 393 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L98
	.loc 1 394 0
	leaq	.LC22(%rip), %rax
	movq	%rax, -16(%rbp)
	jmp	.L101
.L98:
	.loc 1 397 0
	leaq	__FUNCTION__.10208(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 399 0
	movq	pFunc.10207(%rip), %rax
	movl	-4(%rbp), %edi
	call	*%rax
	movq	%rax, -16(%rbp)
.L101:
	movq	-16(%rbp), %rax
	.loc 1 400 0
	leave
	ret
.LFE32:
	.size	cudaGetErrorString, .-cudaGetErrorString
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10225, @object
	.size	__FUNCTION__.10225, 20
__FUNCTION__.10225:
	.string	"rcudaGetDeviceCount"
	.align 8
.LC23:
	.string	" __OK__ the number of devices is %ld. Got from the RPC call\n"
	.text
.globl rcudaGetDeviceCount
	.type	rcudaGetDeviceCount, @function
rcudaGetDeviceCount:
.LFB33:
	.loc 1 402 0
	pushq	%rbp
.LCFI61:
	movq	%rsp, %rbp
.LCFI62:
	subq	$32, %rsp
.LCFI63:
	movq	%rdi, -24(%rbp)
	.loc 1 405 0
	leaq	-8(%rbp), %rdi
	leaq	__FUNCTION__.10225(%rip), %rdx
	movl	$9, %esi
	call	l_remoteInitMetThrReq@PLT
	cmpl	$-1, %eax
	jne	.L104
	.loc 1 407 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -28(%rbp)
	jmp	.L106
.L104:
	.loc 1 411 0
	movq	-8(%rbp), %rdi
	call	nvbackCudaGetDeviceCount_rpc@PLT
	testl	%eax, %eax
	jne	.L107
	.loc 1 412 0
	movl	$413, %r8d
	leaq	__FUNCTION__.10225(%rip), %rcx
	movl	$4, %edx
	leaq	.LC4(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-8(%rbp), %rax
	movq	24(%rax), %rsi
	leaq	.LC23(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 415 0
	movq	-8(%rbp), %rax
	movq	24(%rax), %rax
	movl	%eax, %edx
	movq	-24(%rbp), %rax
	movl	%edx, (%rax)
	.loc 1 416 0
	movq	-8(%rbp), %rax
	movl	88(%rax), %eax
	movl	%eax, cuda_err(%rip)
	jmp	.L109
.L107:
	.loc 1 418 0
	movl	$418, %r8d
	leaq	__FUNCTION__.10225(%rip), %rcx
	movl	$2, %edx
	leaq	.LC7(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC11(%rip), %rdi
	call	puts@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 419 0
	movl	$30, cuda_err(%rip)
.L109:
	.loc 1 422 0
	movq	-8(%rbp), %rdi
	call	free@PLT
	.loc 1 424 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -28(%rbp)
.L106:
	movl	-28(%rbp), %eax
	.loc 1 425 0
	leave
	ret
.LFE33:
	.size	rcudaGetDeviceCount, .-rcudaGetDeviceCount
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10252, @object
	.size	__FUNCTION__.10252, 20
__FUNCTION__.10252:
	.string	"lcudaGetDeviceCount"
	.local	pFunc.10251
	.comm	pFunc.10251,8,8
.LC24:
	.string	"cudaGetDeviceCount"
	.text
.globl lcudaGetDeviceCount
	.type	lcudaGetDeviceCount, @function
lcudaGetDeviceCount:
.LFB34:
	.loc 1 426 0
	pushq	%rbp
.LCFI64:
	movq	%rsp, %rbp
.LCFI65:
	subq	$16, %rsp
.LCFI66:
	movq	%rdi, -8(%rbp)
	.loc 1 430 0
	leaq	__FUNCTION__.10252(%rip), %rdi
	call	l_printFuncSigImpl@PLT
	.loc 1 432 0
	movq	pFunc.10251(%rip), %rax
	testq	%rax, %rax
	jne	.L112
	.loc 1 433 0
	leaq	.LC24(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10251(%rip)
	.loc 1 435 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L112
	.loc 1 436 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -12(%rbp)
	jmp	.L115
.L112:
	.loc 1 439 0
	movq	pFunc.10251(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -12(%rbp)
.L115:
	movl	-12(%rbp), %eax
	.loc 1 440 0
	leave
	ret
.LFE34:
	.size	lcudaGetDeviceCount, .-lcudaGetDeviceCount
.globl cudaGetDeviceCount
	.type	cudaGetDeviceCount, @function
cudaGetDeviceCount:
.LFB35:
	.loc 1 442 0
	pushq	%rbp
.LCFI67:
	movq	%rsp, %rbp
.LCFI68:
	subq	$16, %rsp
.LCFI69:
	movq	%rdi, -8(%rbp)
	.loc 1 443 0
	movl	LOCAL_EXEC(%rip), %eax
	cmpl	$1, %eax
	jne	.L118
	movq	-8(%rbp), %rdi
	call	lcudaGetDeviceCount@PLT
	movl	%eax, -12(%rbp)
	jmp	.L120
.L118:
	movq	-8(%rbp), %rdi
	call	rcudaGetDeviceCount@PLT
	movl	%eax, -12(%rbp)
.L120:
	movl	-12(%rbp), %eax
	.loc 1 444 0
	leave
	ret
.LFE35:
	.size	cudaGetDeviceCount, .-cudaGetDeviceCount
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10282, @object
	.size	__FUNCTION__.10282, 25
__FUNCTION__.10282:
	.string	"rcudaGetDeviceProperties"
	.text
.globl rcudaGetDeviceProperties
	.type	rcudaGetDeviceProperties, @function
rcudaGetDeviceProperties:
.LFB36:
	.loc 1 446 0
	pushq	%rbp
.LCFI70:
	movq	%rsp, %rbp
.LCFI71:
	subq	$32, %rsp
.LCFI72:
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	.loc 1 449 0
	leaq	-8(%rbp), %rdi
	leaq	__FUNCTION__.10282(%rip), %rdx
	movl	$10, %esi
	call	l_remoteInitMetThrReq@PLT
	cmpl	$-1, %eax
	jne	.L123
	.loc 1 450 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -32(%rbp)
	jmp	.L125
.L123:
	.loc 1 456 0
	movq	-8(%rbp), %rdx
	movq	-8(%rbp), %rax
	movzbl	16(%rax), %eax
	orl	$16, %eax
	movb	%al, 16(%rdx)
	.loc 1 464 0
	movq	-8(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rax, 24(%rdx)
	.loc 1 465 0
	movq	-8(%rbp), %rdx
	movl	-28(%rbp), %eax
	cltq
	movq	%rax, 40(%rdx)
	.loc 1 466 0
	movq	-8(%rbp), %rax
	movq	$520, 56(%rax)
	.loc 1 469 0
	movq	-8(%rbp), %rdi
	call	nvbackCudaGetDeviceProperties_rpc@PLT
	testl	%eax, %eax
	jne	.L126
	.loc 1 470 0
	movq	-24(%rbp), %rdi
	call	l_printCudaDeviceProp@PLT
	.loc 1 471 0
	movq	-8(%rbp), %rax
	movl	88(%rax), %eax
	movl	%eax, cuda_err(%rip)
	jmp	.L128
.L126:
	.loc 1 473 0
	movl	$473, %r8d
	leaq	__FUNCTION__.10282(%rip), %rcx
	movl	$2, %edx
	leaq	.LC7(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC11(%rip), %rdi
	call	puts@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 475 0
	movl	$30, cuda_err(%rip)
.L128:
	.loc 1 478 0
	movq	-8(%rbp), %rdi
	call	free@PLT
	.loc 1 480 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -32(%rbp)
.L125:
	movl	-32(%rbp), %eax
	.loc 1 481 0
	leave
	ret
.LFE36:
	.size	rcudaGetDeviceProperties, .-rcudaGetDeviceProperties
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10313, @object
	.size	__FUNCTION__.10313, 25
__FUNCTION__.10313:
	.string	"lcudaGetDeviceProperties"
	.local	pFunc.10312
	.comm	pFunc.10312,8,8
.LC25:
	.string	"cudaGetDeviceProperties"
	.text
.globl lcudaGetDeviceProperties
	.type	lcudaGetDeviceProperties, @function
lcudaGetDeviceProperties:
.LFB37:
	.loc 1 483 0
	pushq	%rbp
.LCFI73:
	movq	%rsp, %rbp
.LCFI74:
	subq	$16, %rsp
.LCFI75:
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	.loc 1 488 0
	leaq	__FUNCTION__.10313(%rip), %rdi
	call	l_printFuncSigImpl@PLT
	.loc 1 490 0
	movq	pFunc.10312(%rip), %rax
	testq	%rax, %rax
	jne	.L131
	.loc 1 491 0
	leaq	.LC25(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10312(%rip)
	.loc 1 493 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L131
	.loc 1 494 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -16(%rbp)
	jmp	.L134
.L131:
	.loc 1 497 0
	movq	pFunc.10312(%rip), %rax
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -16(%rbp)
.L134:
	movl	-16(%rbp), %eax
	.loc 1 499 0
	leave
	ret
.LFE37:
	.size	lcudaGetDeviceProperties, .-lcudaGetDeviceProperties
.globl cudaGetDeviceProperties
	.type	cudaGetDeviceProperties, @function
cudaGetDeviceProperties:
.LFB38:
	.loc 1 501 0
	pushq	%rbp
.LCFI76:
	movq	%rsp, %rbp
.LCFI77:
	subq	$16, %rsp
.LCFI78:
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	.loc 1 502 0
	movl	LOCAL_EXEC(%rip), %eax
	cmpl	$1, %eax
	jne	.L137
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rdi
	call	lcudaGetDeviceProperties@PLT
	movl	%eax, -16(%rbp)
	jmp	.L139
.L137:
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rdi
	call	rcudaGetDeviceProperties@PLT
	movl	%eax, -16(%rbp)
.L139:
	movl	-16(%rbp), %eax
	.loc 1 503 0
	leave
	ret
.LFE38:
	.size	cudaGetDeviceProperties, .-cudaGetDeviceProperties
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10347, @object
	.size	__FUNCTION__.10347, 17
__FUNCTION__.10347:
	.string	"cudaChooseDevice"
	.local	pFunc.10346
	.comm	pFunc.10346,8,8
.LC26:
	.string	"cudaChooseDevice"
	.text
.globl cudaChooseDevice
	.type	cudaChooseDevice, @function
cudaChooseDevice:
.LFB39:
	.loc 1 506 0
	pushq	%rbp
.LCFI79:
	movq	%rsp, %rbp
.LCFI80:
	subq	$32, %rsp
.LCFI81:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 511 0
	movq	pFunc.10346(%rip), %rax
	testq	%rax, %rax
	jne	.L142
	.loc 1 512 0
	leaq	.LC26(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10346(%rip)
	.loc 1 514 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L142
	.loc 1 515 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -20(%rbp)
	jmp	.L145
.L142:
	.loc 1 518 0
	leaq	__FUNCTION__.10347(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 520 0
	movq	pFunc.10346(%rip), %rax
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -20(%rbp)
.L145:
	movl	-20(%rbp), %eax
	.loc 1 521 0
	leave
	ret
.LFE39:
	.size	cudaChooseDevice, .-cudaChooseDevice
	.section	.rodata
	.type	__FUNCTION__.10365, @object
	.size	__FUNCTION__.10365, 15
__FUNCTION__.10365:
	.string	"rcudaSetDevice"
	.text
.globl rcudaSetDevice
	.type	rcudaSetDevice, @function
rcudaSetDevice:
.LFB40:
	.loc 1 523 0
	pushq	%rbp
.LCFI82:
	movq	%rsp, %rbp
.LCFI83:
	subq	$32, %rsp
.LCFI84:
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	.loc 1 526 0
	leaq	-8(%rbp), %rdi
	leaq	__FUNCTION__.10365(%rip), %rdx
	movl	$12, %esi
	call	l_remoteInitMetThrReq@PLT
	cmpl	$-1, %eax
	jne	.L148
	.loc 1 527 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -28(%rbp)
	jmp	.L150
.L148:
	.loc 1 529 0
	movq	-8(%rbp), %rdx
	movl	-20(%rbp), %eax
	cltq
	movq	%rax, 24(%rdx)
	.loc 1 532 0
	movq	-8(%rbp), %rdi
	movl	-24(%rbp), %esi
	call	nvbackCudaSetDevice_rpc@PLT
	testl	%eax, %eax
	jne	.L151
	.loc 1 535 0
	movl	$0, cuda_err(%rip)
	jmp	.L153
.L151:
	.loc 1 537 0
	movl	$537, %r8d
	leaq	__FUNCTION__.10365(%rip), %rcx
	movl	$2, %edx
	leaq	.LC7(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC11(%rip), %rdi
	call	puts@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 538 0
	movl	$30, cuda_err(%rip)
.L153:
	.loc 1 541 0
	movq	-8(%rbp), %rdi
	call	free@PLT
	.loc 1 543 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -28(%rbp)
.L150:
	movl	-28(%rbp), %eax
	.loc 1 544 0
	leave
	ret
.LFE40:
	.size	rcudaSetDevice, .-rcudaSetDevice
	.local	pFunc.10386
	.comm	pFunc.10386,8,8
	.section	.rodata
	.type	__FUNCTION__.10383, @object
	.size	__FUNCTION__.10383, 15
__FUNCTION__.10383:
	.string	"lcudaSetDevice"
.LC27:
	.string	"cudaSetDevice"
	.text
.globl lcudaSetDevice
	.type	lcudaSetDevice, @function
lcudaSetDevice:
.LFB41:
	.loc 1 546 0
	pushq	%rbp
.LCFI85:
	movq	%rsp, %rbp
.LCFI86:
	subq	$16, %rsp
.LCFI87:
	movl	%edi, -4(%rbp)
	.loc 1 547 0
	leaq	__FUNCTION__.10383(%rip), %rdi
	call	l_printFuncSigImpl@PLT
	.loc 1 552 0
	movq	pFunc.10386(%rip), %rax
	testq	%rax, %rax
	jne	.L156
	.loc 1 553 0
	leaq	.LC27(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10386(%rip)
	.loc 1 555 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L156
	.loc 1 556 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -8(%rbp)
	jmp	.L159
.L156:
	.loc 1 559 0
	movq	pFunc.10386(%rip), %rax
	movl	-4(%rbp), %edi
	call	*%rax
	movl	%eax, -8(%rbp)
.L159:
	movl	-8(%rbp), %eax
	.loc 1 560 0
	leave
	ret
.LFE41:
	.size	lcudaSetDevice, .-lcudaSetDevice
.globl cudaSetDevice
	.type	cudaSetDevice, @function
cudaSetDevice:
.LFB42:
	.loc 1 568 0
	pushq	%rbp
.LCFI88:
	movq	%rsp, %rbp
.LCFI89:
	subq	$32, %rsp
.LCFI90:
	movl	%edi, -20(%rbp)
	.loc 1 571 0
	cmpl	$1, -20(%rbp)
	jg	.L162
	.loc 1 572 0
	movl	-20(%rbp), %edi
	call	lcudaSetDevice@PLT
	movl	%eax, -4(%rbp)
	jmp	.L164
.L162:
	.loc 1 574 0
	movl	-20(%rbp), %edx
	movl	%edx, %eax
	shrl	$31, %eax
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, %esi
	movl	-20(%rbp), %edx
	movl	%edx, %eax
	sarl	$31, %eax
	movl	%eax, %ecx
	shrl	$31, %ecx
	leal	(%rdx,%rcx), %eax
	andl	$1, %eax
	subl	%ecx, %eax
	movl	%eax, %edi
	call	rcudaSetDevice@PLT
	movl	%eax, -4(%rbp)
.L164:
	.loc 1 575 0
	cmpl	$0, -4(%rbp)
	jne	.L165
	.loc 1 576 0
	movl	-20(%rbp), %eax
	movl	%eax, CUR_DEV(%rip)
.L165:
	.loc 1 577 0
	movl	-4(%rbp), %eax
	.loc 1 578 0
	leave
	ret
.LFE42:
	.size	cudaSetDevice, .-cudaSetDevice
.globl cudaGetDevice
	.type	cudaGetDevice, @function
cudaGetDevice:
.LFB43:
	.loc 1 627 0
	pushq	%rbp
.LCFI91:
	movq	%rsp, %rbp
.LCFI92:
	movq	%rdi, -24(%rbp)
	.loc 1 630 0
	movl	CUR_DEV(%rip), %edx
	movq	-24(%rbp), %rax
	movl	%edx, (%rax)
	.loc 1 631 0
	movl	$0, -4(%rbp)
	.loc 1 632 0
	movl	-4(%rbp), %eax
	.loc 1 633 0
	leave
	ret
.LFE43:
	.size	cudaGetDevice, .-cudaGetDevice
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10429, @object
	.size	__FUNCTION__.10429, 20
__FUNCTION__.10429:
	.string	"cudaSetValidDevices"
	.local	pFunc.10428
	.comm	pFunc.10428,8,8
.LC28:
	.string	"cudaSetValidDevices"
	.text
.globl cudaSetValidDevices
	.type	cudaSetValidDevices, @function
cudaSetValidDevices:
.LFB44:
	.loc 1 636 0
	pushq	%rbp
.LCFI93:
	movq	%rsp, %rbp
.LCFI94:
	subq	$16, %rsp
.LCFI95:
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	.loc 1 640 0
	movq	pFunc.10428(%rip), %rax
	testq	%rax, %rax
	jne	.L171
	.loc 1 641 0
	leaq	.LC28(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10428(%rip)
	.loc 1 643 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L171
	.loc 1 644 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -16(%rbp)
	jmp	.L174
.L171:
	.loc 1 647 0
	leaq	__FUNCTION__.10429(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 649 0
	movq	pFunc.10428(%rip), %rax
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -16(%rbp)
.L174:
	movl	-16(%rbp), %eax
	.loc 1 650 0
	leave
	ret
.LFE44:
	.size	cudaSetValidDevices, .-cudaSetValidDevices
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10448, @object
	.size	__FUNCTION__.10448, 19
__FUNCTION__.10448:
	.string	"cudaSetDeviceFlags"
	.local	pFunc.10447
	.comm	pFunc.10447,8,8
.LC29:
	.string	"cudaSetDeviceFlags"
	.text
.globl cudaSetDeviceFlags
	.type	cudaSetDeviceFlags, @function
cudaSetDeviceFlags:
.LFB45:
	.loc 1 651 0
	pushq	%rbp
.LCFI96:
	movq	%rsp, %rbp
.LCFI97:
	subq	$16, %rsp
.LCFI98:
	movl	%edi, -4(%rbp)
	.loc 1 655 0
	movq	pFunc.10447(%rip), %rax
	testq	%rax, %rax
	jne	.L177
	.loc 1 656 0
	leaq	.LC29(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10447(%rip)
	.loc 1 658 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L177
	.loc 1 659 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -8(%rbp)
	jmp	.L180
.L177:
	.loc 1 662 0
	leaq	__FUNCTION__.10448(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 664 0
	movq	pFunc.10447(%rip), %rax
	movl	-4(%rbp), %edi
	call	*%rax
	movl	%eax, -8(%rbp)
.L180:
	movl	-8(%rbp), %eax
	.loc 1 665 0
	leave
	ret
.LFE45:
	.size	cudaSetDeviceFlags, .-cudaSetDeviceFlags
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10467, @object
	.size	__FUNCTION__.10467, 17
__FUNCTION__.10467:
	.string	"cudaStreamCreate"
	.local	pFunc.10466
	.comm	pFunc.10466,8,8
.LC30:
	.string	"cudaStreamCreate"
	.text
.globl cudaStreamCreate
	.type	cudaStreamCreate, @function
cudaStreamCreate:
.LFB46:
	.loc 1 667 0
	pushq	%rbp
.LCFI99:
	movq	%rsp, %rbp
.LCFI100:
	subq	$16, %rsp
.LCFI101:
	movq	%rdi, -8(%rbp)
	.loc 1 671 0
	movq	pFunc.10466(%rip), %rax
	testq	%rax, %rax
	jne	.L183
	.loc 1 672 0
	leaq	.LC30(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10466(%rip)
	.loc 1 674 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L183
	.loc 1 675 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -12(%rbp)
	jmp	.L186
.L183:
	.loc 1 678 0
	leaq	__FUNCTION__.10467(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 680 0
	movq	pFunc.10466(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -12(%rbp)
.L186:
	movl	-12(%rbp), %eax
	.loc 1 681 0
	leave
	ret
.LFE46:
	.size	cudaStreamCreate, .-cudaStreamCreate
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10486, @object
	.size	__FUNCTION__.10486, 18
__FUNCTION__.10486:
	.string	"cudaStreamDestroy"
	.local	pFunc.10485
	.comm	pFunc.10485,8,8
.LC31:
	.string	"cudaStreamDestroy"
	.text
.globl cudaStreamDestroy
	.type	cudaStreamDestroy, @function
cudaStreamDestroy:
.LFB47:
	.loc 1 682 0
	pushq	%rbp
.LCFI102:
	movq	%rsp, %rbp
.LCFI103:
	subq	$16, %rsp
.LCFI104:
	movq	%rdi, -8(%rbp)
	.loc 1 686 0
	movq	pFunc.10485(%rip), %rax
	testq	%rax, %rax
	jne	.L189
	.loc 1 687 0
	leaq	.LC31(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10485(%rip)
	.loc 1 689 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L189
	.loc 1 690 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -12(%rbp)
	jmp	.L192
.L189:
	.loc 1 693 0
	leaq	__FUNCTION__.10486(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 695 0
	movq	pFunc.10485(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -12(%rbp)
.L192:
	movl	-12(%rbp), %eax
	.loc 1 696 0
	leave
	ret
.LFE47:
	.size	cudaStreamDestroy, .-cudaStreamDestroy
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10509, @object
	.size	__FUNCTION__.10509, 20
__FUNCTION__.10509:
	.string	"cudaStreamWaitEvent"
	.local	pFunc.10508
	.comm	pFunc.10508,8,8
.LC32:
	.string	"cudaStreamWaitEvent"
	.text
.globl cudaStreamWaitEvent
	.type	cudaStreamWaitEvent, @function
cudaStreamWaitEvent:
.LFB48:
	.loc 1 698 0
	pushq	%rbp
.LCFI105:
	movq	%rsp, %rbp
.LCFI106:
	subq	$32, %rsp
.LCFI107:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	.loc 1 703 0
	movq	pFunc.10508(%rip), %rax
	testq	%rax, %rax
	jne	.L195
	.loc 1 704 0
	leaq	.LC32(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10508(%rip)
	.loc 1 706 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L195
	.loc 1 707 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -24(%rbp)
	jmp	.L198
.L195:
	.loc 1 710 0
	leaq	__FUNCTION__.10509(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 712 0
	movq	pFunc.10508(%rip), %rax
	movl	-20(%rbp), %edx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -24(%rbp)
.L198:
	movl	-24(%rbp), %eax
	.loc 1 713 0
	leave
	ret
.LFE48:
	.size	cudaStreamWaitEvent, .-cudaStreamWaitEvent
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10528, @object
	.size	__FUNCTION__.10528, 22
__FUNCTION__.10528:
	.string	"cudaStreamSynchronize"
	.local	pFunc.10527
	.comm	pFunc.10527,8,8
.LC33:
	.string	"cudaStreamSynchronize"
	.text
.globl cudaStreamSynchronize
	.type	cudaStreamSynchronize, @function
cudaStreamSynchronize:
.LFB49:
	.loc 1 714 0
	pushq	%rbp
.LCFI108:
	movq	%rsp, %rbp
.LCFI109:
	subq	$16, %rsp
.LCFI110:
	movq	%rdi, -8(%rbp)
	.loc 1 718 0
	movq	pFunc.10527(%rip), %rax
	testq	%rax, %rax
	jne	.L201
	.loc 1 719 0
	leaq	.LC33(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10527(%rip)
	.loc 1 721 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L201
	.loc 1 722 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -12(%rbp)
	jmp	.L204
.L201:
	.loc 1 725 0
	leaq	__FUNCTION__.10528(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 727 0
	movq	pFunc.10527(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -12(%rbp)
.L204:
	movl	-12(%rbp), %eax
	.loc 1 728 0
	leave
	ret
.LFE49:
	.size	cudaStreamSynchronize, .-cudaStreamSynchronize
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10547, @object
	.size	__FUNCTION__.10547, 16
__FUNCTION__.10547:
	.string	"cudaStreamQuery"
	.local	pFunc.10546
	.comm	pFunc.10546,8,8
.LC34:
	.string	"cudaStreamQuery"
	.text
.globl cudaStreamQuery
	.type	cudaStreamQuery, @function
cudaStreamQuery:
.LFB50:
	.loc 1 729 0
	pushq	%rbp
.LCFI111:
	movq	%rsp, %rbp
.LCFI112:
	subq	$16, %rsp
.LCFI113:
	movq	%rdi, -8(%rbp)
	.loc 1 733 0
	movq	pFunc.10546(%rip), %rax
	testq	%rax, %rax
	jne	.L207
	.loc 1 734 0
	leaq	.LC34(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10546(%rip)
	.loc 1 736 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L207
	.loc 1 737 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -12(%rbp)
	jmp	.L210
.L207:
	.loc 1 740 0
	leaq	__FUNCTION__.10547(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 742 0
	movq	pFunc.10546(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -12(%rbp)
.L210:
	movl	-12(%rbp), %eax
	.loc 1 743 0
	leave
	ret
.LFE50:
	.size	cudaStreamQuery, .-cudaStreamQuery
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10566, @object
	.size	__FUNCTION__.10566, 16
__FUNCTION__.10566:
	.string	"cudaEventCreate"
	.local	pFunc.10565
	.comm	pFunc.10565,8,8
.LC35:
	.string	"cudaEventCreate"
	.text
.globl cudaEventCreate
	.type	cudaEventCreate, @function
cudaEventCreate:
.LFB51:
	.loc 1 746 0
	pushq	%rbp
.LCFI114:
	movq	%rsp, %rbp
.LCFI115:
	subq	$16, %rsp
.LCFI116:
	movq	%rdi, -8(%rbp)
	.loc 1 750 0
	movq	pFunc.10565(%rip), %rax
	testq	%rax, %rax
	jne	.L213
	.loc 1 751 0
	leaq	.LC35(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10565(%rip)
	.loc 1 753 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L213
	.loc 1 754 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -12(%rbp)
	jmp	.L216
.L213:
	.loc 1 757 0
	leaq	__FUNCTION__.10566(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 759 0
	movq	pFunc.10565(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -12(%rbp)
.L216:
	movl	-12(%rbp), %eax
	.loc 1 760 0
	leave
	ret
.LFE51:
	.size	cudaEventCreate, .-cudaEventCreate
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10587, @object
	.size	__FUNCTION__.10587, 25
__FUNCTION__.10587:
	.string	"cudaEventCreateWithFlags"
	.local	pFunc.10586
	.comm	pFunc.10586,8,8
.LC36:
	.string	"cudaEventCreateWithFlags"
	.text
.globl cudaEventCreateWithFlags
	.type	cudaEventCreateWithFlags, @function
cudaEventCreateWithFlags:
.LFB52:
	.loc 1 762 0
	pushq	%rbp
.LCFI117:
	movq	%rsp, %rbp
.LCFI118:
	subq	$16, %rsp
.LCFI119:
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	.loc 1 766 0
	movq	pFunc.10586(%rip), %rax
	testq	%rax, %rax
	jne	.L219
	.loc 1 767 0
	leaq	.LC36(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10586(%rip)
	.loc 1 769 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L219
	.loc 1 770 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -16(%rbp)
	jmp	.L222
.L219:
	.loc 1 773 0
	leaq	__FUNCTION__.10587(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 775 0
	movq	pFunc.10586(%rip), %rax
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -16(%rbp)
.L222:
	movl	-16(%rbp), %eax
	.loc 1 776 0
	leave
	ret
.LFE52:
	.size	cudaEventCreateWithFlags, .-cudaEventCreateWithFlags
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10608, @object
	.size	__FUNCTION__.10608, 16
__FUNCTION__.10608:
	.string	"cudaEventRecord"
	.local	pFunc.10607
	.comm	pFunc.10607,8,8
.LC37:
	.string	"cudaEventRecord"
	.text
.globl cudaEventRecord
	.type	cudaEventRecord, @function
cudaEventRecord:
.LFB53:
	.loc 1 778 0
	pushq	%rbp
.LCFI120:
	movq	%rsp, %rbp
.LCFI121:
	subq	$32, %rsp
.LCFI122:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 782 0
	movq	pFunc.10607(%rip), %rax
	testq	%rax, %rax
	jne	.L225
	.loc 1 783 0
	leaq	.LC37(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10607(%rip)
	.loc 1 785 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L225
	.loc 1 786 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -20(%rbp)
	jmp	.L228
.L225:
	.loc 1 789 0
	leaq	__FUNCTION__.10608(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 791 0
	movq	pFunc.10607(%rip), %rax
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -20(%rbp)
.L228:
	movl	-20(%rbp), %eax
	.loc 1 792 0
	leave
	ret
.LFE53:
	.size	cudaEventRecord, .-cudaEventRecord
	.section	.rodata
	.type	__FUNCTION__.10627, @object
	.size	__FUNCTION__.10627, 15
__FUNCTION__.10627:
	.string	"cudaEventQuery"
	.local	pFunc.10626
	.comm	pFunc.10626,8,8
.LC38:
	.string	"cudaEventQuery"
	.text
.globl cudaEventQuery
	.type	cudaEventQuery, @function
cudaEventQuery:
.LFB54:
	.loc 1 793 0
	pushq	%rbp
.LCFI123:
	movq	%rsp, %rbp
.LCFI124:
	subq	$16, %rsp
.LCFI125:
	movq	%rdi, -8(%rbp)
	.loc 1 797 0
	movq	pFunc.10626(%rip), %rax
	testq	%rax, %rax
	jne	.L231
	.loc 1 798 0
	leaq	.LC38(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10626(%rip)
	.loc 1 800 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L231
	.loc 1 801 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -12(%rbp)
	jmp	.L234
.L231:
	.loc 1 804 0
	leaq	__FUNCTION__.10627(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 806 0
	movq	pFunc.10626(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -12(%rbp)
.L234:
	movl	-12(%rbp), %eax
	.loc 1 807 0
	leave
	ret
.LFE54:
	.size	cudaEventQuery, .-cudaEventQuery
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10646, @object
	.size	__FUNCTION__.10646, 21
__FUNCTION__.10646:
	.string	"cudaEventSynchronize"
	.local	pFunc.10645
	.comm	pFunc.10645,8,8
.LC39:
	.string	"cudaEventSynchronize"
	.text
.globl cudaEventSynchronize
	.type	cudaEventSynchronize, @function
cudaEventSynchronize:
.LFB55:
	.loc 1 808 0
	pushq	%rbp
.LCFI126:
	movq	%rsp, %rbp
.LCFI127:
	subq	$16, %rsp
.LCFI128:
	movq	%rdi, -8(%rbp)
	.loc 1 812 0
	movq	pFunc.10645(%rip), %rax
	testq	%rax, %rax
	jne	.L237
	.loc 1 813 0
	leaq	.LC39(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10645(%rip)
	.loc 1 815 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L237
	.loc 1 816 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -12(%rbp)
	jmp	.L240
.L237:
	.loc 1 819 0
	leaq	__FUNCTION__.10646(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 821 0
	movq	pFunc.10645(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -12(%rbp)
.L240:
	movl	-12(%rbp), %eax
	.loc 1 822 0
	leave
	ret
.LFE55:
	.size	cudaEventSynchronize, .-cudaEventSynchronize
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10665, @object
	.size	__FUNCTION__.10665, 17
__FUNCTION__.10665:
	.string	"cudaEventDestroy"
	.local	pFunc.10664
	.comm	pFunc.10664,8,8
.LC40:
	.string	"cudaEventDestroy"
	.text
.globl cudaEventDestroy
	.type	cudaEventDestroy, @function
cudaEventDestroy:
.LFB56:
	.loc 1 823 0
	pushq	%rbp
.LCFI129:
	movq	%rsp, %rbp
.LCFI130:
	subq	$16, %rsp
.LCFI131:
	movq	%rdi, -8(%rbp)
	.loc 1 827 0
	movq	pFunc.10664(%rip), %rax
	testq	%rax, %rax
	jne	.L243
	.loc 1 828 0
	leaq	.LC40(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10664(%rip)
	.loc 1 830 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L243
	.loc 1 831 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -12(%rbp)
	jmp	.L246
.L243:
	.loc 1 834 0
	leaq	__FUNCTION__.10665(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 836 0
	movq	pFunc.10664(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -12(%rbp)
.L246:
	movl	-12(%rbp), %eax
	.loc 1 837 0
	leave
	ret
.LFE56:
	.size	cudaEventDestroy, .-cudaEventDestroy
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10688, @object
	.size	__FUNCTION__.10688, 21
__FUNCTION__.10688:
	.string	"cudaEventElapsedTime"
	.local	pFunc.10687
	.comm	pFunc.10687,8,8
.LC41:
	.string	"cudaEventElapsedTime"
	.text
.globl cudaEventElapsedTime
	.type	cudaEventElapsedTime, @function
cudaEventElapsedTime:
.LFB57:
	.loc 1 839 0
	pushq	%rbp
.LCFI132:
	movq	%rsp, %rbp
.LCFI133:
	subq	$32, %rsp
.LCFI134:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	.loc 1 844 0
	movq	pFunc.10687(%rip), %rax
	testq	%rax, %rax
	jne	.L249
	.loc 1 845 0
	leaq	.LC41(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10687(%rip)
	.loc 1 847 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L249
	.loc 1 848 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -28(%rbp)
	jmp	.L252
.L249:
	.loc 1 851 0
	leaq	__FUNCTION__.10688(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 853 0
	movq	pFunc.10687(%rip), %rax
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -28(%rbp)
.L252:
	movl	-28(%rbp), %eax
	.loc 1 854 0
	leave
	ret
.LFE57:
	.size	cudaEventElapsedTime, .-cudaEventElapsedTime
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10709, @object
	.size	__FUNCTION__.10709, 19
__FUNCTION__.10709:
	.string	"rcudaConfigureCall"
	.align 8
.LC42:
	.string	"gridDim(x,y,z)=%u, %u, %u; blockDim(x,y,z)=%u, %u, %u; sharedMem (size) = %ld; stream =%ld\n"
	.align 8
.LC43:
	.string	"__ERROR__: Return from rpc with the wrong return value."
	.text
.globl rcudaConfigureCall
	.type	rcudaConfigureCall, @function
rcudaConfigureCall:
.LFB58:
	.loc 1 858 0
	pushq	%rbp
.LCFI135:
	movq	%rsp, %rbp
.LCFI136:
	subq	$96, %rsp
.LCFI137:
	movq	%rdx, %r10
	movq	%r8, -56(%rbp)
	movq	%r9, -64(%rbp)
	movq	%rdi, %rax
	movl	%esi, %edx
	movq	%rax, -32(%rbp)
	movl	%edx, -24(%rbp)
	movq	%r10, %rax
	movl	%ecx, %edx
	movq	%rax, -48(%rbp)
	movl	%edx, -40(%rbp)
	.loc 1 861 0
	leaq	-8(%rbp), %rdi
	leaq	__FUNCTION__.10709(%rip), %rdx
	movl	$13, %esi
	call	l_remoteInitMetThrReq@PLT
	cmpl	$-1, %eax
	jne	.L255
	.loc 1 862 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -68(%rbp)
	jmp	.L257
.L255:
	.loc 1 864 0
	movq	-8(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rax, 24(%rdx)
	movl	-24(%rbp), %eax
	movl	%eax, 32(%rdx)
	.loc 1 865 0
	movq	-8(%rbp), %rdx
	movq	-48(%rbp), %rax
	movq	%rax, 40(%rdx)
	movl	-40(%rbp), %eax
	movl	%eax, 48(%rdx)
	.loc 1 866 0
	movq	-8(%rbp), %rdx
	movq	-56(%rbp), %rax
	movq	%rax, 56(%rdx)
	.loc 1 867 0
	movq	-8(%rbp), %rdx
	movq	-64(%rbp), %rax
	movq	%rax, 72(%rdx)
	.loc 1 869 0
	movq	-8(%rbp), %rax
	movq	72(%rax), %rax
	movq	%rax, %rdi
	movq	-8(%rbp), %rax
	movq	56(%rax), %r8
	movq	-8(%rbp), %rax
	movl	48(%rax), %r9d
	movq	-8(%rbp), %rax
	movl	44(%rax), %r10d
	movq	-8(%rbp), %rax
	movl	40(%rax), %r11d
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	movq	-8(%rbp), %rax
	movl	28(%rax), %edx
	movq	-8(%rbp), %rax
	movl	24(%rax), %esi
	movq	%rdi, 16(%rsp)
	movq	%r8, 8(%rsp)
	movl	%r9d, (%rsp)
	movl	%r10d, %r9d
	movl	%r11d, %r8d
	leaq	.LC42(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	.loc 1 875 0
	movq	-8(%rbp), %rdi
	movl	16(%rbp), %esi
	call	nvbackCudaConfigureCall_rpc@PLT
	testl	%eax, %eax
	jne	.L258
	.loc 1 877 0
	movl	$0, cuda_err(%rip)
	jmp	.L260
.L258:
	.loc 1 879 0
	movl	$879, %r8d
	leaq	__FUNCTION__.10709(%rip), %rcx
	movl	$2, %edx
	leaq	.LC7(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC43(%rip), %rdi
	call	puts@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 881 0
	movl	$30, cuda_err(%rip)
.L260:
	.loc 1 884 0
	movq	-8(%rbp), %rdi
	call	free@PLT
	.loc 1 886 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -68(%rbp)
.L257:
	movl	-68(%rbp), %eax
	.loc 1 887 0
	leave
	ret
.LFE58:
	.size	rcudaConfigureCall, .-rcudaConfigureCall
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10757, @object
	.size	__FUNCTION__.10757, 19
__FUNCTION__.10757:
	.string	"lcudaConfigureCall"
	.local	pFunc.10756
	.comm	pFunc.10756,8,8
.LC44:
	.string	"cudaConfigureCall"
	.text
.globl lcudaConfigureCall
	.type	lcudaConfigureCall, @function
lcudaConfigureCall:
.LFB59:
	.loc 1 890 0
	pushq	%rbp
.LCFI138:
	movq	%rsp, %rbp
.LCFI139:
	subq	$64, %rsp
.LCFI140:
	movq	%rdx, %r10
	movq	%r8, -40(%rbp)
	movq	%r9, -48(%rbp)
	movq	%rdi, %rax
	movl	%esi, %edx
	movq	%rax, -16(%rbp)
	movl	%edx, -8(%rbp)
	movq	%r10, %rax
	movl	%ecx, %edx
	movq	%rax, -32(%rbp)
	movl	%edx, -24(%rbp)
	.loc 1 896 0
	leaq	__FUNCTION__.10757(%rip), %rdi
	call	l_printFuncSigImpl@PLT
	.loc 1 897 0
	movq	pFunc.10756(%rip), %rax
	testq	%rax, %rax
	jne	.L263
	.loc 1 898 0
	leaq	.LC44(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10756(%rip)
	.loc 1 900 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L263
	.loc 1 901 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -52(%rbp)
	jmp	.L266
.L263:
	.loc 1 904 0
	movq	pFunc.10756(%rip), %r11
	movq	-48(%rbp), %rax
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rcx
	movl	-24(%rbp), %esi
	movq	-16(%rbp), %rdi
	movl	-8(%rbp), %r10d
	movq	%rax, %r9
	movq	%rdx, %r8
	movq	%rcx, %rdx
	movl	%esi, %ecx
	movl	%r10d, %esi
	call	*%r11
	movl	%eax, -52(%rbp)
.L266:
	movl	-52(%rbp), %eax
	.loc 1 905 0
	leave
	ret
.LFE59:
	.size	lcudaConfigureCall, .-lcudaConfigureCall
.globl cudaConfigureCall
	.type	cudaConfigureCall, @function
cudaConfigureCall:
.LFB60:
	.loc 1 934 0
	pushq	%rbp
.LCFI141:
	movq	%rsp, %rbp
.LCFI142:
	movq	%rdx, %r10
	movq	%r8, -40(%rbp)
	movq	%r9, -48(%rbp)
	movq	%rdi, %rax
	movl	%esi, %edx
	movq	%rax, -16(%rbp)
	movl	%edx, -8(%rbp)
	movq	%r10, %rax
	movl	%ecx, %edx
	movq	%rax, -32(%rbp)
	movl	%edx, -24(%rbp)
	.loc 1 935 0
	movl	$1, %eax
	.loc 1 936 0
	leave
	ret
.LFE60:
	.size	cudaConfigureCall, .-cudaConfigureCall
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10785, @object
	.size	__FUNCTION__.10785, 19
__FUNCTION__.10785:
	.string	"rcudaSetupArgument"
	.text
.globl rcudaSetupArgument
	.type	rcudaSetupArgument, @function
rcudaSetupArgument:
.LFB61:
	.loc 1 939 0
	pushq	%rbp
.LCFI143:
	movq	%rsp, %rbp
.LCFI144:
	subq	$48, %rsp
.LCFI145:
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movl	%ecx, -44(%rbp)
	.loc 1 942 0
	leaq	-8(%rbp), %rdi
	leaq	__FUNCTION__.10785(%rip), %rdx
	movl	$7, %esi
	call	l_remoteInitMetThrReq@PLT
	cmpl	$-1, %eax
	jne	.L271
	.loc 1 943 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -48(%rbp)
	jmp	.L273
.L271:
	.loc 1 949 0
	movq	-8(%rbp), %rdx
	movq	-8(%rbp), %rax
	movzbl	16(%rax), %eax
	orl	$16, %eax
	movb	%al, 16(%rdx)
	.loc 1 958 0
	movq	-8(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rax, 24(%rdx)
	.loc 1 959 0
	movq	-8(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rax, 40(%rdx)
	.loc 1 960 0
	movq	-8(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	%rax, 56(%rdx)
	.loc 1 963 0
	movq	-8(%rbp), %rdi
	movl	-44(%rbp), %esi
	call	nvbackCudaSetupArgument_rpc@PLT
	testl	%eax, %eax
	jne	.L274
	.loc 1 964 0
	movl	$0, cuda_err(%rip)
	jmp	.L276
.L274:
	.loc 1 966 0
	movl	$966, %r8d
	leaq	__FUNCTION__.10785(%rip), %rcx
	movl	$2, %edx
	leaq	.LC7(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC11(%rip), %rdi
	call	puts@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 967 0
	movl	$30, cuda_err(%rip)
.L276:
	.loc 1 970 0
	movq	-8(%rbp), %rdi
	call	free@PLT
	.loc 1 972 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -48(%rbp)
.L273:
	movl	-48(%rbp), %eax
	.loc 1 973 0
	leave
	ret
.LFE61:
	.size	rcudaSetupArgument, .-rcudaSetupArgument
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10817, @object
	.size	__FUNCTION__.10817, 19
__FUNCTION__.10817:
	.string	"lcudaSetupArgument"
	.local	pFunc.10816
	.comm	pFunc.10816,8,8
.LC45:
	.string	"cudaSetupArgument"
	.text
.globl lcudaSetupArgument
	.type	lcudaSetupArgument, @function
lcudaSetupArgument:
.LFB62:
	.loc 1 975 0
	pushq	%rbp
.LCFI146:
	movq	%rsp, %rbp
.LCFI147:
	subq	$32, %rsp
.LCFI148:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	.loc 1 981 0
	leaq	__FUNCTION__.10817(%rip), %rdi
	call	l_printFuncSigImpl@PLT
	.loc 1 983 0
	movq	pFunc.10816(%rip), %rax
	testq	%rax, %rax
	jne	.L279
	.loc 1 984 0
	leaq	.LC45(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10816(%rip)
	.loc 1 986 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L279
	.loc 1 987 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -28(%rbp)
	jmp	.L282
.L279:
	.loc 1 990 0
	movq	pFunc.10816(%rip), %rax
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -28(%rbp)
.L282:
	movl	-28(%rbp), %eax
	.loc 1 991 0
	leave
	ret
.LFE62:
	.size	lcudaSetupArgument, .-lcudaSetupArgument
.globl cudaSetupArgument
	.type	cudaSetupArgument, @function
cudaSetupArgument:
.LFB63:
	.loc 1 1002 0
	pushq	%rbp
.LCFI149:
	movq	%rsp, %rbp
.LCFI150:
	subq	$48, %rsp
.LCFI151:
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	.loc 1 1004 0
	movl	CUR_DEV(%rip), %eax
	cmpl	$1, %eax
	jg	.L285
	.loc 1 1005 0
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rsi
	movq	-24(%rbp), %rdi
	call	lcudaSetupArgument@PLT
	movl	%eax, -4(%rbp)
	jmp	.L287
.L285:
	.loc 1 1007 0
	movl	CUR_DEV(%rip), %edx
	movl	%edx, %eax
	shrl	$31, %eax
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, %ecx
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rsi
	movq	-24(%rbp), %rdi
	call	rcudaSetupArgument@PLT
	movl	%eax, -4(%rbp)
.L287:
	.loc 1 1008 0
	movl	-4(%rbp), %eax
	.loc 1 1009 0
	leave
	ret
.LFE63:
	.size	cudaSetupArgument, .-cudaSetupArgument
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10854, @object
	.size	__FUNCTION__.10854, 23
__FUNCTION__.10854:
	.string	"cudaFuncSetCacheConfig"
	.local	pFunc.10853
	.comm	pFunc.10853,8,8
.LC46:
	.string	"cudaFuncSetCacheConfig"
	.text
.globl cudaFuncSetCacheConfig
	.type	cudaFuncSetCacheConfig, @function
cudaFuncSetCacheConfig:
.LFB64:
	.loc 1 1013 0
	pushq	%rbp
.LCFI152:
	movq	%rsp, %rbp
.LCFI153:
	subq	$16, %rsp
.LCFI154:
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	.loc 1 1018 0
	movq	pFunc.10853(%rip), %rax
	testq	%rax, %rax
	jne	.L290
	.loc 1 1019 0
	leaq	.LC46(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10853(%rip)
	.loc 1 1021 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L290
	.loc 1 1022 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -16(%rbp)
	jmp	.L293
.L290:
	.loc 1 1025 0
	leaq	__FUNCTION__.10854(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1027 0
	movq	pFunc.10853(%rip), %rax
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -16(%rbp)
.L293:
	movl	-16(%rbp), %eax
	.loc 1 1028 0
	leave
	ret
.LFE64:
	.size	cudaFuncSetCacheConfig, .-cudaFuncSetCacheConfig
	.section	.rodata
	.type	__FUNCTION__.10872, @object
	.size	__FUNCTION__.10872, 12
__FUNCTION__.10872:
	.string	"rcudaLaunch"
.LC47:
	.string	"%s, entry: %s\n"
	.text
.globl rcudaLaunch
	.type	rcudaLaunch, @function
rcudaLaunch:
.LFB65:
	.loc 1 1030 0
	pushq	%rbp
.LCFI155:
	movq	%rsp, %rbp
.LCFI156:
	subq	$32, %rsp
.LCFI157:
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	.loc 1 1033 0
	leaq	-8(%rbp), %rdi
	leaq	__FUNCTION__.10872(%rip), %rdx
	movl	$8, %esi
	call	l_remoteInitMetThrReq@PLT
	cmpl	$-1, %eax
	jne	.L296
	.loc 1 1034 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -32(%rbp)
	jmp	.L298
.L296:
	.loc 1 1036 0
	movq	-8(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rax, 24(%rdx)
	.loc 1 1038 0
	movq	-24(%rbp), %rdx
	leaq	__FUNCTION__.10872(%rip), %rsi
	leaq	.LC47(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	.loc 1 1040 0
	movq	-8(%rbp), %rdi
	movl	-28(%rbp), %esi
	call	nvbackCudaLaunch_rpc@PLT
	testl	%eax, %eax
	jne	.L299
	.loc 1 1041 0
	movl	$0, cuda_err(%rip)
	jmp	.L301
.L299:
	.loc 1 1043 0
	movl	$1043, %r8d
	leaq	__FUNCTION__.10872(%rip), %rcx
	movl	$2, %edx
	leaq	.LC7(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC43(%rip), %rdi
	call	puts@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 1045 0
	movl	$30, cuda_err(%rip)
.L301:
	.loc 1 1048 0
	movq	-8(%rbp), %rdi
	call	free@PLT
	.loc 1 1050 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -32(%rbp)
.L298:
	movl	-32(%rbp), %eax
	.loc 1 1051 0
	leave
	ret
.LFE65:
	.size	rcudaLaunch, .-rcudaLaunch
	.section	.rodata
	.type	__FUNCTION__.10892, @object
	.size	__FUNCTION__.10892, 12
__FUNCTION__.10892:
	.string	"lcudaLaunch"
	.local	pFunc.10891
	.comm	pFunc.10891,8,8
.LC48:
	.string	"cudaLaunch"
	.text
.globl lcudaLaunch
	.type	lcudaLaunch, @function
lcudaLaunch:
.LFB66:
	.loc 1 1053 0
	pushq	%rbp
.LCFI158:
	movq	%rsp, %rbp
.LCFI159:
	subq	$16, %rsp
.LCFI160:
	movq	%rdi, -8(%rbp)
	.loc 1 1058 0
	leaq	__FUNCTION__.10892(%rip), %rdi
	call	l_printFuncSigImpl@PLT
	.loc 1 1059 0
	movq	pFunc.10891(%rip), %rax
	testq	%rax, %rax
	jne	.L304
	.loc 1 1060 0
	leaq	.LC48(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10891(%rip)
	.loc 1 1062 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L304
	.loc 1 1063 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -12(%rbp)
	jmp	.L307
.L304:
	.loc 1 1066 0
	movq	pFunc.10891(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -12(%rbp)
.L307:
	movl	-12(%rbp), %eax
	.loc 1 1067 0
	leave
	ret
.LFE66:
	.size	lcudaLaunch, .-lcudaLaunch
.globl cudaLaunch
	.type	cudaLaunch, @function
cudaLaunch:
.LFB67:
	.loc 1 1075 0
	pushq	%rbp
.LCFI161:
	movq	%rsp, %rbp
.LCFI162:
	subq	$32, %rsp
.LCFI163:
	movq	%rdi, -24(%rbp)
	.loc 1 1077 0
	movl	CUR_DEV(%rip), %eax
	cmpl	$1, %eax
	jg	.L310
	.loc 1 1078 0
	movq	-24(%rbp), %rdi
	call	lcudaLaunch@PLT
	movl	%eax, -4(%rbp)
	jmp	.L312
.L310:
	.loc 1 1080 0
	movl	CUR_DEV(%rip), %edx
	movl	%edx, %eax
	shrl	$31, %eax
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, %esi
	movq	-24(%rbp), %rdi
	call	rcudaLaunch@PLT
	movl	%eax, -4(%rbp)
.L312:
	.loc 1 1081 0
	movl	-4(%rbp), %eax
	.loc 1 1082 0
	leave
	ret
.LFE67:
	.size	cudaLaunch, .-cudaLaunch
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10927, @object
	.size	__FUNCTION__.10927, 22
__FUNCTION__.10927:
	.string	"cudaFuncGetAttributes"
	.local	pFunc.10926
	.comm	pFunc.10926,8,8
.LC49:
	.string	"cudaFuncGetAttributes"
	.text
.globl cudaFuncGetAttributes
	.type	cudaFuncGetAttributes, @function
cudaFuncGetAttributes:
.LFB68:
	.loc 1 1085 0
	pushq	%rbp
.LCFI164:
	movq	%rsp, %rbp
.LCFI165:
	subq	$32, %rsp
.LCFI166:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 1090 0
	movq	pFunc.10926(%rip), %rax
	testq	%rax, %rax
	jne	.L315
	.loc 1 1091 0
	leaq	.LC49(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10926(%rip)
	.loc 1 1093 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L315
	.loc 1 1094 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -20(%rbp)
	jmp	.L318
.L315:
	.loc 1 1097 0
	leaq	__FUNCTION__.10927(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1099 0
	movq	pFunc.10926(%rip), %rax
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -20(%rbp)
.L318:
	movl	-20(%rbp), %eax
	.loc 1 1100 0
	leave
	ret
.LFE68:
	.size	cudaFuncGetAttributes, .-cudaFuncGetAttributes
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10946, @object
	.size	__FUNCTION__.10946, 23
__FUNCTION__.10946:
	.string	"cudaSetDoubleForDevice"
	.local	pFunc.10945
	.comm	pFunc.10945,8,8
.LC50:
	.string	"cudaSetDoubleForDevice"
	.text
.globl cudaSetDoubleForDevice
	.type	cudaSetDoubleForDevice, @function
cudaSetDoubleForDevice:
.LFB69:
	.loc 1 1101 0
	pushq	%rbp
.LCFI167:
	movq	%rsp, %rbp
.LCFI168:
	subq	$16, %rsp
.LCFI169:
	movq	%rdi, -8(%rbp)
	.loc 1 1105 0
	movq	pFunc.10945(%rip), %rax
	testq	%rax, %rax
	jne	.L321
	.loc 1 1106 0
	leaq	.LC50(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10945(%rip)
	.loc 1 1108 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L321
	.loc 1 1109 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -12(%rbp)
	jmp	.L324
.L321:
	.loc 1 1112 0
	leaq	__FUNCTION__.10946(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1114 0
	movq	pFunc.10945(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -12(%rbp)
.L324:
	movl	-12(%rbp), %eax
	.loc 1 1115 0
	leave
	ret
.LFE69:
	.size	cudaSetDoubleForDevice, .-cudaSetDoubleForDevice
	.local	pFunc.10965
	.comm	pFunc.10965,8,8
	.section	.rodata
	.align 16
	.type	__FUNCTION__.10962, @object
	.size	__FUNCTION__.10962, 21
__FUNCTION__.10962:
	.string	"cudaSetDoubleForHost"
.LC51:
	.string	"cudaSetDoubleForHost"
	.text
.globl cudaSetDoubleForHost
	.type	cudaSetDoubleForHost, @function
cudaSetDoubleForHost:
.LFB70:
	.loc 1 1116 0
	pushq	%rbp
.LCFI170:
	movq	%rsp, %rbp
.LCFI171:
	subq	$16, %rsp
.LCFI172:
	movq	%rdi, -8(%rbp)
	.loc 1 1117 0
	leaq	__FUNCTION__.10962(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1122 0
	movq	pFunc.10965(%rip), %rax
	testq	%rax, %rax
	jne	.L327
	.loc 1 1123 0
	leaq	.LC51(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.10965(%rip)
	.loc 1 1125 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L327
	.loc 1 1126 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -12(%rbp)
	jmp	.L330
.L327:
	.loc 1 1129 0
	movq	pFunc.10965(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -12(%rbp)
.L330:
	movl	-12(%rbp), %eax
	.loc 1 1130 0
	leave
	ret
.LFE70:
	.size	cudaSetDoubleForHost, .-cudaSetDoubleForHost
	.section	.rodata
	.type	__FUNCTION__.10984, @object
	.size	__FUNCTION__.10984, 12
__FUNCTION__.10984:
	.string	"rcudaMalloc"
	.align 8
.LC52:
	.string	"\ndevPtr %p, *devPtr %p, size %ld\n"
.LC53:
	.string	"<%d> %s[%d]: "
	.align 8
.LC54:
	.string	"%s: __ERROR__: Return from the RPC\n"
	.align 8
.LC55:
	.string	"%s: __OK__:  Return from the RPC call DevPtr %p\n"
	.text
.globl rcudaMalloc
	.type	rcudaMalloc, @function
rcudaMalloc:
.LFB71:
	.loc 1 1132 0
	pushq	%rbp
.LCFI173:
	movq	%rsp, %rbp
.LCFI174:
	subq	$48, %rsp
.LCFI175:
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, -36(%rbp)
	.loc 1 1135 0
	leaq	-8(%rbp), %rdi
	leaq	__FUNCTION__.10984(%rip), %rdx
	movl	$1, %esi
	call	l_remoteInitMetThrReq@PLT
	cmpl	$-1, %eax
	jne	.L333
	.loc 1 1136 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -40(%rbp)
	jmp	.L335
.L333:
	.loc 1 1139 0
	movq	-8(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rax, 24(%rdx)
	.loc 1 1140 0
	movq	-8(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rax, 40(%rdx)
	.loc 1 1142 0
	movq	-24(%rbp), %rax
	movq	(%rax), %rdx
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rsi
	leaq	.LC52(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	.loc 1 1144 0
	movq	-8(%rbp), %rdi
	movl	-36(%rbp), %esi
	call	nvbackCudaMalloc_rpc@PLT
	testl	%eax, %eax
	je	.L336
	.loc 1 1145 0
	movl	$1145, %ecx
	leaq	__FUNCTION__.10984(%rip), %rdx
	movl	$0, %esi
	leaq	.LC53(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	__FUNCTION__.10984(%rip), %rsi
	leaq	.LC54(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 1146 0
	movl	$2, cuda_err(%rip)
	.loc 1 1147 0
	movq	-24(%rbp), %rax
	movq	$0, (%rax)
	jmp	.L338
.L336:
	.loc 1 1149 0
	movl	$1150, %ecx
	leaq	__FUNCTION__.10984(%rip), %rdx
	movl	$4, %esi
	leaq	.LC53(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-8(%rbp), %rax
	movq	24(%rax), %rdx
	leaq	__FUNCTION__.10984(%rip), %rsi
	leaq	.LC55(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 1152 0
	movq	-8(%rbp), %rax
	movq	24(%rax), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 1153 0
	movq	-8(%rbp), %rax
	movl	88(%rax), %eax
	movl	%eax, cuda_err(%rip)
.L338:
	.loc 1 1156 0
	movq	-8(%rbp), %rdi
	call	free@PLT
	.loc 1 1157 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -40(%rbp)
.L335:
	movl	-40(%rbp), %eax
	.loc 1 1158 0
	leave
	ret
.LFE71:
	.size	rcudaMalloc, .-rcudaMalloc
	.section	.rodata
	.type	__FUNCTION__.11016, @object
	.size	__FUNCTION__.11016, 12
__FUNCTION__.11016:
	.string	"lcudaMalloc"
	.local	pFunc.11015
	.comm	pFunc.11015,8,8
.LC56:
	.string	"cudaMalloc"
	.text
.globl lcudaMalloc
	.type	lcudaMalloc, @function
lcudaMalloc:
.LFB72:
	.loc 1 1160 0
	pushq	%rbp
.LCFI176:
	movq	%rsp, %rbp
.LCFI177:
	subq	$32, %rsp
.LCFI178:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 1165 0
	leaq	__FUNCTION__.11016(%rip), %rdi
	call	l_printFuncSigImpl@PLT
	.loc 1 1167 0
	movq	pFunc.11015(%rip), %rax
	testq	%rax, %rax
	jne	.L341
	.loc 1 1168 0
	leaq	.LC56(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11015(%rip)
	.loc 1 1170 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L341
	.loc 1 1171 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -20(%rbp)
	jmp	.L344
.L341:
	.loc 1 1174 0
	movq	pFunc.11015(%rip), %rax
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -20(%rbp)
.L344:
	movl	-20(%rbp), %eax
	.loc 1 1175 0
	leave
	ret
.LFE72:
	.size	lcudaMalloc, .-lcudaMalloc
.globl cudaMalloc
	.type	cudaMalloc, @function
cudaMalloc:
.LFB73:
	.loc 1 1184 0
	pushq	%rbp
.LCFI179:
	movq	%rsp, %rbp
.LCFI180:
	subq	$32, %rsp
.LCFI181:
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	.loc 1 1186 0
	movl	CUR_DEV(%rip), %eax
	cmpl	$1, %eax
	jg	.L347
	.loc 1 1187 0
	movq	-32(%rbp), %rsi
	movq	-24(%rbp), %rdi
	call	lcudaMalloc@PLT
	movl	%eax, -4(%rbp)
	jmp	.L349
.L347:
	.loc 1 1189 0
	movl	CUR_DEV(%rip), %edx
	movl	%edx, %eax
	shrl	$31, %eax
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, %edx
	movq	-32(%rbp), %rsi
	movq	-24(%rbp), %rdi
	call	rcudaMalloc@PLT
	movl	%eax, -4(%rbp)
.L349:
	.loc 1 1190 0
	movl	-4(%rbp), %eax
	.loc 1 1191 0
	leave
	ret
.LFE73:
	.size	cudaMalloc, .-cudaMalloc
	.section	.rodata
	.type	__FUNCTION__.11052, @object
	.size	__FUNCTION__.11052, 15
__FUNCTION__.11052:
	.string	"cudaMallocHost"
	.local	pFunc.11051
	.comm	pFunc.11051,8,8
.LC57:
	.string	"cudaMallocHost"
	.text
.globl cudaMallocHost
	.type	cudaMallocHost, @function
cudaMallocHost:
.LFB74:
	.loc 1 1193 0
	pushq	%rbp
.LCFI182:
	movq	%rsp, %rbp
.LCFI183:
	subq	$32, %rsp
.LCFI184:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 1197 0
	movq	pFunc.11051(%rip), %rax
	testq	%rax, %rax
	jne	.L352
	.loc 1 1198 0
	leaq	.LC57(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11051(%rip)
	.loc 1 1200 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L352
	.loc 1 1201 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -20(%rbp)
	jmp	.L355
.L352:
	.loc 1 1204 0
	leaq	__FUNCTION__.11052(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1206 0
	movq	pFunc.11051(%rip), %rax
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -20(%rbp)
.L355:
	movl	-20(%rbp), %eax
	.loc 1 1207 0
	leave
	ret
.LFE74:
	.size	cudaMallocHost, .-cudaMallocHost
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11077, @object
	.size	__FUNCTION__.11077, 16
__FUNCTION__.11077:
	.string	"cudaMallocPitch"
	.local	pFunc.11076
	.comm	pFunc.11076,8,8
.LC58:
	.string	"cudaMallocPitch"
	.text
.globl cudaMallocPitch
	.type	cudaMallocPitch, @function
cudaMallocPitch:
.LFB75:
	.loc 1 1210 0
	pushq	%rbp
.LCFI185:
	movq	%rsp, %rbp
.LCFI186:
	subq	$48, %rsp
.LCFI187:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	.loc 1 1215 0
	movq	pFunc.11076(%rip), %rax
	testq	%rax, %rax
	jne	.L358
	.loc 1 1216 0
	leaq	.LC58(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11076(%rip)
	.loc 1 1218 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L358
	.loc 1 1219 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -36(%rbp)
	jmp	.L361
.L358:
	.loc 1 1221 0
	leaq	__FUNCTION__.11077(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1223 0
	movq	pFunc.11076(%rip), %rax
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -36(%rbp)
.L361:
	movl	-36(%rbp), %eax
	.loc 1 1224 0
	leave
	ret
.LFE75:
	.size	cudaMallocPitch, .-cudaMallocPitch
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11104, @object
	.size	__FUNCTION__.11104, 16
__FUNCTION__.11104:
	.string	"cudaMallocArray"
	.local	pFunc.11103
	.comm	pFunc.11103,8,8
.LC59:
	.string	"cudaMallocArray"
	.text
.globl cudaMallocArray
	.type	cudaMallocArray, @function
cudaMallocArray:
.LFB76:
	.loc 1 1228 0
	pushq	%rbp
.LCFI188:
	movq	%rsp, %rbp
.LCFI189:
	subq	$48, %rsp
.LCFI190:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movl	%r8d, -36(%rbp)
	.loc 1 1233 0
	movq	pFunc.11103(%rip), %rax
	testq	%rax, %rax
	jne	.L364
	.loc 1 1234 0
	leaq	.LC59(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11103(%rip)
	.loc 1 1236 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L364
	.loc 1 1237 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -40(%rbp)
	jmp	.L367
.L364:
	.loc 1 1239 0
	leaq	__FUNCTION__.11104(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1241 0
	movq	pFunc.11103(%rip), %r9
	movl	-36(%rbp), %eax
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	movl	%eax, %r8d
	call	*%r9
	movl	%eax, -40(%rbp)
.L367:
	movl	-40(%rbp), %eax
	.loc 1 1242 0
	leave
	ret
.LFE76:
	.size	cudaMallocArray, .-cudaMallocArray
	.section	.rodata
	.type	__FUNCTION__.11122, @object
	.size	__FUNCTION__.11122, 10
__FUNCTION__.11122:
	.string	"rcudaFree"
	.align 8
.LC60:
	.string	"%s: __OK__ The used pointer %p\n"
	.align 8
.LC61:
	.string	"%s: __ERROR__ Return from rpc with the wrong return value.\n"
	.text
.globl rcudaFree
	.type	rcudaFree, @function
rcudaFree:
.LFB77:
	.loc 1 1245 0
	pushq	%rbp
.LCFI191:
	movq	%rsp, %rbp
.LCFI192:
	subq	$32, %rsp
.LCFI193:
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	.loc 1 1248 0
	leaq	-8(%rbp), %rdi
	leaq	__FUNCTION__.11122(%rip), %rdx
	movl	$2, %esi
	call	l_remoteInitMetThrReq@PLT
	cmpl	$-1, %eax
	jne	.L370
	.loc 1 1249 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -32(%rbp)
	jmp	.L372
.L370:
	.loc 1 1251 0
	movq	-8(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rax, 24(%rdx)
	.loc 1 1254 0
	movq	-8(%rbp), %rdi
	movl	-28(%rbp), %esi
	call	nvbackCudaFree_rpc@PLT
	testl	%eax, %eax
	jne	.L373
	.loc 1 1255 0
	movl	$1256, %ecx
	leaq	__FUNCTION__.11122(%rip), %rdx
	movl	$5, %esi
	leaq	.LC53(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-8(%rbp), %rax
	movq	24(%rax), %rdx
	leaq	__FUNCTION__.11122(%rip), %rsi
	leaq	.LC60(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 1257 0
	movl	$0, cuda_err(%rip)
	jmp	.L375
.L373:
	.loc 1 1259 0
	movl	$1259, %ecx
	leaq	__FUNCTION__.11122(%rip), %rdx
	movl	$0, %esi
	leaq	.LC53(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	__FUNCTION__.11122(%rip), %rsi
	leaq	.LC61(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 1260 0
	movl	$30, cuda_err(%rip)
.L375:
	.loc 1 1263 0
	movq	-8(%rbp), %rdi
	call	free@PLT
	.loc 1 1265 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -32(%rbp)
.L372:
	movl	-32(%rbp), %eax
	.loc 1 1266 0
	leave
	ret
.LFE77:
	.size	rcudaFree, .-rcudaFree
	.section	.rodata
	.type	__FUNCTION__.11145, @object
	.size	__FUNCTION__.11145, 10
__FUNCTION__.11145:
	.string	"lcudaFree"
	.local	pFunc.11144
	.comm	pFunc.11144,8,8
.LC62:
	.string	"cudaFree"
	.text
.globl lcudaFree
	.type	lcudaFree, @function
lcudaFree:
.LFB78:
	.loc 1 1276 0
	pushq	%rbp
.LCFI194:
	movq	%rsp, %rbp
.LCFI195:
	subq	$16, %rsp
.LCFI196:
	movq	%rdi, -8(%rbp)
	.loc 1 1281 0
	leaq	__FUNCTION__.11145(%rip), %rdi
	call	l_printFuncSigImpl@PLT
	.loc 1 1283 0
	movq	pFunc.11144(%rip), %rax
	testq	%rax, %rax
	jne	.L378
	.loc 1 1286 0
	leaq	.LC62(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11144(%rip)
	.loc 1 1288 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L378
	.loc 1 1290 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -12(%rbp)
	jmp	.L381
.L378:
	.loc 1 1295 0
	movq	pFunc.11144(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -12(%rbp)
.L381:
	movl	-12(%rbp), %eax
	.loc 1 1296 0
	leave
	ret
.LFE78:
	.size	lcudaFree, .-lcudaFree
.globl cudaFree
	.type	cudaFree, @function
cudaFree:
.LFB79:
	.loc 1 1304 0
	pushq	%rbp
.LCFI197:
	movq	%rsp, %rbp
.LCFI198:
	subq	$32, %rsp
.LCFI199:
	movq	%rdi, -24(%rbp)
	.loc 1 1306 0
	movl	CUR_DEV(%rip), %eax
	cmpl	$1, %eax
	jg	.L384
	.loc 1 1307 0
	movq	-24(%rbp), %rdi
	call	lcudaFree@PLT
	movl	%eax, -4(%rbp)
	jmp	.L386
.L384:
	.loc 1 1309 0
	movl	CUR_DEV(%rip), %edx
	movl	%edx, %eax
	shrl	$31, %eax
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, %esi
	movq	-24(%rbp), %rdi
	call	rcudaFree@PLT
	movl	%eax, -4(%rbp)
.L386:
	.loc 1 1310 0
	movl	-4(%rbp), %eax
	.loc 1 1311 0
	leave
	ret
.LFE79:
	.size	cudaFree, .-cudaFree
	.section	.rodata
	.type	__FUNCTION__.11178, @object
	.size	__FUNCTION__.11178, 13
__FUNCTION__.11178:
	.string	"cudaFreeHost"
	.local	pFunc.11177
	.comm	pFunc.11177,8,8
.LC63:
	.string	"cudaFreeHost"
	.text
.globl cudaFreeHost
	.type	cudaFreeHost, @function
cudaFreeHost:
.LFB80:
	.loc 1 1313 0
	pushq	%rbp
.LCFI200:
	movq	%rsp, %rbp
.LCFI201:
	subq	$16, %rsp
.LCFI202:
	movq	%rdi, -8(%rbp)
	.loc 1 1317 0
	movq	pFunc.11177(%rip), %rax
	testq	%rax, %rax
	jne	.L389
	.loc 1 1318 0
	leaq	.LC63(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11177(%rip)
	.loc 1 1320 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L389
	.loc 1 1321 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -12(%rbp)
	jmp	.L392
.L389:
	.loc 1 1323 0
	leaq	__FUNCTION__.11178(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1325 0
	movq	pFunc.11177(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -12(%rbp)
.L392:
	movl	-12(%rbp), %eax
	.loc 1 1326 0
	leave
	ret
.LFE80:
	.size	cudaFreeHost, .-cudaFreeHost
	.section	.rodata
	.type	__FUNCTION__.11197, @object
	.size	__FUNCTION__.11197, 14
__FUNCTION__.11197:
	.string	"cudaFreeArray"
	.local	pFunc.11196
	.comm	pFunc.11196,8,8
.LC64:
	.string	"cudaFreeArray"
	.text
.globl cudaFreeArray
	.type	cudaFreeArray, @function
cudaFreeArray:
.LFB81:
	.loc 1 1328 0
	pushq	%rbp
.LCFI203:
	movq	%rsp, %rbp
.LCFI204:
	subq	$16, %rsp
.LCFI205:
	movq	%rdi, -8(%rbp)
	.loc 1 1332 0
	movq	pFunc.11196(%rip), %rax
	testq	%rax, %rax
	jne	.L395
	.loc 1 1333 0
	leaq	.LC64(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11196(%rip)
	.loc 1 1335 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L395
	.loc 1 1336 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -12(%rbp)
	jmp	.L398
.L395:
	.loc 1 1339 0
	leaq	__FUNCTION__.11197(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1341 0
	movq	pFunc.11196(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -12(%rbp)
.L398:
	movl	-12(%rbp), %eax
	.loc 1 1342 0
	leave
	ret
.LFE81:
	.size	cudaFreeArray, .-cudaFreeArray
	.section	.rodata
	.type	__FUNCTION__.11220, @object
	.size	__FUNCTION__.11220, 14
__FUNCTION__.11220:
	.string	"cudaHostAlloc"
	.local	pFunc.11219
	.comm	pFunc.11219,8,8
.LC65:
	.string	"cudaHostAlloc"
	.text
.globl cudaHostAlloc
	.type	cudaHostAlloc, @function
cudaHostAlloc:
.LFB82:
	.loc 1 1345 0
	pushq	%rbp
.LCFI206:
	movq	%rsp, %rbp
.LCFI207:
	subq	$32, %rsp
.LCFI208:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	.loc 1 1349 0
	movq	pFunc.11219(%rip), %rax
	testq	%rax, %rax
	jne	.L401
	.loc 1 1350 0
	leaq	.LC65(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11219(%rip)
	.loc 1 1352 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L401
	.loc 1 1353 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -24(%rbp)
	jmp	.L404
.L401:
	.loc 1 1356 0
	leaq	__FUNCTION__.11220(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1358 0
	movq	pFunc.11219(%rip), %rax
	movl	-20(%rbp), %edx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -24(%rbp)
.L404:
	movl	-24(%rbp), %eax
	.loc 1 1359 0
	leave
	ret
.LFE82:
	.size	cudaHostAlloc, .-cudaHostAlloc
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11243, @object
	.size	__FUNCTION__.11243, 25
__FUNCTION__.11243:
	.string	"cudaHostGetDevicePointer"
	.local	pFunc.11242
	.comm	pFunc.11242,8,8
.LC66:
	.string	"cudaHostGetDevicePointer"
	.text
.globl cudaHostGetDevicePointer
	.type	cudaHostGetDevicePointer, @function
cudaHostGetDevicePointer:
.LFB83:
	.loc 1 1362 0
	pushq	%rbp
.LCFI209:
	movq	%rsp, %rbp
.LCFI210:
	subq	$32, %rsp
.LCFI211:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	.loc 1 1367 0
	movq	pFunc.11242(%rip), %rax
	testq	%rax, %rax
	jne	.L407
	.loc 1 1368 0
	leaq	.LC66(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11242(%rip)
	.loc 1 1370 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L407
	.loc 1 1371 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -24(%rbp)
	jmp	.L410
.L407:
	.loc 1 1373 0
	leaq	__FUNCTION__.11243(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1375 0
	movq	pFunc.11242(%rip), %rax
	movl	-20(%rbp), %edx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -24(%rbp)
.L410:
	movl	-24(%rbp), %eax
	.loc 1 1376 0
	leave
	ret
.LFE83:
	.size	cudaHostGetDevicePointer, .-cudaHostGetDevicePointer
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11264, @object
	.size	__FUNCTION__.11264, 17
__FUNCTION__.11264:
	.string	"cudaHostGetFlags"
	.local	pFunc.11263
	.comm	pFunc.11263,8,8
.LC67:
	.string	"cudaHostGetFlags"
	.text
.globl cudaHostGetFlags
	.type	cudaHostGetFlags, @function
cudaHostGetFlags:
.LFB84:
	.loc 1 1378 0
	pushq	%rbp
.LCFI212:
	movq	%rsp, %rbp
.LCFI213:
	subq	$32, %rsp
.LCFI214:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 1382 0
	movq	pFunc.11263(%rip), %rax
	testq	%rax, %rax
	jne	.L413
	.loc 1 1383 0
	leaq	.LC67(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11263(%rip)
	.loc 1 1385 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L413
	.loc 1 1386 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -20(%rbp)
	jmp	.L416
.L413:
	.loc 1 1389 0
	leaq	__FUNCTION__.11264(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1391 0
	movq	pFunc.11263(%rip), %rax
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -20(%rbp)
.L416:
	movl	-20(%rbp), %eax
	.loc 1 1392 0
	leave
	ret
.LFE84:
	.size	cudaHostGetFlags, .-cudaHostGetFlags
	.section	.rodata
	.type	__FUNCTION__.11285, @object
	.size	__FUNCTION__.11285, 13
__FUNCTION__.11285:
	.string	"cudaMalloc3D"
	.local	pFunc.11284
	.comm	pFunc.11284,8,8
.LC68:
	.string	"cudaMalloc3D"
	.text
.globl cudaMalloc3D
	.type	cudaMalloc3D, @function
cudaMalloc3D:
.LFB85:
	.loc 1 1395 0
	pushq	%rbp
.LCFI215:
	movq	%rsp, %rbp
.LCFI216:
	subq	$48, %rsp
.LCFI217:
	movq	%rdi, -8(%rbp)
	.loc 1 1400 0
	movq	pFunc.11284(%rip), %rax
	testq	%rax, %rax
	jne	.L419
	.loc 1 1401 0
	leaq	.LC68(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11284(%rip)
	.loc 1 1403 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L419
	.loc 1 1404 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -12(%rbp)
	jmp	.L422
.L419:
	.loc 1 1407 0
	leaq	__FUNCTION__.11285(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1409 0
	movq	pFunc.11284(%rip), %rdx
	movq	-8(%rbp), %rdi
	movq	16(%rbp), %rax
	movq	%rax, (%rsp)
	movq	24(%rbp), %rax
	movq	%rax, 8(%rsp)
	movq	32(%rbp), %rax
	movq	%rax, 16(%rsp)
	call	*%rdx
	movl	%eax, -12(%rbp)
.L422:
	movl	-12(%rbp), %eax
	.loc 1 1410 0
	leave
	ret
.LFE85:
	.size	cudaMalloc3D, .-cudaMalloc3D
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11311, @object
	.size	__FUNCTION__.11311, 18
__FUNCTION__.11311:
	.string	"cudaMalloc3DArray"
	.local	pFunc.11310
	.comm	pFunc.11310,8,8
.LC69:
	.string	"cudaMalloc3DArray"
	.text
.globl cudaMalloc3DArray
	.type	cudaMalloc3DArray, @function
cudaMalloc3DArray:
.LFB86:
	.loc 1 1414 0
	pushq	%rbp
.LCFI218:
	movq	%rsp, %rbp
.LCFI219:
	subq	$48, %rsp
.LCFI220:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	.loc 1 1420 0
	movq	pFunc.11310(%rip), %rax
	testq	%rax, %rax
	jne	.L425
	.loc 1 1421 0
	leaq	.LC69(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11310(%rip)
	.loc 1 1423 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L425
	.loc 1 1424 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -24(%rbp)
	jmp	.L428
.L425:
	.loc 1 1426 0
	leaq	__FUNCTION__.11311(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1428 0
	movq	pFunc.11310(%rip), %rcx
	movl	-20(%rbp), %edx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	movq	16(%rbp), %rax
	movq	%rax, (%rsp)
	movq	24(%rbp), %rax
	movq	%rax, 8(%rsp)
	movq	32(%rbp), %rax
	movq	%rax, 16(%rsp)
	call	*%rcx
	movl	%eax, -24(%rbp)
.L428:
	movl	-24(%rbp), %eax
	.loc 1 1429 0
	leave
	ret
.LFE86:
	.size	cudaMalloc3DArray, .-cudaMalloc3DArray
	.section	.rodata
	.type	__FUNCTION__.11330, @object
	.size	__FUNCTION__.11330, 13
__FUNCTION__.11330:
	.string	"cudaMemcpy3D"
	.local	pFunc.11329
	.comm	pFunc.11329,8,8
.LC70:
	.string	"cudaMemcpy3D"
	.text
.globl cudaMemcpy3D
	.type	cudaMemcpy3D, @function
cudaMemcpy3D:
.LFB87:
	.loc 1 1431 0
	pushq	%rbp
.LCFI221:
	movq	%rsp, %rbp
.LCFI222:
	subq	$16, %rsp
.LCFI223:
	movq	%rdi, -8(%rbp)
	.loc 1 1435 0
	movq	pFunc.11329(%rip), %rax
	testq	%rax, %rax
	jne	.L431
	.loc 1 1436 0
	leaq	.LC70(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11329(%rip)
	.loc 1 1438 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L431
	.loc 1 1439 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -12(%rbp)
	jmp	.L434
.L431:
	.loc 1 1441 0
	leaq	__FUNCTION__.11330(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1443 0
	movq	pFunc.11329(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -12(%rbp)
.L434:
	movl	-12(%rbp), %eax
	.loc 1 1444 0
	leave
	ret
.LFE87:
	.size	cudaMemcpy3D, .-cudaMemcpy3D
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11351, @object
	.size	__FUNCTION__.11351, 18
__FUNCTION__.11351:
	.string	"cudaMemcpy3DAsync"
	.local	pFunc.11350
	.comm	pFunc.11350,8,8
.LC71:
	.string	"cudaMemcpy3DAsync"
	.text
.globl cudaMemcpy3DAsync
	.type	cudaMemcpy3DAsync, @function
cudaMemcpy3DAsync:
.LFB88:
	.loc 1 1446 0
	pushq	%rbp
.LCFI224:
	movq	%rsp, %rbp
.LCFI225:
	subq	$32, %rsp
.LCFI226:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 1451 0
	movq	pFunc.11350(%rip), %rax
	testq	%rax, %rax
	jne	.L437
	.loc 1 1452 0
	leaq	.LC71(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11350(%rip)
	.loc 1 1454 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L437
	.loc 1 1455 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -20(%rbp)
	jmp	.L440
.L437:
	.loc 1 1457 0
	leaq	__FUNCTION__.11351(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1459 0
	movq	pFunc.11350(%rip), %rax
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -20(%rbp)
.L440:
	movl	-20(%rbp), %eax
	.loc 1 1460 0
	leave
	ret
.LFE88:
	.size	cudaMemcpy3DAsync, .-cudaMemcpy3DAsync
	.section	.rodata
	.type	__FUNCTION__.11372, @object
	.size	__FUNCTION__.11372, 15
__FUNCTION__.11372:
	.string	"cudaMemGetInfo"
	.local	pFunc.11371
	.comm	pFunc.11371,8,8
.LC72:
	.string	"cudaMemGetInfo"
	.text
.globl cudaMemGetInfo
	.type	cudaMemGetInfo, @function
cudaMemGetInfo:
.LFB89:
	.loc 1 1462 0
	pushq	%rbp
.LCFI227:
	movq	%rsp, %rbp
.LCFI228:
	subq	$32, %rsp
.LCFI229:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 1466 0
	movq	pFunc.11371(%rip), %rax
	testq	%rax, %rax
	jne	.L443
	.loc 1 1467 0
	leaq	.LC72(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11371(%rip)
	.loc 1 1469 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L443
	.loc 1 1470 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -20(%rbp)
	jmp	.L446
.L443:
	.loc 1 1472 0
	leaq	__FUNCTION__.11372(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1474 0
	movq	pFunc.11371(%rip), %rax
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -20(%rbp)
.L446:
	movl	-20(%rbp), %eax
	.loc 1 1475 0
	leave
	ret
.LFE89:
	.size	cudaMemGetInfo, .-cudaMemGetInfo
	.section	.rodata
	.type	__FUNCTION__.11393, @object
	.size	__FUNCTION__.11393, 12
__FUNCTION__.11393:
	.string	"rcudaMemcpy"
.LC73:
	.string	"%s: __OK__ Return from RPC.\n"
	.text
.globl rcudaMemcpy
	.type	rcudaMemcpy, @function
rcudaMemcpy:
.LFB90:
	.loc 1 1478 0
	pushq	%rbp
.LCFI230:
	movq	%rsp, %rbp
.LCFI231:
	subq	$64, %rsp
.LCFI232:
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movl	%ecx, -44(%rbp)
	movl	%r8d, -48(%rbp)
	.loc 1 1482 0
	leaq	-8(%rbp), %rdi
	leaq	__FUNCTION__.11393(%rip), %rdx
	movl	$65535, %esi
	call	l_remoteInitMetThrReq@PLT
	cmpl	$-1, %eax
	jne	.L449
	.loc 1 1483 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -52(%rbp)
	jmp	.L451
.L449:
	.loc 1 1486 0
	movq	-8(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rax, 24(%rdx)
	.loc 1 1487 0
	movq	-8(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rax, 40(%rdx)
	.loc 1 1488 0
	movq	-8(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	%rax, 56(%rdx)
	.loc 1 1489 0
	movq	-8(%rbp), %rdx
	mov	-44(%rbp), %eax
	movq	%rax, 72(%rdx)
	.loc 1 1490 0
	movq	-8(%rbp), %rdx
	movq	-8(%rbp), %rax
	movzbl	16(%rax), %eax
	orl	$16, %eax
	movb	%al, 16(%rdx)
	.loc 1 1493 0
	movq	-8(%rbp), %rdi
	movl	-48(%rbp), %esi
	call	nvbackCudaMemcpy_rpc@PLT
	testl	%eax, %eax
	je	.L452
	.loc 1 1494 0
	movl	$1494, %ecx
	leaq	__FUNCTION__.11393(%rip), %rdx
	movl	$0, %esi
	leaq	.LC53(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	__FUNCTION__.11393(%rip), %rsi
	leaq	.LC61(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 1496 0
	movl	$30, cuda_err(%rip)
	jmp	.L454
.L452:
	.loc 1 1498 0
	movl	$1498, %ecx
	leaq	__FUNCTION__.11393(%rip), %rdx
	movl	$5, %esi
	leaq	.LC53(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	__FUNCTION__.11393(%rip), %rsi
	leaq	.LC73(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 1499 0
	movq	-8(%rbp), %rax
	movl	88(%rax), %eax
	movl	%eax, cuda_err(%rip)
.L454:
	.loc 1 1502 0
	movq	-8(%rbp), %rdi
	call	free@PLT
	.loc 1 1504 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -52(%rbp)
.L451:
	movl	-52(%rbp), %eax
	.loc 1 1505 0
	leave
	ret
.LFE90:
	.size	rcudaMemcpy, .-rcudaMemcpy
	.section	.rodata
	.type	__FUNCTION__.11431, @object
	.size	__FUNCTION__.11431, 12
__FUNCTION__.11431:
	.string	"lcudaMemcpy"
	.local	pFunc.11430
	.comm	pFunc.11430,8,8
.LC74:
	.string	"cudaMemcpy"
	.text
.globl lcudaMemcpy
	.type	lcudaMemcpy, @function
lcudaMemcpy:
.LFB91:
	.loc 1 1508 0
	pushq	%rbp
.LCFI233:
	movq	%rsp, %rbp
.LCFI234:
	subq	$32, %rsp
.LCFI235:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movl	%ecx, -28(%rbp)
	.loc 1 1513 0
	leaq	__FUNCTION__.11431(%rip), %rdi
	call	l_printFuncSigImpl@PLT
	.loc 1 1515 0
	movq	pFunc.11430(%rip), %rax
	testq	%rax, %rax
	jne	.L457
	.loc 1 1516 0
	leaq	.LC74(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11430(%rip)
	.loc 1 1518 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L457
	.loc 1 1519 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -32(%rbp)
	jmp	.L460
.L457:
	.loc 1 1523 0
	movq	pFunc.11430(%rip), %rax
	movl	-28(%rbp), %ecx
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -32(%rbp)
.L460:
	movl	-32(%rbp), %eax
	.loc 1 1524 0
	leave
	ret
.LFE91:
	.size	lcudaMemcpy, .-lcudaMemcpy
.globl cudaMemcpy
	.type	cudaMemcpy, @function
cudaMemcpy:
.LFB92:
	.loc 1 1538 0
	pushq	%rbp
.LCFI236:
	movq	%rsp, %rbp
.LCFI237:
	subq	$48, %rsp
.LCFI238:
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movl	%ecx, -44(%rbp)
	.loc 1 1540 0
	movl	CUR_DEV(%rip), %eax
	cmpl	$1, %eax
	jg	.L463
	.loc 1 1541 0
	movl	-44(%rbp), %ecx
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rsi
	movq	-24(%rbp), %rdi
	call	lcudaMemcpy@PLT
	movl	%eax, -4(%rbp)
	jmp	.L465
.L463:
	.loc 1 1543 0
	movl	CUR_DEV(%rip), %edx
	movl	%edx, %eax
	shrl	$31, %eax
	addl	%edx, %eax
	sarl	%eax
	movl	-44(%rbp), %ecx
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rsi
	movq	-24(%rbp), %rdi
	movl	%eax, %r8d
	call	rcudaMemcpy@PLT
	movl	%eax, -4(%rbp)
.L465:
	.loc 1 1544 0
	movl	-4(%rbp), %eax
	.loc 1 1545 0
	leave
	ret
.LFE92:
	.size	cudaMemcpy, .-cudaMemcpy
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11477, @object
	.size	__FUNCTION__.11477, 18
__FUNCTION__.11477:
	.string	"cudaMemcpyToArray"
	.local	pFunc.11476
	.comm	pFunc.11476,8,8
.LC75:
	.string	"cudaMemcpyToArray"
	.text
.globl cudaMemcpyToArray
	.type	cudaMemcpyToArray, @function
cudaMemcpyToArray:
.LFB93:
	.loc 1 1550 0
	pushq	%rbp
.LCFI239:
	movq	%rsp, %rbp
.LCFI240:
	subq	$48, %rsp
.LCFI241:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movq	%r8, -40(%rbp)
	movl	%r9d, -44(%rbp)
	.loc 1 1556 0
	movq	pFunc.11476(%rip), %rax
	testq	%rax, %rax
	jne	.L468
	.loc 1 1557 0
	leaq	.LC75(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11476(%rip)
	.loc 1 1559 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L468
	.loc 1 1560 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -48(%rbp)
	jmp	.L471
.L468:
	.loc 1 1562 0
	leaq	__FUNCTION__.11477(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1564 0
	movq	pFunc.11476(%rip), %r11
	movl	-44(%rbp), %eax
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rsi
	movq	-16(%rbp), %rdi
	movq	-8(%rbp), %r10
	movl	%eax, %r9d
	movq	%rdx, %r8
	movq	%rsi, %rdx
	movq	%rdi, %rsi
	movq	%r10, %rdi
	call	*%r11
	movl	%eax, -48(%rbp)
.L471:
	movl	-48(%rbp), %eax
	.loc 1 1565 0
	leave
	ret
.LFE93:
	.size	cudaMemcpyToArray, .-cudaMemcpyToArray
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11506, @object
	.size	__FUNCTION__.11506, 20
__FUNCTION__.11506:
	.string	"cudaMemcpyFromArray"
	.local	pFunc.11505
	.comm	pFunc.11505,8,8
.LC76:
	.string	"cudaMemcpyFromArray"
	.text
.globl cudaMemcpyFromArray
	.type	cudaMemcpyFromArray, @function
cudaMemcpyFromArray:
.LFB94:
	.loc 1 1568 0
	pushq	%rbp
.LCFI242:
	movq	%rsp, %rbp
.LCFI243:
	subq	$48, %rsp
.LCFI244:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movq	%r8, -40(%rbp)
	movl	%r9d, -44(%rbp)
	.loc 1 1574 0
	movq	pFunc.11505(%rip), %rax
	testq	%rax, %rax
	jne	.L474
	.loc 1 1575 0
	leaq	.LC76(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11505(%rip)
	.loc 1 1577 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L474
	.loc 1 1578 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -48(%rbp)
	jmp	.L477
.L474:
	.loc 1 1580 0
	leaq	__FUNCTION__.11506(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1582 0
	movq	pFunc.11505(%rip), %r11
	movl	-44(%rbp), %eax
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rsi
	movq	-16(%rbp), %rdi
	movq	-8(%rbp), %r10
	movl	%eax, %r9d
	movq	%rdx, %r8
	movq	%rsi, %rdx
	movq	%rdi, %rsi
	movq	%r10, %rdi
	call	*%r11
	movl	%eax, -48(%rbp)
.L477:
	movl	-48(%rbp), %eax
	.loc 1 1583 0
	leave
	ret
.LFE94:
	.size	cudaMemcpyFromArray, .-cudaMemcpyFromArray
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11539, @object
	.size	__FUNCTION__.11539, 23
__FUNCTION__.11539:
	.string	"cudaMemcpyArrayToArray"
	.local	pFunc.11538
	.comm	pFunc.11538,8,8
.LC77:
	.string	"cudaMemcpyArrayToArray"
	.text
.globl cudaMemcpyArrayToArray
	.type	cudaMemcpyArrayToArray, @function
cudaMemcpyArrayToArray:
.LFB95:
	.loc 1 1588 0
	pushq	%rbp
.LCFI245:
	movq	%rsp, %rbp
.LCFI246:
	pushq	%rbx
.LCFI247:
	subq	$72, %rsp
.LCFI248:
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movq	%r8, -48(%rbp)
	movq	%r9, -56(%rbp)
	.loc 1 1594 0
	movq	pFunc.11538(%rip), %rax
	testq	%rax, %rax
	jne	.L480
	.loc 1 1595 0
	leaq	.LC77(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11538(%rip)
	.loc 1 1597 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L480
	.loc 1 1598 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -60(%rbp)
	jmp	.L483
.L480:
	.loc 1 1600 0
	leaq	__FUNCTION__.11539(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1602 0
	movq	pFunc.11538(%rip), %rbx
	movq	-56(%rbp), %rdx
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rsi
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %r10
	movq	-16(%rbp), %r11
	movl	24(%rbp), %eax
	movl	%eax, 8(%rsp)
	movq	16(%rbp), %rax
	movq	%rax, (%rsp)
	movq	%rdx, %r9
	movq	%rcx, %r8
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r10, %rsi
	movq	%r11, %rdi
	call	*%rbx
	movl	%eax, -60(%rbp)
.L483:
	movl	-60(%rbp), %eax
	.loc 1 1605 0
	addq	$72, %rsp
	popq	%rbx
	leave
	ret
.LFE95:
	.size	cudaMemcpyArrayToArray, .-cudaMemcpyArrayToArray
	.section	.rodata
	.type	__FUNCTION__.11570, @object
	.size	__FUNCTION__.11570, 13
__FUNCTION__.11570:
	.string	"cudaMemcpy2D"
	.local	pFunc.11569
	.comm	pFunc.11569,8,8
.LC78:
	.string	"cudaMemcpy2D"
	.text
.globl cudaMemcpy2D
	.type	cudaMemcpy2D, @function
cudaMemcpy2D:
.LFB96:
	.loc 1 1608 0
	pushq	%rbp
.LCFI249:
	movq	%rsp, %rbp
.LCFI250:
	pushq	%rbx
.LCFI251:
	subq	$72, %rsp
.LCFI252:
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movq	%r8, -48(%rbp)
	movq	%r9, -56(%rbp)
	.loc 1 1614 0
	movq	pFunc.11569(%rip), %rax
	testq	%rax, %rax
	jne	.L486
	.loc 1 1615 0
	leaq	.LC78(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11569(%rip)
	.loc 1 1617 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L486
	.loc 1 1618 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -60(%rbp)
	jmp	.L489
.L486:
	.loc 1 1620 0
	leaq	__FUNCTION__.11570(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1622 0
	movq	pFunc.11569(%rip), %rbx
	movq	-56(%rbp), %rdx
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rsi
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %r10
	movq	-16(%rbp), %r11
	movl	16(%rbp), %eax
	movl	%eax, (%rsp)
	movq	%rdx, %r9
	movq	%rcx, %r8
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r10, %rsi
	movq	%r11, %rdi
	call	*%rbx
	movl	%eax, -60(%rbp)
.L489:
	movl	-60(%rbp), %eax
	.loc 1 1623 0
	addq	$72, %rsp
	popq	%rbx
	leave
	ret
.LFE96:
	.size	cudaMemcpy2D, .-cudaMemcpy2D
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11603, @object
	.size	__FUNCTION__.11603, 20
__FUNCTION__.11603:
	.string	"cudaMemcpy2DToArray"
	.local	pFunc.11602
	.comm	pFunc.11602,8,8
.LC79:
	.string	"cudaMemcpy2DToArray"
	.text
.globl cudaMemcpy2DToArray
	.type	cudaMemcpy2DToArray, @function
cudaMemcpy2DToArray:
.LFB97:
	.loc 1 1627 0
	pushq	%rbp
.LCFI253:
	movq	%rsp, %rbp
.LCFI254:
	pushq	%rbx
.LCFI255:
	subq	$72, %rsp
.LCFI256:
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movq	%r8, -48(%rbp)
	movq	%r9, -56(%rbp)
	.loc 1 1634 0
	movq	pFunc.11602(%rip), %rax
	testq	%rax, %rax
	jne	.L492
	.loc 1 1635 0
	leaq	.LC79(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11602(%rip)
	.loc 1 1637 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L492
	.loc 1 1638 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -60(%rbp)
	jmp	.L495
.L492:
	.loc 1 1640 0
	leaq	__FUNCTION__.11603(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1642 0
	movq	pFunc.11602(%rip), %rbx
	movq	-56(%rbp), %rdx
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rsi
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %r10
	movq	-16(%rbp), %r11
	movl	24(%rbp), %eax
	movl	%eax, 8(%rsp)
	movq	16(%rbp), %rax
	movq	%rax, (%rsp)
	movq	%rdx, %r9
	movq	%rcx, %r8
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r10, %rsi
	movq	%r11, %rdi
	call	*%rbx
	movl	%eax, -60(%rbp)
.L495:
	movl	-60(%rbp), %eax
	.loc 1 1643 0
	addq	$72, %rsp
	popq	%rbx
	leave
	ret
.LFE97:
	.size	cudaMemcpy2DToArray, .-cudaMemcpy2DToArray
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11636, @object
	.size	__FUNCTION__.11636, 22
__FUNCTION__.11636:
	.string	"cudaMemcpy2DFromArray"
	.local	pFunc.11635
	.comm	pFunc.11635,8,8
.LC80:
	.string	"cudaMemcpy2DFromArray"
	.text
.globl cudaMemcpy2DFromArray
	.type	cudaMemcpy2DFromArray, @function
cudaMemcpy2DFromArray:
.LFB98:
	.loc 1 1647 0
	pushq	%rbp
.LCFI257:
	movq	%rsp, %rbp
.LCFI258:
	pushq	%rbx
.LCFI259:
	subq	$72, %rsp
.LCFI260:
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movq	%r8, -48(%rbp)
	movq	%r9, -56(%rbp)
	.loc 1 1653 0
	movq	pFunc.11635(%rip), %rax
	testq	%rax, %rax
	jne	.L498
	.loc 1 1654 0
	leaq	.LC80(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11635(%rip)
	.loc 1 1656 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L498
	.loc 1 1657 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -60(%rbp)
	jmp	.L501
.L498:
	.loc 1 1659 0
	leaq	__FUNCTION__.11636(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1661 0
	movq	pFunc.11635(%rip), %rbx
	movq	-56(%rbp), %rdx
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rsi
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %r10
	movq	-16(%rbp), %r11
	movl	24(%rbp), %eax
	movl	%eax, 8(%rsp)
	movq	16(%rbp), %rax
	movq	%rax, (%rsp)
	movq	%rdx, %r9
	movq	%rcx, %r8
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r10, %rsi
	movq	%r11, %rdi
	call	*%rbx
	movl	%eax, -60(%rbp)
.L501:
	movl	-60(%rbp), %eax
	.loc 1 1662 0
	addq	$72, %rsp
	popq	%rbx
	leave
	ret
.LFE98:
	.size	cudaMemcpy2DFromArray, .-cudaMemcpy2DFromArray
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11671, @object
	.size	__FUNCTION__.11671, 25
__FUNCTION__.11671:
	.string	"cudaMemcpy2DArrayToArray"
	.local	pFunc.11670
	.comm	pFunc.11670,8,8
.LC81:
	.string	"cudaMemcpy2DArrayToArray"
	.text
.globl cudaMemcpy2DArrayToArray
	.type	cudaMemcpy2DArrayToArray, @function
cudaMemcpy2DArrayToArray:
.LFB99:
	.loc 1 1667 0
	pushq	%rbp
.LCFI261:
	movq	%rsp, %rbp
.LCFI262:
	pushq	%rbx
.LCFI263:
	subq	$88, %rsp
.LCFI264:
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movq	%r8, -48(%rbp)
	movq	%r9, -56(%rbp)
	.loc 1 1674 0
	movq	pFunc.11670(%rip), %rax
	testq	%rax, %rax
	jne	.L504
	.loc 1 1675 0
	leaq	.LC81(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11670(%rip)
	.loc 1 1677 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L504
	.loc 1 1678 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -60(%rbp)
	jmp	.L507
.L504:
	.loc 1 1680 0
	leaq	__FUNCTION__.11671(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1682 0
	movq	pFunc.11670(%rip), %r10
	movq	-56(%rbp), %rdx
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rsi
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %r11
	movq	-16(%rbp), %rbx
	movl	32(%rbp), %eax
	movl	%eax, 16(%rsp)
	movq	24(%rbp), %rax
	movq	%rax, 8(%rsp)
	movq	16(%rbp), %rax
	movq	%rax, (%rsp)
	movq	%rdx, %r9
	movq	%rcx, %r8
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r11, %rsi
	movq	%rbx, %rdi
	call	*%r10
	movl	%eax, -60(%rbp)
.L507:
	movl	-60(%rbp), %eax
	.loc 1 1684 0
	addq	$88, %rsp
	popq	%rbx
	leave
	ret
.LFE99:
	.size	cudaMemcpy2DArrayToArray, .-cudaMemcpy2DArrayToArray
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11693, @object
	.size	__FUNCTION__.11693, 20
__FUNCTION__.11693:
	.string	"rcudaMemcpyToSymbol"
	.align 8
.LC82:
	.string	"__ERROR__: The symbol %p has not been found"
.LC83:
	.string	"__OK__: Return from RPC."
	.text
.globl rcudaMemcpyToSymbol
	.type	rcudaMemcpyToSymbol, @function
rcudaMemcpyToSymbol:
.LFB100:
	.loc 1 1688 0
	pushq	%rbp
.LCFI265:
	movq	%rsp, %rbp
.LCFI266:
	subq	$64, %rsp
.LCFI267:
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	%rcx, -48(%rbp)
	movl	%r8d, -52(%rbp)
	.loc 1 1692 0
	movq	$0, -8(%rbp)
	.loc 1 1706 0
	movq	regHostVarsTab(%rip), %rdi
	movq	-24(%rbp), %rsi
	call	g_vars_find@PLT
	movq	%rax, -8(%rbp)
	.loc 1 1707 0
	cmpq	$0, -8(%rbp)
	jne	.L510
	.loc 1 1708 0
	movl	$1708, %r8d
	leaq	__FUNCTION__.11693(%rip), %rcx
	movl	$2, %edx
	leaq	.LC7(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-24(%rbp), %rsi
	leaq	.LC82(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 1709 0
	movl	$13, cuda_err(%rip)
	.loc 1 1710 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -56(%rbp)
	jmp	.L512
.L510:
	.loc 1 1713 0
	leaq	-16(%rbp), %rdi
	leaq	__FUNCTION__.11693(%rip), %rdx
	movl	$21, %esi
	call	l_remoteInitMetThrReq@PLT
	cmpl	$-1, %eax
	jne	.L513
	.loc 1 1714 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -56(%rbp)
	jmp	.L512
.L513:
	.loc 1 1718 0
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rax, 24(%rdx)
	.loc 1 1719 0
	movq	-16(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rax, 40(%rdx)
	.loc 1 1720 0
	movq	-16(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	%rax, 56(%rdx)
	.loc 1 1721 0
	movq	-16(%rbp), %rdx
	movq	-48(%rbp), %rax
	movq	%rax, 64(%rdx)
	.loc 1 1722 0
	movq	-16(%rbp), %rdx
	mov	-52(%rbp), %eax
	movq	%rax, 72(%rdx)
	.loc 1 1723 0
	movq	-16(%rbp), %rdx
	movq	-16(%rbp), %rax
	movzbl	16(%rax), %eax
	orl	$16, %eax
	movb	%al, 16(%rdx)
	.loc 1 1726 0
	movq	-16(%rbp), %rdi
	call	nvbackCudaMemcpyToSymbol_rpc@PLT
	testl	%eax, %eax
	jne	.L515
	.loc 1 1727 0
	movl	$1727, %r8d
	leaq	__FUNCTION__.11693(%rip), %rcx
	movl	$5, %edx
	leaq	.LC17(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC83(%rip), %rdi
	call	puts@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 1728 0
	movq	-16(%rbp), %rax
	movl	88(%rax), %eax
	movl	%eax, cuda_err(%rip)
	jmp	.L517
.L515:
	.loc 1 1730 0
	movl	$1730, %r8d
	leaq	__FUNCTION__.11693(%rip), %rcx
	movl	$2, %edx
	leaq	.LC7(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC43(%rip), %rdi
	call	puts@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 1731 0
	movl	$30, cuda_err(%rip)
.L517:
	.loc 1 1734 0
	movq	-16(%rbp), %rdi
	call	free@PLT
	.loc 1 1736 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -56(%rbp)
.L512:
	movl	-56(%rbp), %eax
	.loc 1 1738 0
	leave
	ret
.LFE100:
	.size	rcudaMemcpyToSymbol, .-rcudaMemcpyToSymbol
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11738, @object
	.size	__FUNCTION__.11738, 20
__FUNCTION__.11738:
	.string	"lcudaMemcpyToSymbol"
	.local	pFunc.11737
	.comm	pFunc.11737,8,8
.LC84:
	.string	"cudaMemcpyToSymbol"
	.text
.globl lcudaMemcpyToSymbol
	.type	lcudaMemcpyToSymbol, @function
lcudaMemcpyToSymbol:
.LFB101:
	.loc 1 1742 0
	pushq	%rbp
.LCFI268:
	movq	%rsp, %rbp
.LCFI269:
	subq	$48, %rsp
.LCFI270:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movl	%r8d, -36(%rbp)
	.loc 1 1747 0
	leaq	__FUNCTION__.11738(%rip), %rdi
	call	l_printFuncSigImpl@PLT
	.loc 1 1749 0
	movq	pFunc.11737(%rip), %rax
	testq	%rax, %rax
	jne	.L520
	.loc 1 1750 0
	leaq	.LC84(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11737(%rip)
	.loc 1 1752 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L520
	.loc 1 1753 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -40(%rbp)
	jmp	.L523
.L520:
	.loc 1 1756 0
	movq	pFunc.11737(%rip), %r9
	movl	-36(%rbp), %eax
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	movl	%eax, %r8d
	call	*%r9
	movl	%eax, -40(%rbp)
.L523:
	movl	-40(%rbp), %eax
	.loc 1 1757 0
	leave
	ret
.LFE101:
	.size	lcudaMemcpyToSymbol, .-lcudaMemcpyToSymbol
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11758, @object
	.size	__FUNCTION__.11758, 19
__FUNCTION__.11758:
	.string	"cudaMemcpyToSymbol"
	.align 8
.LC85:
	.string	"symbol = %p, src = %p, count = %ld, offset = %ld, kind = %u\n"
	.text
.globl cudaMemcpyToSymbol
	.type	cudaMemcpyToSymbol, @function
cudaMemcpyToSymbol:
.LFB102:
	.loc 1 1761 0
	pushq	%rbp
.LCFI271:
	movq	%rsp, %rbp
.LCFI272:
	subq	$48, %rsp
.LCFI273:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movl	%r8d, -36(%rbp)
	.loc 1 1763 0
	movl	$1764, %r8d
	leaq	__FUNCTION__.11758(%rip), %rcx
	movl	$5, %edx
	leaq	.LC17(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-36(%rbp), %eax
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rcx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	movl	%eax, %r9d
	movq	%rdx, %r8
	movq	%rsi, %rdx
	movq	%rdi, %rsi
	leaq	.LC85(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 1766 0
	movl	LOCAL_EXEC(%rip), %eax
	cmpl	$1, %eax
	jne	.L526
	.loc 1 1767 0
	movl	-36(%rbp), %eax
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	movl	%eax, %r8d
	call	lcudaMemcpyToSymbol@PLT
	movl	%eax, -40(%rbp)
	jmp	.L528
.L526:
	.loc 1 1769 0
	movl	-36(%rbp), %eax
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	movl	%eax, %r8d
	call	rcudaMemcpyToSymbol@PLT
	movl	%eax, -40(%rbp)
.L528:
	movl	-40(%rbp), %eax
	.loc 1 1770 0
	leave
	ret
.LFE102:
	.size	cudaMemcpyToSymbol, .-cudaMemcpyToSymbol
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11776, @object
	.size	__FUNCTION__.11776, 22
__FUNCTION__.11776:
	.string	"rcudaMemcpyFromSymbol"
	.align 8
.LC86:
	.string	"The symbol %p has not been found!"
.LC87:
	.string	" __OK__ Return from RPC."
	.text
.globl rcudaMemcpyFromSymbol
	.type	rcudaMemcpyFromSymbol, @function
rcudaMemcpyFromSymbol:
.LFB103:
	.loc 1 1776 0
	pushq	%rbp
.LCFI274:
	movq	%rsp, %rbp
.LCFI275:
	subq	$64, %rsp
.LCFI276:
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	%rcx, -48(%rbp)
	movl	%r8d, -52(%rbp)
	.loc 1 1780 0
	movq	$0, -8(%rbp)
	.loc 1 1795 0
	movq	regHostVarsTab(%rip), %rdi
	movq	-32(%rbp), %rsi
	call	g_vars_find@PLT
	movq	%rax, -8(%rbp)
	.loc 1 1796 0
	cmpq	$0, -8(%rbp)
	jne	.L531
	.loc 1 1797 0
	movl	$1797, %r8d
	leaq	__FUNCTION__.11776(%rip), %rcx
	movl	$2, %edx
	leaq	.LC7(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-32(%rbp), %rsi
	leaq	.LC86(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 1798 0
	movl	$13, cuda_err(%rip)
	.loc 1 1799 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -56(%rbp)
	jmp	.L533
.L531:
	.loc 1 1803 0
	leaq	-16(%rbp), %rdi
	leaq	__FUNCTION__.11776(%rip), %rdx
	movl	$22, %esi
	call	l_remoteInitMetThrReq@PLT
	cmpl	$-1, %eax
	jne	.L534
	.loc 1 1804 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -56(%rbp)
	jmp	.L533
.L534:
	.loc 1 1808 0
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rax, 24(%rdx)
	.loc 1 1809 0
	movq	-16(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rax, 40(%rdx)
	.loc 1 1810 0
	movq	-16(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	%rax, 56(%rdx)
	.loc 1 1811 0
	movq	-16(%rbp), %rdx
	movq	-48(%rbp), %rax
	movq	%rax, 64(%rdx)
	.loc 1 1812 0
	movq	-16(%rbp), %rdx
	mov	-52(%rbp), %eax
	movq	%rax, 72(%rdx)
	.loc 1 1813 0
	movq	-16(%rbp), %rdx
	movq	-16(%rbp), %rax
	movzbl	16(%rax), %eax
	orl	$16, %eax
	movb	%al, 16(%rdx)
	.loc 1 1816 0
	movq	-16(%rbp), %rdi
	call	nvbackCudaMemcpyFromSymbol_rpc@PLT
	testl	%eax, %eax
	jne	.L536
	.loc 1 1817 0
	movl	$1817, %r8d
	leaq	__FUNCTION__.11776(%rip), %rcx
	movl	$5, %edx
	leaq	.LC17(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC87(%rip), %rdi
	call	puts@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 1818 0
	movq	-16(%rbp), %rax
	movl	88(%rax), %eax
	movl	%eax, cuda_err(%rip)
	jmp	.L538
.L536:
	.loc 1 1820 0
	movl	$1820, %r8d
	leaq	__FUNCTION__.11776(%rip), %rcx
	movl	$2, %edx
	leaq	.LC7(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC11(%rip), %rdi
	call	puts@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 1822 0
	movl	$30, cuda_err(%rip)
.L538:
	.loc 1 1825 0
	movq	-16(%rbp), %rdi
	call	free@PLT
	.loc 1 1827 0
	movl	cuda_err(%rip), %eax
	movl	%eax, -56(%rbp)
.L533:
	movl	-56(%rbp), %eax
	.loc 1 1828 0
	leave
	ret
.LFE103:
	.size	rcudaMemcpyFromSymbol, .-rcudaMemcpyFromSymbol
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11821, @object
	.size	__FUNCTION__.11821, 22
__FUNCTION__.11821:
	.string	"lcudaMemcpyFromSymbol"
	.local	pFunc.11820
	.comm	pFunc.11820,8,8
.LC88:
	.string	"cudaMemcpyFromSymbol"
	.text
.globl lcudaMemcpyFromSymbol
	.type	lcudaMemcpyFromSymbol, @function
lcudaMemcpyFromSymbol:
.LFB104:
	.loc 1 1832 0
	pushq	%rbp
.LCFI277:
	movq	%rsp, %rbp
.LCFI278:
	subq	$48, %rsp
.LCFI279:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movl	%r8d, -36(%rbp)
	.loc 1 1837 0
	leaq	__FUNCTION__.11821(%rip), %rdi
	call	l_printFuncSigImpl@PLT
	.loc 1 1839 0
	movq	pFunc.11820(%rip), %rax
	testq	%rax, %rax
	jne	.L541
	.loc 1 1840 0
	leaq	.LC88(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11820(%rip)
	.loc 1 1842 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L541
	.loc 1 1843 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -40(%rbp)
	jmp	.L544
.L541:
	.loc 1 1846 0
	movq	pFunc.11820(%rip), %r9
	movl	-36(%rbp), %eax
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	movl	%eax, %r8d
	call	*%r9
	movl	%eax, -40(%rbp)
.L544:
	movl	-40(%rbp), %eax
	.loc 1 1847 0
	leave
	ret
.LFE104:
	.size	lcudaMemcpyFromSymbol, .-lcudaMemcpyFromSymbol
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11841, @object
	.size	__FUNCTION__.11841, 21
__FUNCTION__.11841:
	.string	"cudaMemcpyFromSymbol"
	.align 8
.LC89:
	.string	"dst = %p, symbol = %p (str %s), count = %ld, offset = %ld, kind = %d\n"
	.text
.globl cudaMemcpyFromSymbol
	.type	cudaMemcpyFromSymbol, @function
cudaMemcpyFromSymbol:
.LFB105:
	.loc 1 1851 0
	pushq	%rbp
.LCFI280:
	movq	%rsp, %rbp
.LCFI281:
	subq	$48, %rsp
.LCFI282:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movl	%r8d, -36(%rbp)
	.loc 1 1852 0
	movl	$1853, %r8d
	leaq	__FUNCTION__.11841(%rip), %rcx
	movl	$5, %edx
	leaq	.LC17(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rcx
	movq	-16(%rbp), %rsi
	movq	-16(%rbp), %rdi
	movq	-8(%rbp), %r10
	movl	-36(%rbp), %eax
	movl	%eax, (%rsp)
	movq	%rdx, %r9
	movq	%rcx, %r8
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r10, %rsi
	leaq	.LC89(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 1855 0
	movl	LOCAL_EXEC(%rip), %eax
	cmpl	$1, %eax
	jne	.L547
	.loc 1 1856 0
	movl	-36(%rbp), %eax
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	movl	%eax, %r8d
	call	lcudaMemcpyFromSymbol@PLT
	movl	%eax, -40(%rbp)
	jmp	.L549
.L547:
	.loc 1 1858 0
	movl	-36(%rbp), %eax
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	movl	%eax, %r8d
	call	rcudaMemcpyFromSymbol@PLT
	movl	%eax, -40(%rbp)
.L549:
	movl	-40(%rbp), %eax
	.loc 1 1859 0
	leave
	ret
.LFE105:
	.size	cudaMemcpyFromSymbol, .-cudaMemcpyFromSymbol
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11864, @object
	.size	__FUNCTION__.11864, 16
__FUNCTION__.11864:
	.string	"cudaMemcpyAsync"
	.local	pFunc.11863
	.comm	pFunc.11863,8,8
.LC90:
	.string	"cudaMemcpyAsync"
	.text
.globl cudaMemcpyAsync
	.type	cudaMemcpyAsync, @function
cudaMemcpyAsync:
.LFB106:
	.loc 1 1863 0
	pushq	%rbp
.LCFI283:
	movq	%rsp, %rbp
.LCFI284:
	subq	$48, %rsp
.LCFI285:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movl	%ecx, -28(%rbp)
	movq	%r8, -40(%rbp)
	.loc 1 1868 0
	movq	pFunc.11863(%rip), %rax
	testq	%rax, %rax
	jne	.L552
	.loc 1 1869 0
	leaq	.LC90(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11863(%rip)
	.loc 1 1871 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L552
	.loc 1 1872 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -44(%rbp)
	jmp	.L555
.L552:
	.loc 1 1875 0
	leaq	__FUNCTION__.11864(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1877 0
	movq	pFunc.11863(%rip), %r9
	movq	-40(%rbp), %rax
	movl	-28(%rbp), %ecx
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	movq	%rax, %r8
	call	*%r9
	movl	%eax, -44(%rbp)
.L555:
	movl	-44(%rbp), %eax
	.loc 1 1878 0
	leave
	ret
.LFE106:
	.size	cudaMemcpyAsync, .-cudaMemcpyAsync
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11895, @object
	.size	__FUNCTION__.11895, 23
__FUNCTION__.11895:
	.string	"cudaMemcpyToArrayAsync"
	.local	pFunc.11894
	.comm	pFunc.11894,8,8
.LC91:
	.string	"cudaMemcpyToArrayAsync"
	.text
.globl cudaMemcpyToArrayAsync
	.type	cudaMemcpyToArrayAsync, @function
cudaMemcpyToArrayAsync:
.LFB107:
	.loc 1 1882 0
	pushq	%rbp
.LCFI286:
	movq	%rsp, %rbp
.LCFI287:
	pushq	%rbx
.LCFI288:
	subq	$56, %rsp
.LCFI289:
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movq	%r8, -48(%rbp)
	movl	%r9d, -52(%rbp)
	.loc 1 1888 0
	movq	pFunc.11894(%rip), %rax
	testq	%rax, %rax
	jne	.L558
	.loc 1 1889 0
	leaq	.LC91(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11894(%rip)
	.loc 1 1891 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L558
	.loc 1 1892 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -56(%rbp)
	jmp	.L561
.L558:
	.loc 1 1895 0
	leaq	__FUNCTION__.11895(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1897 0
	movq	pFunc.11894(%rip), %rbx
	movl	-52(%rbp), %edx
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rsi
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %r10
	movq	-16(%rbp), %r11
	movq	16(%rbp), %rax
	movq	%rax, (%rsp)
	movl	%edx, %r9d
	movq	%rcx, %r8
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r10, %rsi
	movq	%r11, %rdi
	call	*%rbx
	movl	%eax, -56(%rbp)
.L561:
	movl	-56(%rbp), %eax
	.loc 1 1898 0
	addq	$56, %rsp
	popq	%rbx
	leave
	ret
.LFE107:
	.size	cudaMemcpyToArrayAsync, .-cudaMemcpyToArrayAsync
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11926, @object
	.size	__FUNCTION__.11926, 25
__FUNCTION__.11926:
	.string	"cudaMemcpyFromArrayAsync"
	.local	pFunc.11925
	.comm	pFunc.11925,8,8
.LC92:
	.string	"cudaMemcpyFromArrayAsync"
	.text
.globl cudaMemcpyFromArrayAsync
	.type	cudaMemcpyFromArrayAsync, @function
cudaMemcpyFromArrayAsync:
.LFB108:
	.loc 1 1902 0
	pushq	%rbp
.LCFI290:
	movq	%rsp, %rbp
.LCFI291:
	pushq	%rbx
.LCFI292:
	subq	$56, %rsp
.LCFI293:
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movq	%r8, -48(%rbp)
	movl	%r9d, -52(%rbp)
	.loc 1 1908 0
	movq	pFunc.11925(%rip), %rax
	testq	%rax, %rax
	jne	.L564
	.loc 1 1909 0
	leaq	.LC92(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11925(%rip)
	.loc 1 1911 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L564
	.loc 1 1912 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -56(%rbp)
	jmp	.L567
.L564:
	.loc 1 1915 0
	leaq	__FUNCTION__.11926(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1917 0
	movq	pFunc.11925(%rip), %rbx
	movl	-52(%rbp), %edx
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rsi
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %r10
	movq	-16(%rbp), %r11
	movq	16(%rbp), %rax
	movq	%rax, (%rsp)
	movl	%edx, %r9d
	movq	%rcx, %r8
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r10, %rsi
	movq	%r11, %rdi
	call	*%rbx
	movl	%eax, -56(%rbp)
.L567:
	movl	-56(%rbp), %eax
	.loc 1 1918 0
	addq	$56, %rsp
	popq	%rbx
	leave
	ret
.LFE108:
	.size	cudaMemcpyFromArrayAsync, .-cudaMemcpyFromArrayAsync
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11959, @object
	.size	__FUNCTION__.11959, 18
__FUNCTION__.11959:
	.string	"cudaMemcpy2DAsync"
	.local	pFunc.11958
	.comm	pFunc.11958,8,8
.LC93:
	.string	"cudaMemcpy2DAsync"
	.text
.globl cudaMemcpy2DAsync
	.type	cudaMemcpy2DAsync, @function
cudaMemcpy2DAsync:
.LFB109:
	.loc 1 1922 0
	pushq	%rbp
.LCFI294:
	movq	%rsp, %rbp
.LCFI295:
	pushq	%rbx
.LCFI296:
	subq	$72, %rsp
.LCFI297:
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movq	%r8, -48(%rbp)
	movq	%r9, -56(%rbp)
	.loc 1 1928 0
	movq	pFunc.11958(%rip), %rax
	testq	%rax, %rax
	jne	.L570
	.loc 1 1929 0
	leaq	.LC93(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11958(%rip)
	.loc 1 1931 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L570
	.loc 1 1932 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -60(%rbp)
	jmp	.L573
.L570:
	.loc 1 1935 0
	leaq	__FUNCTION__.11959(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1937 0
	movq	pFunc.11958(%rip), %rbx
	movq	-56(%rbp), %rdx
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rsi
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %r10
	movq	-16(%rbp), %r11
	movq	24(%rbp), %rax
	movq	%rax, 8(%rsp)
	movl	16(%rbp), %eax
	movl	%eax, (%rsp)
	movq	%rdx, %r9
	movq	%rcx, %r8
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r10, %rsi
	movq	%r11, %rdi
	call	*%rbx
	movl	%eax, -60(%rbp)
.L573:
	movl	-60(%rbp), %eax
	.loc 1 1938 0
	addq	$72, %rsp
	popq	%rbx
	leave
	ret
.LFE109:
	.size	cudaMemcpy2DAsync, .-cudaMemcpy2DAsync
	.section	.rodata
	.align 16
	.type	__FUNCTION__.11994, @object
	.size	__FUNCTION__.11994, 25
__FUNCTION__.11994:
	.string	"cudaMemcpy2DToArrayAsync"
	.local	pFunc.11993
	.comm	pFunc.11993,8,8
.LC94:
	.string	"cudaMemcpy2DToArrayAsync"
	.text
.globl cudaMemcpy2DToArrayAsync
	.type	cudaMemcpy2DToArrayAsync, @function
cudaMemcpy2DToArrayAsync:
.LFB110:
	.loc 1 1943 0
	pushq	%rbp
.LCFI298:
	movq	%rsp, %rbp
.LCFI299:
	pushq	%rbx
.LCFI300:
	subq	$88, %rsp
.LCFI301:
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movq	%r8, -48(%rbp)
	movq	%r9, -56(%rbp)
	.loc 1 1949 0
	movq	pFunc.11993(%rip), %rax
	testq	%rax, %rax
	jne	.L576
	.loc 1 1950 0
	leaq	.LC94(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.11993(%rip)
	.loc 1 1952 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L576
	.loc 1 1953 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -60(%rbp)
	jmp	.L579
.L576:
	.loc 1 1956 0
	leaq	__FUNCTION__.11994(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1958 0
	movq	pFunc.11993(%rip), %r10
	movq	-56(%rbp), %rdx
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rsi
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %r11
	movq	-16(%rbp), %rbx
	movq	32(%rbp), %rax
	movq	%rax, 16(%rsp)
	movl	24(%rbp), %eax
	movl	%eax, 8(%rsp)
	movq	16(%rbp), %rax
	movq	%rax, (%rsp)
	movq	%rdx, %r9
	movq	%rcx, %r8
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r11, %rsi
	movq	%rbx, %rdi
	call	*%r10
	movl	%eax, -60(%rbp)
.L579:
	movl	-60(%rbp), %eax
	.loc 1 1960 0
	addq	$88, %rsp
	popq	%rbx
	leave
	ret
.LFE110:
	.size	cudaMemcpy2DToArrayAsync, .-cudaMemcpy2DToArrayAsync
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12029, @object
	.size	__FUNCTION__.12029, 27
__FUNCTION__.12029:
	.string	"cudaMemcpy2DFromArrayAsync"
	.local	pFunc.12028
	.comm	pFunc.12028,8,8
.LC95:
	.string	"cudaMemcpy2DFromArrayAsync"
	.text
.globl cudaMemcpy2DFromArrayAsync
	.type	cudaMemcpy2DFromArrayAsync, @function
cudaMemcpy2DFromArrayAsync:
.LFB111:
	.loc 1 1965 0
	pushq	%rbp
.LCFI302:
	movq	%rsp, %rbp
.LCFI303:
	pushq	%rbx
.LCFI304:
	subq	$88, %rsp
.LCFI305:
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movq	%r8, -48(%rbp)
	movq	%r9, -56(%rbp)
	.loc 1 1972 0
	movq	pFunc.12028(%rip), %rax
	testq	%rax, %rax
	jne	.L582
	.loc 1 1973 0
	leaq	.LC95(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12028(%rip)
	.loc 1 1975 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L582
	.loc 1 1976 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -60(%rbp)
	jmp	.L585
.L582:
	.loc 1 1979 0
	leaq	__FUNCTION__.12029(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 1981 0
	movq	pFunc.12028(%rip), %r10
	movq	-56(%rbp), %rdx
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rsi
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %r11
	movq	-16(%rbp), %rbx
	movq	32(%rbp), %rax
	movq	%rax, 16(%rsp)
	movl	24(%rbp), %eax
	movl	%eax, 8(%rsp)
	movq	16(%rbp), %rax
	movq	%rax, (%rsp)
	movq	%rdx, %r9
	movq	%rcx, %r8
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r11, %rsi
	movq	%rbx, %rdi
	call	*%r10
	movl	%eax, -60(%rbp)
.L585:
	movl	-60(%rbp), %eax
	.loc 1 1983 0
	addq	$88, %rsp
	popq	%rbx
	leave
	ret
.LFE111:
	.size	cudaMemcpy2DFromArrayAsync, .-cudaMemcpy2DFromArrayAsync
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12058, @object
	.size	__FUNCTION__.12058, 24
__FUNCTION__.12058:
	.string	"cudaMemcpyToSymbolAsync"
	.local	pFunc.12057
	.comm	pFunc.12057,8,8
.LC96:
	.string	"cudaMemcpyToSymbolAsync"
	.text
.globl cudaMemcpyToSymbolAsync
	.type	cudaMemcpyToSymbolAsync, @function
cudaMemcpyToSymbolAsync:
.LFB112:
	.loc 1 1987 0
	pushq	%rbp
.LCFI306:
	movq	%rsp, %rbp
.LCFI307:
	subq	$64, %rsp
.LCFI308:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movl	%r8d, -36(%rbp)
	movq	%r9, -48(%rbp)
	.loc 1 1993 0
	movq	pFunc.12057(%rip), %rax
	testq	%rax, %rax
	jne	.L588
	.loc 1 1994 0
	leaq	.LC96(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12057(%rip)
	.loc 1 1996 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L588
	.loc 1 1997 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -52(%rbp)
	jmp	.L591
.L588:
	.loc 1 2000 0
	leaq	__FUNCTION__.12058(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2002 0
	movq	pFunc.12057(%rip), %r11
	movq	-48(%rbp), %rax
	movl	-36(%rbp), %edx
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rsi
	movq	-16(%rbp), %rdi
	movq	-8(%rbp), %r10
	movq	%rax, %r9
	movl	%edx, %r8d
	movq	%rsi, %rdx
	movq	%rdi, %rsi
	movq	%r10, %rdi
	call	*%r11
	movl	%eax, -52(%rbp)
.L591:
	movl	-52(%rbp), %eax
	.loc 1 2003 0
	leave
	ret
.LFE112:
	.size	cudaMemcpyToSymbolAsync, .-cudaMemcpyToSymbolAsync
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12087, @object
	.size	__FUNCTION__.12087, 26
__FUNCTION__.12087:
	.string	"cudaMemcpyFromSymbolAsync"
	.local	pFunc.12086
	.comm	pFunc.12086,8,8
.LC97:
	.string	"cudaMemcpyFromSymbolAsync"
	.text
.globl cudaMemcpyFromSymbolAsync
	.type	cudaMemcpyFromSymbolAsync, @function
cudaMemcpyFromSymbolAsync:
.LFB113:
	.loc 1 2007 0
	pushq	%rbp
.LCFI309:
	movq	%rsp, %rbp
.LCFI310:
	subq	$64, %rsp
.LCFI311:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movl	%r8d, -36(%rbp)
	movq	%r9, -48(%rbp)
	.loc 1 2013 0
	movq	pFunc.12086(%rip), %rax
	testq	%rax, %rax
	jne	.L594
	.loc 1 2014 0
	leaq	.LC97(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12086(%rip)
	.loc 1 2016 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L594
	.loc 1 2017 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -52(%rbp)
	jmp	.L597
.L594:
	.loc 1 2020 0
	leaq	__FUNCTION__.12087(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2022 0
	movq	pFunc.12086(%rip), %r11
	movq	-48(%rbp), %rax
	movl	-36(%rbp), %edx
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rsi
	movq	-16(%rbp), %rdi
	movq	-8(%rbp), %r10
	movq	%rax, %r9
	movl	%edx, %r8d
	movq	%rsi, %rdx
	movq	%rdi, %rsi
	movq	%r10, %rdi
	call	*%r11
	movl	%eax, -52(%rbp)
.L597:
	movl	-52(%rbp), %eax
	.loc 1 2023 0
	leave
	ret
.LFE113:
	.size	cudaMemcpyFromSymbolAsync, .-cudaMemcpyFromSymbolAsync
	.section	.rodata
	.type	__FUNCTION__.12110, @object
	.size	__FUNCTION__.12110, 11
__FUNCTION__.12110:
	.string	"cudaMemset"
	.local	pFunc.12109
	.comm	pFunc.12109,8,8
.LC98:
	.string	"cudaMemset"
	.text
.globl cudaMemset
	.type	cudaMemset, @function
cudaMemset:
.LFB114:
	.loc 1 2026 0
	pushq	%rbp
.LCFI312:
	movq	%rsp, %rbp
.LCFI313:
	subq	$32, %rsp
.LCFI314:
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movq	%rdx, -24(%rbp)
	.loc 1 2030 0
	movq	pFunc.12109(%rip), %rax
	testq	%rax, %rax
	jne	.L600
	.loc 1 2031 0
	leaq	.LC98(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12109(%rip)
	.loc 1 2033 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L600
	.loc 1 2034 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -28(%rbp)
	jmp	.L603
.L600:
	.loc 1 2037 0
	leaq	__FUNCTION__.12110(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2039 0
	movq	pFunc.12109(%rip), %rax
	movq	-24(%rbp), %rdx
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -28(%rbp)
.L603:
	movl	-28(%rbp), %eax
	.loc 1 2040 0
	leave
	ret
.LFE114:
	.size	cudaMemset, .-cudaMemset
	.section	.rodata
	.type	__FUNCTION__.12137, @object
	.size	__FUNCTION__.12137, 13
__FUNCTION__.12137:
	.string	"cudaMemset2D"
	.local	pFunc.12136
	.comm	pFunc.12136,8,8
.LC99:
	.string	"cudaMemset2D"
	.text
.globl cudaMemset2D
	.type	cudaMemset2D, @function
cudaMemset2D:
.LFB115:
	.loc 1 2043 0
	pushq	%rbp
.LCFI315:
	movq	%rsp, %rbp
.LCFI316:
	subq	$48, %rsp
.LCFI317:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movq	%rcx, -32(%rbp)
	movq	%r8, -40(%rbp)
	.loc 1 2048 0
	movq	pFunc.12136(%rip), %rax
	testq	%rax, %rax
	jne	.L606
	.loc 1 2049 0
	leaq	.LC99(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12136(%rip)
	.loc 1 2051 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L606
	.loc 1 2052 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -44(%rbp)
	jmp	.L609
.L606:
	.loc 1 2055 0
	leaq	__FUNCTION__.12137(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2057 0
	movq	pFunc.12136(%rip), %r9
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rcx
	movl	-20(%rbp), %edx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	movq	%rax, %r8
	call	*%r9
	movl	%eax, -44(%rbp)
.L609:
	movl	-44(%rbp), %eax
	.loc 1 2058 0
	leave
	ret
.LFE115:
	.size	cudaMemset2D, .-cudaMemset2D
	.section	.rodata
	.type	__FUNCTION__.12160, @object
	.size	__FUNCTION__.12160, 13
__FUNCTION__.12160:
	.string	"cudaMemset3D"
	.local	pFunc.12159
	.comm	pFunc.12159,8,8
.LC100:
	.string	"cudaMemset3D"
	.text
.globl cudaMemset3D
	.type	cudaMemset3D, @function
cudaMemset3D:
.LFB116:
	.loc 1 2060 0
	pushq	%rbp
.LCFI318:
	movq	%rsp, %rbp
.LCFI319:
	subq	$64, %rsp
.LCFI320:
	movl	%edi, -4(%rbp)
	.loc 1 2065 0
	movq	pFunc.12159(%rip), %rax
	testq	%rax, %rax
	jne	.L612
	.loc 1 2066 0
	leaq	.LC100(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12159(%rip)
	.loc 1 2068 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L612
	.loc 1 2069 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -8(%rbp)
	jmp	.L615
.L612:
	.loc 1 2072 0
	leaq	__FUNCTION__.12160(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2074 0
	movq	pFunc.12159(%rip), %rdx
	movl	-4(%rbp), %edi
	movq	48(%rbp), %rax
	movq	%rax, 32(%rsp)
	movq	56(%rbp), %rax
	movq	%rax, 40(%rsp)
	movq	64(%rbp), %rax
	movq	%rax, 48(%rsp)
	movq	16(%rbp), %rax
	movq	%rax, (%rsp)
	movq	24(%rbp), %rax
	movq	%rax, 8(%rsp)
	movq	32(%rbp), %rax
	movq	%rax, 16(%rsp)
	movq	40(%rbp), %rax
	movq	%rax, 24(%rsp)
	call	*%rdx
	movl	%eax, -8(%rbp)
.L615:
	movl	-8(%rbp), %eax
	.loc 1 2075 0
	leave
	ret
.LFE116:
	.size	cudaMemset3D, .-cudaMemset3D
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12185, @object
	.size	__FUNCTION__.12185, 16
__FUNCTION__.12185:
	.string	"cudaMemsetAsync"
	.local	pFunc.12184
	.comm	pFunc.12184,8,8
.LC101:
	.string	"cudaMemsetAsync"
	.text
.globl cudaMemsetAsync
	.type	cudaMemsetAsync, @function
cudaMemsetAsync:
.LFB117:
	.loc 1 2077 0
	pushq	%rbp
.LCFI321:
	movq	%rsp, %rbp
.LCFI322:
	subq	$48, %rsp
.LCFI323:
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	.loc 1 2082 0
	movq	pFunc.12184(%rip), %rax
	testq	%rax, %rax
	jne	.L618
	.loc 1 2083 0
	leaq	.LC101(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12184(%rip)
	.loc 1 2085 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L618
	.loc 1 2086 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -36(%rbp)
	jmp	.L621
.L618:
	.loc 1 2089 0
	leaq	__FUNCTION__.12185(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2091 0
	movq	pFunc.12184(%rip), %rax
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rdx
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -36(%rbp)
.L621:
	movl	-36(%rbp), %eax
	.loc 1 2092 0
	leave
	ret
.LFE117:
	.size	cudaMemsetAsync, .-cudaMemsetAsync
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12214, @object
	.size	__FUNCTION__.12214, 18
__FUNCTION__.12214:
	.string	"cudaMemset2DAsync"
	.local	pFunc.12213
	.comm	pFunc.12213,8,8
.LC102:
	.string	"cudaMemset2DAsync"
	.text
.globl cudaMemset2DAsync
	.type	cudaMemset2DAsync, @function
cudaMemset2DAsync:
.LFB118:
	.loc 1 2094 0
	pushq	%rbp
.LCFI324:
	movq	%rsp, %rbp
.LCFI325:
	subq	$64, %rsp
.LCFI326:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movq	%rcx, -32(%rbp)
	movq	%r8, -40(%rbp)
	movq	%r9, -48(%rbp)
	.loc 1 2099 0
	movq	pFunc.12213(%rip), %rax
	testq	%rax, %rax
	jne	.L624
	.loc 1 2100 0
	leaq	.LC102(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12213(%rip)
	.loc 1 2102 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L624
	.loc 1 2103 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -52(%rbp)
	jmp	.L627
.L624:
	.loc 1 2106 0
	leaq	__FUNCTION__.12214(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2108 0
	movq	pFunc.12213(%rip), %r11
	movq	-48(%rbp), %rax
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rcx
	movl	-20(%rbp), %esi
	movq	-16(%rbp), %rdi
	movq	-8(%rbp), %r10
	movq	%rax, %r9
	movq	%rdx, %r8
	movl	%esi, %edx
	movq	%rdi, %rsi
	movq	%r10, %rdi
	call	*%r11
	movl	%eax, -52(%rbp)
.L627:
	movl	-52(%rbp), %eax
	.loc 1 2109 0
	leave
	ret
.LFE118:
	.size	cudaMemset2DAsync, .-cudaMemset2DAsync
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12239, @object
	.size	__FUNCTION__.12239, 18
__FUNCTION__.12239:
	.string	"cudaMemset3DAsync"
	.local	pFunc.12238
	.comm	pFunc.12238,8,8
.LC103:
	.string	"cudaMemset3DAsync"
	.text
.globl cudaMemset3DAsync
	.type	cudaMemset3DAsync, @function
cudaMemset3DAsync:
.LFB119:
	.loc 1 2111 0
	pushq	%rbp
.LCFI327:
	movq	%rsp, %rbp
.LCFI328:
	subq	$80, %rsp
.LCFI329:
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 2116 0
	movq	pFunc.12238(%rip), %rax
	testq	%rax, %rax
	jne	.L630
	.loc 1 2117 0
	leaq	.LC103(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12238(%rip)
	.loc 1 2119 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L630
	.loc 1 2120 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -20(%rbp)
	jmp	.L633
.L630:
	.loc 1 2123 0
	leaq	__FUNCTION__.12239(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2125 0
	movq	pFunc.12238(%rip), %rdx
	movq	-16(%rbp), %rsi
	movl	-4(%rbp), %edi
	movq	48(%rbp), %rax
	movq	%rax, 32(%rsp)
	movq	56(%rbp), %rax
	movq	%rax, 40(%rsp)
	movq	64(%rbp), %rax
	movq	%rax, 48(%rsp)
	movq	16(%rbp), %rax
	movq	%rax, (%rsp)
	movq	24(%rbp), %rax
	movq	%rax, 8(%rsp)
	movq	32(%rbp), %rax
	movq	%rax, 16(%rsp)
	movq	40(%rbp), %rax
	movq	%rax, 24(%rsp)
	call	*%rdx
	movl	%eax, -20(%rbp)
.L633:
	movl	-20(%rbp), %eax
	.loc 1 2126 0
	leave
	ret
.LFE119:
	.size	cudaMemset3DAsync, .-cudaMemset3DAsync
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12260, @object
	.size	__FUNCTION__.12260, 21
__FUNCTION__.12260:
	.string	"cudaGetSymbolAddress"
	.local	pFunc.12259
	.comm	pFunc.12259,8,8
.LC104:
	.string	"cudaGetSymbolAddress"
	.text
.globl cudaGetSymbolAddress
	.type	cudaGetSymbolAddress, @function
cudaGetSymbolAddress:
.LFB120:
	.loc 1 2128 0
	pushq	%rbp
.LCFI330:
	movq	%rsp, %rbp
.LCFI331:
	subq	$32, %rsp
.LCFI332:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 2132 0
	movq	pFunc.12259(%rip), %rax
	testq	%rax, %rax
	jne	.L636
	.loc 1 2133 0
	leaq	.LC104(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12259(%rip)
	.loc 1 2135 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L636
	.loc 1 2136 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -20(%rbp)
	jmp	.L639
.L636:
	.loc 1 2139 0
	leaq	__FUNCTION__.12260(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2141 0
	movq	pFunc.12259(%rip), %rax
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -20(%rbp)
.L639:
	movl	-20(%rbp), %eax
	.loc 1 2142 0
	leave
	ret
.LFE120:
	.size	cudaGetSymbolAddress, .-cudaGetSymbolAddress
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12281, @object
	.size	__FUNCTION__.12281, 18
__FUNCTION__.12281:
	.string	"cudaGetSymbolSize"
	.local	pFunc.12280
	.comm	pFunc.12280,8,8
.LC105:
	.string	"cudaGetSymbolSize"
	.text
.globl cudaGetSymbolSize
	.type	cudaGetSymbolSize, @function
cudaGetSymbolSize:
.LFB121:
	.loc 1 2144 0
	pushq	%rbp
.LCFI333:
	movq	%rsp, %rbp
.LCFI334:
	subq	$32, %rsp
.LCFI335:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 2148 0
	movq	pFunc.12280(%rip), %rax
	testq	%rax, %rax
	jne	.L642
	.loc 1 2149 0
	leaq	.LC105(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12280(%rip)
	.loc 1 2151 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L642
	.loc 1 2152 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -20(%rbp)
	jmp	.L645
.L642:
	.loc 1 2155 0
	leaq	__FUNCTION__.12281(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2157 0
	movq	pFunc.12280(%rip), %rax
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -20(%rbp)
.L645:
	movl	-20(%rbp), %eax
	.loc 1 2158 0
	leave
	ret
.LFE121:
	.size	cudaGetSymbolSize, .-cudaGetSymbolSize
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12300, @object
	.size	__FUNCTION__.12300, 31
__FUNCTION__.12300:
	.string	"cudaGraphicsUnregisterResource"
	.local	pFunc.12299
	.comm	pFunc.12299,8,8
	.align 8
.LC106:
	.string	"cudaGraphicsUnregisterResource"
	.text
.globl cudaGraphicsUnregisterResource
	.type	cudaGraphicsUnregisterResource, @function
cudaGraphicsUnregisterResource:
.LFB122:
	.loc 1 2162 0
	pushq	%rbp
.LCFI336:
	movq	%rsp, %rbp
.LCFI337:
	subq	$16, %rsp
.LCFI338:
	movq	%rdi, -8(%rbp)
	.loc 1 2166 0
	movq	pFunc.12299(%rip), %rax
	testq	%rax, %rax
	jne	.L648
	.loc 1 2167 0
	leaq	.LC106(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12299(%rip)
	.loc 1 2169 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L648
	.loc 1 2170 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -12(%rbp)
	jmp	.L651
.L648:
	.loc 1 2173 0
	leaq	__FUNCTION__.12300(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2175 0
	movq	pFunc.12299(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -12(%rbp)
.L651:
	movl	-12(%rbp), %eax
	.loc 1 2176 0
	leave
	ret
.LFE122:
	.size	cudaGraphicsUnregisterResource, .-cudaGraphicsUnregisterResource
	.section	.rodata
	.align 32
	.type	__FUNCTION__.12321, @object
	.size	__FUNCTION__.12321, 32
__FUNCTION__.12321:
	.string	"cudaGraphicsResourceSetMapFlags"
	.local	pFunc.12320
	.comm	pFunc.12320,8,8
	.align 8
.LC107:
	.string	"cudaGraphicsResourceSetMapFlags"
	.text
.globl cudaGraphicsResourceSetMapFlags
	.type	cudaGraphicsResourceSetMapFlags, @function
cudaGraphicsResourceSetMapFlags:
.LFB123:
	.loc 1 2178 0
	pushq	%rbp
.LCFI339:
	movq	%rsp, %rbp
.LCFI340:
	subq	$16, %rsp
.LCFI341:
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	.loc 1 2183 0
	movq	pFunc.12320(%rip), %rax
	testq	%rax, %rax
	jne	.L654
	.loc 1 2184 0
	leaq	.LC107(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12320(%rip)
	.loc 1 2186 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L654
	.loc 1 2187 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -16(%rbp)
	jmp	.L657
.L654:
	.loc 1 2190 0
	leaq	__FUNCTION__.12321(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2192 0
	movq	pFunc.12320(%rip), %rax
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -16(%rbp)
.L657:
	movl	-16(%rbp), %eax
	.loc 1 2193 0
	leave
	ret
.LFE123:
	.size	cudaGraphicsResourceSetMapFlags, .-cudaGraphicsResourceSetMapFlags
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12344, @object
	.size	__FUNCTION__.12344, 25
__FUNCTION__.12344:
	.string	"cudaGraphicsMapResources"
	.local	pFunc.12343
	.comm	pFunc.12343,8,8
.LC108:
	.string	"cudaGraphicsMapResources"
	.text
.globl cudaGraphicsMapResources
	.type	cudaGraphicsMapResources, @function
cudaGraphicsMapResources:
.LFB124:
	.loc 1 2195 0
	pushq	%rbp
.LCFI342:
	movq	%rsp, %rbp
.LCFI343:
	subq	$32, %rsp
.LCFI344:
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	.loc 1 2200 0
	movq	pFunc.12343(%rip), %rax
	testq	%rax, %rax
	jne	.L660
	.loc 1 2201 0
	leaq	.LC108(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12343(%rip)
	.loc 1 2203 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L660
	.loc 1 2204 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -28(%rbp)
	jmp	.L663
.L660:
	.loc 1 2207 0
	leaq	__FUNCTION__.12344(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2209 0
	movq	pFunc.12343(%rip), %rax
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rsi
	movl	-4(%rbp), %edi
	call	*%rax
	movl	%eax, -28(%rbp)
.L663:
	movl	-28(%rbp), %eax
	.loc 1 2210 0
	leave
	ret
.LFE124:
	.size	cudaGraphicsMapResources, .-cudaGraphicsMapResources
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12367, @object
	.size	__FUNCTION__.12367, 27
__FUNCTION__.12367:
	.string	"cudaGraphicsUnmapResources"
	.local	pFunc.12366
	.comm	pFunc.12366,8,8
.LC109:
	.string	"cudaGraphicsUnmapResources"
	.text
.globl cudaGraphicsUnmapResources
	.type	cudaGraphicsUnmapResources, @function
cudaGraphicsUnmapResources:
.LFB125:
	.loc 1 2212 0
	pushq	%rbp
.LCFI345:
	movq	%rsp, %rbp
.LCFI346:
	subq	$32, %rsp
.LCFI347:
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	.loc 1 2217 0
	movq	pFunc.12366(%rip), %rax
	testq	%rax, %rax
	jne	.L666
	.loc 1 2218 0
	leaq	.LC109(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12366(%rip)
	.loc 1 2220 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L666
	.loc 1 2221 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -28(%rbp)
	jmp	.L669
.L666:
	.loc 1 2224 0
	leaq	__FUNCTION__.12367(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2226 0
	movq	pFunc.12366(%rip), %rax
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rsi
	movl	-4(%rbp), %edi
	call	*%rax
	movl	%eax, -28(%rbp)
.L669:
	movl	-28(%rbp), %eax
	.loc 1 2227 0
	leave
	ret
.LFE125:
	.size	cudaGraphicsUnmapResources, .-cudaGraphicsUnmapResources
	.section	.rodata
	.align 32
	.type	__FUNCTION__.12390, @object
	.size	__FUNCTION__.12390, 37
__FUNCTION__.12390:
	.string	"cudaGraphicsResourceGetMappedPointer"
	.local	pFunc.12389
	.comm	pFunc.12389,8,8
	.align 8
.LC110:
	.string	"cudaGraphicsResourceGetMappedPointer"
	.text
.globl cudaGraphicsResourceGetMappedPointer
	.type	cudaGraphicsResourceGetMappedPointer, @function
cudaGraphicsResourceGetMappedPointer:
.LFB126:
	.loc 1 2229 0
	pushq	%rbp
.LCFI348:
	movq	%rsp, %rbp
.LCFI349:
	subq	$32, %rsp
.LCFI350:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	.loc 1 2234 0
	movq	pFunc.12389(%rip), %rax
	testq	%rax, %rax
	jne	.L672
	.loc 1 2235 0
	leaq	.LC110(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12389(%rip)
	.loc 1 2238 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L672
	.loc 1 2239 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -28(%rbp)
	jmp	.L675
.L672:
	.loc 1 2242 0
	leaq	__FUNCTION__.12390(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2244 0
	movq	pFunc.12389(%rip), %rax
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -28(%rbp)
.L675:
	movl	-28(%rbp), %eax
	.loc 1 2245 0
	leave
	ret
.LFE126:
	.size	cudaGraphicsResourceGetMappedPointer, .-cudaGraphicsResourceGetMappedPointer
	.section	.rodata
	.align 32
	.type	__FUNCTION__.12415, @object
	.size	__FUNCTION__.12415, 38
__FUNCTION__.12415:
	.string	"cudaGraphicsSubResourceGetMappedArray"
	.local	pFunc.12414
	.comm	pFunc.12414,8,8
	.align 8
.LC111:
	.string	"cudaGraphicsSubResourceGetMappedArray"
	.text
.globl cudaGraphicsSubResourceGetMappedArray
	.type	cudaGraphicsSubResourceGetMappedArray, @function
cudaGraphicsSubResourceGetMappedArray:
.LFB127:
	.loc 1 2248 0
	pushq	%rbp
.LCFI351:
	movq	%rsp, %rbp
.LCFI352:
	subq	$32, %rsp
.LCFI353:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movl	%ecx, -24(%rbp)
	.loc 1 2254 0
	movq	pFunc.12414(%rip), %rax
	testq	%rax, %rax
	jne	.L678
	.loc 1 2255 0
	leaq	.LC111(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12414(%rip)
	.loc 1 2258 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L678
	.loc 1 2259 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -28(%rbp)
	jmp	.L681
.L678:
	.loc 1 2262 0
	leaq	__FUNCTION__.12415(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2264 0
	movq	pFunc.12414(%rip), %rax
	movl	-24(%rbp), %ecx
	movl	-20(%rbp), %edx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -28(%rbp)
.L681:
	movl	-28(%rbp), %eax
	.loc 1 2265 0
	leave
	ret
.LFE127:
	.size	cudaGraphicsSubResourceGetMappedArray, .-cudaGraphicsSubResourceGetMappedArray
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12436, @object
	.size	__FUNCTION__.12436, 19
__FUNCTION__.12436:
	.string	"cudaGetChannelDesc"
	.local	pFunc.12435
	.comm	pFunc.12435,8,8
.LC112:
	.string	"cudaGetChannelDesc"
	.text
.globl cudaGetChannelDesc
	.type	cudaGetChannelDesc, @function
cudaGetChannelDesc:
.LFB128:
	.loc 1 2269 0
	pushq	%rbp
.LCFI354:
	movq	%rsp, %rbp
.LCFI355:
	subq	$32, %rsp
.LCFI356:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 2274 0
	movq	pFunc.12435(%rip), %rax
	testq	%rax, %rax
	jne	.L684
	.loc 1 2275 0
	leaq	.LC112(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12435(%rip)
	.loc 1 2277 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L684
	.loc 1 2278 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -20(%rbp)
	jmp	.L687
.L684:
	.loc 1 2281 0
	leaq	__FUNCTION__.12436(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2283 0
	movq	pFunc.12435(%rip), %rax
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -20(%rbp)
.L687:
	movl	-20(%rbp), %eax
	.loc 1 2285 0
	leave
	ret
.LFE128:
	.size	cudaGetChannelDesc, .-cudaGetChannelDesc
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12464, @object
	.size	__FUNCTION__.12464, 22
__FUNCTION__.12464:
	.string	"cudaCreateChannelDesc"
	.local	pFunc.12462
	.comm	pFunc.12462,8,8
.LC113:
	.string	"cudaCreateChannelDesc"
	.text
.globl cudaCreateChannelDesc
	.type	cudaCreateChannelDesc, @function
cudaCreateChannelDesc:
.LFB129:
	.loc 1 2293 0
	pushq	%rbp
.LCFI357:
	movq	%rsp, %rbp
.LCFI358:
	subq	$64, %rsp
.LCFI359:
	movq	%rdi, -64(%rbp)
	movl	%esi, -36(%rbp)
	movl	%edx, -40(%rbp)
	movl	%ecx, -44(%rbp)
	movl	%r8d, -48(%rbp)
	movl	%r9d, -52(%rbp)
	.loc 1 2298 0
	movq	pFunc.12462(%rip), %rax
	testq	%rax, %rax
	jne	.L690
	.loc 1 2299 0
	leaq	.LC113(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12462(%rip)
	.loc 1 2301 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L690
.LBB2:
	.loc 1 2303 0
	movq	-32(%rbp), %rax
	movq	-64(%rbp), %rdx
	movq	%rax, (%rdx)
	movq	-24(%rbp), %rax
	movq	-64(%rbp), %rdx
	movq	%rax, 8(%rdx)
	movl	-16(%rbp), %eax
	movq	-64(%rbp), %rdx
	movl	%eax, 16(%rdx)
	jmp	.L689
.L690:
.LBE2:
	.loc 1 2308 0
	leaq	__FUNCTION__.12464(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2310 0
	movq	pFunc.12462(%rip), %r10
	movl	-52(%rbp), %eax
	movl	-48(%rbp), %edx
	movl	-44(%rbp), %ecx
	movl	-40(%rbp), %esi
	movl	-36(%rbp), %edi
	movl	%eax, %r9d
	movl	%edx, %r8d
	movl	%esi, %edx
	movl	%edi, %esi
	movq	-64(%rbp), %rdi
	call	*%r10
.L689:
	.loc 1 2312 0
	movq	-64(%rbp), %rax
	leave
	ret
.LFE129:
	.size	cudaCreateChannelDesc, .-cudaCreateChannelDesc
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12492, @object
	.size	__FUNCTION__.12492, 16
__FUNCTION__.12492:
	.string	"cudaBindTexture"
	.local	pFunc.12491
	.comm	pFunc.12491,8,8
.LC114:
	.string	"cudaBindTexture"
	.text
.globl cudaBindTexture
	.type	cudaBindTexture, @function
cudaBindTexture:
.LFB130:
	.loc 1 2317 0
	pushq	%rbp
.LCFI360:
	movq	%rsp, %rbp
.LCFI361:
	subq	$48, %rsp
.LCFI362:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movq	%r8, -40(%rbp)
	.loc 1 2323 0
	movq	pFunc.12491(%rip), %rax
	testq	%rax, %rax
	jne	.L696
	.loc 1 2324 0
	leaq	.LC114(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12491(%rip)
	.loc 1 2326 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L696
	.loc 1 2327 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -44(%rbp)
	jmp	.L699
.L696:
	.loc 1 2330 0
	leaq	__FUNCTION__.12492(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2332 0
	movq	pFunc.12491(%rip), %r9
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	movq	%rax, %r8
	call	*%r9
	movl	%eax, -44(%rbp)
.L699:
	movl	-44(%rbp), %eax
	.loc 1 2334 0
	leave
	ret
.LFE130:
	.size	cudaBindTexture, .-cudaBindTexture
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12523, @object
	.size	__FUNCTION__.12523, 18
__FUNCTION__.12523:
	.string	"cudaBindTexture2D"
	.local	pFunc.12522
	.comm	pFunc.12522,8,8
.LC115:
	.string	"cudaBindTexture2D"
	.text
.globl cudaBindTexture2D
	.type	cudaBindTexture2D, @function
cudaBindTexture2D:
.LFB131:
	.loc 1 2338 0
	pushq	%rbp
.LCFI363:
	movq	%rsp, %rbp
.LCFI364:
	pushq	%rbx
.LCFI365:
	subq	$72, %rsp
.LCFI366:
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movq	%r8, -48(%rbp)
	movq	%r9, -56(%rbp)
	.loc 1 2345 0
	movq	pFunc.12522(%rip), %rax
	testq	%rax, %rax
	jne	.L702
	.loc 1 2346 0
	leaq	.LC115(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12522(%rip)
	.loc 1 2348 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L702
	.loc 1 2349 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -60(%rbp)
	jmp	.L705
.L702:
	.loc 1 2352 0
	leaq	__FUNCTION__.12523(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2354 0
	movq	pFunc.12522(%rip), %rbx
	movq	-56(%rbp), %rdx
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rsi
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %r10
	movq	-16(%rbp), %r11
	movq	16(%rbp), %rax
	movq	%rax, (%rsp)
	movq	%rdx, %r9
	movq	%rcx, %r8
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r10, %rsi
	movq	%r11, %rdi
	call	*%rbx
	movl	%eax, -60(%rbp)
.L705:
	movl	-60(%rbp), %eax
	.loc 1 2355 0
	addq	$72, %rsp
	popq	%rbx
	leave
	ret
.LFE131:
	.size	cudaBindTexture2D, .-cudaBindTexture2D
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12546, @object
	.size	__FUNCTION__.12546, 23
__FUNCTION__.12546:
	.string	"cudaBindTextureToArray"
	.local	pFunc.12545
	.comm	pFunc.12545,8,8
.LC116:
	.string	"cudaBindTextureToArray"
	.text
.globl cudaBindTextureToArray
	.type	cudaBindTextureToArray, @function
cudaBindTextureToArray:
.LFB132:
	.loc 1 2358 0
	pushq	%rbp
.LCFI367:
	movq	%rsp, %rbp
.LCFI368:
	subq	$32, %rsp
.LCFI369:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	.loc 1 2364 0
	movq	pFunc.12545(%rip), %rax
	testq	%rax, %rax
	jne	.L708
	.loc 1 2365 0
	leaq	.LC116(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12545(%rip)
	.loc 1 2367 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L708
	.loc 1 2368 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -28(%rbp)
	jmp	.L711
.L708:
	.loc 1 2371 0
	leaq	__FUNCTION__.12546(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2373 0
	movq	pFunc.12545(%rip), %rax
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -28(%rbp)
.L711:
	movl	-28(%rbp), %eax
	.loc 1 2375 0
	leave
	ret
.LFE132:
	.size	cudaBindTextureToArray, .-cudaBindTextureToArray
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12565, @object
	.size	__FUNCTION__.12565, 18
__FUNCTION__.12565:
	.string	"cudaUnbindTexture"
	.local	pFunc.12564
	.comm	pFunc.12564,8,8
.LC117:
	.string	"cudaUnbindTexture"
	.text
.globl cudaUnbindTexture
	.type	cudaUnbindTexture, @function
cudaUnbindTexture:
.LFB133:
	.loc 1 2376 0
	pushq	%rbp
.LCFI370:
	movq	%rsp, %rbp
.LCFI371:
	subq	$16, %rsp
.LCFI372:
	movq	%rdi, -8(%rbp)
	.loc 1 2380 0
	movq	pFunc.12564(%rip), %rax
	testq	%rax, %rax
	jne	.L714
	.loc 1 2381 0
	leaq	.LC117(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12564(%rip)
	.loc 1 2383 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L714
	.loc 1 2384 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -12(%rbp)
	jmp	.L717
.L714:
	.loc 1 2387 0
	leaq	__FUNCTION__.12565(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2389 0
	movq	pFunc.12564(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -12(%rbp)
.L717:
	movl	-12(%rbp), %eax
	.loc 1 2391 0
	leave
	ret
.LFE133:
	.size	cudaUnbindTexture, .-cudaUnbindTexture
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12586, @object
	.size	__FUNCTION__.12586, 30
__FUNCTION__.12586:
	.string	"cudaGetTextureAlignmentOffset"
	.local	pFunc.12585
	.comm	pFunc.12585,8,8
.LC118:
	.string	"cudaGetTextureAlignmentOffset"
	.text
.globl cudaGetTextureAlignmentOffset
	.type	cudaGetTextureAlignmentOffset, @function
cudaGetTextureAlignmentOffset:
.LFB134:
	.loc 1 2393 0
	pushq	%rbp
.LCFI373:
	movq	%rsp, %rbp
.LCFI374:
	subq	$32, %rsp
.LCFI375:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 2398 0
	movq	pFunc.12585(%rip), %rax
	testq	%rax, %rax
	jne	.L720
	.loc 1 2399 0
	leaq	.LC118(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12585(%rip)
	.loc 1 2401 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L720
	.loc 1 2402 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -20(%rbp)
	jmp	.L723
.L720:
	.loc 1 2405 0
	leaq	__FUNCTION__.12586(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2407 0
	movq	pFunc.12585(%rip), %rax
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -20(%rbp)
.L723:
	movl	-20(%rbp), %eax
	.loc 1 2408 0
	leave
	ret
.LFE134:
	.size	cudaGetTextureAlignmentOffset, .-cudaGetTextureAlignmentOffset
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12607, @object
	.size	__FUNCTION__.12607, 24
__FUNCTION__.12607:
	.string	"cudaGetTextureReference"
	.local	pFunc.12606
	.comm	pFunc.12606,8,8
.LC119:
	.string	"cudaGetTextureReference"
	.text
.globl cudaGetTextureReference
	.type	cudaGetTextureReference, @function
cudaGetTextureReference:
.LFB135:
	.loc 1 2410 0
	pushq	%rbp
.LCFI376:
	movq	%rsp, %rbp
.LCFI377:
	subq	$32, %rsp
.LCFI378:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 2415 0
	movq	pFunc.12606(%rip), %rax
	testq	%rax, %rax
	jne	.L726
	.loc 1 2416 0
	leaq	.LC119(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12606(%rip)
	.loc 1 2418 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L726
	.loc 1 2419 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -20(%rbp)
	jmp	.L729
.L726:
	.loc 1 2422 0
	leaq	__FUNCTION__.12607(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2424 0
	movq	pFunc.12606(%rip), %rax
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -20(%rbp)
.L729:
	movl	-20(%rbp), %eax
	.loc 1 2426 0
	leave
	ret
.LFE135:
	.size	cudaGetTextureReference, .-cudaGetTextureReference
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12630, @object
	.size	__FUNCTION__.12630, 23
__FUNCTION__.12630:
	.string	"cudaBindSurfaceToArray"
	.local	pFunc.12629
	.comm	pFunc.12629,8,8
.LC120:
	.string	"cudaBindSurfaceToArray"
	.text
.globl cudaBindSurfaceToArray
	.type	cudaBindSurfaceToArray, @function
cudaBindSurfaceToArray:
.LFB136:
	.loc 1 2431 0
	pushq	%rbp
.LCFI379:
	movq	%rsp, %rbp
.LCFI380:
	subq	$32, %rsp
.LCFI381:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	.loc 1 2437 0
	movq	pFunc.12629(%rip), %rax
	testq	%rax, %rax
	jne	.L732
	.loc 1 2438 0
	leaq	.LC120(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12629(%rip)
	.loc 1 2440 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L732
	.loc 1 2441 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -28(%rbp)
	jmp	.L735
.L732:
	.loc 1 2444 0
	leaq	__FUNCTION__.12630(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2446 0
	movq	pFunc.12629(%rip), %rax
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -28(%rbp)
.L735:
	movl	-28(%rbp), %eax
	.loc 1 2448 0
	leave
	ret
.LFE136:
	.size	cudaBindSurfaceToArray, .-cudaBindSurfaceToArray
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12651, @object
	.size	__FUNCTION__.12651, 24
__FUNCTION__.12651:
	.string	"cudaGetSurfaceReference"
	.local	pFunc.12650
	.comm	pFunc.12650,8,8
.LC121:
	.string	"cudaGetSurfaceReference"
	.text
.globl cudaGetSurfaceReference
	.type	cudaGetSurfaceReference, @function
cudaGetSurfaceReference:
.LFB137:
	.loc 1 2450 0
	pushq	%rbp
.LCFI382:
	movq	%rsp, %rbp
.LCFI383:
	subq	$32, %rsp
.LCFI384:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 2455 0
	movq	pFunc.12650(%rip), %rax
	testq	%rax, %rax
	jne	.L738
	.loc 1 2456 0
	leaq	.LC121(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12650(%rip)
	.loc 1 2458 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L738
	.loc 1 2459 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -20(%rbp)
	jmp	.L741
.L738:
	.loc 1 2462 0
	leaq	__FUNCTION__.12651(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2464 0
	movq	pFunc.12650(%rip), %rax
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -20(%rbp)
.L741:
	movl	-20(%rbp), %eax
	.loc 1 2465 0
	leave
	ret
.LFE137:
	.size	cudaGetSurfaceReference, .-cudaGetSurfaceReference
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12670, @object
	.size	__FUNCTION__.12670, 21
__FUNCTION__.12670:
	.string	"cudaDriverGetVersion"
	.local	pFunc.12669
	.comm	pFunc.12669,8,8
.LC122:
	.string	"cudaDriverGetVersion"
	.text
.globl cudaDriverGetVersion
	.type	cudaDriverGetVersion, @function
cudaDriverGetVersion:
.LFB138:
	.loc 1 2468 0
	pushq	%rbp
.LCFI385:
	movq	%rsp, %rbp
.LCFI386:
	subq	$16, %rsp
.LCFI387:
	movq	%rdi, -8(%rbp)
	.loc 1 2472 0
	movq	pFunc.12669(%rip), %rax
	testq	%rax, %rax
	jne	.L744
	.loc 1 2473 0
	leaq	.LC122(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12669(%rip)
	.loc 1 2475 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L744
	.loc 1 2476 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -12(%rbp)
	jmp	.L747
.L744:
	.loc 1 2479 0
	leaq	__FUNCTION__.12670(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2481 0
	movq	pFunc.12669(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -12(%rbp)
.L747:
	movl	-12(%rbp), %eax
	.loc 1 2483 0
	leave
	ret
.LFE138:
	.size	cudaDriverGetVersion, .-cudaDriverGetVersion
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12689, @object
	.size	__FUNCTION__.12689, 22
__FUNCTION__.12689:
	.string	"cudaRuntimeGetVersion"
	.local	pFunc.12688
	.comm	pFunc.12688,8,8
.LC123:
	.string	"cudaRuntimeGetVersion"
	.text
.globl cudaRuntimeGetVersion
	.type	cudaRuntimeGetVersion, @function
cudaRuntimeGetVersion:
.LFB139:
	.loc 1 2484 0
	pushq	%rbp
.LCFI388:
	movq	%rsp, %rbp
.LCFI389:
	subq	$16, %rsp
.LCFI390:
	movq	%rdi, -8(%rbp)
	.loc 1 2488 0
	movq	pFunc.12688(%rip), %rax
	testq	%rax, %rax
	jne	.L750
	.loc 1 2489 0
	leaq	.LC123(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12688(%rip)
	.loc 1 2491 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L750
	.loc 1 2492 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -12(%rbp)
	jmp	.L753
.L750:
	.loc 1 2495 0
	leaq	__FUNCTION__.12689(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2497 0
	movq	pFunc.12688(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -12(%rbp)
.L753:
	movl	-12(%rbp), %eax
	.loc 1 2498 0
	leave
	ret
.LFE139:
	.size	cudaRuntimeGetVersion, .-cudaRuntimeGetVersion
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12710, @object
	.size	__FUNCTION__.12710, 19
__FUNCTION__.12710:
	.string	"cudaGetExportTable"
	.local	pFunc.12709
	.comm	pFunc.12709,8,8
.LC124:
	.string	"cudaGetExportTable"
	.text
.globl cudaGetExportTable
	.type	cudaGetExportTable, @function
cudaGetExportTable:
.LFB140:
	.loc 1 2502 0
	pushq	%rbp
.LCFI391:
	movq	%rsp, %rbp
.LCFI392:
	subq	$32, %rsp
.LCFI393:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 2507 0
	movq	pFunc.12709(%rip), %rax
	testq	%rax, %rax
	jne	.L756
	.loc 1 2508 0
	leaq	.LC124(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12709(%rip)
	.loc 1 2510 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L756
	.loc 1 2511 0
	movl	cudaErrorDL(%rip), %eax
	movl	%eax, -20(%rbp)
	jmp	.L759
.L756:
	.loc 1 2514 0
	leaq	__FUNCTION__.12710(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2516 0
	movq	pFunc.12709(%rip), %rax
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	movl	%eax, -20(%rbp)
.L759:
	movl	-20(%rbp), %eax
	.loc 1 2517 0
	leave
	ret
.LFE140:
	.size	cudaGetExportTable, .-cudaGetExportTable
.globl pFatBinaryHandle
	.bss
	.align 8
	.type	pFatBinaryHandle, @object
	.size	pFatBinaryHandle, 8
pFatBinaryHandle:
	.zero	8
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12733, @object
	.size	__FUNCTION__.12733, 25
__FUNCTION__.12733:
	.string	"r__cudaRegisterFatBinary"
	.align 8
.LC125:
	.string	"NULL CUDA fat binary. Have to exit\n."
.LC126:
	.string	"FatCubin size: %d\n"
	.align 8
.LC127:
	.string	"pPackedFat, pPacket->args[0].argp = %p, %ld\n"
.LC128:
	.string	"CRITICAL"
	.align 8
.LC129:
	.string	"Return from rpc with the wrong return value."
.LC130:
	.string	"Returned fatCubinHandle = %p\n"
	.text
.globl r__cudaRegisterFatBinary
	.type	r__cudaRegisterFatBinary, @function
r__cudaRegisterFatBinary:
.LFB141:
	.loc 1 2533 0
	pushq	%rbp
.LCFI394:
	movq	%rsp, %rbp
.LCFI395:
	subq	$96, %rsp
.LCFI396:
	movq	%rdi, -88(%rbp)
	.loc 1 2537 0
	movq	$0, -80(%rbp)
	movq	$0, -72(%rbp)
	movq	$0, -64(%rbp)
	movl	$0, -56(%rbp)
	.loc 1 2540 0
	movq	$0, -24(%rbp)
	.loc 1 2550 0
	movq	-88(%rbp), %rax
	movq	%rax, -16(%rbp)
	.loc 1 2552 0
	movq	$0, -8(%rbp)
	.loc 1 2554 0
	movq	-88(%rbp), %rdi
	leaq	.LC125(%rip), %rsi
	call	nullExitChkpt@PLT
	.loc 1 2557 0
	leaq	-40(%rbp), %rdi
	leaq	__FUNCTION__.12733(%rip), %rdx
	movl	$33, %esi
	call	l_remoteInitMetThrReq@PLT
	cmpl	$-1, %eax
	jne	.L762
	.loc 1 2558 0
	movl	$-1, %edi
	call	exit@PLT
.L762:
	.loc 1 2561 0
	leaq	-80(%rbp), %rsi
	movq	-16(%rbp), %rdi
	call	getFatRecPktSize@PLT
	movl	%eax, -28(%rbp)
	.loc 1 2563 0
	movl	$2563, %r8d
	leaq	__FUNCTION__.12733(%rip), %rcx
	movl	$5, %edx
	leaq	.LC17(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-28(%rbp), %esi
	leaq	.LC126(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 2566 0
	movl	-28(%rbp), %eax
	movslq	%eax,%rdi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	.loc 1 2568 0
	movq	-8(%rbp), %rdi
	movl	$0, %edx
	leaq	__FUNCTION__.12733(%rip), %rsi
	call	mallocCheck@PLT
	cmpl	$-1, %eax
	jne	.L764
	.loc 1 2569 0
	movl	$-1, %edi
	call	exit@PLT
.L764:
	.loc 1 2572 0
	leaq	-80(%rbp), %rdx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	packFatBinary@PLT
	cmpl	$-1, %eax
	jne	.L766
	.loc 1 2573 0
	movl	$-1, %edi
	call	exit@PLT
.L766:
	.loc 1 2577 0
	movq	-40(%rbp), %rdx
	movq	-40(%rbp), %rax
	movzbl	16(%rax), %eax
	orl	$16, %eax
	movb	%al, 16(%rdx)
	.loc 1 2578 0
	movq	-40(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rax, 24(%rdx)
	.loc 1 2579 0
	movq	-40(%rbp), %rdx
	movl	-28(%rbp), %eax
	cltq
	movq	%rax, 40(%rdx)
	.loc 1 2581 0
	movl	$2582, %r8d
	leaq	__FUNCTION__.12733(%rip), %rcx
	movl	$5, %edx
	leaq	.LC17(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-40(%rbp), %rax
	movq	40(%rax), %rdx
	movq	-40(%rbp), %rax
	movq	24(%rax), %rsi
	leaq	.LC127(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 2584 0
	movq	-40(%rbp), %rdi
	call	__nvback_cudaRegisterFatBinary_rpc@PLT
	testl	%eax, %eax
	je	.L768
	.loc 1 2585 0
	movl	$2585, %r8d
	leaq	__FUNCTION__.12733(%rip), %rcx
	movl	$1, %edx
	leaq	.LC128(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC129(%rip), %rdi
	call	puts@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 2586 0
	movl	$30, cuda_err(%rip)
	jmp	.L770
.L768:
	.loc 1 2588 0
	movq	-40(%rbp), %rax
	movq	88(%rax), %rax
	movq	%rax, -24(%rbp)
	.loc 1 2589 0
	movl	$2589, %r8d
	leaq	__FUNCTION__.12733(%rip), %rcx
	movl	$5, %edx
	leaq	.LC17(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-40(%rbp), %rax
	movq	88(%rax), %rsi
	leaq	.LC130(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
.L770:
	.loc 1 2592 0
	movq	-40(%rbp), %rdi
	call	free@PLT
	.loc 1 2594 0
	movq	-24(%rbp), %rax
	.loc 1 2595 0
	leave
	ret
.LFE141:
	.size	r__cudaRegisterFatBinary, .-r__cudaRegisterFatBinary
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12777, @object
	.size	__FUNCTION__.12777, 25
__FUNCTION__.12777:
	.string	"l__cudaRegisterFatBinary"
	.local	func.12776
	.comm	func.12776,8,8
.LC131:
	.string	"__cudaRegisterFatBinary"
	.text
.globl l__cudaRegisterFatBinary
	.type	l__cudaRegisterFatBinary, @function
l__cudaRegisterFatBinary:
.LFB142:
	.loc 1 2597 0
	pushq	%rbp
.LCFI397:
	movq	%rsp, %rbp
.LCFI398:
	subq	$16, %rsp
.LCFI399:
	movq	%rdi, -8(%rbp)
	.loc 1 2601 0
	leaq	__FUNCTION__.12777(%rip), %rdi
	call	l_printFuncSigImpl@PLT
	.loc 1 2603 0
	movq	func.12776(%rip), %rax
	testq	%rax, %rax
	jne	.L773
	.loc 1 2604 0
	leaq	.LC131(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, func.12776(%rip)
	.loc 1 2606 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L773
	.loc 1 2607 0
	movl	$-1, %edi
	call	exit@PLT
.L773:
	.loc 1 2610 0
	movq	func.12776(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	.loc 1 2611 0
	leave
	ret
.LFE142:
	.size	l__cudaRegisterFatBinary, .-l__cudaRegisterFatBinary
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12793, @object
	.size	__FUNCTION__.12793, 24
__FUNCTION__.12793:
	.string	"__cudaRegisterFatBinary"
	.align 8
.LC132:
	.string	"LOCAL_EXEC=%d (1-local, 0-remote), faC = %p\n"
	.text
.globl __cudaRegisterFatBinary
	.type	__cudaRegisterFatBinary, @function
__cudaRegisterFatBinary:
.LFB143:
	.loc 1 2613 0
	pushq	%rbp
.LCFI400:
	movq	%rsp, %rbp
.LCFI401:
	subq	$16, %rsp
.LCFI402:
	movq	%rdi, -8(%rbp)
	.loc 1 2615 0
	call	l_getLocalFromConfig@PLT
	movl	%eax, LOCAL_EXEC(%rip)
	.loc 1 2616 0
	movl	$2616, %r8d
	leaq	__FUNCTION__.12793(%rip), %rcx
	movl	$5, %edx
	leaq	.LC17(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	LOCAL_EXEC(%rip), %esi
	movq	-8(%rbp), %rdx
	leaq	.LC132(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 2620 0
	movl	LOCAL_EXEC(%rip), %eax
	cmpl	$1, %eax
	jne	.L778
	.loc 1 2621 0
	movq	-8(%rbp), %rdi
	call	l__cudaRegisterFatBinary@PLT
	movq	%rax, -16(%rbp)
	jmp	.L780
.L778:
	.loc 1 2623 0
	movq	-8(%rbp), %rdi
	call	r__cudaRegisterFatBinary@PLT
	movq	%rax, -16(%rbp)
.L780:
	movq	-16(%rbp), %rax
	.loc 1 2624 0
	leave
	ret
.LFE143:
	.size	__cudaRegisterFatBinary, .-__cudaRegisterFatBinary
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12808, @object
	.size	__FUNCTION__.12808, 27
__FUNCTION__.12808:
	.string	"r__cudaUnregisterFatBinary"
	.align 8
.LC133:
	.string	"__OK__ Return from rpc with ok value."
	.text
.globl r__cudaUnregisterFatBinary
	.type	r__cudaUnregisterFatBinary, @function
r__cudaUnregisterFatBinary:
.LFB144:
	.loc 1 2627 0
	pushq	%rbp
.LCFI403:
	movq	%rsp, %rbp
.LCFI404:
	subq	$32, %rsp
.LCFI405:
	movq	%rdi, -24(%rbp)
	.loc 1 2630 0
	leaq	-8(%rbp), %rdi
	leaq	__FUNCTION__.12808(%rip), %rdx
	movl	$38, %esi
	call	l_remoteInitMetThrReq@PLT
	cmpl	$-1, %eax
	jne	.L783
	.loc 1 2632 0
	movl	$-1, %edi
	call	exit@PLT
.L783:
	.loc 1 2636 0
	movq	-8(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rax, 24(%rdx)
	.loc 1 2638 0
	movq	-8(%rbp), %rdi
	call	__nvback_cudaUnregisterFatBinary_rpc@PLT
	cmpl	$-1, %eax
	jne	.L785
	.loc 1 2639 0
	movl	$2639, %r8d
	leaq	__FUNCTION__.12808(%rip), %rcx
	movl	$2, %edx
	leaq	.LC7(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC11(%rip), %rdi
	call	puts@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 2641 0
	movl	$30, cuda_err(%rip)
	jmp	.L787
.L785:
	.loc 1 2645 0
	movl	$2645, %r8d
	leaq	__FUNCTION__.12808(%rip), %rcx
	movl	$5, %edx
	leaq	.LC17(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC133(%rip), %rdi
	call	puts@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 2647 0
	movq	regHostVarsTab(%rip), %rdi
	movq	-24(%rbp), %rsi
	call	g_vars_remove@PLT
	.loc 1 2649 0
	movq	regHostVarsTab(%rip), %rax
	testq	%rax, %rax
	je	.L788
	movq	regHostVarsTab(%rip), %rdi
	call	g_hash_table_size@PLT
	testl	%eax, %eax
	jne	.L788
	.loc 1 2650 0
	movq	regHostVarsTab(%rip), %rdi
	call	g_hash_table_destroy@PLT
.L788:
	.loc 1 2651 0
	movq	$0, regHostVarsTab(%rip)
.L787:
	.loc 1 2654 0
	movq	-8(%rbp), %rdi
	call	free@PLT
	.loc 1 2655 0
	leave
	ret
.LFE144:
	.size	r__cudaUnregisterFatBinary, .-r__cudaUnregisterFatBinary
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12836, @object
	.size	__FUNCTION__.12836, 27
__FUNCTION__.12836:
	.string	"l__cudaUnregisterFatBinary"
	.local	pFunc.12835
	.comm	pFunc.12835,8,8
.LC134:
	.string	"__cudaUnregisterFatBinary"
	.text
.globl l__cudaUnregisterFatBinary
	.type	l__cudaUnregisterFatBinary, @function
l__cudaUnregisterFatBinary:
.LFB145:
	.loc 1 2657 0
	pushq	%rbp
.LCFI406:
	movq	%rsp, %rbp
.LCFI407:
	subq	$16, %rsp
.LCFI408:
	movq	%rdi, -8(%rbp)
	.loc 1 2661 0
	leaq	__FUNCTION__.12836(%rip), %rdi
	call	l_printFuncSigImpl@PLT
	.loc 1 2663 0
	movq	pFunc.12835(%rip), %rax
	testq	%rax, %rax
	jne	.L793
	.loc 1 2664 0
	leaq	.LC134(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12835(%rip)
	.loc 1 2666 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L793
	.loc 1 2667 0
	movl	$-1, %edi
	call	exit@PLT
.L793:
	.loc 1 2670 0
	movq	pFunc.12835(%rip), %rax
	movq	-8(%rbp), %rdi
	call	*%rax
	.loc 1 2671 0
	leave
	ret
.LFE145:
	.size	l__cudaUnregisterFatBinary, .-l__cudaUnregisterFatBinary
.globl __cudaUnregisterFatBinary
	.type	__cudaUnregisterFatBinary, @function
__cudaUnregisterFatBinary:
.LFB146:
	.loc 1 2673 0
	pushq	%rbp
.LCFI409:
	movq	%rsp, %rbp
.LCFI410:
	subq	$16, %rsp
.LCFI411:
	movq	%rdi, -8(%rbp)
	.loc 1 2674 0
	movl	LOCAL_EXEC(%rip), %eax
	cmpl	$1, %eax
	jne	.L798
	.loc 1 2675 0
	movq	-8(%rbp), %rdi
	call	l__cudaUnregisterFatBinary@PLT
	jmp	.L801
.L798:
	.loc 1 2677 0
	movq	-8(%rbp), %rdi
	call	r__cudaUnregisterFatBinary@PLT
.L801:
	.loc 1 2678 0
	leave
	ret
.LFE146:
	.size	__cudaUnregisterFatBinary, .-__cudaUnregisterFatBinary
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12866, @object
	.size	__FUNCTION__.12866, 24
__FUNCTION__.12866:
	.string	"r__cudaRegisterFunction"
.LC135:
	.string	"ERROR"
	.align 8
.LC136:
	.string	"__ERROR__ Problems with allocating the memory. Quitting ... "
	.align 8
.LC137:
	.string	"__ERROR__: Return from the RPC with an error"
	.text
.globl r__cudaRegisterFunction
	.type	r__cudaRegisterFunction, @function
r__cudaRegisterFunction:
.LFB147:
	.loc 1 2682 0
	pushq	%rbp
.LCFI412:
	movq	%rsp, %rbp
.LCFI413:
	addq	$-128, %rsp
.LCFI414:
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movq	%rcx, -64(%rbp)
	movl	%r8d, -68(%rbp)
	movq	%r9, -80(%rbp)
	.loc 1 2685 0
	leaq	-16(%rbp), %rdi
	leaq	__FUNCTION__.12866(%rip), %rdx
	movl	$34, %esi
	call	l_remoteInitMetThrReq@PLT
	cmpl	$-1, %eax
	jne	.L803
	.loc 1 2687 0
	movl	$-1, %edi
	call	exit@PLT
.L803:
	.loc 1 2690 0
	movq	-80(%rbp), %rdx
	movl	-68(%rbp), %ecx
	movq	-64(%rbp), %rsi
	movq	-56(%rbp), %rdi
	movq	-48(%rbp), %r10
	movq	-40(%rbp), %r11
	movq	40(%rbp), %rax
	movq	%rax, 24(%rsp)
	movq	32(%rbp), %rax
	movq	%rax, 16(%rsp)
	movq	24(%rbp), %rax
	movq	%rax, 8(%rsp)
	movq	16(%rbp), %rax
	movq	%rax, (%rsp)
	movq	%rdx, %r9
	movl	%ecx, %r8d
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r10, %rsi
	movq	%r11, %rdi
	call	l_printRegFunArgs@PLT
	.loc 1 2693 0
	movl	$0, -20(%rbp)
	.loc 1 2696 0
	movq	-80(%rbp), %rdx
	movl	-68(%rbp), %ecx
	movq	-64(%rbp), %rsi
	movq	-56(%rbp), %rdi
	movq	-48(%rbp), %r10
	movq	-40(%rbp), %r11
	leaq	-20(%rbp), %rax
	movq	%rax, 32(%rsp)
	movq	40(%rbp), %rax
	movq	%rax, 24(%rsp)
	movq	32(%rbp), %rax
	movq	%rax, 16(%rsp)
	movq	24(%rbp), %rax
	movq	%rax, 8(%rsp)
	movq	16(%rbp), %rax
	movq	%rax, (%rsp)
	movq	%rdx, %r9
	movl	%ecx, %r8d
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r10, %rsi
	movq	%r11, %rdi
	call	packRegFuncArgs@PLT
	movq	%rax, -8(%rbp)
	.loc 1 2698 0
	cmpq	$0, -8(%rbp)
	jne	.L805
	.loc 1 2699 0
	movl	$2699, %r8d
	leaq	__FUNCTION__.12866(%rip), %rcx
	movl	$0, %edx
	leaq	.LC135(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC136(%rip), %rdi
	call	puts@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	movl	$-1, %edi
	call	exit@PLT
.L805:
	.loc 1 2703 0
	movq	-16(%rbp), %rdx
	movq	-16(%rbp), %rax
	movzbl	16(%rax), %eax
	orl	$16, %eax
	movb	%al, 16(%rdx)
	.loc 1 2704 0
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rax, 24(%rdx)
	.loc 1 2705 0
	movq	-16(%rbp), %rdx
	movl	-20(%rbp), %eax
	cltq
	movq	%rax, 40(%rdx)
	.loc 1 2709 0
	movq	-16(%rbp), %rdi
	call	__nvback_cudaRegisterFunction_rpc@PLT
	testl	%eax, %eax
	jne	.L807
	.loc 1 2713 0
	movq	-16(%rbp), %rax
	movl	88(%rax), %eax
	movl	%eax, cuda_err(%rip)
	jmp	.L809
.L807:
	.loc 1 2715 0
	movl	$2715, %r8d
	leaq	__FUNCTION__.12866(%rip), %rcx
	movl	$2, %edx
	leaq	.LC7(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC137(%rip), %rdi
	call	puts@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 2716 0
	movl	$30, cuda_err(%rip)
.L809:
	.loc 1 2719 0
	movq	-16(%rbp), %rdi
	call	free@PLT
	.loc 1 2721 0
	leave
	ret
.LFE147:
	.size	r__cudaRegisterFunction, .-r__cudaRegisterFunction
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12918, @object
	.size	__FUNCTION__.12918, 24
__FUNCTION__.12918:
	.string	"l__cudaRegisterFunction"
	.local	pFunc.12917
	.comm	pFunc.12917,8,8
.LC138:
	.string	"__cudaRegisterFunction"
	.text
.globl l__cudaRegisterFunction
	.type	l__cudaRegisterFunction, @function
l__cudaRegisterFunction:
.LFB148:
	.loc 1 2725 0
	pushq	%rbp
.LCFI415:
	movq	%rsp, %rbp
.LCFI416:
	pushq	%rbx
.LCFI417:
	subq	$88, %rsp
.LCFI418:
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movl	%r8d, -44(%rbp)
	movq	%r9, -56(%rbp)
	.loc 1 2732 0
	leaq	__FUNCTION__.12918(%rip), %rdi
	call	l_printFuncSigImpl@PLT
	.loc 1 2734 0
	movq	pFunc.12917(%rip), %rax
	testq	%rax, %rax
	jne	.L812
	.loc 1 2735 0
	leaq	.LC138(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12917(%rip)
	.loc 1 2737 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L812
	.loc 1 2738 0
	movl	$-1, %edi
	call	exit@PLT
.L812:
	.loc 1 2741 0
	movq	pFunc.12917(%rip), %r10
	movq	-56(%rbp), %rdx
	movl	-44(%rbp), %ecx
	movq	-40(%rbp), %rsi
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %r11
	movq	-16(%rbp), %rbx
	movq	40(%rbp), %rax
	movq	%rax, 24(%rsp)
	movq	32(%rbp), %rax
	movq	%rax, 16(%rsp)
	movq	24(%rbp), %rax
	movq	%rax, 8(%rsp)
	movq	16(%rbp), %rax
	movq	%rax, (%rsp)
	movq	%rdx, %r9
	movl	%ecx, %r8d
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r11, %rsi
	movq	%rbx, %rdi
	call	*%r10
	.loc 1 2743 0
	addq	$88, %rsp
	popq	%rbx
	leave
	ret
.LFE148:
	.size	l__cudaRegisterFunction, .-l__cudaRegisterFunction
.globl __cudaRegisterFunction
	.type	__cudaRegisterFunction, @function
__cudaRegisterFunction:
.LFB149:
	.loc 1 2747 0
	pushq	%rbp
.LCFI419:
	movq	%rsp, %rbp
.LCFI420:
	subq	$80, %rsp
.LCFI421:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movl	%r8d, -36(%rbp)
	movq	%r9, -48(%rbp)
	.loc 1 2748 0
	movl	LOCAL_EXEC(%rip), %eax
	cmpl	$1, %eax
	jne	.L817
	.loc 1 2749 0
	movq	-48(%rbp), %rdx
	movl	-36(%rbp), %ecx
	movq	-32(%rbp), %rsi
	movq	-24(%rbp), %rdi
	movq	-16(%rbp), %r10
	movq	-8(%rbp), %r11
	movq	40(%rbp), %rax
	movq	%rax, 24(%rsp)
	movq	32(%rbp), %rax
	movq	%rax, 16(%rsp)
	movq	24(%rbp), %rax
	movq	%rax, 8(%rsp)
	movq	16(%rbp), %rax
	movq	%rax, (%rsp)
	movq	%rdx, %r9
	movl	%ecx, %r8d
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r10, %rsi
	movq	%r11, %rdi
	call	l__cudaRegisterFunction@PLT
	jmp	.L820
.L817:
	.loc 1 2752 0
	movq	-48(%rbp), %rdx
	movl	-36(%rbp), %ecx
	movq	-32(%rbp), %rsi
	movq	-24(%rbp), %rdi
	movq	-16(%rbp), %r10
	movq	-8(%rbp), %r11
	movq	40(%rbp), %rax
	movq	%rax, 24(%rsp)
	movq	32(%rbp), %rax
	movq	%rax, 16(%rsp)
	movq	24(%rbp), %rax
	movq	%rax, 8(%rsp)
	movq	16(%rbp), %rax
	movq	%rax, (%rsp)
	movq	%rdx, %r9
	movl	%ecx, %r8d
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r10, %rsi
	movq	%r11, %rdi
	call	r__cudaRegisterFunction@PLT
.L820:
	.loc 1 2754 0
	leave
	ret
.LFE149:
	.size	__cudaRegisterFunction, .-__cudaRegisterFunction
	.section	.rodata
	.align 16
	.type	__FUNCTION__.12964, @object
	.size	__FUNCTION__.12964, 19
__FUNCTION__.12964:
	.string	"l__cudaRegisterVar"
	.local	pFunc.12963
	.comm	pFunc.12963,8,8
.LC139:
	.string	"__cudaRegisterVar"
	.text
.globl l__cudaRegisterVar
	.type	l__cudaRegisterVar, @function
l__cudaRegisterVar:
.LFB150:
	.loc 1 2758 0
	pushq	%rbp
.LCFI422:
	movq	%rsp, %rbp
.LCFI423:
	pushq	%rbx
.LCFI424:
	subq	$56, %rsp
.LCFI425:
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movl	%r8d, -44(%rbp)
	movl	%r9d, -48(%rbp)
	.loc 1 2764 0
	leaq	__FUNCTION__.12964(%rip), %rdi
	call	l_printFuncSigImpl@PLT
	.loc 1 2766 0
	movq	pFunc.12963(%rip), %rax
	testq	%rax, %rax
	jne	.L822
	.loc 1 2767 0
	leaq	.LC139(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.12963(%rip)
	.loc 1 2769 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L822
	.loc 1 2770 0
	movl	$-1, %edi
	call	exit@PLT
.L822:
	.loc 1 2773 0
	movq	pFunc.12963(%rip), %rbx
	movl	-48(%rbp), %edx
	movl	-44(%rbp), %ecx
	movq	-40(%rbp), %rsi
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %r10
	movq	-16(%rbp), %r11
	movl	24(%rbp), %eax
	movl	%eax, 8(%rsp)
	movl	16(%rbp), %eax
	movl	%eax, (%rsp)
	movl	%edx, %r9d
	movl	%ecx, %r8d
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r10, %rsi
	movq	%r11, %rdi
	call	*%rbx
	.loc 1 2775 0
	addq	$56, %rsp
	popq	%rbx
	leave
	ret
.LFE150:
	.size	l__cudaRegisterVar, .-l__cudaRegisterVar
	.section	.rodata
	.align 16
	.type	__PRETTY_FUNCTION__.12988, @object
	.size	__PRETTY_FUNCTION__.12988, 19
__PRETTY_FUNCTION__.12988:
	.string	"r__cudaRegisterVar"
	.align 16
	.type	__FUNCTION__.12985, @object
	.size	__FUNCTION__.12985, 19
__FUNCTION__.12985:
	.string	"r__cudaRegisterVar"
	.align 8
.LC140:
	.string	"__ERROR__ Problems with allocating the memory. Exiting ... "
.LC141:
	.string	"interposer/libci.c"
.LC142:
	.string	"fatCubinHandle != ((void *)0)"
	.text
.globl r__cudaRegisterVar
	.type	r__cudaRegisterVar, @function
r__cudaRegisterVar:
.LFB151:
	.loc 1 2780 0
	pushq	%rbp
.LCFI426:
	movq	%rsp, %rbp
.LCFI427:
	subq	$96, %rsp
.LCFI428:
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movq	%rcx, -64(%rbp)
	movl	%r8d, -68(%rbp)
	movl	%r9d, -72(%rbp)
	.loc 1 2783 0
	leaq	-16(%rbp), %rdi
	leaq	__FUNCTION__.12985(%rip), %rdx
	movl	$35, %esi
	call	l_remoteInitMetThrReq@PLT
	cmpl	$-1, %eax
	jne	.L827
	.loc 1 2785 0
	movl	$-1, %edi
	call	exit@PLT
.L827:
	.loc 1 2791 0
	movl	$0, -20(%rbp)
	.loc 1 2794 0
	movl	-72(%rbp), %edx
	movl	-68(%rbp), %ecx
	movq	-64(%rbp), %rsi
	movq	-56(%rbp), %rdi
	movq	-48(%rbp), %r10
	movq	-40(%rbp), %r11
	leaq	-20(%rbp), %rax
	movq	%rax, 16(%rsp)
	movl	24(%rbp), %eax
	movl	%eax, 8(%rsp)
	movl	16(%rbp), %eax
	movl	%eax, (%rsp)
	movl	%edx, %r9d
	movl	%ecx, %r8d
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r10, %rsi
	movq	%r11, %rdi
	call	packRegVar@PLT
	movq	%rax, -8(%rbp)
	.loc 1 2796 0
	cmpq	$0, -8(%rbp)
	jne	.L829
	.loc 1 2797 0
	movl	$2797, %r8d
	leaq	__FUNCTION__.12985(%rip), %rcx
	movl	$0, %edx
	leaq	.LC135(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC140(%rip), %rdi
	call	puts@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	movl	$-1, %edi
	call	exit@PLT
.L829:
	.loc 1 2802 0
	movq	regHostVarsTab(%rip), %rax
	testq	%rax, %rax
	jne	.L831
	.loc 1 2804 0
	movq	g_vars_remove@GOTPCREL(%rip), %rax
	movq	%rax, %rcx
	movl	$0, %edx
	movq	g_direct_equal@GOTPCREL(%rip), %rsi
	movq	g_direct_hash@GOTPCREL(%rip), %rdi
	call	g_hash_table_new_full@PLT
	movq	%rax, regHostVarsTab(%rip)
.L831:
	.loc 1 2809 0
	cmpq	$0, -40(%rbp)
	jne	.L833
	leaq	__PRETTY_FUNCTION__.12988(%rip), %rcx
	movl	$2809, %edx
	leaq	.LC141(%rip), %rsi
	leaq	.LC142(%rip), %rdi
	call	__assert_fail@PLT
.L833:
	.loc 1 2813 0
	movq	-16(%rbp), %rdx
	movq	-16(%rbp), %rax
	movzbl	16(%rax), %eax
	orl	$16, %eax
	movb	%al, 16(%rdx)
	.loc 1 2814 0
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rax, 24(%rdx)
	.loc 1 2815 0
	movq	-16(%rbp), %rdx
	movl	-20(%rbp), %eax
	cltq
	movq	%rax, 40(%rdx)
	.loc 1 2817 0
	movq	-16(%rbp), %rdi
	call	__nvback_cudaRegisterVar_rpc@PLT
	testl	%eax, %eax
	jne	.L835
	.loc 1 2818 0
	movq	-16(%rbp), %rax
	movl	88(%rax), %eax
	movl	%eax, cuda_err(%rip)
	jmp	.L837
.L835:
	.loc 1 2820 0
	movl	$2820, %r8d
	leaq	__FUNCTION__.12985(%rip), %rcx
	movl	$2, %edx
	leaq	.LC7(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC137(%rip), %rdi
	call	puts@PLT
	movq	stdout@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	fflush@PLT
	.loc 1 2821 0
	movl	$30, cuda_err(%rip)
.L837:
	.loc 1 2825 0
	movq	-64(%rbp), %rsi
	movq	-48(%rbp), %rdi
	call	g_vars_val_new@PLT
	movq	regHostVarsTab(%rip), %rdi
	movq	-40(%rbp), %rsi
	movq	%rax, %rdx
	call	g_vars_insert@PLT
	.loc 1 2827 0
	movq	regHostVarsTab(%rip), %rdi
	call	printRegVarTab@PLT
	.loc 1 2829 0
	movq	-16(%rbp), %rdi
	call	free@PLT
	.loc 1 2831 0
	leave
	ret
.LFE151:
	.size	r__cudaRegisterVar, .-r__cudaRegisterVar
.globl __cudaRegisterVar
	.type	__cudaRegisterVar, @function
__cudaRegisterVar:
.LFB152:
	.loc 1 2842 0
	pushq	%rbp
.LCFI429:
	movq	%rsp, %rbp
.LCFI430:
	subq	$64, %rsp
.LCFI431:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movl	%r8d, -36(%rbp)
	movl	%r9d, -40(%rbp)
	.loc 1 2843 0
	movl	-40(%rbp), %edx
	movl	-36(%rbp), %ecx
	movq	-32(%rbp), %rsi
	movq	-24(%rbp), %rdi
	movq	-16(%rbp), %r10
	movq	-8(%rbp), %r11
	movl	24(%rbp), %eax
	movl	%eax, 8(%rsp)
	movl	16(%rbp), %eax
	movl	%eax, (%rsp)
	movl	%edx, %r9d
	movl	%ecx, %r8d
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r10, %rsi
	movq	%r11, %rdi
	call	l_printRegVar@PLT
	.loc 1 2846 0
	movl	LOCAL_EXEC(%rip), %eax
	cmpl	$1, %eax
	jne	.L840
	.loc 1 2847 0
	movl	-40(%rbp), %edx
	movl	-36(%rbp), %ecx
	movq	-32(%rbp), %rsi
	movq	-24(%rbp), %rdi
	movq	-16(%rbp), %r10
	movq	-8(%rbp), %r11
	movl	24(%rbp), %eax
	movl	%eax, 8(%rsp)
	movl	16(%rbp), %eax
	movl	%eax, (%rsp)
	movl	%edx, %r9d
	movl	%ecx, %r8d
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r10, %rsi
	movq	%r11, %rdi
	call	l__cudaRegisterVar@PLT
	jmp	.L843
.L840:
	.loc 1 2850 0
	movl	-40(%rbp), %edx
	movl	-36(%rbp), %ecx
	movq	-32(%rbp), %rsi
	movq	-24(%rbp), %rdi
	movq	-16(%rbp), %r10
	movq	-8(%rbp), %r11
	movl	24(%rbp), %eax
	movl	%eax, 8(%rsp)
	movl	16(%rbp), %eax
	movl	%eax, (%rsp)
	movl	%edx, %r9d
	movl	%ecx, %r8d
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r10, %rsi
	movq	%r11, %rdi
	call	r__cudaRegisterVar@PLT
.L843:
	.loc 1 2852 0
	leave
	ret
.LFE152:
	.size	__cudaRegisterVar, .-__cudaRegisterVar
	.section	.rodata
	.align 16
	.type	__FUNCTION__.13056, @object
	.size	__FUNCTION__.13056, 22
__FUNCTION__.13056:
	.string	"__cudaRegisterTexture"
	.local	pFunc.13055
	.comm	pFunc.13055,8,8
.LC143:
	.string	"__cudaRegisterTexture"
	.text
.globl __cudaRegisterTexture
	.type	__cudaRegisterTexture, @function
__cudaRegisterTexture:
.LFB153:
	.loc 1 2856 0
	pushq	%rbp
.LCFI432:
	movq	%rsp, %rbp
.LCFI433:
	pushq	%rbx
.LCFI434:
	subq	$56, %rsp
.LCFI435:
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movl	%r8d, -44(%rbp)
	movl	%r9d, -48(%rbp)
	.loc 1 2862 0
	movq	pFunc.13055(%rip), %rax
	testq	%rax, %rax
	jne	.L845
	.loc 1 2863 0
	leaq	.LC143(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.13055(%rip)
	.loc 1 2865 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L845
	.loc 1 2866 0
	movl	$-1, %edi
	call	exit@PLT
.L845:
	.loc 1 2869 0
	leaq	__FUNCTION__.13056(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2871 0
	movq	pFunc.13055(%rip), %rbx
	movl	-48(%rbp), %edx
	movl	-44(%rbp), %ecx
	movq	-40(%rbp), %rsi
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %r10
	movq	-16(%rbp), %r11
	movl	16(%rbp), %eax
	movl	%eax, (%rsp)
	movl	%edx, %r9d
	movl	%ecx, %r8d
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	movq	%r10, %rsi
	movq	%r11, %rdi
	call	*%rbx
	.loc 1 2872 0
	addq	$56, %rsp
	popq	%rbx
	leave
	ret
.LFE153:
	.size	__cudaRegisterTexture, .-__cudaRegisterTexture
	.section	.rodata
	.align 16
	.type	__FUNCTION__.13074, @object
	.size	__FUNCTION__.13074, 21
__FUNCTION__.13074:
	.string	"__cudaRegisterShared"
	.local	pFunc.13073
	.comm	pFunc.13073,8,8
.LC144:
	.string	"__cudaRegisterShared"
	.text
.globl __cudaRegisterShared
	.type	__cudaRegisterShared, @function
__cudaRegisterShared:
.LFB154:
	.loc 1 2874 0
	pushq	%rbp
.LCFI436:
	movq	%rsp, %rbp
.LCFI437:
	subq	$16, %rsp
.LCFI438:
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 2878 0
	movq	pFunc.13073(%rip), %rax
	testq	%rax, %rax
	jne	.L850
	.loc 1 2879 0
	leaq	.LC144(%rip), %rsi
	movq	$-1, %rdi
	call	dlsym@PLT
	movq	%rax, pFunc.13073(%rip)
	.loc 1 2881 0
	movl	$0, %eax
	call	l_handleDlError@PLT
	testl	%eax, %eax
	je	.L850
	.loc 1 2882 0
	movl	$-1, %edi
	call	exit@PLT
.L850:
	.loc 1 2885 0
	leaq	__FUNCTION__.13074(%rip), %rdi
	call	l_printFuncSig@PLT
	.loc 1 2887 0
	movq	pFunc.13073(%rip), %rax
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	call	*%rax
	.loc 1 2888 0
	leave
	ret
.LFE154:
	.size	__cudaRegisterShared, .-__cudaRegisterShared
	.section	.debug_frame,"",@progbits
.Lframe0:
	.long	.LECIE0-.LSCIE0
.LSCIE0:
	.long	0xffffffff
	.byte	0x1
	.string	""
	.uleb128 0x1
	.sleb128 -8
	.byte	0x10
	.byte	0xc
	.uleb128 0x7
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x1
	.align 8
.LECIE0:
.LSFDE0:
	.long	.LEFDE0-.LASFDE0
.LASFDE0:
	.long	.Lframe0
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.byte	0x4
	.long	.LCFI0-.LFB13
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI1-.LCFI0
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE0:
.LSFDE2:
	.long	.LEFDE2-.LASFDE2
.LASFDE2:
	.long	.Lframe0
	.quad	.LFB14
	.quad	.LFE14-.LFB14
	.byte	0x4
	.long	.LCFI3-.LFB14
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI4-.LCFI3
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE2:
.LSFDE4:
	.long	.LEFDE4-.LASFDE4
.LASFDE4:
	.long	.Lframe0
	.quad	.LFB15
	.quad	.LFE15-.LFB15
	.byte	0x4
	.long	.LCFI6-.LFB15
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI7-.LCFI6
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE4:
.LSFDE6:
	.long	.LEFDE6-.LASFDE6
.LASFDE6:
	.long	.Lframe0
	.quad	.LFB16
	.quad	.LFE16-.LFB16
	.byte	0x4
	.long	.LCFI9-.LFB16
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI10-.LCFI9
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI12-.LCFI10
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE6:
.LSFDE8:
	.long	.LEFDE8-.LASFDE8
.LASFDE8:
	.long	.Lframe0
	.quad	.LFB17
	.quad	.LFE17-.LFB17
	.byte	0x4
	.long	.LCFI13-.LFB17
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI14-.LCFI13
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI16-.LCFI14
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE8:
.LSFDE10:
	.long	.LEFDE10-.LASFDE10
.LASFDE10:
	.long	.Lframe0
	.quad	.LFB18
	.quad	.LFE18-.LFB18
	.byte	0x4
	.long	.LCFI17-.LFB18
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI18-.LCFI17
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE10:
.LSFDE12:
	.long	.LEFDE12-.LASFDE12
.LASFDE12:
	.long	.Lframe0
	.quad	.LFB19
	.quad	.LFE19-.LFB19
	.byte	0x4
	.long	.LCFI20-.LFB19
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI21-.LCFI20
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE12:
.LSFDE14:
	.long	.LEFDE14-.LASFDE14
.LASFDE14:
	.long	.Lframe0
	.quad	.LFB20
	.quad	.LFE20-.LFB20
	.byte	0x4
	.long	.LCFI23-.LFB20
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI24-.LCFI23
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE14:
.LSFDE16:
	.long	.LEFDE16-.LASFDE16
.LASFDE16:
	.long	.Lframe0
	.quad	.LFB21
	.quad	.LFE21-.LFB21
	.byte	0x4
	.long	.LCFI26-.LFB21
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI27-.LCFI26
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE16:
.LSFDE18:
	.long	.LEFDE18-.LASFDE18
.LASFDE18:
	.long	.Lframe0
	.quad	.LFB22
	.quad	.LFE22-.LFB22
	.byte	0x4
	.long	.LCFI29-.LFB22
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI30-.LCFI29
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE18:
.LSFDE20:
	.long	.LEFDE20-.LASFDE20
.LASFDE20:
	.long	.Lframe0
	.quad	.LFB23
	.quad	.LFE23-.LFB23
	.byte	0x4
	.long	.LCFI32-.LFB23
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI33-.LCFI32
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE20:
.LSFDE22:
	.long	.LEFDE22-.LASFDE22
.LASFDE22:
	.long	.Lframe0
	.quad	.LFB24
	.quad	.LFE24-.LFB24
	.byte	0x4
	.long	.LCFI35-.LFB24
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI36-.LCFI35
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE22:
.LSFDE24:
	.long	.LEFDE24-.LASFDE24
.LASFDE24:
	.long	.Lframe0
	.quad	.LFB25
	.quad	.LFE25-.LFB25
	.byte	0x4
	.long	.LCFI38-.LFB25
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI39-.LCFI38
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE24:
.LSFDE26:
	.long	.LEFDE26-.LASFDE26
.LASFDE26:
	.long	.Lframe0
	.quad	.LFB26
	.quad	.LFE26-.LFB26
	.byte	0x4
	.long	.LCFI41-.LFB26
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI42-.LCFI41
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE26:
.LSFDE28:
	.long	.LEFDE28-.LASFDE28
.LASFDE28:
	.long	.Lframe0
	.quad	.LFB27
	.quad	.LFE27-.LFB27
	.byte	0x4
	.long	.LCFI44-.LFB27
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI45-.LCFI44
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE28:
.LSFDE30:
	.long	.LEFDE30-.LASFDE30
.LASFDE30:
	.long	.Lframe0
	.quad	.LFB28
	.quad	.LFE28-.LFB28
	.byte	0x4
	.long	.LCFI47-.LFB28
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI48-.LCFI47
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE30:
.LSFDE32:
	.long	.LEFDE32-.LASFDE32
.LASFDE32:
	.long	.Lframe0
	.quad	.LFB29
	.quad	.LFE29-.LFB29
	.byte	0x4
	.long	.LCFI49-.LFB29
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI50-.LCFI49
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE32:
.LSFDE34:
	.long	.LEFDE34-.LASFDE34
.LASFDE34:
	.long	.Lframe0
	.quad	.LFB30
	.quad	.LFE30-.LFB30
	.byte	0x4
	.long	.LCFI52-.LFB30
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI53-.LCFI52
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE34:
.LSFDE36:
	.long	.LEFDE36-.LASFDE36
.LASFDE36:
	.long	.Lframe0
	.quad	.LFB31
	.quad	.LFE31-.LFB31
	.byte	0x4
	.long	.LCFI55-.LFB31
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI56-.LCFI55
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE36:
.LSFDE38:
	.long	.LEFDE38-.LASFDE38
.LASFDE38:
	.long	.Lframe0
	.quad	.LFB32
	.quad	.LFE32-.LFB32
	.byte	0x4
	.long	.LCFI58-.LFB32
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI59-.LCFI58
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE38:
.LSFDE40:
	.long	.LEFDE40-.LASFDE40
.LASFDE40:
	.long	.Lframe0
	.quad	.LFB33
	.quad	.LFE33-.LFB33
	.byte	0x4
	.long	.LCFI61-.LFB33
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI62-.LCFI61
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE40:
.LSFDE42:
	.long	.LEFDE42-.LASFDE42
.LASFDE42:
	.long	.Lframe0
	.quad	.LFB34
	.quad	.LFE34-.LFB34
	.byte	0x4
	.long	.LCFI64-.LFB34
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI65-.LCFI64
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE42:
.LSFDE44:
	.long	.LEFDE44-.LASFDE44
.LASFDE44:
	.long	.Lframe0
	.quad	.LFB35
	.quad	.LFE35-.LFB35
	.byte	0x4
	.long	.LCFI67-.LFB35
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI68-.LCFI67
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE44:
.LSFDE46:
	.long	.LEFDE46-.LASFDE46
.LASFDE46:
	.long	.Lframe0
	.quad	.LFB36
	.quad	.LFE36-.LFB36
	.byte	0x4
	.long	.LCFI70-.LFB36
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI71-.LCFI70
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE46:
.LSFDE48:
	.long	.LEFDE48-.LASFDE48
.LASFDE48:
	.long	.Lframe0
	.quad	.LFB37
	.quad	.LFE37-.LFB37
	.byte	0x4
	.long	.LCFI73-.LFB37
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI74-.LCFI73
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE48:
.LSFDE50:
	.long	.LEFDE50-.LASFDE50
.LASFDE50:
	.long	.Lframe0
	.quad	.LFB38
	.quad	.LFE38-.LFB38
	.byte	0x4
	.long	.LCFI76-.LFB38
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI77-.LCFI76
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE50:
.LSFDE52:
	.long	.LEFDE52-.LASFDE52
.LASFDE52:
	.long	.Lframe0
	.quad	.LFB39
	.quad	.LFE39-.LFB39
	.byte	0x4
	.long	.LCFI79-.LFB39
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI80-.LCFI79
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE52:
.LSFDE54:
	.long	.LEFDE54-.LASFDE54
.LASFDE54:
	.long	.Lframe0
	.quad	.LFB40
	.quad	.LFE40-.LFB40
	.byte	0x4
	.long	.LCFI82-.LFB40
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI83-.LCFI82
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE54:
.LSFDE56:
	.long	.LEFDE56-.LASFDE56
.LASFDE56:
	.long	.Lframe0
	.quad	.LFB41
	.quad	.LFE41-.LFB41
	.byte	0x4
	.long	.LCFI85-.LFB41
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI86-.LCFI85
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE56:
.LSFDE58:
	.long	.LEFDE58-.LASFDE58
.LASFDE58:
	.long	.Lframe0
	.quad	.LFB42
	.quad	.LFE42-.LFB42
	.byte	0x4
	.long	.LCFI88-.LFB42
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI89-.LCFI88
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE58:
.LSFDE60:
	.long	.LEFDE60-.LASFDE60
.LASFDE60:
	.long	.Lframe0
	.quad	.LFB43
	.quad	.LFE43-.LFB43
	.byte	0x4
	.long	.LCFI91-.LFB43
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI92-.LCFI91
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE60:
.LSFDE62:
	.long	.LEFDE62-.LASFDE62
.LASFDE62:
	.long	.Lframe0
	.quad	.LFB44
	.quad	.LFE44-.LFB44
	.byte	0x4
	.long	.LCFI93-.LFB44
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI94-.LCFI93
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE62:
.LSFDE64:
	.long	.LEFDE64-.LASFDE64
.LASFDE64:
	.long	.Lframe0
	.quad	.LFB45
	.quad	.LFE45-.LFB45
	.byte	0x4
	.long	.LCFI96-.LFB45
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI97-.LCFI96
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE64:
.LSFDE66:
	.long	.LEFDE66-.LASFDE66
.LASFDE66:
	.long	.Lframe0
	.quad	.LFB46
	.quad	.LFE46-.LFB46
	.byte	0x4
	.long	.LCFI99-.LFB46
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI100-.LCFI99
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE66:
.LSFDE68:
	.long	.LEFDE68-.LASFDE68
.LASFDE68:
	.long	.Lframe0
	.quad	.LFB47
	.quad	.LFE47-.LFB47
	.byte	0x4
	.long	.LCFI102-.LFB47
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI103-.LCFI102
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE68:
.LSFDE70:
	.long	.LEFDE70-.LASFDE70
.LASFDE70:
	.long	.Lframe0
	.quad	.LFB48
	.quad	.LFE48-.LFB48
	.byte	0x4
	.long	.LCFI105-.LFB48
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI106-.LCFI105
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE70:
.LSFDE72:
	.long	.LEFDE72-.LASFDE72
.LASFDE72:
	.long	.Lframe0
	.quad	.LFB49
	.quad	.LFE49-.LFB49
	.byte	0x4
	.long	.LCFI108-.LFB49
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI109-.LCFI108
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE72:
.LSFDE74:
	.long	.LEFDE74-.LASFDE74
.LASFDE74:
	.long	.Lframe0
	.quad	.LFB50
	.quad	.LFE50-.LFB50
	.byte	0x4
	.long	.LCFI111-.LFB50
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI112-.LCFI111
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE74:
.LSFDE76:
	.long	.LEFDE76-.LASFDE76
.LASFDE76:
	.long	.Lframe0
	.quad	.LFB51
	.quad	.LFE51-.LFB51
	.byte	0x4
	.long	.LCFI114-.LFB51
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI115-.LCFI114
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE76:
.LSFDE78:
	.long	.LEFDE78-.LASFDE78
.LASFDE78:
	.long	.Lframe0
	.quad	.LFB52
	.quad	.LFE52-.LFB52
	.byte	0x4
	.long	.LCFI117-.LFB52
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI118-.LCFI117
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE78:
.LSFDE80:
	.long	.LEFDE80-.LASFDE80
.LASFDE80:
	.long	.Lframe0
	.quad	.LFB53
	.quad	.LFE53-.LFB53
	.byte	0x4
	.long	.LCFI120-.LFB53
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI121-.LCFI120
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE80:
.LSFDE82:
	.long	.LEFDE82-.LASFDE82
.LASFDE82:
	.long	.Lframe0
	.quad	.LFB54
	.quad	.LFE54-.LFB54
	.byte	0x4
	.long	.LCFI123-.LFB54
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI124-.LCFI123
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE82:
.LSFDE84:
	.long	.LEFDE84-.LASFDE84
.LASFDE84:
	.long	.Lframe0
	.quad	.LFB55
	.quad	.LFE55-.LFB55
	.byte	0x4
	.long	.LCFI126-.LFB55
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI127-.LCFI126
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE84:
.LSFDE86:
	.long	.LEFDE86-.LASFDE86
.LASFDE86:
	.long	.Lframe0
	.quad	.LFB56
	.quad	.LFE56-.LFB56
	.byte	0x4
	.long	.LCFI129-.LFB56
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI130-.LCFI129
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE86:
.LSFDE88:
	.long	.LEFDE88-.LASFDE88
.LASFDE88:
	.long	.Lframe0
	.quad	.LFB57
	.quad	.LFE57-.LFB57
	.byte	0x4
	.long	.LCFI132-.LFB57
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI133-.LCFI132
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE88:
.LSFDE90:
	.long	.LEFDE90-.LASFDE90
.LASFDE90:
	.long	.Lframe0
	.quad	.LFB58
	.quad	.LFE58-.LFB58
	.byte	0x4
	.long	.LCFI135-.LFB58
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI136-.LCFI135
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE90:
.LSFDE92:
	.long	.LEFDE92-.LASFDE92
.LASFDE92:
	.long	.Lframe0
	.quad	.LFB59
	.quad	.LFE59-.LFB59
	.byte	0x4
	.long	.LCFI138-.LFB59
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI139-.LCFI138
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE92:
.LSFDE94:
	.long	.LEFDE94-.LASFDE94
.LASFDE94:
	.long	.Lframe0
	.quad	.LFB60
	.quad	.LFE60-.LFB60
	.byte	0x4
	.long	.LCFI141-.LFB60
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI142-.LCFI141
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE94:
.LSFDE96:
	.long	.LEFDE96-.LASFDE96
.LASFDE96:
	.long	.Lframe0
	.quad	.LFB61
	.quad	.LFE61-.LFB61
	.byte	0x4
	.long	.LCFI143-.LFB61
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI144-.LCFI143
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE96:
.LSFDE98:
	.long	.LEFDE98-.LASFDE98
.LASFDE98:
	.long	.Lframe0
	.quad	.LFB62
	.quad	.LFE62-.LFB62
	.byte	0x4
	.long	.LCFI146-.LFB62
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI147-.LCFI146
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE98:
.LSFDE100:
	.long	.LEFDE100-.LASFDE100
.LASFDE100:
	.long	.Lframe0
	.quad	.LFB63
	.quad	.LFE63-.LFB63
	.byte	0x4
	.long	.LCFI149-.LFB63
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI150-.LCFI149
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE100:
.LSFDE102:
	.long	.LEFDE102-.LASFDE102
.LASFDE102:
	.long	.Lframe0
	.quad	.LFB64
	.quad	.LFE64-.LFB64
	.byte	0x4
	.long	.LCFI152-.LFB64
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI153-.LCFI152
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE102:
.LSFDE104:
	.long	.LEFDE104-.LASFDE104
.LASFDE104:
	.long	.Lframe0
	.quad	.LFB65
	.quad	.LFE65-.LFB65
	.byte	0x4
	.long	.LCFI155-.LFB65
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI156-.LCFI155
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE104:
.LSFDE106:
	.long	.LEFDE106-.LASFDE106
.LASFDE106:
	.long	.Lframe0
	.quad	.LFB66
	.quad	.LFE66-.LFB66
	.byte	0x4
	.long	.LCFI158-.LFB66
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI159-.LCFI158
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE106:
.LSFDE108:
	.long	.LEFDE108-.LASFDE108
.LASFDE108:
	.long	.Lframe0
	.quad	.LFB67
	.quad	.LFE67-.LFB67
	.byte	0x4
	.long	.LCFI161-.LFB67
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI162-.LCFI161
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE108:
.LSFDE110:
	.long	.LEFDE110-.LASFDE110
.LASFDE110:
	.long	.Lframe0
	.quad	.LFB68
	.quad	.LFE68-.LFB68
	.byte	0x4
	.long	.LCFI164-.LFB68
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI165-.LCFI164
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE110:
.LSFDE112:
	.long	.LEFDE112-.LASFDE112
.LASFDE112:
	.long	.Lframe0
	.quad	.LFB69
	.quad	.LFE69-.LFB69
	.byte	0x4
	.long	.LCFI167-.LFB69
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI168-.LCFI167
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE112:
.LSFDE114:
	.long	.LEFDE114-.LASFDE114
.LASFDE114:
	.long	.Lframe0
	.quad	.LFB70
	.quad	.LFE70-.LFB70
	.byte	0x4
	.long	.LCFI170-.LFB70
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI171-.LCFI170
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE114:
.LSFDE116:
	.long	.LEFDE116-.LASFDE116
.LASFDE116:
	.long	.Lframe0
	.quad	.LFB71
	.quad	.LFE71-.LFB71
	.byte	0x4
	.long	.LCFI173-.LFB71
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI174-.LCFI173
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE116:
.LSFDE118:
	.long	.LEFDE118-.LASFDE118
.LASFDE118:
	.long	.Lframe0
	.quad	.LFB72
	.quad	.LFE72-.LFB72
	.byte	0x4
	.long	.LCFI176-.LFB72
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI177-.LCFI176
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE118:
.LSFDE120:
	.long	.LEFDE120-.LASFDE120
.LASFDE120:
	.long	.Lframe0
	.quad	.LFB73
	.quad	.LFE73-.LFB73
	.byte	0x4
	.long	.LCFI179-.LFB73
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI180-.LCFI179
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE120:
.LSFDE122:
	.long	.LEFDE122-.LASFDE122
.LASFDE122:
	.long	.Lframe0
	.quad	.LFB74
	.quad	.LFE74-.LFB74
	.byte	0x4
	.long	.LCFI182-.LFB74
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI183-.LCFI182
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE122:
.LSFDE124:
	.long	.LEFDE124-.LASFDE124
.LASFDE124:
	.long	.Lframe0
	.quad	.LFB75
	.quad	.LFE75-.LFB75
	.byte	0x4
	.long	.LCFI185-.LFB75
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI186-.LCFI185
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE124:
.LSFDE126:
	.long	.LEFDE126-.LASFDE126
.LASFDE126:
	.long	.Lframe0
	.quad	.LFB76
	.quad	.LFE76-.LFB76
	.byte	0x4
	.long	.LCFI188-.LFB76
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI189-.LCFI188
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE126:
.LSFDE128:
	.long	.LEFDE128-.LASFDE128
.LASFDE128:
	.long	.Lframe0
	.quad	.LFB77
	.quad	.LFE77-.LFB77
	.byte	0x4
	.long	.LCFI191-.LFB77
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI192-.LCFI191
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE128:
.LSFDE130:
	.long	.LEFDE130-.LASFDE130
.LASFDE130:
	.long	.Lframe0
	.quad	.LFB78
	.quad	.LFE78-.LFB78
	.byte	0x4
	.long	.LCFI194-.LFB78
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI195-.LCFI194
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE130:
.LSFDE132:
	.long	.LEFDE132-.LASFDE132
.LASFDE132:
	.long	.Lframe0
	.quad	.LFB79
	.quad	.LFE79-.LFB79
	.byte	0x4
	.long	.LCFI197-.LFB79
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI198-.LCFI197
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE132:
.LSFDE134:
	.long	.LEFDE134-.LASFDE134
.LASFDE134:
	.long	.Lframe0
	.quad	.LFB80
	.quad	.LFE80-.LFB80
	.byte	0x4
	.long	.LCFI200-.LFB80
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI201-.LCFI200
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE134:
.LSFDE136:
	.long	.LEFDE136-.LASFDE136
.LASFDE136:
	.long	.Lframe0
	.quad	.LFB81
	.quad	.LFE81-.LFB81
	.byte	0x4
	.long	.LCFI203-.LFB81
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI204-.LCFI203
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE136:
.LSFDE138:
	.long	.LEFDE138-.LASFDE138
.LASFDE138:
	.long	.Lframe0
	.quad	.LFB82
	.quad	.LFE82-.LFB82
	.byte	0x4
	.long	.LCFI206-.LFB82
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI207-.LCFI206
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE138:
.LSFDE140:
	.long	.LEFDE140-.LASFDE140
.LASFDE140:
	.long	.Lframe0
	.quad	.LFB83
	.quad	.LFE83-.LFB83
	.byte	0x4
	.long	.LCFI209-.LFB83
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI210-.LCFI209
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE140:
.LSFDE142:
	.long	.LEFDE142-.LASFDE142
.LASFDE142:
	.long	.Lframe0
	.quad	.LFB84
	.quad	.LFE84-.LFB84
	.byte	0x4
	.long	.LCFI212-.LFB84
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI213-.LCFI212
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE142:
.LSFDE144:
	.long	.LEFDE144-.LASFDE144
.LASFDE144:
	.long	.Lframe0
	.quad	.LFB85
	.quad	.LFE85-.LFB85
	.byte	0x4
	.long	.LCFI215-.LFB85
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI216-.LCFI215
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE144:
.LSFDE146:
	.long	.LEFDE146-.LASFDE146
.LASFDE146:
	.long	.Lframe0
	.quad	.LFB86
	.quad	.LFE86-.LFB86
	.byte	0x4
	.long	.LCFI218-.LFB86
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI219-.LCFI218
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE146:
.LSFDE148:
	.long	.LEFDE148-.LASFDE148
.LASFDE148:
	.long	.Lframe0
	.quad	.LFB87
	.quad	.LFE87-.LFB87
	.byte	0x4
	.long	.LCFI221-.LFB87
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI222-.LCFI221
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE148:
.LSFDE150:
	.long	.LEFDE150-.LASFDE150
.LASFDE150:
	.long	.Lframe0
	.quad	.LFB88
	.quad	.LFE88-.LFB88
	.byte	0x4
	.long	.LCFI224-.LFB88
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI225-.LCFI224
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE150:
.LSFDE152:
	.long	.LEFDE152-.LASFDE152
.LASFDE152:
	.long	.Lframe0
	.quad	.LFB89
	.quad	.LFE89-.LFB89
	.byte	0x4
	.long	.LCFI227-.LFB89
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI228-.LCFI227
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE152:
.LSFDE154:
	.long	.LEFDE154-.LASFDE154
.LASFDE154:
	.long	.Lframe0
	.quad	.LFB90
	.quad	.LFE90-.LFB90
	.byte	0x4
	.long	.LCFI230-.LFB90
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI231-.LCFI230
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE154:
.LSFDE156:
	.long	.LEFDE156-.LASFDE156
.LASFDE156:
	.long	.Lframe0
	.quad	.LFB91
	.quad	.LFE91-.LFB91
	.byte	0x4
	.long	.LCFI233-.LFB91
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI234-.LCFI233
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE156:
.LSFDE158:
	.long	.LEFDE158-.LASFDE158
.LASFDE158:
	.long	.Lframe0
	.quad	.LFB92
	.quad	.LFE92-.LFB92
	.byte	0x4
	.long	.LCFI236-.LFB92
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI237-.LCFI236
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE158:
.LSFDE160:
	.long	.LEFDE160-.LASFDE160
.LASFDE160:
	.long	.Lframe0
	.quad	.LFB93
	.quad	.LFE93-.LFB93
	.byte	0x4
	.long	.LCFI239-.LFB93
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI240-.LCFI239
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE160:
.LSFDE162:
	.long	.LEFDE162-.LASFDE162
.LASFDE162:
	.long	.Lframe0
	.quad	.LFB94
	.quad	.LFE94-.LFB94
	.byte	0x4
	.long	.LCFI242-.LFB94
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI243-.LCFI242
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE162:
.LSFDE164:
	.long	.LEFDE164-.LASFDE164
.LASFDE164:
	.long	.Lframe0
	.quad	.LFB95
	.quad	.LFE95-.LFB95
	.byte	0x4
	.long	.LCFI245-.LFB95
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI246-.LCFI245
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI248-.LCFI246
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE164:
.LSFDE166:
	.long	.LEFDE166-.LASFDE166
.LASFDE166:
	.long	.Lframe0
	.quad	.LFB96
	.quad	.LFE96-.LFB96
	.byte	0x4
	.long	.LCFI249-.LFB96
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI250-.LCFI249
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI252-.LCFI250
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE166:
.LSFDE168:
	.long	.LEFDE168-.LASFDE168
.LASFDE168:
	.long	.Lframe0
	.quad	.LFB97
	.quad	.LFE97-.LFB97
	.byte	0x4
	.long	.LCFI253-.LFB97
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI254-.LCFI253
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI256-.LCFI254
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE168:
.LSFDE170:
	.long	.LEFDE170-.LASFDE170
.LASFDE170:
	.long	.Lframe0
	.quad	.LFB98
	.quad	.LFE98-.LFB98
	.byte	0x4
	.long	.LCFI257-.LFB98
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI258-.LCFI257
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI260-.LCFI258
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE170:
.LSFDE172:
	.long	.LEFDE172-.LASFDE172
.LASFDE172:
	.long	.Lframe0
	.quad	.LFB99
	.quad	.LFE99-.LFB99
	.byte	0x4
	.long	.LCFI261-.LFB99
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI262-.LCFI261
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI264-.LCFI262
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE172:
.LSFDE174:
	.long	.LEFDE174-.LASFDE174
.LASFDE174:
	.long	.Lframe0
	.quad	.LFB100
	.quad	.LFE100-.LFB100
	.byte	0x4
	.long	.LCFI265-.LFB100
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI266-.LCFI265
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE174:
.LSFDE176:
	.long	.LEFDE176-.LASFDE176
.LASFDE176:
	.long	.Lframe0
	.quad	.LFB101
	.quad	.LFE101-.LFB101
	.byte	0x4
	.long	.LCFI268-.LFB101
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI269-.LCFI268
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE176:
.LSFDE178:
	.long	.LEFDE178-.LASFDE178
.LASFDE178:
	.long	.Lframe0
	.quad	.LFB102
	.quad	.LFE102-.LFB102
	.byte	0x4
	.long	.LCFI271-.LFB102
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI272-.LCFI271
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE178:
.LSFDE180:
	.long	.LEFDE180-.LASFDE180
.LASFDE180:
	.long	.Lframe0
	.quad	.LFB103
	.quad	.LFE103-.LFB103
	.byte	0x4
	.long	.LCFI274-.LFB103
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI275-.LCFI274
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE180:
.LSFDE182:
	.long	.LEFDE182-.LASFDE182
.LASFDE182:
	.long	.Lframe0
	.quad	.LFB104
	.quad	.LFE104-.LFB104
	.byte	0x4
	.long	.LCFI277-.LFB104
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI278-.LCFI277
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE182:
.LSFDE184:
	.long	.LEFDE184-.LASFDE184
.LASFDE184:
	.long	.Lframe0
	.quad	.LFB105
	.quad	.LFE105-.LFB105
	.byte	0x4
	.long	.LCFI280-.LFB105
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI281-.LCFI280
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE184:
.LSFDE186:
	.long	.LEFDE186-.LASFDE186
.LASFDE186:
	.long	.Lframe0
	.quad	.LFB106
	.quad	.LFE106-.LFB106
	.byte	0x4
	.long	.LCFI283-.LFB106
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI284-.LCFI283
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE186:
.LSFDE188:
	.long	.LEFDE188-.LASFDE188
.LASFDE188:
	.long	.Lframe0
	.quad	.LFB107
	.quad	.LFE107-.LFB107
	.byte	0x4
	.long	.LCFI286-.LFB107
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI287-.LCFI286
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI289-.LCFI287
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE188:
.LSFDE190:
	.long	.LEFDE190-.LASFDE190
.LASFDE190:
	.long	.Lframe0
	.quad	.LFB108
	.quad	.LFE108-.LFB108
	.byte	0x4
	.long	.LCFI290-.LFB108
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI291-.LCFI290
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI293-.LCFI291
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE190:
.LSFDE192:
	.long	.LEFDE192-.LASFDE192
.LASFDE192:
	.long	.Lframe0
	.quad	.LFB109
	.quad	.LFE109-.LFB109
	.byte	0x4
	.long	.LCFI294-.LFB109
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI295-.LCFI294
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI297-.LCFI295
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE192:
.LSFDE194:
	.long	.LEFDE194-.LASFDE194
.LASFDE194:
	.long	.Lframe0
	.quad	.LFB110
	.quad	.LFE110-.LFB110
	.byte	0x4
	.long	.LCFI298-.LFB110
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI299-.LCFI298
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI301-.LCFI299
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE194:
.LSFDE196:
	.long	.LEFDE196-.LASFDE196
.LASFDE196:
	.long	.Lframe0
	.quad	.LFB111
	.quad	.LFE111-.LFB111
	.byte	0x4
	.long	.LCFI302-.LFB111
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI303-.LCFI302
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI305-.LCFI303
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE196:
.LSFDE198:
	.long	.LEFDE198-.LASFDE198
.LASFDE198:
	.long	.Lframe0
	.quad	.LFB112
	.quad	.LFE112-.LFB112
	.byte	0x4
	.long	.LCFI306-.LFB112
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI307-.LCFI306
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE198:
.LSFDE200:
	.long	.LEFDE200-.LASFDE200
.LASFDE200:
	.long	.Lframe0
	.quad	.LFB113
	.quad	.LFE113-.LFB113
	.byte	0x4
	.long	.LCFI309-.LFB113
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI310-.LCFI309
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE200:
.LSFDE202:
	.long	.LEFDE202-.LASFDE202
.LASFDE202:
	.long	.Lframe0
	.quad	.LFB114
	.quad	.LFE114-.LFB114
	.byte	0x4
	.long	.LCFI312-.LFB114
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI313-.LCFI312
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE202:
.LSFDE204:
	.long	.LEFDE204-.LASFDE204
.LASFDE204:
	.long	.Lframe0
	.quad	.LFB115
	.quad	.LFE115-.LFB115
	.byte	0x4
	.long	.LCFI315-.LFB115
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI316-.LCFI315
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE204:
.LSFDE206:
	.long	.LEFDE206-.LASFDE206
.LASFDE206:
	.long	.Lframe0
	.quad	.LFB116
	.quad	.LFE116-.LFB116
	.byte	0x4
	.long	.LCFI318-.LFB116
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI319-.LCFI318
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE206:
.LSFDE208:
	.long	.LEFDE208-.LASFDE208
.LASFDE208:
	.long	.Lframe0
	.quad	.LFB117
	.quad	.LFE117-.LFB117
	.byte	0x4
	.long	.LCFI321-.LFB117
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI322-.LCFI321
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE208:
.LSFDE210:
	.long	.LEFDE210-.LASFDE210
.LASFDE210:
	.long	.Lframe0
	.quad	.LFB118
	.quad	.LFE118-.LFB118
	.byte	0x4
	.long	.LCFI324-.LFB118
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI325-.LCFI324
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE210:
.LSFDE212:
	.long	.LEFDE212-.LASFDE212
.LASFDE212:
	.long	.Lframe0
	.quad	.LFB119
	.quad	.LFE119-.LFB119
	.byte	0x4
	.long	.LCFI327-.LFB119
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI328-.LCFI327
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE212:
.LSFDE214:
	.long	.LEFDE214-.LASFDE214
.LASFDE214:
	.long	.Lframe0
	.quad	.LFB120
	.quad	.LFE120-.LFB120
	.byte	0x4
	.long	.LCFI330-.LFB120
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI331-.LCFI330
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE214:
.LSFDE216:
	.long	.LEFDE216-.LASFDE216
.LASFDE216:
	.long	.Lframe0
	.quad	.LFB121
	.quad	.LFE121-.LFB121
	.byte	0x4
	.long	.LCFI333-.LFB121
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI334-.LCFI333
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE216:
.LSFDE218:
	.long	.LEFDE218-.LASFDE218
.LASFDE218:
	.long	.Lframe0
	.quad	.LFB122
	.quad	.LFE122-.LFB122
	.byte	0x4
	.long	.LCFI336-.LFB122
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI337-.LCFI336
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE218:
.LSFDE220:
	.long	.LEFDE220-.LASFDE220
.LASFDE220:
	.long	.Lframe0
	.quad	.LFB123
	.quad	.LFE123-.LFB123
	.byte	0x4
	.long	.LCFI339-.LFB123
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI340-.LCFI339
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE220:
.LSFDE222:
	.long	.LEFDE222-.LASFDE222
.LASFDE222:
	.long	.Lframe0
	.quad	.LFB124
	.quad	.LFE124-.LFB124
	.byte	0x4
	.long	.LCFI342-.LFB124
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI343-.LCFI342
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE222:
.LSFDE224:
	.long	.LEFDE224-.LASFDE224
.LASFDE224:
	.long	.Lframe0
	.quad	.LFB125
	.quad	.LFE125-.LFB125
	.byte	0x4
	.long	.LCFI345-.LFB125
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI346-.LCFI345
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE224:
.LSFDE226:
	.long	.LEFDE226-.LASFDE226
.LASFDE226:
	.long	.Lframe0
	.quad	.LFB126
	.quad	.LFE126-.LFB126
	.byte	0x4
	.long	.LCFI348-.LFB126
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI349-.LCFI348
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE226:
.LSFDE228:
	.long	.LEFDE228-.LASFDE228
.LASFDE228:
	.long	.Lframe0
	.quad	.LFB127
	.quad	.LFE127-.LFB127
	.byte	0x4
	.long	.LCFI351-.LFB127
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI352-.LCFI351
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE228:
.LSFDE230:
	.long	.LEFDE230-.LASFDE230
.LASFDE230:
	.long	.Lframe0
	.quad	.LFB128
	.quad	.LFE128-.LFB128
	.byte	0x4
	.long	.LCFI354-.LFB128
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI355-.LCFI354
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE230:
.LSFDE232:
	.long	.LEFDE232-.LASFDE232
.LASFDE232:
	.long	.Lframe0
	.quad	.LFB129
	.quad	.LFE129-.LFB129
	.byte	0x4
	.long	.LCFI357-.LFB129
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI358-.LCFI357
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE232:
.LSFDE234:
	.long	.LEFDE234-.LASFDE234
.LASFDE234:
	.long	.Lframe0
	.quad	.LFB130
	.quad	.LFE130-.LFB130
	.byte	0x4
	.long	.LCFI360-.LFB130
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI361-.LCFI360
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE234:
.LSFDE236:
	.long	.LEFDE236-.LASFDE236
.LASFDE236:
	.long	.Lframe0
	.quad	.LFB131
	.quad	.LFE131-.LFB131
	.byte	0x4
	.long	.LCFI363-.LFB131
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI364-.LCFI363
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI366-.LCFI364
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE236:
.LSFDE238:
	.long	.LEFDE238-.LASFDE238
.LASFDE238:
	.long	.Lframe0
	.quad	.LFB132
	.quad	.LFE132-.LFB132
	.byte	0x4
	.long	.LCFI367-.LFB132
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI368-.LCFI367
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE238:
.LSFDE240:
	.long	.LEFDE240-.LASFDE240
.LASFDE240:
	.long	.Lframe0
	.quad	.LFB133
	.quad	.LFE133-.LFB133
	.byte	0x4
	.long	.LCFI370-.LFB133
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI371-.LCFI370
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE240:
.LSFDE242:
	.long	.LEFDE242-.LASFDE242
.LASFDE242:
	.long	.Lframe0
	.quad	.LFB134
	.quad	.LFE134-.LFB134
	.byte	0x4
	.long	.LCFI373-.LFB134
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI374-.LCFI373
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE242:
.LSFDE244:
	.long	.LEFDE244-.LASFDE244
.LASFDE244:
	.long	.Lframe0
	.quad	.LFB135
	.quad	.LFE135-.LFB135
	.byte	0x4
	.long	.LCFI376-.LFB135
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI377-.LCFI376
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE244:
.LSFDE246:
	.long	.LEFDE246-.LASFDE246
.LASFDE246:
	.long	.Lframe0
	.quad	.LFB136
	.quad	.LFE136-.LFB136
	.byte	0x4
	.long	.LCFI379-.LFB136
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI380-.LCFI379
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE246:
.LSFDE248:
	.long	.LEFDE248-.LASFDE248
.LASFDE248:
	.long	.Lframe0
	.quad	.LFB137
	.quad	.LFE137-.LFB137
	.byte	0x4
	.long	.LCFI382-.LFB137
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI383-.LCFI382
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE248:
.LSFDE250:
	.long	.LEFDE250-.LASFDE250
.LASFDE250:
	.long	.Lframe0
	.quad	.LFB138
	.quad	.LFE138-.LFB138
	.byte	0x4
	.long	.LCFI385-.LFB138
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI386-.LCFI385
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE250:
.LSFDE252:
	.long	.LEFDE252-.LASFDE252
.LASFDE252:
	.long	.Lframe0
	.quad	.LFB139
	.quad	.LFE139-.LFB139
	.byte	0x4
	.long	.LCFI388-.LFB139
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI389-.LCFI388
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE252:
.LSFDE254:
	.long	.LEFDE254-.LASFDE254
.LASFDE254:
	.long	.Lframe0
	.quad	.LFB140
	.quad	.LFE140-.LFB140
	.byte	0x4
	.long	.LCFI391-.LFB140
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI392-.LCFI391
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE254:
.LSFDE256:
	.long	.LEFDE256-.LASFDE256
.LASFDE256:
	.long	.Lframe0
	.quad	.LFB141
	.quad	.LFE141-.LFB141
	.byte	0x4
	.long	.LCFI394-.LFB141
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI395-.LCFI394
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE256:
.LSFDE258:
	.long	.LEFDE258-.LASFDE258
.LASFDE258:
	.long	.Lframe0
	.quad	.LFB142
	.quad	.LFE142-.LFB142
	.byte	0x4
	.long	.LCFI397-.LFB142
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI398-.LCFI397
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE258:
.LSFDE260:
	.long	.LEFDE260-.LASFDE260
.LASFDE260:
	.long	.Lframe0
	.quad	.LFB143
	.quad	.LFE143-.LFB143
	.byte	0x4
	.long	.LCFI400-.LFB143
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI401-.LCFI400
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE260:
.LSFDE262:
	.long	.LEFDE262-.LASFDE262
.LASFDE262:
	.long	.Lframe0
	.quad	.LFB144
	.quad	.LFE144-.LFB144
	.byte	0x4
	.long	.LCFI403-.LFB144
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI404-.LCFI403
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE262:
.LSFDE264:
	.long	.LEFDE264-.LASFDE264
.LASFDE264:
	.long	.Lframe0
	.quad	.LFB145
	.quad	.LFE145-.LFB145
	.byte	0x4
	.long	.LCFI406-.LFB145
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI407-.LCFI406
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE264:
.LSFDE266:
	.long	.LEFDE266-.LASFDE266
.LASFDE266:
	.long	.Lframe0
	.quad	.LFB146
	.quad	.LFE146-.LFB146
	.byte	0x4
	.long	.LCFI409-.LFB146
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI410-.LCFI409
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE266:
.LSFDE268:
	.long	.LEFDE268-.LASFDE268
.LASFDE268:
	.long	.Lframe0
	.quad	.LFB147
	.quad	.LFE147-.LFB147
	.byte	0x4
	.long	.LCFI412-.LFB147
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI413-.LCFI412
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE268:
.LSFDE270:
	.long	.LEFDE270-.LASFDE270
.LASFDE270:
	.long	.Lframe0
	.quad	.LFB148
	.quad	.LFE148-.LFB148
	.byte	0x4
	.long	.LCFI415-.LFB148
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI416-.LCFI415
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI418-.LCFI416
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE270:
.LSFDE272:
	.long	.LEFDE272-.LASFDE272
.LASFDE272:
	.long	.Lframe0
	.quad	.LFB149
	.quad	.LFE149-.LFB149
	.byte	0x4
	.long	.LCFI419-.LFB149
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI420-.LCFI419
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE272:
.LSFDE274:
	.long	.LEFDE274-.LASFDE274
.LASFDE274:
	.long	.Lframe0
	.quad	.LFB150
	.quad	.LFE150-.LFB150
	.byte	0x4
	.long	.LCFI422-.LFB150
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI423-.LCFI422
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI425-.LCFI423
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE274:
.LSFDE276:
	.long	.LEFDE276-.LASFDE276
.LASFDE276:
	.long	.Lframe0
	.quad	.LFB151
	.quad	.LFE151-.LFB151
	.byte	0x4
	.long	.LCFI426-.LFB151
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI427-.LCFI426
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE276:
.LSFDE278:
	.long	.LEFDE278-.LASFDE278
.LASFDE278:
	.long	.Lframe0
	.quad	.LFB152
	.quad	.LFE152-.LFB152
	.byte	0x4
	.long	.LCFI429-.LFB152
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI430-.LCFI429
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE278:
.LSFDE280:
	.long	.LEFDE280-.LASFDE280
.LASFDE280:
	.long	.Lframe0
	.quad	.LFB153
	.quad	.LFE153-.LFB153
	.byte	0x4
	.long	.LCFI432-.LFB153
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI433-.LCFI432
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI435-.LCFI433
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE280:
.LSFDE282:
	.long	.LEFDE282-.LASFDE282
.LASFDE282:
	.long	.Lframe0
	.quad	.LFB154
	.quad	.LFE154-.LFB154
	.byte	0x4
	.long	.LCFI436-.LFB154
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI437-.LCFI436
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE282:
	.section	.eh_frame,"a",@progbits
.Lframe1:
	.long	.LECIE1-.LSCIE1
.LSCIE1:
	.long	0x0
	.byte	0x1
	.string	"zR"
	.uleb128 0x1
	.sleb128 -8
	.byte	0x10
	.uleb128 0x1
	.byte	0x1b
	.byte	0xc
	.uleb128 0x7
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x1
	.align 8
.LECIE1:
.LSFDE1:
	.long	.LEFDE1-.LASFDE1
.LASFDE1:
	.long	.LASFDE1-.Lframe1
	.long	.LFB13-.
	.long	.LFE13-.LFB13
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI0-.LFB13
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI1-.LCFI0
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE1:
.LSFDE3:
	.long	.LEFDE3-.LASFDE3
.LASFDE3:
	.long	.LASFDE3-.Lframe1
	.long	.LFB14-.
	.long	.LFE14-.LFB14
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI3-.LFB14
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI4-.LCFI3
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE3:
.LSFDE5:
	.long	.LEFDE5-.LASFDE5
.LASFDE5:
	.long	.LASFDE5-.Lframe1
	.long	.LFB15-.
	.long	.LFE15-.LFB15
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI6-.LFB15
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI7-.LCFI6
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE5:
.LSFDE7:
	.long	.LEFDE7-.LASFDE7
.LASFDE7:
	.long	.LASFDE7-.Lframe1
	.long	.LFB16-.
	.long	.LFE16-.LFB16
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI9-.LFB16
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI10-.LCFI9
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI12-.LCFI10
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE7:
.LSFDE9:
	.long	.LEFDE9-.LASFDE9
.LASFDE9:
	.long	.LASFDE9-.Lframe1
	.long	.LFB17-.
	.long	.LFE17-.LFB17
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI13-.LFB17
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI14-.LCFI13
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI16-.LCFI14
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE9:
.LSFDE11:
	.long	.LEFDE11-.LASFDE11
.LASFDE11:
	.long	.LASFDE11-.Lframe1
	.long	.LFB18-.
	.long	.LFE18-.LFB18
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI17-.LFB18
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI18-.LCFI17
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE11:
.LSFDE13:
	.long	.LEFDE13-.LASFDE13
.LASFDE13:
	.long	.LASFDE13-.Lframe1
	.long	.LFB19-.
	.long	.LFE19-.LFB19
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI20-.LFB19
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI21-.LCFI20
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE13:
.LSFDE15:
	.long	.LEFDE15-.LASFDE15
.LASFDE15:
	.long	.LASFDE15-.Lframe1
	.long	.LFB20-.
	.long	.LFE20-.LFB20
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI23-.LFB20
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI24-.LCFI23
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE15:
.LSFDE17:
	.long	.LEFDE17-.LASFDE17
.LASFDE17:
	.long	.LASFDE17-.Lframe1
	.long	.LFB21-.
	.long	.LFE21-.LFB21
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI26-.LFB21
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI27-.LCFI26
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE17:
.LSFDE19:
	.long	.LEFDE19-.LASFDE19
.LASFDE19:
	.long	.LASFDE19-.Lframe1
	.long	.LFB22-.
	.long	.LFE22-.LFB22
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI29-.LFB22
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI30-.LCFI29
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE19:
.LSFDE21:
	.long	.LEFDE21-.LASFDE21
.LASFDE21:
	.long	.LASFDE21-.Lframe1
	.long	.LFB23-.
	.long	.LFE23-.LFB23
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI32-.LFB23
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI33-.LCFI32
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE21:
.LSFDE23:
	.long	.LEFDE23-.LASFDE23
.LASFDE23:
	.long	.LASFDE23-.Lframe1
	.long	.LFB24-.
	.long	.LFE24-.LFB24
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI35-.LFB24
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI36-.LCFI35
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE23:
.LSFDE25:
	.long	.LEFDE25-.LASFDE25
.LASFDE25:
	.long	.LASFDE25-.Lframe1
	.long	.LFB25-.
	.long	.LFE25-.LFB25
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI38-.LFB25
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI39-.LCFI38
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE25:
.LSFDE27:
	.long	.LEFDE27-.LASFDE27
.LASFDE27:
	.long	.LASFDE27-.Lframe1
	.long	.LFB26-.
	.long	.LFE26-.LFB26
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI41-.LFB26
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI42-.LCFI41
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE27:
.LSFDE29:
	.long	.LEFDE29-.LASFDE29
.LASFDE29:
	.long	.LASFDE29-.Lframe1
	.long	.LFB27-.
	.long	.LFE27-.LFB27
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI44-.LFB27
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI45-.LCFI44
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE29:
.LSFDE31:
	.long	.LEFDE31-.LASFDE31
.LASFDE31:
	.long	.LASFDE31-.Lframe1
	.long	.LFB28-.
	.long	.LFE28-.LFB28
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI47-.LFB28
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI48-.LCFI47
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE31:
.LSFDE33:
	.long	.LEFDE33-.LASFDE33
.LASFDE33:
	.long	.LASFDE33-.Lframe1
	.long	.LFB29-.
	.long	.LFE29-.LFB29
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI49-.LFB29
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI50-.LCFI49
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE33:
.LSFDE35:
	.long	.LEFDE35-.LASFDE35
.LASFDE35:
	.long	.LASFDE35-.Lframe1
	.long	.LFB30-.
	.long	.LFE30-.LFB30
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI52-.LFB30
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI53-.LCFI52
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE35:
.LSFDE37:
	.long	.LEFDE37-.LASFDE37
.LASFDE37:
	.long	.LASFDE37-.Lframe1
	.long	.LFB31-.
	.long	.LFE31-.LFB31
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI55-.LFB31
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI56-.LCFI55
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE37:
.LSFDE39:
	.long	.LEFDE39-.LASFDE39
.LASFDE39:
	.long	.LASFDE39-.Lframe1
	.long	.LFB32-.
	.long	.LFE32-.LFB32
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI58-.LFB32
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI59-.LCFI58
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE39:
.LSFDE41:
	.long	.LEFDE41-.LASFDE41
.LASFDE41:
	.long	.LASFDE41-.Lframe1
	.long	.LFB33-.
	.long	.LFE33-.LFB33
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI61-.LFB33
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI62-.LCFI61
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE41:
.LSFDE43:
	.long	.LEFDE43-.LASFDE43
.LASFDE43:
	.long	.LASFDE43-.Lframe1
	.long	.LFB34-.
	.long	.LFE34-.LFB34
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI64-.LFB34
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI65-.LCFI64
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE43:
.LSFDE45:
	.long	.LEFDE45-.LASFDE45
.LASFDE45:
	.long	.LASFDE45-.Lframe1
	.long	.LFB35-.
	.long	.LFE35-.LFB35
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI67-.LFB35
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI68-.LCFI67
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE45:
.LSFDE47:
	.long	.LEFDE47-.LASFDE47
.LASFDE47:
	.long	.LASFDE47-.Lframe1
	.long	.LFB36-.
	.long	.LFE36-.LFB36
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI70-.LFB36
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI71-.LCFI70
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE47:
.LSFDE49:
	.long	.LEFDE49-.LASFDE49
.LASFDE49:
	.long	.LASFDE49-.Lframe1
	.long	.LFB37-.
	.long	.LFE37-.LFB37
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI73-.LFB37
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI74-.LCFI73
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE49:
.LSFDE51:
	.long	.LEFDE51-.LASFDE51
.LASFDE51:
	.long	.LASFDE51-.Lframe1
	.long	.LFB38-.
	.long	.LFE38-.LFB38
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI76-.LFB38
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI77-.LCFI76
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE51:
.LSFDE53:
	.long	.LEFDE53-.LASFDE53
.LASFDE53:
	.long	.LASFDE53-.Lframe1
	.long	.LFB39-.
	.long	.LFE39-.LFB39
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI79-.LFB39
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI80-.LCFI79
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE53:
.LSFDE55:
	.long	.LEFDE55-.LASFDE55
.LASFDE55:
	.long	.LASFDE55-.Lframe1
	.long	.LFB40-.
	.long	.LFE40-.LFB40
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI82-.LFB40
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI83-.LCFI82
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE55:
.LSFDE57:
	.long	.LEFDE57-.LASFDE57
.LASFDE57:
	.long	.LASFDE57-.Lframe1
	.long	.LFB41-.
	.long	.LFE41-.LFB41
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI85-.LFB41
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI86-.LCFI85
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE57:
.LSFDE59:
	.long	.LEFDE59-.LASFDE59
.LASFDE59:
	.long	.LASFDE59-.Lframe1
	.long	.LFB42-.
	.long	.LFE42-.LFB42
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI88-.LFB42
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI89-.LCFI88
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE59:
.LSFDE61:
	.long	.LEFDE61-.LASFDE61
.LASFDE61:
	.long	.LASFDE61-.Lframe1
	.long	.LFB43-.
	.long	.LFE43-.LFB43
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI91-.LFB43
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI92-.LCFI91
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE61:
.LSFDE63:
	.long	.LEFDE63-.LASFDE63
.LASFDE63:
	.long	.LASFDE63-.Lframe1
	.long	.LFB44-.
	.long	.LFE44-.LFB44
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI93-.LFB44
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI94-.LCFI93
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE63:
.LSFDE65:
	.long	.LEFDE65-.LASFDE65
.LASFDE65:
	.long	.LASFDE65-.Lframe1
	.long	.LFB45-.
	.long	.LFE45-.LFB45
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI96-.LFB45
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI97-.LCFI96
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE65:
.LSFDE67:
	.long	.LEFDE67-.LASFDE67
.LASFDE67:
	.long	.LASFDE67-.Lframe1
	.long	.LFB46-.
	.long	.LFE46-.LFB46
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI99-.LFB46
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI100-.LCFI99
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE67:
.LSFDE69:
	.long	.LEFDE69-.LASFDE69
.LASFDE69:
	.long	.LASFDE69-.Lframe1
	.long	.LFB47-.
	.long	.LFE47-.LFB47
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI102-.LFB47
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI103-.LCFI102
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE69:
.LSFDE71:
	.long	.LEFDE71-.LASFDE71
.LASFDE71:
	.long	.LASFDE71-.Lframe1
	.long	.LFB48-.
	.long	.LFE48-.LFB48
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI105-.LFB48
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI106-.LCFI105
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE71:
.LSFDE73:
	.long	.LEFDE73-.LASFDE73
.LASFDE73:
	.long	.LASFDE73-.Lframe1
	.long	.LFB49-.
	.long	.LFE49-.LFB49
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI108-.LFB49
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI109-.LCFI108
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE73:
.LSFDE75:
	.long	.LEFDE75-.LASFDE75
.LASFDE75:
	.long	.LASFDE75-.Lframe1
	.long	.LFB50-.
	.long	.LFE50-.LFB50
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI111-.LFB50
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI112-.LCFI111
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE75:
.LSFDE77:
	.long	.LEFDE77-.LASFDE77
.LASFDE77:
	.long	.LASFDE77-.Lframe1
	.long	.LFB51-.
	.long	.LFE51-.LFB51
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI114-.LFB51
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI115-.LCFI114
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE77:
.LSFDE79:
	.long	.LEFDE79-.LASFDE79
.LASFDE79:
	.long	.LASFDE79-.Lframe1
	.long	.LFB52-.
	.long	.LFE52-.LFB52
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI117-.LFB52
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI118-.LCFI117
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE79:
.LSFDE81:
	.long	.LEFDE81-.LASFDE81
.LASFDE81:
	.long	.LASFDE81-.Lframe1
	.long	.LFB53-.
	.long	.LFE53-.LFB53
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI120-.LFB53
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI121-.LCFI120
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE81:
.LSFDE83:
	.long	.LEFDE83-.LASFDE83
.LASFDE83:
	.long	.LASFDE83-.Lframe1
	.long	.LFB54-.
	.long	.LFE54-.LFB54
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI123-.LFB54
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI124-.LCFI123
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE83:
.LSFDE85:
	.long	.LEFDE85-.LASFDE85
.LASFDE85:
	.long	.LASFDE85-.Lframe1
	.long	.LFB55-.
	.long	.LFE55-.LFB55
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI126-.LFB55
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI127-.LCFI126
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE85:
.LSFDE87:
	.long	.LEFDE87-.LASFDE87
.LASFDE87:
	.long	.LASFDE87-.Lframe1
	.long	.LFB56-.
	.long	.LFE56-.LFB56
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI129-.LFB56
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI130-.LCFI129
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE87:
.LSFDE89:
	.long	.LEFDE89-.LASFDE89
.LASFDE89:
	.long	.LASFDE89-.Lframe1
	.long	.LFB57-.
	.long	.LFE57-.LFB57
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI132-.LFB57
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI133-.LCFI132
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE89:
.LSFDE91:
	.long	.LEFDE91-.LASFDE91
.LASFDE91:
	.long	.LASFDE91-.Lframe1
	.long	.LFB58-.
	.long	.LFE58-.LFB58
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI135-.LFB58
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI136-.LCFI135
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE91:
.LSFDE93:
	.long	.LEFDE93-.LASFDE93
.LASFDE93:
	.long	.LASFDE93-.Lframe1
	.long	.LFB59-.
	.long	.LFE59-.LFB59
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI138-.LFB59
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI139-.LCFI138
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE93:
.LSFDE95:
	.long	.LEFDE95-.LASFDE95
.LASFDE95:
	.long	.LASFDE95-.Lframe1
	.long	.LFB60-.
	.long	.LFE60-.LFB60
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI141-.LFB60
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI142-.LCFI141
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE95:
.LSFDE97:
	.long	.LEFDE97-.LASFDE97
.LASFDE97:
	.long	.LASFDE97-.Lframe1
	.long	.LFB61-.
	.long	.LFE61-.LFB61
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI143-.LFB61
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI144-.LCFI143
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE97:
.LSFDE99:
	.long	.LEFDE99-.LASFDE99
.LASFDE99:
	.long	.LASFDE99-.Lframe1
	.long	.LFB62-.
	.long	.LFE62-.LFB62
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI146-.LFB62
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI147-.LCFI146
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE99:
.LSFDE101:
	.long	.LEFDE101-.LASFDE101
.LASFDE101:
	.long	.LASFDE101-.Lframe1
	.long	.LFB63-.
	.long	.LFE63-.LFB63
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI149-.LFB63
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI150-.LCFI149
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE101:
.LSFDE103:
	.long	.LEFDE103-.LASFDE103
.LASFDE103:
	.long	.LASFDE103-.Lframe1
	.long	.LFB64-.
	.long	.LFE64-.LFB64
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI152-.LFB64
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI153-.LCFI152
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE103:
.LSFDE105:
	.long	.LEFDE105-.LASFDE105
.LASFDE105:
	.long	.LASFDE105-.Lframe1
	.long	.LFB65-.
	.long	.LFE65-.LFB65
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI155-.LFB65
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI156-.LCFI155
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE105:
.LSFDE107:
	.long	.LEFDE107-.LASFDE107
.LASFDE107:
	.long	.LASFDE107-.Lframe1
	.long	.LFB66-.
	.long	.LFE66-.LFB66
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI158-.LFB66
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI159-.LCFI158
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE107:
.LSFDE109:
	.long	.LEFDE109-.LASFDE109
.LASFDE109:
	.long	.LASFDE109-.Lframe1
	.long	.LFB67-.
	.long	.LFE67-.LFB67
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI161-.LFB67
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI162-.LCFI161
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE109:
.LSFDE111:
	.long	.LEFDE111-.LASFDE111
.LASFDE111:
	.long	.LASFDE111-.Lframe1
	.long	.LFB68-.
	.long	.LFE68-.LFB68
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI164-.LFB68
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI165-.LCFI164
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE111:
.LSFDE113:
	.long	.LEFDE113-.LASFDE113
.LASFDE113:
	.long	.LASFDE113-.Lframe1
	.long	.LFB69-.
	.long	.LFE69-.LFB69
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI167-.LFB69
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI168-.LCFI167
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE113:
.LSFDE115:
	.long	.LEFDE115-.LASFDE115
.LASFDE115:
	.long	.LASFDE115-.Lframe1
	.long	.LFB70-.
	.long	.LFE70-.LFB70
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI170-.LFB70
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI171-.LCFI170
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE115:
.LSFDE117:
	.long	.LEFDE117-.LASFDE117
.LASFDE117:
	.long	.LASFDE117-.Lframe1
	.long	.LFB71-.
	.long	.LFE71-.LFB71
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI173-.LFB71
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI174-.LCFI173
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE117:
.LSFDE119:
	.long	.LEFDE119-.LASFDE119
.LASFDE119:
	.long	.LASFDE119-.Lframe1
	.long	.LFB72-.
	.long	.LFE72-.LFB72
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI176-.LFB72
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI177-.LCFI176
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE119:
.LSFDE121:
	.long	.LEFDE121-.LASFDE121
.LASFDE121:
	.long	.LASFDE121-.Lframe1
	.long	.LFB73-.
	.long	.LFE73-.LFB73
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI179-.LFB73
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI180-.LCFI179
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE121:
.LSFDE123:
	.long	.LEFDE123-.LASFDE123
.LASFDE123:
	.long	.LASFDE123-.Lframe1
	.long	.LFB74-.
	.long	.LFE74-.LFB74
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI182-.LFB74
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI183-.LCFI182
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE123:
.LSFDE125:
	.long	.LEFDE125-.LASFDE125
.LASFDE125:
	.long	.LASFDE125-.Lframe1
	.long	.LFB75-.
	.long	.LFE75-.LFB75
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI185-.LFB75
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI186-.LCFI185
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE125:
.LSFDE127:
	.long	.LEFDE127-.LASFDE127
.LASFDE127:
	.long	.LASFDE127-.Lframe1
	.long	.LFB76-.
	.long	.LFE76-.LFB76
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI188-.LFB76
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI189-.LCFI188
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE127:
.LSFDE129:
	.long	.LEFDE129-.LASFDE129
.LASFDE129:
	.long	.LASFDE129-.Lframe1
	.long	.LFB77-.
	.long	.LFE77-.LFB77
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI191-.LFB77
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI192-.LCFI191
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE129:
.LSFDE131:
	.long	.LEFDE131-.LASFDE131
.LASFDE131:
	.long	.LASFDE131-.Lframe1
	.long	.LFB78-.
	.long	.LFE78-.LFB78
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI194-.LFB78
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI195-.LCFI194
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE131:
.LSFDE133:
	.long	.LEFDE133-.LASFDE133
.LASFDE133:
	.long	.LASFDE133-.Lframe1
	.long	.LFB79-.
	.long	.LFE79-.LFB79
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI197-.LFB79
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI198-.LCFI197
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE133:
.LSFDE135:
	.long	.LEFDE135-.LASFDE135
.LASFDE135:
	.long	.LASFDE135-.Lframe1
	.long	.LFB80-.
	.long	.LFE80-.LFB80
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI200-.LFB80
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI201-.LCFI200
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE135:
.LSFDE137:
	.long	.LEFDE137-.LASFDE137
.LASFDE137:
	.long	.LASFDE137-.Lframe1
	.long	.LFB81-.
	.long	.LFE81-.LFB81
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI203-.LFB81
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI204-.LCFI203
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE137:
.LSFDE139:
	.long	.LEFDE139-.LASFDE139
.LASFDE139:
	.long	.LASFDE139-.Lframe1
	.long	.LFB82-.
	.long	.LFE82-.LFB82
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI206-.LFB82
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI207-.LCFI206
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE139:
.LSFDE141:
	.long	.LEFDE141-.LASFDE141
.LASFDE141:
	.long	.LASFDE141-.Lframe1
	.long	.LFB83-.
	.long	.LFE83-.LFB83
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI209-.LFB83
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI210-.LCFI209
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE141:
.LSFDE143:
	.long	.LEFDE143-.LASFDE143
.LASFDE143:
	.long	.LASFDE143-.Lframe1
	.long	.LFB84-.
	.long	.LFE84-.LFB84
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI212-.LFB84
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI213-.LCFI212
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE143:
.LSFDE145:
	.long	.LEFDE145-.LASFDE145
.LASFDE145:
	.long	.LASFDE145-.Lframe1
	.long	.LFB85-.
	.long	.LFE85-.LFB85
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI215-.LFB85
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI216-.LCFI215
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE145:
.LSFDE147:
	.long	.LEFDE147-.LASFDE147
.LASFDE147:
	.long	.LASFDE147-.Lframe1
	.long	.LFB86-.
	.long	.LFE86-.LFB86
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI218-.LFB86
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI219-.LCFI218
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE147:
.LSFDE149:
	.long	.LEFDE149-.LASFDE149
.LASFDE149:
	.long	.LASFDE149-.Lframe1
	.long	.LFB87-.
	.long	.LFE87-.LFB87
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI221-.LFB87
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI222-.LCFI221
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE149:
.LSFDE151:
	.long	.LEFDE151-.LASFDE151
.LASFDE151:
	.long	.LASFDE151-.Lframe1
	.long	.LFB88-.
	.long	.LFE88-.LFB88
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI224-.LFB88
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI225-.LCFI224
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE151:
.LSFDE153:
	.long	.LEFDE153-.LASFDE153
.LASFDE153:
	.long	.LASFDE153-.Lframe1
	.long	.LFB89-.
	.long	.LFE89-.LFB89
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI227-.LFB89
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI228-.LCFI227
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE153:
.LSFDE155:
	.long	.LEFDE155-.LASFDE155
.LASFDE155:
	.long	.LASFDE155-.Lframe1
	.long	.LFB90-.
	.long	.LFE90-.LFB90
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI230-.LFB90
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI231-.LCFI230
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE155:
.LSFDE157:
	.long	.LEFDE157-.LASFDE157
.LASFDE157:
	.long	.LASFDE157-.Lframe1
	.long	.LFB91-.
	.long	.LFE91-.LFB91
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI233-.LFB91
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI234-.LCFI233
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE157:
.LSFDE159:
	.long	.LEFDE159-.LASFDE159
.LASFDE159:
	.long	.LASFDE159-.Lframe1
	.long	.LFB92-.
	.long	.LFE92-.LFB92
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI236-.LFB92
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI237-.LCFI236
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE159:
.LSFDE161:
	.long	.LEFDE161-.LASFDE161
.LASFDE161:
	.long	.LASFDE161-.Lframe1
	.long	.LFB93-.
	.long	.LFE93-.LFB93
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI239-.LFB93
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI240-.LCFI239
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE161:
.LSFDE163:
	.long	.LEFDE163-.LASFDE163
.LASFDE163:
	.long	.LASFDE163-.Lframe1
	.long	.LFB94-.
	.long	.LFE94-.LFB94
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI242-.LFB94
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI243-.LCFI242
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE163:
.LSFDE165:
	.long	.LEFDE165-.LASFDE165
.LASFDE165:
	.long	.LASFDE165-.Lframe1
	.long	.LFB95-.
	.long	.LFE95-.LFB95
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI245-.LFB95
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI246-.LCFI245
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI248-.LCFI246
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE165:
.LSFDE167:
	.long	.LEFDE167-.LASFDE167
.LASFDE167:
	.long	.LASFDE167-.Lframe1
	.long	.LFB96-.
	.long	.LFE96-.LFB96
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI249-.LFB96
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI250-.LCFI249
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI252-.LCFI250
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE167:
.LSFDE169:
	.long	.LEFDE169-.LASFDE169
.LASFDE169:
	.long	.LASFDE169-.Lframe1
	.long	.LFB97-.
	.long	.LFE97-.LFB97
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI253-.LFB97
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI254-.LCFI253
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI256-.LCFI254
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE169:
.LSFDE171:
	.long	.LEFDE171-.LASFDE171
.LASFDE171:
	.long	.LASFDE171-.Lframe1
	.long	.LFB98-.
	.long	.LFE98-.LFB98
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI257-.LFB98
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI258-.LCFI257
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI260-.LCFI258
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE171:
.LSFDE173:
	.long	.LEFDE173-.LASFDE173
.LASFDE173:
	.long	.LASFDE173-.Lframe1
	.long	.LFB99-.
	.long	.LFE99-.LFB99
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI261-.LFB99
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI262-.LCFI261
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI264-.LCFI262
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE173:
.LSFDE175:
	.long	.LEFDE175-.LASFDE175
.LASFDE175:
	.long	.LASFDE175-.Lframe1
	.long	.LFB100-.
	.long	.LFE100-.LFB100
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI265-.LFB100
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI266-.LCFI265
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE175:
.LSFDE177:
	.long	.LEFDE177-.LASFDE177
.LASFDE177:
	.long	.LASFDE177-.Lframe1
	.long	.LFB101-.
	.long	.LFE101-.LFB101
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI268-.LFB101
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI269-.LCFI268
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE177:
.LSFDE179:
	.long	.LEFDE179-.LASFDE179
.LASFDE179:
	.long	.LASFDE179-.Lframe1
	.long	.LFB102-.
	.long	.LFE102-.LFB102
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI271-.LFB102
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI272-.LCFI271
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE179:
.LSFDE181:
	.long	.LEFDE181-.LASFDE181
.LASFDE181:
	.long	.LASFDE181-.Lframe1
	.long	.LFB103-.
	.long	.LFE103-.LFB103
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI274-.LFB103
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI275-.LCFI274
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE181:
.LSFDE183:
	.long	.LEFDE183-.LASFDE183
.LASFDE183:
	.long	.LASFDE183-.Lframe1
	.long	.LFB104-.
	.long	.LFE104-.LFB104
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI277-.LFB104
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI278-.LCFI277
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE183:
.LSFDE185:
	.long	.LEFDE185-.LASFDE185
.LASFDE185:
	.long	.LASFDE185-.Lframe1
	.long	.LFB105-.
	.long	.LFE105-.LFB105
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI280-.LFB105
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI281-.LCFI280
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE185:
.LSFDE187:
	.long	.LEFDE187-.LASFDE187
.LASFDE187:
	.long	.LASFDE187-.Lframe1
	.long	.LFB106-.
	.long	.LFE106-.LFB106
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI283-.LFB106
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI284-.LCFI283
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE187:
.LSFDE189:
	.long	.LEFDE189-.LASFDE189
.LASFDE189:
	.long	.LASFDE189-.Lframe1
	.long	.LFB107-.
	.long	.LFE107-.LFB107
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI286-.LFB107
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI287-.LCFI286
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI289-.LCFI287
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE189:
.LSFDE191:
	.long	.LEFDE191-.LASFDE191
.LASFDE191:
	.long	.LASFDE191-.Lframe1
	.long	.LFB108-.
	.long	.LFE108-.LFB108
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI290-.LFB108
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI291-.LCFI290
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI293-.LCFI291
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE191:
.LSFDE193:
	.long	.LEFDE193-.LASFDE193
.LASFDE193:
	.long	.LASFDE193-.Lframe1
	.long	.LFB109-.
	.long	.LFE109-.LFB109
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI294-.LFB109
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI295-.LCFI294
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI297-.LCFI295
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE193:
.LSFDE195:
	.long	.LEFDE195-.LASFDE195
.LASFDE195:
	.long	.LASFDE195-.Lframe1
	.long	.LFB110-.
	.long	.LFE110-.LFB110
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI298-.LFB110
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI299-.LCFI298
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI301-.LCFI299
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE195:
.LSFDE197:
	.long	.LEFDE197-.LASFDE197
.LASFDE197:
	.long	.LASFDE197-.Lframe1
	.long	.LFB111-.
	.long	.LFE111-.LFB111
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI302-.LFB111
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI303-.LCFI302
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI305-.LCFI303
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE197:
.LSFDE199:
	.long	.LEFDE199-.LASFDE199
.LASFDE199:
	.long	.LASFDE199-.Lframe1
	.long	.LFB112-.
	.long	.LFE112-.LFB112
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI306-.LFB112
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI307-.LCFI306
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE199:
.LSFDE201:
	.long	.LEFDE201-.LASFDE201
.LASFDE201:
	.long	.LASFDE201-.Lframe1
	.long	.LFB113-.
	.long	.LFE113-.LFB113
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI309-.LFB113
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI310-.LCFI309
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE201:
.LSFDE203:
	.long	.LEFDE203-.LASFDE203
.LASFDE203:
	.long	.LASFDE203-.Lframe1
	.long	.LFB114-.
	.long	.LFE114-.LFB114
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI312-.LFB114
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI313-.LCFI312
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE203:
.LSFDE205:
	.long	.LEFDE205-.LASFDE205
.LASFDE205:
	.long	.LASFDE205-.Lframe1
	.long	.LFB115-.
	.long	.LFE115-.LFB115
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI315-.LFB115
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI316-.LCFI315
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE205:
.LSFDE207:
	.long	.LEFDE207-.LASFDE207
.LASFDE207:
	.long	.LASFDE207-.Lframe1
	.long	.LFB116-.
	.long	.LFE116-.LFB116
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI318-.LFB116
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI319-.LCFI318
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE207:
.LSFDE209:
	.long	.LEFDE209-.LASFDE209
.LASFDE209:
	.long	.LASFDE209-.Lframe1
	.long	.LFB117-.
	.long	.LFE117-.LFB117
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI321-.LFB117
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI322-.LCFI321
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE209:
.LSFDE211:
	.long	.LEFDE211-.LASFDE211
.LASFDE211:
	.long	.LASFDE211-.Lframe1
	.long	.LFB118-.
	.long	.LFE118-.LFB118
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI324-.LFB118
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI325-.LCFI324
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE211:
.LSFDE213:
	.long	.LEFDE213-.LASFDE213
.LASFDE213:
	.long	.LASFDE213-.Lframe1
	.long	.LFB119-.
	.long	.LFE119-.LFB119
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI327-.LFB119
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI328-.LCFI327
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE213:
.LSFDE215:
	.long	.LEFDE215-.LASFDE215
.LASFDE215:
	.long	.LASFDE215-.Lframe1
	.long	.LFB120-.
	.long	.LFE120-.LFB120
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI330-.LFB120
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI331-.LCFI330
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE215:
.LSFDE217:
	.long	.LEFDE217-.LASFDE217
.LASFDE217:
	.long	.LASFDE217-.Lframe1
	.long	.LFB121-.
	.long	.LFE121-.LFB121
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI333-.LFB121
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI334-.LCFI333
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE217:
.LSFDE219:
	.long	.LEFDE219-.LASFDE219
.LASFDE219:
	.long	.LASFDE219-.Lframe1
	.long	.LFB122-.
	.long	.LFE122-.LFB122
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI336-.LFB122
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI337-.LCFI336
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE219:
.LSFDE221:
	.long	.LEFDE221-.LASFDE221
.LASFDE221:
	.long	.LASFDE221-.Lframe1
	.long	.LFB123-.
	.long	.LFE123-.LFB123
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI339-.LFB123
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI340-.LCFI339
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE221:
.LSFDE223:
	.long	.LEFDE223-.LASFDE223
.LASFDE223:
	.long	.LASFDE223-.Lframe1
	.long	.LFB124-.
	.long	.LFE124-.LFB124
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI342-.LFB124
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI343-.LCFI342
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE223:
.LSFDE225:
	.long	.LEFDE225-.LASFDE225
.LASFDE225:
	.long	.LASFDE225-.Lframe1
	.long	.LFB125-.
	.long	.LFE125-.LFB125
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI345-.LFB125
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI346-.LCFI345
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE225:
.LSFDE227:
	.long	.LEFDE227-.LASFDE227
.LASFDE227:
	.long	.LASFDE227-.Lframe1
	.long	.LFB126-.
	.long	.LFE126-.LFB126
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI348-.LFB126
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI349-.LCFI348
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE227:
.LSFDE229:
	.long	.LEFDE229-.LASFDE229
.LASFDE229:
	.long	.LASFDE229-.Lframe1
	.long	.LFB127-.
	.long	.LFE127-.LFB127
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI351-.LFB127
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI352-.LCFI351
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE229:
.LSFDE231:
	.long	.LEFDE231-.LASFDE231
.LASFDE231:
	.long	.LASFDE231-.Lframe1
	.long	.LFB128-.
	.long	.LFE128-.LFB128
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI354-.LFB128
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI355-.LCFI354
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE231:
.LSFDE233:
	.long	.LEFDE233-.LASFDE233
.LASFDE233:
	.long	.LASFDE233-.Lframe1
	.long	.LFB129-.
	.long	.LFE129-.LFB129
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI357-.LFB129
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI358-.LCFI357
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE233:
.LSFDE235:
	.long	.LEFDE235-.LASFDE235
.LASFDE235:
	.long	.LASFDE235-.Lframe1
	.long	.LFB130-.
	.long	.LFE130-.LFB130
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI360-.LFB130
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI361-.LCFI360
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE235:
.LSFDE237:
	.long	.LEFDE237-.LASFDE237
.LASFDE237:
	.long	.LASFDE237-.Lframe1
	.long	.LFB131-.
	.long	.LFE131-.LFB131
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI363-.LFB131
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI364-.LCFI363
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI366-.LCFI364
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE237:
.LSFDE239:
	.long	.LEFDE239-.LASFDE239
.LASFDE239:
	.long	.LASFDE239-.Lframe1
	.long	.LFB132-.
	.long	.LFE132-.LFB132
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI367-.LFB132
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI368-.LCFI367
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE239:
.LSFDE241:
	.long	.LEFDE241-.LASFDE241
.LASFDE241:
	.long	.LASFDE241-.Lframe1
	.long	.LFB133-.
	.long	.LFE133-.LFB133
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI370-.LFB133
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI371-.LCFI370
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE241:
.LSFDE243:
	.long	.LEFDE243-.LASFDE243
.LASFDE243:
	.long	.LASFDE243-.Lframe1
	.long	.LFB134-.
	.long	.LFE134-.LFB134
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI373-.LFB134
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI374-.LCFI373
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE243:
.LSFDE245:
	.long	.LEFDE245-.LASFDE245
.LASFDE245:
	.long	.LASFDE245-.Lframe1
	.long	.LFB135-.
	.long	.LFE135-.LFB135
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI376-.LFB135
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI377-.LCFI376
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE245:
.LSFDE247:
	.long	.LEFDE247-.LASFDE247
.LASFDE247:
	.long	.LASFDE247-.Lframe1
	.long	.LFB136-.
	.long	.LFE136-.LFB136
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI379-.LFB136
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI380-.LCFI379
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE247:
.LSFDE249:
	.long	.LEFDE249-.LASFDE249
.LASFDE249:
	.long	.LASFDE249-.Lframe1
	.long	.LFB137-.
	.long	.LFE137-.LFB137
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI382-.LFB137
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI383-.LCFI382
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE249:
.LSFDE251:
	.long	.LEFDE251-.LASFDE251
.LASFDE251:
	.long	.LASFDE251-.Lframe1
	.long	.LFB138-.
	.long	.LFE138-.LFB138
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI385-.LFB138
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI386-.LCFI385
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE251:
.LSFDE253:
	.long	.LEFDE253-.LASFDE253
.LASFDE253:
	.long	.LASFDE253-.Lframe1
	.long	.LFB139-.
	.long	.LFE139-.LFB139
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI388-.LFB139
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI389-.LCFI388
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE253:
.LSFDE255:
	.long	.LEFDE255-.LASFDE255
.LASFDE255:
	.long	.LASFDE255-.Lframe1
	.long	.LFB140-.
	.long	.LFE140-.LFB140
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI391-.LFB140
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI392-.LCFI391
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE255:
.LSFDE257:
	.long	.LEFDE257-.LASFDE257
.LASFDE257:
	.long	.LASFDE257-.Lframe1
	.long	.LFB141-.
	.long	.LFE141-.LFB141
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI394-.LFB141
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI395-.LCFI394
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE257:
.LSFDE259:
	.long	.LEFDE259-.LASFDE259
.LASFDE259:
	.long	.LASFDE259-.Lframe1
	.long	.LFB142-.
	.long	.LFE142-.LFB142
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI397-.LFB142
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI398-.LCFI397
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE259:
.LSFDE261:
	.long	.LEFDE261-.LASFDE261
.LASFDE261:
	.long	.LASFDE261-.Lframe1
	.long	.LFB143-.
	.long	.LFE143-.LFB143
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI400-.LFB143
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI401-.LCFI400
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE261:
.LSFDE263:
	.long	.LEFDE263-.LASFDE263
.LASFDE263:
	.long	.LASFDE263-.Lframe1
	.long	.LFB144-.
	.long	.LFE144-.LFB144
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI403-.LFB144
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI404-.LCFI403
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE263:
.LSFDE265:
	.long	.LEFDE265-.LASFDE265
.LASFDE265:
	.long	.LASFDE265-.Lframe1
	.long	.LFB145-.
	.long	.LFE145-.LFB145
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI406-.LFB145
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI407-.LCFI406
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE265:
.LSFDE267:
	.long	.LEFDE267-.LASFDE267
.LASFDE267:
	.long	.LASFDE267-.Lframe1
	.long	.LFB146-.
	.long	.LFE146-.LFB146
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI409-.LFB146
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI410-.LCFI409
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE267:
.LSFDE269:
	.long	.LEFDE269-.LASFDE269
.LASFDE269:
	.long	.LASFDE269-.Lframe1
	.long	.LFB147-.
	.long	.LFE147-.LFB147
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI412-.LFB147
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI413-.LCFI412
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE269:
.LSFDE271:
	.long	.LEFDE271-.LASFDE271
.LASFDE271:
	.long	.LASFDE271-.Lframe1
	.long	.LFB148-.
	.long	.LFE148-.LFB148
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI415-.LFB148
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI416-.LCFI415
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI418-.LCFI416
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE271:
.LSFDE273:
	.long	.LEFDE273-.LASFDE273
.LASFDE273:
	.long	.LASFDE273-.Lframe1
	.long	.LFB149-.
	.long	.LFE149-.LFB149
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI419-.LFB149
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI420-.LCFI419
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE273:
.LSFDE275:
	.long	.LEFDE275-.LASFDE275
.LASFDE275:
	.long	.LASFDE275-.Lframe1
	.long	.LFB150-.
	.long	.LFE150-.LFB150
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI422-.LFB150
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI423-.LCFI422
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI425-.LCFI423
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE275:
.LSFDE277:
	.long	.LEFDE277-.LASFDE277
.LASFDE277:
	.long	.LASFDE277-.Lframe1
	.long	.LFB151-.
	.long	.LFE151-.LFB151
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI426-.LFB151
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI427-.LCFI426
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE277:
.LSFDE279:
	.long	.LEFDE279-.LASFDE279
.LASFDE279:
	.long	.LASFDE279-.Lframe1
	.long	.LFB152-.
	.long	.LFE152-.LFB152
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI429-.LFB152
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI430-.LCFI429
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE279:
.LSFDE281:
	.long	.LEFDE281-.LASFDE281
.LASFDE281:
	.long	.LASFDE281-.Lframe1
	.long	.LFB153-.
	.long	.LFE153-.LFB153
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI432-.LFB153
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI433-.LCFI432
	.byte	0xd
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI435-.LCFI433
	.byte	0x83
	.uleb128 0x3
	.align 8
.LEFDE281:
.LSFDE283:
	.long	.LEFDE283-.LASFDE283
.LASFDE283:
	.long	.LASFDE283-.Lframe1
	.long	.LFB154-.
	.long	.LFE154-.LFB154
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI436-.LFB154
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI437-.LCFI436
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE283:
	.file 2 "include/packetheader.h"
	.file 3 "/usr/include/bits/pthreadtypes.h"
	.file 4 "/usr/lib/gcc/x86_64-redhat-linux/4.1.2/include/stddef.h"
	.file 5 "/usr/local/cuda/include/vector_types.h"
	.file 6 "/usr/local/cuda/include/driver_types.h"
	.file 7 "/usr/local/cuda/include/texture_types.h"
	.file 8 "/usr/local/cuda/include/surface_types.h"
	.file 9 "/usr/local/cuda/include/cuda.h"
	.file 10 "interposer/libciutils.h"
	.file 11 "/usr/local/cuda/include/__cudaFatFormat.h"
	.file 12 "/usr/include/glib-2.0/glib/ghash.h"
	.file 13 "/usr/include/stdio.h"
	.file 14 "/usr/include/libio.h"
	.file 15 "/usr/include/bits/types.h"
	.text
.Letext0:
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.quad	.LFB13-.Ltext0
	.quad	.LCFI0-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI0-.Ltext0
	.quad	.LCFI1-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI1-.Ltext0
	.quad	.LFE13-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST1:
	.quad	.LFB14-.Ltext0
	.quad	.LCFI3-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI3-.Ltext0
	.quad	.LCFI4-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI4-.Ltext0
	.quad	.LFE14-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST2:
	.quad	.LFB15-.Ltext0
	.quad	.LCFI6-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI6-.Ltext0
	.quad	.LCFI7-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI7-.Ltext0
	.quad	.LFE15-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST3:
	.quad	.LFB16-.Ltext0
	.quad	.LCFI9-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI9-.Ltext0
	.quad	.LCFI10-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI10-.Ltext0
	.quad	.LFE16-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST4:
	.quad	.LFB17-.Ltext0
	.quad	.LCFI13-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI13-.Ltext0
	.quad	.LCFI14-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI14-.Ltext0
	.quad	.LFE17-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST5:
	.quad	.LFB18-.Ltext0
	.quad	.LCFI17-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI17-.Ltext0
	.quad	.LCFI18-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI18-.Ltext0
	.quad	.LFE18-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST6:
	.quad	.LFB19-.Ltext0
	.quad	.LCFI20-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI20-.Ltext0
	.quad	.LCFI21-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI21-.Ltext0
	.quad	.LFE19-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST7:
	.quad	.LFB20-.Ltext0
	.quad	.LCFI23-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI23-.Ltext0
	.quad	.LCFI24-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI24-.Ltext0
	.quad	.LFE20-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST8:
	.quad	.LFB21-.Ltext0
	.quad	.LCFI26-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI26-.Ltext0
	.quad	.LCFI27-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI27-.Ltext0
	.quad	.LFE21-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST9:
	.quad	.LFB22-.Ltext0
	.quad	.LCFI29-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI29-.Ltext0
	.quad	.LCFI30-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI30-.Ltext0
	.quad	.LFE22-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST10:
	.quad	.LFB23-.Ltext0
	.quad	.LCFI32-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI32-.Ltext0
	.quad	.LCFI33-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI33-.Ltext0
	.quad	.LFE23-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST11:
	.quad	.LFB24-.Ltext0
	.quad	.LCFI35-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI35-.Ltext0
	.quad	.LCFI36-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI36-.Ltext0
	.quad	.LFE24-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST12:
	.quad	.LFB25-.Ltext0
	.quad	.LCFI38-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI38-.Ltext0
	.quad	.LCFI39-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI39-.Ltext0
	.quad	.LFE25-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST13:
	.quad	.LFB26-.Ltext0
	.quad	.LCFI41-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI41-.Ltext0
	.quad	.LCFI42-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI42-.Ltext0
	.quad	.LFE26-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST14:
	.quad	.LFB27-.Ltext0
	.quad	.LCFI44-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI44-.Ltext0
	.quad	.LCFI45-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI45-.Ltext0
	.quad	.LFE27-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST15:
	.quad	.LFB28-.Ltext0
	.quad	.LCFI47-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI47-.Ltext0
	.quad	.LCFI48-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI48-.Ltext0
	.quad	.LFE28-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST16:
	.quad	.LFB29-.Ltext0
	.quad	.LCFI49-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI49-.Ltext0
	.quad	.LCFI50-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI50-.Ltext0
	.quad	.LFE29-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST17:
	.quad	.LFB30-.Ltext0
	.quad	.LCFI52-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI52-.Ltext0
	.quad	.LCFI53-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI53-.Ltext0
	.quad	.LFE30-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST18:
	.quad	.LFB31-.Ltext0
	.quad	.LCFI55-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI55-.Ltext0
	.quad	.LCFI56-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI56-.Ltext0
	.quad	.LFE31-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST19:
	.quad	.LFB32-.Ltext0
	.quad	.LCFI58-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI58-.Ltext0
	.quad	.LCFI59-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI59-.Ltext0
	.quad	.LFE32-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST20:
	.quad	.LFB33-.Ltext0
	.quad	.LCFI61-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI61-.Ltext0
	.quad	.LCFI62-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI62-.Ltext0
	.quad	.LFE33-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST21:
	.quad	.LFB34-.Ltext0
	.quad	.LCFI64-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI64-.Ltext0
	.quad	.LCFI65-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI65-.Ltext0
	.quad	.LFE34-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST22:
	.quad	.LFB35-.Ltext0
	.quad	.LCFI67-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI67-.Ltext0
	.quad	.LCFI68-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI68-.Ltext0
	.quad	.LFE35-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST23:
	.quad	.LFB36-.Ltext0
	.quad	.LCFI70-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI70-.Ltext0
	.quad	.LCFI71-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI71-.Ltext0
	.quad	.LFE36-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST24:
	.quad	.LFB37-.Ltext0
	.quad	.LCFI73-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI73-.Ltext0
	.quad	.LCFI74-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI74-.Ltext0
	.quad	.LFE37-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST25:
	.quad	.LFB38-.Ltext0
	.quad	.LCFI76-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI76-.Ltext0
	.quad	.LCFI77-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI77-.Ltext0
	.quad	.LFE38-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST26:
	.quad	.LFB39-.Ltext0
	.quad	.LCFI79-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI79-.Ltext0
	.quad	.LCFI80-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI80-.Ltext0
	.quad	.LFE39-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST27:
	.quad	.LFB40-.Ltext0
	.quad	.LCFI82-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI82-.Ltext0
	.quad	.LCFI83-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI83-.Ltext0
	.quad	.LFE40-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST28:
	.quad	.LFB41-.Ltext0
	.quad	.LCFI85-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI85-.Ltext0
	.quad	.LCFI86-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI86-.Ltext0
	.quad	.LFE41-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST29:
	.quad	.LFB42-.Ltext0
	.quad	.LCFI88-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI88-.Ltext0
	.quad	.LCFI89-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI89-.Ltext0
	.quad	.LFE42-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST30:
	.quad	.LFB43-.Ltext0
	.quad	.LCFI91-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI91-.Ltext0
	.quad	.LCFI92-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI92-.Ltext0
	.quad	.LFE43-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST31:
	.quad	.LFB44-.Ltext0
	.quad	.LCFI93-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI93-.Ltext0
	.quad	.LCFI94-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI94-.Ltext0
	.quad	.LFE44-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST32:
	.quad	.LFB45-.Ltext0
	.quad	.LCFI96-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI96-.Ltext0
	.quad	.LCFI97-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI97-.Ltext0
	.quad	.LFE45-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST33:
	.quad	.LFB46-.Ltext0
	.quad	.LCFI99-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI99-.Ltext0
	.quad	.LCFI100-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI100-.Ltext0
	.quad	.LFE46-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST34:
	.quad	.LFB47-.Ltext0
	.quad	.LCFI102-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI102-.Ltext0
	.quad	.LCFI103-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI103-.Ltext0
	.quad	.LFE47-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST35:
	.quad	.LFB48-.Ltext0
	.quad	.LCFI105-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI105-.Ltext0
	.quad	.LCFI106-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI106-.Ltext0
	.quad	.LFE48-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST36:
	.quad	.LFB49-.Ltext0
	.quad	.LCFI108-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI108-.Ltext0
	.quad	.LCFI109-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI109-.Ltext0
	.quad	.LFE49-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST37:
	.quad	.LFB50-.Ltext0
	.quad	.LCFI111-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI111-.Ltext0
	.quad	.LCFI112-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI112-.Ltext0
	.quad	.LFE50-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST38:
	.quad	.LFB51-.Ltext0
	.quad	.LCFI114-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI114-.Ltext0
	.quad	.LCFI115-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI115-.Ltext0
	.quad	.LFE51-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST39:
	.quad	.LFB52-.Ltext0
	.quad	.LCFI117-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI117-.Ltext0
	.quad	.LCFI118-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI118-.Ltext0
	.quad	.LFE52-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST40:
	.quad	.LFB53-.Ltext0
	.quad	.LCFI120-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI120-.Ltext0
	.quad	.LCFI121-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI121-.Ltext0
	.quad	.LFE53-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST41:
	.quad	.LFB54-.Ltext0
	.quad	.LCFI123-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI123-.Ltext0
	.quad	.LCFI124-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI124-.Ltext0
	.quad	.LFE54-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST42:
	.quad	.LFB55-.Ltext0
	.quad	.LCFI126-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI126-.Ltext0
	.quad	.LCFI127-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI127-.Ltext0
	.quad	.LFE55-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST43:
	.quad	.LFB56-.Ltext0
	.quad	.LCFI129-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI129-.Ltext0
	.quad	.LCFI130-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI130-.Ltext0
	.quad	.LFE56-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST44:
	.quad	.LFB57-.Ltext0
	.quad	.LCFI132-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI132-.Ltext0
	.quad	.LCFI133-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI133-.Ltext0
	.quad	.LFE57-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST45:
	.quad	.LFB58-.Ltext0
	.quad	.LCFI135-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI135-.Ltext0
	.quad	.LCFI136-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI136-.Ltext0
	.quad	.LFE58-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST46:
	.quad	.LFB59-.Ltext0
	.quad	.LCFI138-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI138-.Ltext0
	.quad	.LCFI139-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI139-.Ltext0
	.quad	.LFE59-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST47:
	.quad	.LFB60-.Ltext0
	.quad	.LCFI141-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI141-.Ltext0
	.quad	.LCFI142-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI142-.Ltext0
	.quad	.LFE60-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST48:
	.quad	.LFB61-.Ltext0
	.quad	.LCFI143-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI143-.Ltext0
	.quad	.LCFI144-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI144-.Ltext0
	.quad	.LFE61-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST49:
	.quad	.LFB62-.Ltext0
	.quad	.LCFI146-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI146-.Ltext0
	.quad	.LCFI147-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI147-.Ltext0
	.quad	.LFE62-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST50:
	.quad	.LFB63-.Ltext0
	.quad	.LCFI149-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI149-.Ltext0
	.quad	.LCFI150-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI150-.Ltext0
	.quad	.LFE63-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST51:
	.quad	.LFB64-.Ltext0
	.quad	.LCFI152-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI152-.Ltext0
	.quad	.LCFI153-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI153-.Ltext0
	.quad	.LFE64-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST52:
	.quad	.LFB65-.Ltext0
	.quad	.LCFI155-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI155-.Ltext0
	.quad	.LCFI156-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI156-.Ltext0
	.quad	.LFE65-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST53:
	.quad	.LFB66-.Ltext0
	.quad	.LCFI158-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI158-.Ltext0
	.quad	.LCFI159-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI159-.Ltext0
	.quad	.LFE66-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST54:
	.quad	.LFB67-.Ltext0
	.quad	.LCFI161-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI161-.Ltext0
	.quad	.LCFI162-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI162-.Ltext0
	.quad	.LFE67-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST55:
	.quad	.LFB68-.Ltext0
	.quad	.LCFI164-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI164-.Ltext0
	.quad	.LCFI165-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI165-.Ltext0
	.quad	.LFE68-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST56:
	.quad	.LFB69-.Ltext0
	.quad	.LCFI167-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI167-.Ltext0
	.quad	.LCFI168-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI168-.Ltext0
	.quad	.LFE69-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST57:
	.quad	.LFB70-.Ltext0
	.quad	.LCFI170-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI170-.Ltext0
	.quad	.LCFI171-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI171-.Ltext0
	.quad	.LFE70-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST58:
	.quad	.LFB71-.Ltext0
	.quad	.LCFI173-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI173-.Ltext0
	.quad	.LCFI174-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI174-.Ltext0
	.quad	.LFE71-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST59:
	.quad	.LFB72-.Ltext0
	.quad	.LCFI176-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI176-.Ltext0
	.quad	.LCFI177-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI177-.Ltext0
	.quad	.LFE72-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST60:
	.quad	.LFB73-.Ltext0
	.quad	.LCFI179-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI179-.Ltext0
	.quad	.LCFI180-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI180-.Ltext0
	.quad	.LFE73-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST61:
	.quad	.LFB74-.Ltext0
	.quad	.LCFI182-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI182-.Ltext0
	.quad	.LCFI183-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI183-.Ltext0
	.quad	.LFE74-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST62:
	.quad	.LFB75-.Ltext0
	.quad	.LCFI185-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI185-.Ltext0
	.quad	.LCFI186-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI186-.Ltext0
	.quad	.LFE75-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST63:
	.quad	.LFB76-.Ltext0
	.quad	.LCFI188-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI188-.Ltext0
	.quad	.LCFI189-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI189-.Ltext0
	.quad	.LFE76-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST64:
	.quad	.LFB77-.Ltext0
	.quad	.LCFI191-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI191-.Ltext0
	.quad	.LCFI192-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI192-.Ltext0
	.quad	.LFE77-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST65:
	.quad	.LFB78-.Ltext0
	.quad	.LCFI194-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI194-.Ltext0
	.quad	.LCFI195-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI195-.Ltext0
	.quad	.LFE78-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST66:
	.quad	.LFB79-.Ltext0
	.quad	.LCFI197-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI197-.Ltext0
	.quad	.LCFI198-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI198-.Ltext0
	.quad	.LFE79-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST67:
	.quad	.LFB80-.Ltext0
	.quad	.LCFI200-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI200-.Ltext0
	.quad	.LCFI201-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI201-.Ltext0
	.quad	.LFE80-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST68:
	.quad	.LFB81-.Ltext0
	.quad	.LCFI203-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI203-.Ltext0
	.quad	.LCFI204-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI204-.Ltext0
	.quad	.LFE81-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST69:
	.quad	.LFB82-.Ltext0
	.quad	.LCFI206-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI206-.Ltext0
	.quad	.LCFI207-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI207-.Ltext0
	.quad	.LFE82-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST70:
	.quad	.LFB83-.Ltext0
	.quad	.LCFI209-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI209-.Ltext0
	.quad	.LCFI210-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI210-.Ltext0
	.quad	.LFE83-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST71:
	.quad	.LFB84-.Ltext0
	.quad	.LCFI212-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI212-.Ltext0
	.quad	.LCFI213-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI213-.Ltext0
	.quad	.LFE84-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST72:
	.quad	.LFB85-.Ltext0
	.quad	.LCFI215-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI215-.Ltext0
	.quad	.LCFI216-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI216-.Ltext0
	.quad	.LFE85-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST73:
	.quad	.LFB86-.Ltext0
	.quad	.LCFI218-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI218-.Ltext0
	.quad	.LCFI219-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI219-.Ltext0
	.quad	.LFE86-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST74:
	.quad	.LFB87-.Ltext0
	.quad	.LCFI221-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI221-.Ltext0
	.quad	.LCFI222-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI222-.Ltext0
	.quad	.LFE87-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST75:
	.quad	.LFB88-.Ltext0
	.quad	.LCFI224-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI224-.Ltext0
	.quad	.LCFI225-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI225-.Ltext0
	.quad	.LFE88-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST76:
	.quad	.LFB89-.Ltext0
	.quad	.LCFI227-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI227-.Ltext0
	.quad	.LCFI228-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI228-.Ltext0
	.quad	.LFE89-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST77:
	.quad	.LFB90-.Ltext0
	.quad	.LCFI230-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI230-.Ltext0
	.quad	.LCFI231-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI231-.Ltext0
	.quad	.LFE90-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST78:
	.quad	.LFB91-.Ltext0
	.quad	.LCFI233-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI233-.Ltext0
	.quad	.LCFI234-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI234-.Ltext0
	.quad	.LFE91-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST79:
	.quad	.LFB92-.Ltext0
	.quad	.LCFI236-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI236-.Ltext0
	.quad	.LCFI237-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI237-.Ltext0
	.quad	.LFE92-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST80:
	.quad	.LFB93-.Ltext0
	.quad	.LCFI239-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI239-.Ltext0
	.quad	.LCFI240-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI240-.Ltext0
	.quad	.LFE93-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST81:
	.quad	.LFB94-.Ltext0
	.quad	.LCFI242-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI242-.Ltext0
	.quad	.LCFI243-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI243-.Ltext0
	.quad	.LFE94-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST82:
	.quad	.LFB95-.Ltext0
	.quad	.LCFI245-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI245-.Ltext0
	.quad	.LCFI246-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI246-.Ltext0
	.quad	.LFE95-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST83:
	.quad	.LFB96-.Ltext0
	.quad	.LCFI249-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI249-.Ltext0
	.quad	.LCFI250-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI250-.Ltext0
	.quad	.LFE96-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST84:
	.quad	.LFB97-.Ltext0
	.quad	.LCFI253-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI253-.Ltext0
	.quad	.LCFI254-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI254-.Ltext0
	.quad	.LFE97-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST85:
	.quad	.LFB98-.Ltext0
	.quad	.LCFI257-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI257-.Ltext0
	.quad	.LCFI258-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI258-.Ltext0
	.quad	.LFE98-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST86:
	.quad	.LFB99-.Ltext0
	.quad	.LCFI261-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI261-.Ltext0
	.quad	.LCFI262-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI262-.Ltext0
	.quad	.LFE99-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST87:
	.quad	.LFB100-.Ltext0
	.quad	.LCFI265-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI265-.Ltext0
	.quad	.LCFI266-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI266-.Ltext0
	.quad	.LFE100-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST88:
	.quad	.LFB101-.Ltext0
	.quad	.LCFI268-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI268-.Ltext0
	.quad	.LCFI269-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI269-.Ltext0
	.quad	.LFE101-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST89:
	.quad	.LFB102-.Ltext0
	.quad	.LCFI271-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI271-.Ltext0
	.quad	.LCFI272-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI272-.Ltext0
	.quad	.LFE102-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST90:
	.quad	.LFB103-.Ltext0
	.quad	.LCFI274-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI274-.Ltext0
	.quad	.LCFI275-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI275-.Ltext0
	.quad	.LFE103-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST91:
	.quad	.LFB104-.Ltext0
	.quad	.LCFI277-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI277-.Ltext0
	.quad	.LCFI278-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI278-.Ltext0
	.quad	.LFE104-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST92:
	.quad	.LFB105-.Ltext0
	.quad	.LCFI280-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI280-.Ltext0
	.quad	.LCFI281-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI281-.Ltext0
	.quad	.LFE105-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST93:
	.quad	.LFB106-.Ltext0
	.quad	.LCFI283-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI283-.Ltext0
	.quad	.LCFI284-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI284-.Ltext0
	.quad	.LFE106-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST94:
	.quad	.LFB107-.Ltext0
	.quad	.LCFI286-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI286-.Ltext0
	.quad	.LCFI287-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI287-.Ltext0
	.quad	.LFE107-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST95:
	.quad	.LFB108-.Ltext0
	.quad	.LCFI290-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI290-.Ltext0
	.quad	.LCFI291-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI291-.Ltext0
	.quad	.LFE108-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST96:
	.quad	.LFB109-.Ltext0
	.quad	.LCFI294-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI294-.Ltext0
	.quad	.LCFI295-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI295-.Ltext0
	.quad	.LFE109-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST97:
	.quad	.LFB110-.Ltext0
	.quad	.LCFI298-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI298-.Ltext0
	.quad	.LCFI299-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI299-.Ltext0
	.quad	.LFE110-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST98:
	.quad	.LFB111-.Ltext0
	.quad	.LCFI302-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI302-.Ltext0
	.quad	.LCFI303-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI303-.Ltext0
	.quad	.LFE111-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST99:
	.quad	.LFB112-.Ltext0
	.quad	.LCFI306-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI306-.Ltext0
	.quad	.LCFI307-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI307-.Ltext0
	.quad	.LFE112-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST100:
	.quad	.LFB113-.Ltext0
	.quad	.LCFI309-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI309-.Ltext0
	.quad	.LCFI310-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI310-.Ltext0
	.quad	.LFE113-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST101:
	.quad	.LFB114-.Ltext0
	.quad	.LCFI312-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI312-.Ltext0
	.quad	.LCFI313-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI313-.Ltext0
	.quad	.LFE114-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST102:
	.quad	.LFB115-.Ltext0
	.quad	.LCFI315-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI315-.Ltext0
	.quad	.LCFI316-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI316-.Ltext0
	.quad	.LFE115-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST103:
	.quad	.LFB116-.Ltext0
	.quad	.LCFI318-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI318-.Ltext0
	.quad	.LCFI319-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI319-.Ltext0
	.quad	.LFE116-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST104:
	.quad	.LFB117-.Ltext0
	.quad	.LCFI321-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI321-.Ltext0
	.quad	.LCFI322-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI322-.Ltext0
	.quad	.LFE117-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST105:
	.quad	.LFB118-.Ltext0
	.quad	.LCFI324-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI324-.Ltext0
	.quad	.LCFI325-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI325-.Ltext0
	.quad	.LFE118-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST106:
	.quad	.LFB119-.Ltext0
	.quad	.LCFI327-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI327-.Ltext0
	.quad	.LCFI328-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI328-.Ltext0
	.quad	.LFE119-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST107:
	.quad	.LFB120-.Ltext0
	.quad	.LCFI330-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI330-.Ltext0
	.quad	.LCFI331-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI331-.Ltext0
	.quad	.LFE120-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST108:
	.quad	.LFB121-.Ltext0
	.quad	.LCFI333-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI333-.Ltext0
	.quad	.LCFI334-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI334-.Ltext0
	.quad	.LFE121-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST109:
	.quad	.LFB122-.Ltext0
	.quad	.LCFI336-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI336-.Ltext0
	.quad	.LCFI337-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI337-.Ltext0
	.quad	.LFE122-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST110:
	.quad	.LFB123-.Ltext0
	.quad	.LCFI339-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI339-.Ltext0
	.quad	.LCFI340-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI340-.Ltext0
	.quad	.LFE123-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST111:
	.quad	.LFB124-.Ltext0
	.quad	.LCFI342-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI342-.Ltext0
	.quad	.LCFI343-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI343-.Ltext0
	.quad	.LFE124-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST112:
	.quad	.LFB125-.Ltext0
	.quad	.LCFI345-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI345-.Ltext0
	.quad	.LCFI346-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI346-.Ltext0
	.quad	.LFE125-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST113:
	.quad	.LFB126-.Ltext0
	.quad	.LCFI348-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI348-.Ltext0
	.quad	.LCFI349-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI349-.Ltext0
	.quad	.LFE126-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST114:
	.quad	.LFB127-.Ltext0
	.quad	.LCFI351-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI351-.Ltext0
	.quad	.LCFI352-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI352-.Ltext0
	.quad	.LFE127-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST115:
	.quad	.LFB128-.Ltext0
	.quad	.LCFI354-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI354-.Ltext0
	.quad	.LCFI355-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI355-.Ltext0
	.quad	.LFE128-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST116:
	.quad	.LFB129-.Ltext0
	.quad	.LCFI357-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI357-.Ltext0
	.quad	.LCFI358-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI358-.Ltext0
	.quad	.LFE129-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST117:
	.quad	.LFB130-.Ltext0
	.quad	.LCFI360-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI360-.Ltext0
	.quad	.LCFI361-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI361-.Ltext0
	.quad	.LFE130-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST118:
	.quad	.LFB131-.Ltext0
	.quad	.LCFI363-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI363-.Ltext0
	.quad	.LCFI364-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI364-.Ltext0
	.quad	.LFE131-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST119:
	.quad	.LFB132-.Ltext0
	.quad	.LCFI367-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI367-.Ltext0
	.quad	.LCFI368-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI368-.Ltext0
	.quad	.LFE132-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST120:
	.quad	.LFB133-.Ltext0
	.quad	.LCFI370-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI370-.Ltext0
	.quad	.LCFI371-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI371-.Ltext0
	.quad	.LFE133-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST121:
	.quad	.LFB134-.Ltext0
	.quad	.LCFI373-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI373-.Ltext0
	.quad	.LCFI374-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI374-.Ltext0
	.quad	.LFE134-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST122:
	.quad	.LFB135-.Ltext0
	.quad	.LCFI376-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI376-.Ltext0
	.quad	.LCFI377-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI377-.Ltext0
	.quad	.LFE135-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST123:
	.quad	.LFB136-.Ltext0
	.quad	.LCFI379-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI379-.Ltext0
	.quad	.LCFI380-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI380-.Ltext0
	.quad	.LFE136-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST124:
	.quad	.LFB137-.Ltext0
	.quad	.LCFI382-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI382-.Ltext0
	.quad	.LCFI383-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI383-.Ltext0
	.quad	.LFE137-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST125:
	.quad	.LFB138-.Ltext0
	.quad	.LCFI385-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI385-.Ltext0
	.quad	.LCFI386-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI386-.Ltext0
	.quad	.LFE138-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST126:
	.quad	.LFB139-.Ltext0
	.quad	.LCFI388-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI388-.Ltext0
	.quad	.LCFI389-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI389-.Ltext0
	.quad	.LFE139-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST127:
	.quad	.LFB140-.Ltext0
	.quad	.LCFI391-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI391-.Ltext0
	.quad	.LCFI392-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI392-.Ltext0
	.quad	.LFE140-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST128:
	.quad	.LFB141-.Ltext0
	.quad	.LCFI394-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI394-.Ltext0
	.quad	.LCFI395-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI395-.Ltext0
	.quad	.LFE141-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST129:
	.quad	.LFB142-.Ltext0
	.quad	.LCFI397-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI397-.Ltext0
	.quad	.LCFI398-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI398-.Ltext0
	.quad	.LFE142-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST130:
	.quad	.LFB143-.Ltext0
	.quad	.LCFI400-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI400-.Ltext0
	.quad	.LCFI401-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI401-.Ltext0
	.quad	.LFE143-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST131:
	.quad	.LFB144-.Ltext0
	.quad	.LCFI403-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI403-.Ltext0
	.quad	.LCFI404-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI404-.Ltext0
	.quad	.LFE144-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST132:
	.quad	.LFB145-.Ltext0
	.quad	.LCFI406-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI406-.Ltext0
	.quad	.LCFI407-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI407-.Ltext0
	.quad	.LFE145-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST133:
	.quad	.LFB146-.Ltext0
	.quad	.LCFI409-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI409-.Ltext0
	.quad	.LCFI410-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI410-.Ltext0
	.quad	.LFE146-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST134:
	.quad	.LFB147-.Ltext0
	.quad	.LCFI412-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI412-.Ltext0
	.quad	.LCFI413-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI413-.Ltext0
	.quad	.LFE147-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST135:
	.quad	.LFB148-.Ltext0
	.quad	.LCFI415-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI415-.Ltext0
	.quad	.LCFI416-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI416-.Ltext0
	.quad	.LFE148-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST136:
	.quad	.LFB149-.Ltext0
	.quad	.LCFI419-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI419-.Ltext0
	.quad	.LCFI420-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI420-.Ltext0
	.quad	.LFE149-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST137:
	.quad	.LFB150-.Ltext0
	.quad	.LCFI422-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI422-.Ltext0
	.quad	.LCFI423-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI423-.Ltext0
	.quad	.LFE150-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST138:
	.quad	.LFB151-.Ltext0
	.quad	.LCFI426-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI426-.Ltext0
	.quad	.LCFI427-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI427-.Ltext0
	.quad	.LFE151-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST139:
	.quad	.LFB152-.Ltext0
	.quad	.LCFI429-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI429-.Ltext0
	.quad	.LCFI430-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI430-.Ltext0
	.quad	.LFE152-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST140:
	.quad	.LFB153-.Ltext0
	.quad	.LCFI432-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI432-.Ltext0
	.quad	.LCFI433-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI433-.Ltext0
	.quad	.LFE153-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
.LLST141:
	.quad	.LFB154-.Ltext0
	.quad	.LCFI436-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI436-.Ltext0
	.quad	.LCFI437-.Ltext0
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI437-.Ltext0
	.quad	.LFE154-.Ltext0
	.value	0x2
	.byte	0x76
	.sleb128 16
	.quad	0x0
	.quad	0x0
	.section	.debug_info
	.long	0x7fe5
	.value	0x2
	.long	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.long	.Ldebug_line0
	.quad	.Letext0
	.quad	.Ltext0
	.string	"GNU C 4.1.2 20080704 (Red Hat 4.1.2-51)"
	.byte	0x1
	.string	"interposer/libci.c"
	.string	"/root/kidron-utils-rce-release-0.0.1"
	.uleb128 0x2
	.string	"size_t"
	.byte	0x4
	.byte	0xd6
	.long	0x8f
	.uleb128 0x3
	.long	.LASF0
	.byte	0x8
	.byte	0x7
	.uleb128 0x4
	.string	"unsigned char"
	.byte	0x1
	.byte	0x8
	.uleb128 0x4
	.string	"short unsigned int"
	.byte	0x2
	.byte	0x7
	.uleb128 0x4
	.string	"unsigned int"
	.byte	0x4
	.byte	0x7
	.uleb128 0x4
	.string	"signed char"
	.byte	0x1
	.byte	0x6
	.uleb128 0x4
	.string	"short int"
	.byte	0x2
	.byte	0x5
	.uleb128 0x4
	.string	"int"
	.byte	0x4
	.byte	0x5
	.uleb128 0x4
	.string	"long int"
	.byte	0x8
	.byte	0x5
	.uleb128 0x2
	.string	"__off_t"
	.byte	0xf
	.byte	0x90
	.long	0xf0
	.uleb128 0x2
	.string	"__off64_t"
	.byte	0xf
	.byte	0x91
	.long	0xf0
	.uleb128 0x5
	.long	0x12c
	.long	0xe9
	.uleb128 0x6
	.long	0x12c
	.byte	0x1
	.byte	0x0
	.uleb128 0x3
	.long	.LASF0
	.byte	0x8
	.byte	0x7
	.uleb128 0x7
	.byte	0x8
	.uleb128 0x8
	.byte	0x8
	.long	0x13b
	.uleb128 0x4
	.string	"char"
	.byte	0x1
	.byte	0x6
	.uleb128 0x9
	.long	0x3ca
	.long	.LASF1
	.byte	0xd8
	.byte	0xd
	.byte	0x2e
	.uleb128 0xa
	.string	"_flags"
	.byte	0xe
	.value	0x10d
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xa
	.string	"_IO_read_ptr"
	.byte	0xe
	.value	0x112
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0xa
	.string	"_IO_read_end"
	.byte	0xe
	.value	0x113
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0xa
	.string	"_IO_read_base"
	.byte	0xe
	.value	0x114
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.uleb128 0xa
	.string	"_IO_write_base"
	.byte	0xe
	.value	0x115
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x20
	.uleb128 0xa
	.string	"_IO_write_ptr"
	.byte	0xe
	.value	0x116
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x28
	.uleb128 0xa
	.string	"_IO_write_end"
	.byte	0xe
	.value	0x117
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x30
	.uleb128 0xa
	.string	"_IO_buf_base"
	.byte	0xe
	.value	0x118
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x38
	.uleb128 0xa
	.string	"_IO_buf_end"
	.byte	0xe
	.value	0x119
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x40
	.uleb128 0xa
	.string	"_IO_save_base"
	.byte	0xe
	.value	0x11b
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x48
	.uleb128 0xa
	.string	"_IO_backup_base"
	.byte	0xe
	.value	0x11c
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x50
	.uleb128 0xa
	.string	"_IO_save_end"
	.byte	0xe
	.value	0x11d
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x58
	.uleb128 0xa
	.string	"_markers"
	.byte	0xe
	.value	0x11f
	.long	0x432
	.byte	0x2
	.byte	0x23
	.uleb128 0x60
	.uleb128 0xa
	.string	"_chain"
	.byte	0xe
	.value	0x121
	.long	0x438
	.byte	0x2
	.byte	0x23
	.uleb128 0x68
	.uleb128 0xa
	.string	"_fileno"
	.byte	0xe
	.value	0x123
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x70
	.uleb128 0xa
	.string	"_flags2"
	.byte	0xe
	.value	0x127
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x74
	.uleb128 0xa
	.string	"_old_offset"
	.byte	0xe
	.value	0x129
	.long	0xfc
	.byte	0x2
	.byte	0x23
	.uleb128 0x78
	.uleb128 0xa
	.string	"_cur_column"
	.byte	0xe
	.value	0x12d
	.long	0xa7
	.byte	0x3
	.byte	0x23
	.uleb128 0x80
	.uleb128 0xa
	.string	"_vtable_offset"
	.byte	0xe
	.value	0x12e
	.long	0xcd
	.byte	0x3
	.byte	0x23
	.uleb128 0x82
	.uleb128 0xa
	.string	"_shortbuf"
	.byte	0xe
	.value	0x12f
	.long	0x43e
	.byte	0x3
	.byte	0x23
	.uleb128 0x83
	.uleb128 0xa
	.string	"_lock"
	.byte	0xe
	.value	0x133
	.long	0x44e
	.byte	0x3
	.byte	0x23
	.uleb128 0x88
	.uleb128 0xa
	.string	"_offset"
	.byte	0xe
	.value	0x13c
	.long	0x10b
	.byte	0x3
	.byte	0x23
	.uleb128 0x90
	.uleb128 0xa
	.string	"__pad1"
	.byte	0xe
	.value	0x145
	.long	0x133
	.byte	0x3
	.byte	0x23
	.uleb128 0x98
	.uleb128 0xa
	.string	"__pad2"
	.byte	0xe
	.value	0x146
	.long	0x133
	.byte	0x3
	.byte	0x23
	.uleb128 0xa0
	.uleb128 0xa
	.string	"__pad3"
	.byte	0xe
	.value	0x147
	.long	0x133
	.byte	0x3
	.byte	0x23
	.uleb128 0xa8
	.uleb128 0xa
	.string	"__pad4"
	.byte	0xe
	.value	0x148
	.long	0x133
	.byte	0x3
	.byte	0x23
	.uleb128 0xb0
	.uleb128 0xa
	.string	"__pad5"
	.byte	0xe
	.value	0x149
	.long	0x81
	.byte	0x3
	.byte	0x23
	.uleb128 0xb8
	.uleb128 0xa
	.string	"_mode"
	.byte	0xe
	.value	0x14b
	.long	0xe9
	.byte	0x3
	.byte	0x23
	.uleb128 0xc0
	.uleb128 0xa
	.string	"_unused2"
	.byte	0xe
	.value	0x14d
	.long	0x454
	.byte	0x3
	.byte	0x23
	.uleb128 0xc4
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x81
	.uleb128 0x8
	.byte	0x8
	.long	0x3d6
	.uleb128 0xb
	.long	0x13b
	.uleb128 0x8
	.byte	0x8
	.long	0x133
	.uleb128 0xc
	.string	"_IO_lock_t"
	.byte	0xe
	.byte	0xb1
	.uleb128 0xd
	.long	0x432
	.string	"_IO_marker"
	.byte	0x18
	.byte	0xe
	.byte	0xb7
	.uleb128 0xe
	.string	"_next"
	.byte	0xe
	.byte	0xb8
	.long	0x432
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xe
	.string	"_sbuf"
	.byte	0xe
	.byte	0xb9
	.long	0x438
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0xe
	.string	"_pos"
	.byte	0xe
	.byte	0xbd
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x3ef
	.uleb128 0x8
	.byte	0x8
	.long	0x143
	.uleb128 0x5
	.long	0x44e
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0x0
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x3e1
	.uleb128 0x5
	.long	0x464
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0x13
	.byte	0x0
	.uleb128 0xf
	.long	0xa0e
	.string	"cudaError"
	.byte	0x4
	.byte	0x6
	.byte	0x5f
	.uleb128 0x10
	.string	"cudaSuccess"
	.sleb128 0
	.uleb128 0x10
	.string	"cudaErrorMissingConfiguration"
	.sleb128 1
	.uleb128 0x10
	.string	"cudaErrorMemoryAllocation"
	.sleb128 2
	.uleb128 0x10
	.string	"cudaErrorInitializationError"
	.sleb128 3
	.uleb128 0x10
	.string	"cudaErrorLaunchFailure"
	.sleb128 4
	.uleb128 0x10
	.string	"cudaErrorPriorLaunchFailure"
	.sleb128 5
	.uleb128 0x10
	.string	"cudaErrorLaunchTimeout"
	.sleb128 6
	.uleb128 0x10
	.string	"cudaErrorLaunchOutOfResources"
	.sleb128 7
	.uleb128 0x10
	.string	"cudaErrorInvalidDeviceFunction"
	.sleb128 8
	.uleb128 0x10
	.string	"cudaErrorInvalidConfiguration"
	.sleb128 9
	.uleb128 0x10
	.string	"cudaErrorInvalidDevice"
	.sleb128 10
	.uleb128 0x10
	.string	"cudaErrorInvalidValue"
	.sleb128 11
	.uleb128 0x10
	.string	"cudaErrorInvalidPitchValue"
	.sleb128 12
	.uleb128 0x10
	.string	"cudaErrorInvalidSymbol"
	.sleb128 13
	.uleb128 0x10
	.string	"cudaErrorMapBufferObjectFailed"
	.sleb128 14
	.uleb128 0x10
	.string	"cudaErrorUnmapBufferObjectFailed"
	.sleb128 15
	.uleb128 0x10
	.string	"cudaErrorInvalidHostPointer"
	.sleb128 16
	.uleb128 0x10
	.string	"cudaErrorInvalidDevicePointer"
	.sleb128 17
	.uleb128 0x10
	.string	"cudaErrorInvalidTexture"
	.sleb128 18
	.uleb128 0x10
	.string	"cudaErrorInvalidTextureBinding"
	.sleb128 19
	.uleb128 0x10
	.string	"cudaErrorInvalidChannelDescriptor"
	.sleb128 20
	.uleb128 0x10
	.string	"cudaErrorInvalidMemcpyDirection"
	.sleb128 21
	.uleb128 0x10
	.string	"cudaErrorAddressOfConstant"
	.sleb128 22
	.uleb128 0x10
	.string	"cudaErrorTextureFetchFailed"
	.sleb128 23
	.uleb128 0x10
	.string	"cudaErrorTextureNotBound"
	.sleb128 24
	.uleb128 0x10
	.string	"cudaErrorSynchronizationError"
	.sleb128 25
	.uleb128 0x10
	.string	"cudaErrorInvalidFilterSetting"
	.sleb128 26
	.uleb128 0x10
	.string	"cudaErrorInvalidNormSetting"
	.sleb128 27
	.uleb128 0x10
	.string	"cudaErrorMixedDeviceExecution"
	.sleb128 28
	.uleb128 0x10
	.string	"cudaErrorCudartUnloading"
	.sleb128 29
	.uleb128 0x10
	.string	"cudaErrorUnknown"
	.sleb128 30
	.uleb128 0x10
	.string	"cudaErrorNotYetImplemented"
	.sleb128 31
	.uleb128 0x10
	.string	"cudaErrorMemoryValueTooLarge"
	.sleb128 32
	.uleb128 0x10
	.string	"cudaErrorInvalidResourceHandle"
	.sleb128 33
	.uleb128 0x10
	.string	"cudaErrorNotReady"
	.sleb128 34
	.uleb128 0x10
	.string	"cudaErrorInsufficientDriver"
	.sleb128 35
	.uleb128 0x10
	.string	"cudaErrorSetOnActiveProcess"
	.sleb128 36
	.uleb128 0x10
	.string	"cudaErrorInvalidSurface"
	.sleb128 37
	.uleb128 0x10
	.string	"cudaErrorNoDevice"
	.sleb128 38
	.uleb128 0x10
	.string	"cudaErrorECCUncorrectable"
	.sleb128 39
	.uleb128 0x10
	.string	"cudaErrorSharedObjectSymbolNotFound"
	.sleb128 40
	.uleb128 0x10
	.string	"cudaErrorSharedObjectInitFailed"
	.sleb128 41
	.uleb128 0x10
	.string	"cudaErrorUnsupportedLimit"
	.sleb128 42
	.uleb128 0x10
	.string	"cudaErrorDuplicateVariableName"
	.sleb128 43
	.uleb128 0x10
	.string	"cudaErrorDuplicateTextureName"
	.sleb128 44
	.uleb128 0x10
	.string	"cudaErrorDuplicateSurfaceName"
	.sleb128 45
	.uleb128 0x10
	.string	"cudaErrorDevicesUnavailable"
	.sleb128 46
	.uleb128 0x10
	.string	"cudaErrorStartupFailure"
	.sleb128 127
	.uleb128 0x10
	.string	"cudaErrorApiFailureBase"
	.sleb128 10000
	.byte	0x0
	.uleb128 0xf
	.long	0xaa4
	.string	"cudaChannelFormatKind"
	.byte	0x4
	.byte	0x6
	.byte	0x9d
	.uleb128 0x10
	.string	"cudaChannelFormatKindSigned"
	.sleb128 0
	.uleb128 0x10
	.string	"cudaChannelFormatKindUnsigned"
	.sleb128 1
	.uleb128 0x10
	.string	"cudaChannelFormatKindFloat"
	.sleb128 2
	.uleb128 0x10
	.string	"cudaChannelFormatKindNone"
	.sleb128 3
	.byte	0x0
	.uleb128 0xd
	.long	0xaff
	.string	"cudaChannelFormatDesc"
	.byte	0x14
	.byte	0x6
	.byte	0xa9
	.uleb128 0xe
	.string	"x"
	.byte	0x6
	.byte	0xaa
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xe
	.string	"y"
	.byte	0x6
	.byte	0xab
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0xe
	.string	"z"
	.byte	0x6
	.byte	0xac
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0xe
	.string	"w"
	.byte	0x6
	.byte	0xad
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0xe
	.string	"f"
	.byte	0x6
	.byte	0xae
	.long	0xa0e
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.byte	0x0
	.uleb128 0xf
	.long	0xb7b
	.string	"cudaMemcpyKind"
	.byte	0x4
	.byte	0x6
	.byte	0xbc
	.uleb128 0x10
	.string	"cudaMemcpyHostToHost"
	.sleb128 0
	.uleb128 0x10
	.string	"cudaMemcpyHostToDevice"
	.sleb128 1
	.uleb128 0x10
	.string	"cudaMemcpyDeviceToHost"
	.sleb128 2
	.uleb128 0x10
	.string	"cudaMemcpyDeviceToDevice"
	.sleb128 3
	.byte	0x0
	.uleb128 0xd
	.long	0xbcf
	.string	"cudaPitchedPtr"
	.byte	0x20
	.byte	0x6
	.byte	0xc9
	.uleb128 0xe
	.string	"ptr"
	.byte	0x6
	.byte	0xca
	.long	0x133
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x11
	.long	.LASF2
	.byte	0x6
	.byte	0xcb
	.long	0x81
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0xe
	.string	"xsize"
	.byte	0x6
	.byte	0xcc
	.long	0x81
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0xe
	.string	"ysize"
	.byte	0x6
	.byte	0xcd
	.long	0x81
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.byte	0x0
	.uleb128 0xd
	.long	0xc0f
	.string	"cudaExtent"
	.byte	0x18
	.byte	0x6
	.byte	0xd6
	.uleb128 0x11
	.long	.LASF3
	.byte	0x6
	.byte	0xd7
	.long	0x81
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x11
	.long	.LASF4
	.byte	0x6
	.byte	0xd8
	.long	0x81
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0xe
	.string	"depth"
	.byte	0x6
	.byte	0xd9
	.long	0x81
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.byte	0x0
	.uleb128 0xd
	.long	0xc44
	.string	"cudaPos"
	.byte	0x18
	.byte	0x6
	.byte	0xe2
	.uleb128 0xe
	.string	"x"
	.byte	0x6
	.byte	0xe3
	.long	0x81
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xe
	.string	"y"
	.byte	0x6
	.byte	0xe4
	.long	0x81
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0xe
	.string	"z"
	.byte	0x6
	.byte	0xe5
	.long	0x81
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.byte	0x0
	.uleb128 0xd
	.long	0xce7
	.string	"cudaMemcpy3DParms"
	.byte	0xa0
	.byte	0x6
	.byte	0xed
	.uleb128 0xe
	.string	"srcArray"
	.byte	0x6
	.byte	0xee
	.long	0xcf3
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xe
	.string	"srcPos"
	.byte	0x6
	.byte	0xef
	.long	0xc0f
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0xe
	.string	"srcPtr"
	.byte	0x6
	.byte	0xf0
	.long	0xb7b
	.byte	0x2
	.byte	0x23
	.uleb128 0x20
	.uleb128 0xe
	.string	"dstArray"
	.byte	0x6
	.byte	0xf2
	.long	0xcf3
	.byte	0x2
	.byte	0x23
	.uleb128 0x40
	.uleb128 0xe
	.string	"dstPos"
	.byte	0x6
	.byte	0xf3
	.long	0xc0f
	.byte	0x2
	.byte	0x23
	.uleb128 0x48
	.uleb128 0xe
	.string	"dstPtr"
	.byte	0x6
	.byte	0xf4
	.long	0xb7b
	.byte	0x2
	.byte	0x23
	.uleb128 0x60
	.uleb128 0x11
	.long	.LASF5
	.byte	0x6
	.byte	0xf6
	.long	0xbcf
	.byte	0x3
	.byte	0x23
	.uleb128 0x80
	.uleb128 0x11
	.long	.LASF6
	.byte	0x6
	.byte	0xf7
	.long	0xaff
	.byte	0x3
	.byte	0x23
	.uleb128 0x98
	.byte	0x0
	.uleb128 0x12
	.string	"cudaArray"
	.byte	0x1
	.uleb128 0x8
	.byte	0x8
	.long	0xce7
	.uleb128 0x13
	.long	0xdc5
	.string	"cudaFuncAttributes"
	.byte	0x40
	.byte	0x6
	.value	0x126
	.uleb128 0xa
	.string	"sharedSizeBytes"
	.byte	0x6
	.value	0x127
	.long	0x81
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xa
	.string	"constSizeBytes"
	.byte	0x6
	.value	0x128
	.long	0x81
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0xa
	.string	"localSizeBytes"
	.byte	0x6
	.value	0x129
	.long	0x81
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0x14
	.long	.LASF7
	.byte	0x6
	.value	0x12a
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.uleb128 0xa
	.string	"numRegs"
	.byte	0x6
	.value	0x12b
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x1c
	.uleb128 0xa
	.string	"ptxVersion"
	.byte	0x6
	.value	0x131
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x20
	.uleb128 0xa
	.string	"binaryVersion"
	.byte	0x6
	.value	0x137
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x24
	.uleb128 0x14
	.long	.LASF8
	.byte	0x6
	.value	0x138
	.long	0xdc5
	.byte	0x2
	.byte	0x23
	.uleb128 0x28
	.byte	0x0
	.uleb128 0x5
	.long	0xdd5
	.long	0xe9
	.uleb128 0x6
	.long	0x12c
	.byte	0x5
	.byte	0x0
	.uleb128 0x15
	.long	0xe3b
	.string	"cudaFuncCache"
	.byte	0x4
	.byte	0x6
	.value	0x140
	.uleb128 0x10
	.string	"cudaFuncCachePreferNone"
	.sleb128 0
	.uleb128 0x10
	.string	"cudaFuncCachePreferShared"
	.sleb128 1
	.uleb128 0x10
	.string	"cudaFuncCachePreferL1"
	.sleb128 2
	.byte	0x0
	.uleb128 0x15
	.long	0xe7e
	.string	"cudaLimit"
	.byte	0x4
	.byte	0x6
	.value	0x156
	.uleb128 0x10
	.string	"cudaLimitStackSize"
	.sleb128 0
	.uleb128 0x10
	.string	"cudaLimitPrintfFifoSize"
	.sleb128 1
	.byte	0x0
	.uleb128 0x16
	.long	0x117a
	.string	"cudaDeviceProp"
	.value	0x208
	.byte	0x6
	.value	0x160
	.uleb128 0xa
	.string	"name"
	.byte	0x6
	.value	0x161
	.long	0x117a
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xa
	.string	"totalGlobalMem"
	.byte	0x6
	.value	0x162
	.long	0x81
	.byte	0x3
	.byte	0x23
	.uleb128 0x100
	.uleb128 0xa
	.string	"sharedMemPerBlock"
	.byte	0x6
	.value	0x163
	.long	0x81
	.byte	0x3
	.byte	0x23
	.uleb128 0x108
	.uleb128 0xa
	.string	"regsPerBlock"
	.byte	0x6
	.value	0x164
	.long	0xe9
	.byte	0x3
	.byte	0x23
	.uleb128 0x110
	.uleb128 0xa
	.string	"warpSize"
	.byte	0x6
	.value	0x165
	.long	0xe9
	.byte	0x3
	.byte	0x23
	.uleb128 0x114
	.uleb128 0xa
	.string	"memPitch"
	.byte	0x6
	.value	0x166
	.long	0x81
	.byte	0x3
	.byte	0x23
	.uleb128 0x118
	.uleb128 0x14
	.long	.LASF7
	.byte	0x6
	.value	0x167
	.long	0xe9
	.byte	0x3
	.byte	0x23
	.uleb128 0x120
	.uleb128 0xa
	.string	"maxThreadsDim"
	.byte	0x6
	.value	0x168
	.long	0x118a
	.byte	0x3
	.byte	0x23
	.uleb128 0x124
	.uleb128 0xa
	.string	"maxGridSize"
	.byte	0x6
	.value	0x169
	.long	0x118a
	.byte	0x3
	.byte	0x23
	.uleb128 0x130
	.uleb128 0xa
	.string	"clockRate"
	.byte	0x6
	.value	0x16a
	.long	0xe9
	.byte	0x3
	.byte	0x23
	.uleb128 0x13c
	.uleb128 0xa
	.string	"totalConstMem"
	.byte	0x6
	.value	0x16b
	.long	0x81
	.byte	0x3
	.byte	0x23
	.uleb128 0x140
	.uleb128 0xa
	.string	"major"
	.byte	0x6
	.value	0x16c
	.long	0xe9
	.byte	0x3
	.byte	0x23
	.uleb128 0x148
	.uleb128 0xa
	.string	"minor"
	.byte	0x6
	.value	0x16d
	.long	0xe9
	.byte	0x3
	.byte	0x23
	.uleb128 0x14c
	.uleb128 0xa
	.string	"textureAlignment"
	.byte	0x6
	.value	0x16e
	.long	0x81
	.byte	0x3
	.byte	0x23
	.uleb128 0x150
	.uleb128 0xa
	.string	"deviceOverlap"
	.byte	0x6
	.value	0x16f
	.long	0xe9
	.byte	0x3
	.byte	0x23
	.uleb128 0x158
	.uleb128 0xa
	.string	"multiProcessorCount"
	.byte	0x6
	.value	0x170
	.long	0xe9
	.byte	0x3
	.byte	0x23
	.uleb128 0x15c
	.uleb128 0xa
	.string	"kernelExecTimeoutEnabled"
	.byte	0x6
	.value	0x171
	.long	0xe9
	.byte	0x3
	.byte	0x23
	.uleb128 0x160
	.uleb128 0xa
	.string	"integrated"
	.byte	0x6
	.value	0x172
	.long	0xe9
	.byte	0x3
	.byte	0x23
	.uleb128 0x164
	.uleb128 0xa
	.string	"canMapHostMemory"
	.byte	0x6
	.value	0x173
	.long	0xe9
	.byte	0x3
	.byte	0x23
	.uleb128 0x168
	.uleb128 0xa
	.string	"computeMode"
	.byte	0x6
	.value	0x174
	.long	0xe9
	.byte	0x3
	.byte	0x23
	.uleb128 0x16c
	.uleb128 0xa
	.string	"maxTexture1D"
	.byte	0x6
	.value	0x175
	.long	0xe9
	.byte	0x3
	.byte	0x23
	.uleb128 0x170
	.uleb128 0xa
	.string	"maxTexture2D"
	.byte	0x6
	.value	0x176
	.long	0x11c
	.byte	0x3
	.byte	0x23
	.uleb128 0x174
	.uleb128 0xa
	.string	"maxTexture3D"
	.byte	0x6
	.value	0x177
	.long	0x118a
	.byte	0x3
	.byte	0x23
	.uleb128 0x17c
	.uleb128 0xa
	.string	"maxTexture2DArray"
	.byte	0x6
	.value	0x178
	.long	0x118a
	.byte	0x3
	.byte	0x23
	.uleb128 0x188
	.uleb128 0xa
	.string	"surfaceAlignment"
	.byte	0x6
	.value	0x179
	.long	0x81
	.byte	0x3
	.byte	0x23
	.uleb128 0x198
	.uleb128 0xa
	.string	"concurrentKernels"
	.byte	0x6
	.value	0x17a
	.long	0xe9
	.byte	0x3
	.byte	0x23
	.uleb128 0x1a0
	.uleb128 0xa
	.string	"ECCEnabled"
	.byte	0x6
	.value	0x17b
	.long	0xe9
	.byte	0x3
	.byte	0x23
	.uleb128 0x1a4
	.uleb128 0xa
	.string	"pciBusID"
	.byte	0x6
	.value	0x17c
	.long	0xe9
	.byte	0x3
	.byte	0x23
	.uleb128 0x1a8
	.uleb128 0xa
	.string	"pciDeviceID"
	.byte	0x6
	.value	0x17d
	.long	0xe9
	.byte	0x3
	.byte	0x23
	.uleb128 0x1ac
	.uleb128 0x14
	.long	.LASF8
	.byte	0x6
	.value	0x17e
	.long	0x119a
	.byte	0x3
	.byte	0x23
	.uleb128 0x1b0
	.byte	0x0
	.uleb128 0x5
	.long	0x118a
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0xff
	.byte	0x0
	.uleb128 0x5
	.long	0x119a
	.long	0xe9
	.uleb128 0x6
	.long	0x12c
	.byte	0x2
	.byte	0x0
	.uleb128 0x5
	.long	0x11aa
	.long	0xe9
	.uleb128 0x6
	.long	0x12c
	.byte	0x15
	.byte	0x0
	.uleb128 0x17
	.string	"cudaError_t"
	.byte	0x6
	.value	0x1aa
	.long	0x464
	.uleb128 0x17
	.string	"cudaStream_t"
	.byte	0x6
	.value	0x1b0
	.long	0x11d3
	.uleb128 0x8
	.byte	0x8
	.long	0x11d9
	.uleb128 0x12
	.string	"CUstream_st"
	.byte	0x1
	.uleb128 0x17
	.string	"cudaEvent_t"
	.byte	0x6
	.value	0x1b6
	.long	0x11fb
	.uleb128 0x8
	.byte	0x8
	.long	0x1201
	.uleb128 0x12
	.string	"CUevent_st"
	.byte	0x1
	.uleb128 0x17
	.string	"cudaUUID_t"
	.byte	0x6
	.value	0x1bc
	.long	0x1221
	.uleb128 0x13
	.long	0x1245
	.string	"CUuuid_st"
	.byte	0x10
	.byte	0x6
	.value	0x1bc
	.uleb128 0xe
	.string	"bytes"
	.byte	0x9
	.byte	0x4c
	.long	0x14a9
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.byte	0x0
	.uleb128 0xd
	.long	0x126d
	.string	"surfaceReference"
	.byte	0x14
	.byte	0x8
	.byte	0x46
	.uleb128 0x11
	.long	.LASF9
	.byte	0x8
	.byte	0x47
	.long	0xaa4
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.byte	0x0
	.uleb128 0xf
	.long	0x12d2
	.string	"cudaTextureAddressMode"
	.byte	0x4
	.byte	0x7
	.byte	0x37
	.uleb128 0x10
	.string	"cudaAddressModeWrap"
	.sleb128 0
	.uleb128 0x10
	.string	"cudaAddressModeClamp"
	.sleb128 1
	.uleb128 0x10
	.string	"cudaAddressModeMirror"
	.sleb128 2
	.byte	0x0
	.uleb128 0xf
	.long	0x131e
	.string	"cudaTextureFilterMode"
	.byte	0x4
	.byte	0x7
	.byte	0x3f
	.uleb128 0x10
	.string	"cudaFilterModePoint"
	.sleb128 0
	.uleb128 0x10
	.string	"cudaFilterModeLinear"
	.sleb128 1
	.byte	0x0
	.uleb128 0xd
	.long	0x1394
	.string	"textureReference"
	.byte	0x68
	.byte	0x7
	.byte	0x4d
	.uleb128 0xe
	.string	"normalized"
	.byte	0x7
	.byte	0x4e
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xe
	.string	"filterMode"
	.byte	0x7
	.byte	0x4f
	.long	0x12d2
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0xe
	.string	"addressMode"
	.byte	0x7
	.byte	0x50
	.long	0x1394
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x11
	.long	.LASF9
	.byte	0x7
	.byte	0x51
	.long	0xaa4
	.byte	0x2
	.byte	0x23
	.uleb128 0x14
	.uleb128 0x11
	.long	.LASF8
	.byte	0x7
	.byte	0x52
	.long	0x13a4
	.byte	0x2
	.byte	0x23
	.uleb128 0x28
	.byte	0x0
	.uleb128 0x5
	.long	0x13a4
	.long	0x126d
	.uleb128 0x6
	.long	0x12c
	.byte	0x2
	.byte	0x0
	.uleb128 0x5
	.long	0x13b4
	.long	0xe9
	.uleb128 0x6
	.long	0x12c
	.byte	0xf
	.byte	0x0
	.uleb128 0xd
	.long	0x13e7
	.string	"uint3"
	.byte	0xc
	.byte	0x5
	.byte	0xbe
	.uleb128 0xe
	.string	"x"
	.byte	0x5
	.byte	0xbf
	.long	0xbd
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xe
	.string	"y"
	.byte	0x5
	.byte	0xbf
	.long	0xbd
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0xe
	.string	"z"
	.byte	0x5
	.byte	0xbf
	.long	0xbd
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.byte	0x0
	.uleb128 0x4
	.string	"float"
	.byte	0x4
	.byte	0x4
	.uleb128 0x4
	.string	"long long int"
	.byte	0x8
	.byte	0x5
	.uleb128 0x4
	.string	"long long unsigned int"
	.byte	0x8
	.byte	0x7
	.uleb128 0x4
	.string	"double"
	.byte	0x8
	.byte	0x4
	.uleb128 0x17
	.string	"uint3"
	.byte	0x5
	.value	0x198
	.long	0x13b4
	.uleb128 0x13
	.long	0x1469
	.string	"dim3"
	.byte	0xc
	.byte	0x5
	.value	0x1d6
	.uleb128 0xa
	.string	"x"
	.byte	0x5
	.value	0x1d7
	.long	0xbd
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xa
	.string	"y"
	.byte	0x5
	.value	0x1d7
	.long	0xbd
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0xa
	.string	"z"
	.byte	0x5
	.value	0x1d7
	.long	0xbd
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.byte	0x0
	.uleb128 0x17
	.string	"dim3"
	.byte	0x5
	.value	0x1e0
	.long	0x1433
	.uleb128 0xb
	.long	0xa7
	.uleb128 0x8
	.byte	0x8
	.long	0xe9
	.uleb128 0x2
	.string	"pthread_t"
	.byte	0x3
	.byte	0x32
	.long	0x8f
	.uleb128 0x5
	.long	0x14a2
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0x1f
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x14a8
	.uleb128 0x18
	.uleb128 0x5
	.long	0x14b9
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0xf
	.byte	0x0
	.uleb128 0x19
	.long	0x14e0
	.byte	0x10
	.byte	0xb
	.byte	0x61
	.uleb128 0x11
	.long	.LASF10
	.byte	0xb
	.byte	0x62
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xe
	.string	"cubin"
	.byte	0xb
	.byte	0x63
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.byte	0x0
	.uleb128 0x2
	.string	"__cudaFatCubinEntry"
	.byte	0xb
	.byte	0x64
	.long	0x14b9
	.uleb128 0x19
	.long	0x1520
	.byte	0x10
	.byte	0xb
	.byte	0x71
	.uleb128 0x11
	.long	.LASF10
	.byte	0xb
	.byte	0x72
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xe
	.string	"ptx"
	.byte	0xb
	.byte	0x73
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.byte	0x0
	.uleb128 0x2
	.string	"__cudaFatPtxEntry"
	.byte	0xb
	.byte	0x74
	.long	0x14fb
	.uleb128 0xd
	.long	0x1594
	.string	"__cudaFatDebugEntryRec"
	.byte	0x20
	.byte	0xb
	.byte	0x7d
	.uleb128 0x11
	.long	.LASF10
	.byte	0xb
	.byte	0x7e
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xe
	.string	"debug"
	.byte	0xb
	.byte	0x7f
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0xe
	.string	"next"
	.byte	0xb
	.byte	0x80
	.long	0x1594
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0x11
	.long	.LASF11
	.byte	0xb
	.byte	0x81
	.long	0xbd
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x1539
	.uleb128 0x2
	.string	"__cudaFatDebugEntry"
	.byte	0xb
	.byte	0x82
	.long	0x1539
	.uleb128 0xd
	.long	0x160c
	.string	"__cudaFatElfEntryRec"
	.byte	0x20
	.byte	0xb
	.byte	0x84
	.uleb128 0x11
	.long	.LASF10
	.byte	0xb
	.byte	0x85
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xe
	.string	"elf"
	.byte	0xb
	.byte	0x86
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0xe
	.string	"next"
	.byte	0xb
	.byte	0x87
	.long	0x160c
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0x11
	.long	.LASF11
	.byte	0xb
	.byte	0x88
	.long	0xbd
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x15b5
	.uleb128 0x2
	.string	"__cudaFatElfEntry"
	.byte	0xb
	.byte	0x89
	.long	0x15b5
	.uleb128 0x19
	.long	0x1643
	.byte	0x8
	.byte	0xb
	.byte	0x98
	.uleb128 0xe
	.string	"name"
	.byte	0xb
	.byte	0x99
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.byte	0x0
	.uleb128 0x2
	.string	"__cudaFatSymbol"
	.byte	0xb
	.byte	0x9a
	.long	0x162b
	.uleb128 0xd
	.long	0x1799
	.string	"__cudaFatCudaBinaryRec"
	.byte	0x80
	.byte	0xb
	.byte	0xa6
	.uleb128 0xe
	.string	"magic"
	.byte	0xb
	.byte	0xa7
	.long	0x8f
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xe
	.string	"version"
	.byte	0xb
	.byte	0xa8
	.long	0x8f
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0xe
	.string	"gpuInfoVersion"
	.byte	0xb
	.byte	0xa9
	.long	0x8f
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0xe
	.string	"key"
	.byte	0xb
	.byte	0xaa
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.uleb128 0xe
	.string	"ident"
	.byte	0xb
	.byte	0xab
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x20
	.uleb128 0xe
	.string	"usageMode"
	.byte	0xb
	.byte	0xac
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x28
	.uleb128 0xe
	.string	"ptx"
	.byte	0xb
	.byte	0xad
	.long	0x1799
	.byte	0x2
	.byte	0x23
	.uleb128 0x30
	.uleb128 0xe
	.string	"cubin"
	.byte	0xb
	.byte	0xae
	.long	0x179f
	.byte	0x2
	.byte	0x23
	.uleb128 0x38
	.uleb128 0xe
	.string	"debug"
	.byte	0xb
	.byte	0xaf
	.long	0x17a5
	.byte	0x2
	.byte	0x23
	.uleb128 0x40
	.uleb128 0xe
	.string	"debugInfo"
	.byte	0xb
	.byte	0xb0
	.long	0x133
	.byte	0x2
	.byte	0x23
	.uleb128 0x48
	.uleb128 0x11
	.long	.LASF12
	.byte	0xb
	.byte	0xb1
	.long	0xbd
	.byte	0x2
	.byte	0x23
	.uleb128 0x50
	.uleb128 0xe
	.string	"exported"
	.byte	0xb
	.byte	0xb2
	.long	0x17ab
	.byte	0x2
	.byte	0x23
	.uleb128 0x58
	.uleb128 0xe
	.string	"imported"
	.byte	0xb
	.byte	0xb3
	.long	0x17ab
	.byte	0x2
	.byte	0x23
	.uleb128 0x60
	.uleb128 0xe
	.string	"dependends"
	.byte	0xb
	.byte	0xb4
	.long	0x17b1
	.byte	0x2
	.byte	0x23
	.uleb128 0x68
	.uleb128 0xe
	.string	"characteristic"
	.byte	0xb
	.byte	0xb5
	.long	0xbd
	.byte	0x2
	.byte	0x23
	.uleb128 0x70
	.uleb128 0xe
	.string	"elf"
	.byte	0xb
	.byte	0xb6
	.long	0x17b7
	.byte	0x2
	.byte	0x23
	.uleb128 0x78
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x1520
	.uleb128 0x8
	.byte	0x8
	.long	0x14e0
	.uleb128 0x8
	.byte	0x8
	.long	0x159a
	.uleb128 0x8
	.byte	0x8
	.long	0x1643
	.uleb128 0x8
	.byte	0x8
	.long	0x165a
	.uleb128 0x8
	.byte	0x8
	.long	0x1612
	.uleb128 0x2
	.string	"__cudaFatCudaBinary"
	.byte	0xb
	.byte	0xb7
	.long	0x165a
	.uleb128 0x2
	.string	"uint8_t"
	.byte	0x2
	.byte	0xc
	.long	0x96
	.uleb128 0x2
	.string	"uint16_t"
	.byte	0x2
	.byte	0xd
	.long	0xa7
	.uleb128 0x2
	.string	"uint32_t"
	.byte	0x2
	.byte	0xe
	.long	0xbd
	.uleb128 0x2
	.string	"uint64_t"
	.byte	0x2
	.byte	0x10
	.long	0x8f
	.uleb128 0x2
	.string	"tid_t"
	.byte	0x2
	.byte	0x1f
	.long	0x1481
	.uleb128 0xd
	.long	0x186c
	.string	"tf_arg"
	.byte	0x10
	.byte	0x2
	.byte	0x5f
	.uleb128 0xe
	.string	"mfn"
	.byte	0x2
	.byte	0x62
	.long	0x8f
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xe
	.string	"ref"
	.byte	0x2
	.byte	0x63
	.long	0x17f7
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x11
	.long	.LASF13
	.byte	0x2
	.byte	0x64
	.long	0x17e7
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0x11
	.long	.LASF11
	.byte	0x2
	.byte	0x67
	.long	0x17e7
	.byte	0x2
	.byte	0x23
	.uleb128 0xe
	.byte	0x0
	.uleb128 0x2
	.string	"tf_args_t"
	.byte	0x2
	.byte	0x69
	.long	0x1824
	.uleb128 0x19
	.long	0x1929
	.byte	0x58
	.byte	0x2
	.byte	0x6e
	.uleb128 0x11
	.long	.LASF14
	.byte	0x2
	.byte	0x6f
	.long	0x3db
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x11
	.long	.LASF15
	.byte	0x2
	.byte	0x70
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0xe
	.string	"hostFEaddr"
	.byte	0x2
	.byte	0x74
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0x11
	.long	.LASF16
	.byte	0x2
	.byte	0x75
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.uleb128 0x11
	.long	.LASF17
	.byte	0x2
	.byte	0x76
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x20
	.uleb128 0x11
	.long	.LASF18
	.byte	0x2
	.byte	0x77
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x28
	.uleb128 0xe
	.string	"tid"
	.byte	0x2
	.byte	0x78
	.long	0x1929
	.byte	0x2
	.byte	0x23
	.uleb128 0x30
	.uleb128 0xe
	.string	"bid"
	.byte	0x2
	.byte	0x79
	.long	0x1929
	.byte	0x2
	.byte	0x23
	.uleb128 0x38
	.uleb128 0xe
	.string	"bDim"
	.byte	0x2
	.byte	0x7a
	.long	0x192f
	.byte	0x2
	.byte	0x23
	.uleb128 0x40
	.uleb128 0xe
	.string	"gDim"
	.byte	0x2
	.byte	0x7b
	.long	0x192f
	.byte	0x2
	.byte	0x23
	.uleb128 0x48
	.uleb128 0x11
	.long	.LASF19
	.byte	0x2
	.byte	0x7c
	.long	0x147b
	.byte	0x2
	.byte	0x23
	.uleb128 0x50
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x1425
	.uleb128 0x8
	.byte	0x8
	.long	0x1469
	.uleb128 0x2
	.string	"reg_func_args_t"
	.byte	0x2
	.byte	0x7d
	.long	0x187d
	.uleb128 0x19
	.long	0x19dc
	.byte	0x38
	.byte	0x2
	.byte	0x80
	.uleb128 0x11
	.long	.LASF14
	.byte	0x2
	.byte	0x81
	.long	0x3db
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x11
	.long	.LASF20
	.byte	0x2
	.byte	0x82
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0xe
	.string	"dom0HostAddr"
	.byte	0x2
	.byte	0x83
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0x11
	.long	.LASF21
	.byte	0x2
	.byte	0x84
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.uleb128 0x11
	.long	.LASF17
	.byte	0x2
	.byte	0x85
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x20
	.uleb128 0xe
	.string	"ext"
	.byte	0x2
	.byte	0x86
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x28
	.uleb128 0x11
	.long	.LASF11
	.byte	0x2
	.byte	0x87
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x2c
	.uleb128 0x11
	.long	.LASF22
	.byte	0x2
	.byte	0x88
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x30
	.uleb128 0x11
	.long	.LASF23
	.byte	0x2
	.byte	0x89
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x2
	.string	"reg_var_args_t"
	.byte	0x2
	.byte	0x8a
	.long	0x194c
	.uleb128 0x19
	.long	0x1a88
	.byte	0x40
	.byte	0x2
	.byte	0x8d
	.uleb128 0x11
	.long	.LASF14
	.byte	0x2
	.byte	0x8e
	.long	0x3db
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x11
	.long	.LASF20
	.byte	0x2
	.byte	0x8f
	.long	0x1a88
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0xe
	.string	"hostChannel"
	.byte	0x2
	.byte	0x90
	.long	0x1a8e
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0xe
	.string	"hostFEVar"
	.byte	0x2
	.byte	0x91
	.long	0x1a88
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.uleb128 0x11
	.long	.LASF21
	.byte	0x2
	.byte	0x92
	.long	0x3db
	.byte	0x2
	.byte	0x23
	.uleb128 0x20
	.uleb128 0x11
	.long	.LASF17
	.byte	0x2
	.byte	0x93
	.long	0x135
	.byte	0x2
	.byte	0x23
	.uleb128 0x28
	.uleb128 0xe
	.string	"dim"
	.byte	0x2
	.byte	0x94
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x30
	.uleb128 0xe
	.string	"norm"
	.byte	0x2
	.byte	0x95
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x34
	.uleb128 0xe
	.string	"ext"
	.byte	0x2
	.byte	0x96
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x38
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x131e
	.uleb128 0x8
	.byte	0x8
	.long	0xaa4
	.uleb128 0x2
	.string	"reg_tex_args_t"
	.byte	0x2
	.byte	0x97
	.long	0x19f2
	.uleb128 0x1a
	.long	0x1ba9
	.string	"args"
	.byte	0x10
	.byte	0x2
	.byte	0x9d
	.uleb128 0x1b
	.string	"arr_argii"
	.byte	0x2
	.byte	0x9e
	.long	0x1ba9
	.uleb128 0x1b
	.string	"arr_arguii"
	.byte	0x2
	.byte	0x9f
	.long	0x1bb9
	.uleb128 0x1b
	.string	"argi"
	.byte	0x2
	.byte	0xa0
	.long	0xf0
	.uleb128 0x1b
	.string	"argui"
	.byte	0x2
	.byte	0xa1
	.long	0x1807
	.uleb128 0x1b
	.string	"argf"
	.byte	0x2
	.byte	0xa2
	.long	0x13e7
	.uleb128 0x1b
	.string	"argp"
	.byte	0x2
	.byte	0xa3
	.long	0x133
	.uleb128 0x1b
	.string	"argdp"
	.byte	0x2
	.byte	0xa4
	.long	0x3db
	.uleb128 0x1b
	.string	"argcp"
	.byte	0x2
	.byte	0xa5
	.long	0x135
	.uleb128 0x1b
	.string	"arr_argi"
	.byte	0x2
	.byte	0xa6
	.long	0x1bc9
	.uleb128 0x1b
	.string	"arr_argui"
	.byte	0x2
	.byte	0xa8
	.long	0x1bd9
	.uleb128 0x1b
	.string	"tf_args"
	.byte	0x2
	.byte	0xa9
	.long	0x186c
	.uleb128 0x1b
	.string	"arg_dim"
	.byte	0x2
	.byte	0xaa
	.long	0x1469
	.uleb128 0x1b
	.string	"arg_str"
	.byte	0x2
	.byte	0xab
	.long	0x11be
	.uleb128 0x1b
	.string	"reg_func_args"
	.byte	0x2
	.byte	0xac
	.long	0x1be9
	.uleb128 0x1b
	.string	"reg_vars"
	.byte	0x2
	.byte	0xad
	.long	0x1bef
	.uleb128 0x1b
	.string	"reg_texs"
	.byte	0x2
	.byte	0xae
	.long	0x1bf5
	.byte	0x0
	.uleb128 0x5
	.long	0x1bb9
	.long	0xe9
	.uleb128 0x6
	.long	0x12c
	.byte	0x3
	.byte	0x0
	.uleb128 0x5
	.long	0x1bc9
	.long	0xbd
	.uleb128 0x6
	.long	0x12c
	.byte	0x3
	.byte	0x0
	.uleb128 0x5
	.long	0x1bd9
	.long	0x81
	.uleb128 0x6
	.long	0x12c
	.byte	0x1
	.byte	0x0
	.uleb128 0x5
	.long	0x1be9
	.long	0x1807
	.uleb128 0x6
	.long	0x12c
	.byte	0x1
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x1935
	.uleb128 0x8
	.byte	0x8
	.long	0x19dc
	.uleb128 0x8
	.byte	0x8
	.long	0x1a94
	.uleb128 0x2
	.string	"args_t"
	.byte	0x2
	.byte	0xaf
	.long	0x1aaa
	.uleb128 0x1a
	.long	0x1c7e
	.string	"ret_extra"
	.byte	0x8
	.byte	0x2
	.byte	0xb3
	.uleb128 0x1b
	.string	"num_args"
	.byte	0x2
	.byte	0xb4
	.long	0xe9
	.uleb128 0x1b
	.string	"bit_idx"
	.byte	0x2
	.byte	0xb5
	.long	0xe9
	.uleb128 0x1b
	.string	"data_unit"
	.byte	0x2
	.byte	0xb6
	.long	0x17f7
	.uleb128 0x1b
	.string	"err"
	.byte	0x2
	.byte	0xb7
	.long	0x11aa
	.uleb128 0x1b
	.string	"errp"
	.byte	0x2
	.byte	0xb8
	.long	0x1c7e
	.uleb128 0x1b
	.string	"charp"
	.byte	0x2
	.byte	0xb9
	.long	0x3d0
	.uleb128 0x1b
	.string	"handle"
	.byte	0x2
	.byte	0xba
	.long	0x3db
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x11aa
	.uleb128 0x2
	.string	"ret_extra_t"
	.byte	0x2
	.byte	0xbb
	.long	0x1c09
	.uleb128 0xd
	.long	0x1d0e
	.string	"cuda_packet"
	.byte	0x60
	.byte	0x2
	.byte	0xbd
	.uleb128 0x11
	.long	.LASF24
	.byte	0x2
	.byte	0xbe
	.long	0x17e7
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xe
	.string	"req_id"
	.byte	0x2
	.byte	0xbf
	.long	0x17e7
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0xe
	.string	"thr_id"
	.byte	0x2
	.byte	0xc0
	.long	0x1817
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x11
	.long	.LASF12
	.byte	0x2
	.byte	0xc1
	.long	0x17d8
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0xe
	.string	"args"
	.byte	0x2
	.byte	0xc2
	.long	0x1d0e
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.uleb128 0xe
	.string	"ret_ex_val"
	.byte	0x2
	.byte	0xc3
	.long	0x1c84
	.byte	0x2
	.byte	0x23
	.uleb128 0x58
	.byte	0x0
	.uleb128 0x5
	.long	0x1d1e
	.long	0x1bfb
	.uleb128 0x6
	.long	0x12c
	.byte	0x3
	.byte	0x0
	.uleb128 0x2
	.string	"cuda_packet_t"
	.byte	0x2
	.byte	0xc6
	.long	0x1c97
	.uleb128 0x5
	.long	0x1d43
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0xd
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x17bd
	.uleb128 0x2
	.string	"GHashTable"
	.byte	0xc
	.byte	0x22
	.long	0x1d5b
	.uleb128 0x12
	.string	"_GHashTable"
	.byte	0x1
	.uleb128 0x8
	.byte	0x8
	.long	0x1d49
	.uleb128 0x19
	.long	0x1de9
	.byte	0x1c
	.byte	0xa
	.byte	0x14
	.uleb128 0xe
	.string	"nptxs"
	.byte	0xa
	.byte	0x15
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xe
	.string	"ncubs"
	.byte	0xa
	.byte	0x16
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0xe
	.string	"ndebs"
	.byte	0xa
	.byte	0x17
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0xe
	.string	"ndeps"
	.byte	0xa
	.byte	0x18
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0xe
	.string	"nelves"
	.byte	0xa
	.byte	0x19
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0xe
	.string	"nexps"
	.byte	0xa
	.byte	0x1a
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x14
	.uleb128 0xe
	.string	"nimps"
	.byte	0xa
	.byte	0x1b
	.long	0xe9
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.byte	0x0
	.uleb128 0x2
	.string	"cache_num_entries_t"
	.byte	0xa
	.byte	0x1c
	.long	0x1d6f
	.uleb128 0x1c
	.long	0x1e67
	.byte	0x1
	.string	"l_handleDlError"
	.byte	0x1
	.byte	0x5d
	.long	0xe9
	.quad	.LFB13
	.quad	.LFE13
	.long	.LLST0
	.uleb128 0x1d
	.string	"error"
	.byte	0x1
	.byte	0x5e
	.long	0x135
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x1d
	.string	"ret"
	.byte	0x1
	.byte	0x5f
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7f23
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.9917
	.byte	0x0
	.uleb128 0x1f
	.long	0x1ea6
	.byte	0x1
	.string	"l_printFuncSig"
	.byte	0x1
	.byte	0x6e
	.byte	0x1
	.long	0xe9
	.quad	.LFB14
	.quad	.LFE14
	.long	.LLST1
	.uleb128 0x20
	.long	.LASF26
	.byte	0x1
	.byte	0x6e
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.byte	0x0
	.uleb128 0x1f
	.long	0x1ee9
	.byte	0x1
	.string	"l_printFuncSigImpl"
	.byte	0x1
	.byte	0x79
	.byte	0x1
	.long	0xe9
	.quad	.LFB15
	.quad	.LFE15
	.long	.LLST2
	.uleb128 0x20
	.long	.LASF26
	.byte	0x1
	.byte	0x79
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.byte	0x0
	.uleb128 0x1f
	.long	0x1f36
	.byte	0x1
	.string	"l_setMetThrReq"
	.byte	0x1
	.byte	0x84
	.byte	0x1
	.long	0xe9
	.quad	.LFB16
	.quad	.LFE16
	.long	.LLST3
	.uleb128 0x20
	.long	.LASF27
	.byte	0x1
	.byte	0x84
	.long	0x1f36
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x20
	.long	.LASF28
	.byte	0x1
	.byte	0x84
	.long	0x1476
	.byte	0x2
	.byte	0x91
	.sleb128 -36
	.byte	0x0
	.uleb128 0xb
	.long	0x1f3b
	.uleb128 0x8
	.byte	0x8
	.long	0x1f41
	.uleb128 0x8
	.byte	0x8
	.long	0x1d1e
	.uleb128 0x1f
	.long	0x1fa9
	.byte	0x1
	.string	"l_remoteInitMetThrReq"
	.byte	0x1
	.byte	0x98
	.byte	0x1
	.long	0xe9
	.quad	.LFB17
	.quad	.LFE17
	.long	.LLST4
	.uleb128 0x20
	.long	.LASF27
	.byte	0x1
	.byte	0x97
	.long	0x1f36
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x20
	.long	.LASF28
	.byte	0x1
	.byte	0x98
	.long	0x1476
	.byte	0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x20
	.long	.LASF26
	.byte	0x1
	.byte	0x98
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.byte	0x0
	.uleb128 0x1f
	.long	0x1ffd
	.byte	0x1
	.string	"rcudaThreadExit"
	.byte	0x1
	.byte	0xb7
	.byte	0x1
	.long	0x11aa
	.quad	.LFB18
	.quad	.LFE18
	.long	.LLST5
	.uleb128 0x21
	.long	.LASF27
	.byte	0x1
	.byte	0xb8
	.long	0x1f41
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7f1e
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.9965
	.byte	0x0
	.uleb128 0x1f
	.long	0x2063
	.byte	0x1
	.string	"lcudaThreadExit"
	.byte	0x1
	.byte	0xce
	.byte	0x1
	.long	0x11aa
	.quad	.LFB19
	.quad	.LFE19
	.long	.LLST6
	.uleb128 0x22
	.long	.LASF29
	.byte	0x1
	.byte	0xcf
	.long	0x2063
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7f19
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.9986
	.uleb128 0x21
	.long	.LASF30
	.byte	0x1
	.byte	0xd2
	.long	0x202e
	.byte	0x9
	.byte	0x3
	.quad	pFunc.9987
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x2069
	.uleb128 0x23
	.byte	0x1
	.long	0x11aa
	.uleb128 0x24
	.byte	0x1
	.string	"cudaThreadExit"
	.byte	0x1
	.byte	0xde
	.byte	0x1
	.long	0x11aa
	.quad	.LFB20
	.quad	.LFE20
	.long	.LLST7
	.uleb128 0x1f
	.long	0x2104
	.byte	0x1
	.string	"rcudaThreadSynchronize"
	.byte	0x1
	.byte	0xe3
	.byte	0x1
	.long	0x11aa
	.quad	.LFB21
	.quad	.LFE21
	.long	.LLST8
	.uleb128 0x20
	.long	.LASF31
	.byte	0x1
	.byte	0xe3
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x21
	.long	.LASF27
	.byte	0x1
	.byte	0xe4
	.long	0x1f41
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7f14
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10016
	.byte	0x0
	.uleb128 0x1f
	.long	0x2171
	.byte	0x1
	.string	"lcudaThreadSynchronize"
	.byte	0x1
	.byte	0xf8
	.byte	0x1
	.long	0x11aa
	.quad	.LFB22
	.quad	.LFE22
	.long	.LLST9
	.uleb128 0x22
	.long	.LASF29
	.byte	0x1
	.byte	0xf9
	.long	0x2063
	.uleb128 0x21
	.long	.LASF30
	.byte	0x1
	.byte	0xfa
	.long	0x213c
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10037
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7f0f
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10038
	.byte	0x0
	.uleb128 0x25
	.long	0x21b9
	.byte	0x1
	.string	"cudaThreadSynchronize"
	.byte	0x1
	.value	0x10f
	.byte	0x1
	.long	0x11aa
	.quad	.LFB23
	.quad	.LFE23
	.long	.LLST10
	.uleb128 0x26
	.string	"ret"
	.byte	0x1
	.value	0x110
	.long	0x11aa
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.byte	0x0
	.uleb128 0x25
	.long	0x2245
	.byte	0x1
	.string	"cudaThreadSetLimit"
	.byte	0x1
	.value	0x118
	.byte	0x1
	.long	0x11aa
	.quad	.LFB24
	.quad	.LFE24
	.long	.LLST11
	.uleb128 0x27
	.string	"limit"
	.byte	0x1
	.value	0x118
	.long	0xe3b
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x28
	.long	.LASF32
	.byte	0x1
	.value	0x118
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x119
	.long	0x2245
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x11a
	.long	0x220e
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10072
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7f0a
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10073
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x224b
	.uleb128 0x2b
	.long	0x2260
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0xe3b
	.uleb128 0x2c
	.long	0x81
	.byte	0x0
	.uleb128 0x25
	.long	0x22ef
	.byte	0x1
	.string	"cudaThreadGetLimit"
	.byte	0x1
	.value	0x128
	.byte	0x1
	.long	0x11aa
	.quad	.LFB25
	.quad	.LFE25
	.long	.LLST12
	.uleb128 0x27
	.string	"pValue"
	.byte	0x1
	.value	0x128
	.long	0x3ca
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x27
	.string	"limit"
	.byte	0x1
	.value	0x128
	.long	0xe3b
	.byte	0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x129
	.long	0x22ef
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x12a
	.long	0x22b8
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10093
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7f05
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10094
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x22f5
	.uleb128 0x2b
	.long	0x230a
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x3ca
	.uleb128 0x2c
	.long	0xe3b
	.byte	0x0
	.uleb128 0x25
	.long	0x2394
	.byte	0x1
	.string	"cudaThreadGetCacheConfig"
	.byte	0x1
	.value	0x138
	.byte	0x1
	.long	0x11aa
	.quad	.LFB26
	.quad	.LFE26
	.long	.LLST13
	.uleb128 0x27
	.string	"pCacheConfig"
	.byte	0x1
	.value	0x138
	.long	0x2394
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x139
	.long	0x239a
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x13a
	.long	0x235d
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10112
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7f00
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10113
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0xdd5
	.uleb128 0x8
	.byte	0x8
	.long	0x23a0
	.uleb128 0x2b
	.long	0x23b0
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x2394
	.byte	0x0
	.uleb128 0x25
	.long	0x2431
	.byte	0x1
	.string	"cudaThreadSetCacheConfig"
	.byte	0x1
	.value	0x147
	.byte	0x1
	.long	0x11aa
	.quad	.LFB27
	.quad	.LFE27
	.long	.LLST14
	.uleb128 0x28
	.long	.LASF33
	.byte	0x1
	.value	0x147
	.long	0xdd5
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x148
	.long	0x2431
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x149
	.long	0x23fa
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10131
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7efb
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10132
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x2437
	.uleb128 0x2b
	.long	0x2447
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0xdd5
	.byte	0x0
	.uleb128 0x25
	.long	0x2490
	.byte	0x1
	.string	"rcudaGetLastError"
	.byte	0x1
	.value	0x157
	.byte	0x1
	.long	0x11aa
	.quad	.LFB28
	.quad	.LFE28
	.long	.LLST15
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7ef6
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10148
	.byte	0x0
	.uleb128 0x25
	.long	0x24fb
	.byte	0x1
	.string	"lcudaGetLastError"
	.byte	0x1
	.value	0x15d
	.byte	0x1
	.long	0x11aa
	.quad	.LFB29
	.quad	.LFE29
	.long	.LLST16
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x15e
	.long	0x2063
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x15f
	.long	0x24c4
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10157
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7ef1
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10158
	.byte	0x0
	.uleb128 0x2d
	.byte	0x1
	.string	"cudaGetLastError"
	.byte	0x1
	.value	0x16e
	.byte	0x1
	.long	0x11aa
	.quad	.LFB30
	.quad	.LFE30
	.long	.LLST17
	.uleb128 0x25
	.long	0x2597
	.byte	0x1
	.string	"cudaPeekAtLastError"
	.byte	0x1
	.value	0x173
	.byte	0x1
	.long	0x11aa
	.quad	.LFB31
	.quad	.LFE31
	.long	.LLST18
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x174
	.long	0x2063
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x175
	.long	0x2560
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10188
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7eec
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10189
	.byte	0x0
	.uleb128 0x25
	.long	0x2614
	.byte	0x1
	.string	"cudaGetErrorString"
	.byte	0x1
	.value	0x182
	.byte	0x1
	.long	0x3d0
	.quad	.LFB32
	.quad	.LFE32
	.long	.LLST19
	.uleb128 0x27
	.string	"error"
	.byte	0x1
	.value	0x182
	.long	0x11aa
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x183
	.long	0x2614
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x184
	.long	0x25dd
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10207
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7ee7
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10208
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x261a
	.uleb128 0x2b
	.long	0x262a
	.byte	0x1
	.long	0x3d0
	.uleb128 0x2c
	.long	0x11aa
	.byte	0x0
	.uleb128 0x25
	.long	0x2693
	.byte	0x1
	.string	"rcudaGetDeviceCount"
	.byte	0x1
	.value	0x192
	.byte	0x1
	.long	0x11aa
	.quad	.LFB33
	.quad	.LFE33
	.long	.LLST20
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x192
	.long	0x147b
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x2a
	.long	.LASF27
	.byte	0x1
	.value	0x193
	.long	0x1f41
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7ee2
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10225
	.byte	0x0
	.uleb128 0x25
	.long	0x270f
	.byte	0x1
	.string	"lcudaGetDeviceCount"
	.byte	0x1
	.value	0x1aa
	.byte	0x1
	.long	0x11aa
	.quad	.LFB34
	.quad	.LFE34
	.long	.LLST21
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x1aa
	.long	0x147b
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x1ab
	.long	0x270f
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x1ac
	.long	0x26d8
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10251
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7edd
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10252
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x2715
	.uleb128 0x2b
	.long	0x2725
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x147b
	.byte	0x0
	.uleb128 0x25
	.long	0x276a
	.byte	0x1
	.string	"cudaGetDeviceCount"
	.byte	0x1
	.value	0x1ba
	.byte	0x1
	.long	0x11aa
	.quad	.LFB35
	.quad	.LFE35
	.long	.LLST22
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x1ba
	.long	0x147b
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.byte	0x0
	.uleb128 0x25
	.long	0x27e8
	.byte	0x1
	.string	"rcudaGetDeviceProperties"
	.byte	0x1
	.value	0x1be
	.byte	0x1
	.long	0x11aa
	.quad	.LFB36
	.quad	.LFE36
	.long	.LLST23
	.uleb128 0x27
	.string	"prop"
	.byte	0x1
	.value	0x1be
	.long	0x27e8
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF35
	.byte	0x1
	.value	0x1be
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x2a
	.long	.LASF27
	.byte	0x1
	.value	0x1bf
	.long	0x1f41
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7ed8
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10282
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0xe7e
	.uleb128 0x25
	.long	0x287f
	.byte	0x1
	.string	"lcudaGetDeviceProperties"
	.byte	0x1
	.value	0x1e3
	.byte	0x1
	.long	0x11aa
	.quad	.LFB37
	.quad	.LFE37
	.long	.LLST24
	.uleb128 0x27
	.string	"prop"
	.byte	0x1
	.value	0x1e3
	.long	0x27e8
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF35
	.byte	0x1
	.value	0x1e3
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x1e5
	.long	0x287f
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x1e6
	.long	0x2848
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10312
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7ed3
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10313
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x2885
	.uleb128 0x2b
	.long	0x289a
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x27e8
	.uleb128 0x2c
	.long	0xe9
	.byte	0x0
	.uleb128 0x25
	.long	0x28f4
	.byte	0x1
	.string	"cudaGetDeviceProperties"
	.byte	0x1
	.value	0x1f5
	.byte	0x1
	.long	0x11aa
	.quad	.LFB38
	.quad	.LFE38
	.long	.LLST25
	.uleb128 0x27
	.string	"prop"
	.byte	0x1
	.value	0x1f5
	.long	0x27e8
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF35
	.byte	0x1
	.value	0x1f5
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -28
	.byte	0x0
	.uleb128 0x25
	.long	0x297d
	.byte	0x1
	.string	"cudaChooseDevice"
	.byte	0x1
	.value	0x1fa
	.byte	0x1
	.long	0x11aa
	.quad	.LFB39
	.quad	.LFE39
	.long	.LLST26
	.uleb128 0x28
	.long	.LASF35
	.byte	0x1
	.value	0x1f9
	.long	0x147b
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x27
	.string	"prop"
	.byte	0x1
	.value	0x1fa
	.long	0x297d
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x1fc
	.long	0x2988
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x1fd
	.long	0x2946
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10346
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7ece
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10347
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x2983
	.uleb128 0xb
	.long	0xe7e
	.uleb128 0x8
	.byte	0x8
	.long	0x298e
	.uleb128 0x2b
	.long	0x29a3
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x147b
	.uleb128 0x2c
	.long	0x297d
	.byte	0x0
	.uleb128 0x25
	.long	0x2a16
	.byte	0x1
	.string	"rcudaSetDevice"
	.byte	0x1
	.value	0x20b
	.byte	0x1
	.long	0x11aa
	.quad	.LFB40
	.quad	.LFE40
	.long	.LLST27
	.uleb128 0x28
	.long	.LASF35
	.byte	0x1
	.value	0x20b
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x28
	.long	.LASF31
	.byte	0x1
	.value	0x20b
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x2a
	.long	.LASF27
	.byte	0x1
	.value	0x20c
	.long	0x1f41
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7ec9
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10365
	.byte	0x0
	.uleb128 0x25
	.long	0x2a8d
	.byte	0x1
	.string	"lcudaSetDevice"
	.byte	0x1
	.value	0x222
	.byte	0x1
	.long	0x11aa
	.quad	.LFB41
	.quad	.LFE41
	.long	.LLST28
	.uleb128 0x28
	.long	.LASF35
	.byte	0x1
	.value	0x222
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x225
	.long	0x2a8d
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7ec4
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10383
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x226
	.long	0x2a56
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10386
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x2a93
	.uleb128 0x2b
	.long	0x2aa3
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0xe9
	.byte	0x0
	.uleb128 0x25
	.long	0x2af2
	.byte	0x1
	.string	"cudaSetDevice"
	.byte	0x1
	.value	0x238
	.byte	0x1
	.long	0x11aa
	.quad	.LFB42
	.quad	.LFE42
	.long	.LLST29
	.uleb128 0x28
	.long	.LASF35
	.byte	0x1
	.value	0x238
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x26
	.string	"ret"
	.byte	0x1
	.value	0x239
	.long	0x11aa
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.byte	0x0
	.uleb128 0x25
	.long	0x2b41
	.byte	0x1
	.string	"cudaGetDevice"
	.byte	0x1
	.value	0x273
	.byte	0x1
	.long	0x11aa
	.quad	.LFB43
	.quad	.LFE43
	.long	.LLST30
	.uleb128 0x28
	.long	.LASF35
	.byte	0x1
	.value	0x273
	.long	0x147b
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x26
	.string	"ret"
	.byte	0x1
	.value	0x275
	.long	0x11aa
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.byte	0x0
	.uleb128 0x25
	.long	0x2bd3
	.byte	0x1
	.string	"cudaSetValidDevices"
	.byte	0x1
	.value	0x27c
	.byte	0x1
	.long	0x11aa
	.quad	.LFB44
	.quad	.LFE44
	.long	.LLST31
	.uleb128 0x27
	.string	"device_arr"
	.byte	0x1
	.value	0x27c
	.long	0x147b
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x27
	.string	"len"
	.byte	0x1
	.value	0x27c
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x27d
	.long	0x2bd3
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x27e
	.long	0x2b9c
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10428
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7ebf
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10429
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x2bd9
	.uleb128 0x2b
	.long	0x2bee
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x147b
	.uleb128 0x2c
	.long	0xe9
	.byte	0x0
	.uleb128 0x25
	.long	0x2c69
	.byte	0x1
	.string	"cudaSetDeviceFlags"
	.byte	0x1
	.value	0x28b
	.byte	0x1
	.long	0x11aa
	.quad	.LFB45
	.quad	.LFE45
	.long	.LLST32
	.uleb128 0x28
	.long	.LASF12
	.byte	0x1
	.value	0x28b
	.long	0xbd
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x28c
	.long	0x2c69
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x28d
	.long	0x2c32
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10447
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7eba
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10448
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x2c6f
	.uleb128 0x2b
	.long	0x2c7f
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0xbd
	.byte	0x0
	.uleb128 0x25
	.long	0x2cfc
	.byte	0x1
	.string	"cudaStreamCreate"
	.byte	0x1
	.value	0x29b
	.byte	0x1
	.long	0x11aa
	.quad	.LFB46
	.quad	.LFE46
	.long	.LLST33
	.uleb128 0x27
	.string	"pStream"
	.byte	0x1
	.value	0x29b
	.long	0x2cfc
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x29c
	.long	0x2d02
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x29d
	.long	0x2cc5
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10466
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7eb5
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10467
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x11be
	.uleb128 0x8
	.byte	0x8
	.long	0x2d08
	.uleb128 0x2b
	.long	0x2d18
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x2cfc
	.byte	0x0
	.uleb128 0x25
	.long	0x2d92
	.byte	0x1
	.string	"cudaStreamDestroy"
	.byte	0x1
	.value	0x2aa
	.byte	0x1
	.long	0x11aa
	.quad	.LFB47
	.quad	.LFE47
	.long	.LLST34
	.uleb128 0x28
	.long	.LASF36
	.byte	0x1
	.value	0x2aa
	.long	0x11be
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x2ab
	.long	0x2d92
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x2ac
	.long	0x2d5b
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10485
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7eb0
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10486
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x2d98
	.uleb128 0x2b
	.long	0x2da8
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x11be
	.byte	0x0
	.uleb128 0x25
	.long	0x2e42
	.byte	0x1
	.string	"cudaStreamWaitEvent"
	.byte	0x1
	.value	0x2ba
	.byte	0x1
	.long	0x11aa
	.quad	.LFB48
	.quad	.LFE48
	.long	.LLST35
	.uleb128 0x28
	.long	.LASF36
	.byte	0x1
	.value	0x2b9
	.long	0x11be
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF37
	.byte	0x1
	.value	0x2b9
	.long	0x11e7
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF12
	.byte	0x1
	.value	0x2ba
	.long	0xbd
	.byte	0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x2bc
	.long	0x2e42
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x2bd
	.long	0x2e0b
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10508
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7eab
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10509
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x2e48
	.uleb128 0x2b
	.long	0x2e62
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x11be
	.uleb128 0x2c
	.long	0x11e7
	.uleb128 0x2c
	.long	0xbd
	.byte	0x0
	.uleb128 0x25
	.long	0x2ee0
	.byte	0x1
	.string	"cudaStreamSynchronize"
	.byte	0x1
	.value	0x2ca
	.byte	0x1
	.long	0x11aa
	.quad	.LFB49
	.quad	.LFE49
	.long	.LLST36
	.uleb128 0x28
	.long	.LASF36
	.byte	0x1
	.value	0x2ca
	.long	0x11be
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x2cb
	.long	0x2d92
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x2cc
	.long	0x2ea9
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10527
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7ea6
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10528
	.byte	0x0
	.uleb128 0x25
	.long	0x2f58
	.byte	0x1
	.string	"cudaStreamQuery"
	.byte	0x1
	.value	0x2d9
	.byte	0x1
	.long	0x11aa
	.quad	.LFB50
	.quad	.LFE50
	.long	.LLST37
	.uleb128 0x28
	.long	.LASF36
	.byte	0x1
	.value	0x2d9
	.long	0x11be
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x2da
	.long	0x2d92
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x2db
	.long	0x2f21
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10546
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7ea1
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10547
	.byte	0x0
	.uleb128 0x25
	.long	0x2fd0
	.byte	0x1
	.string	"cudaEventCreate"
	.byte	0x1
	.value	0x2ea
	.byte	0x1
	.long	0x11aa
	.quad	.LFB51
	.quad	.LFE51
	.long	.LLST38
	.uleb128 0x28
	.long	.LASF37
	.byte	0x1
	.value	0x2ea
	.long	0x2fd0
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x2eb
	.long	0x2fd6
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x2ec
	.long	0x2f99
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10565
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e9c
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10566
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x11e7
	.uleb128 0x8
	.byte	0x8
	.long	0x2fdc
	.uleb128 0x2b
	.long	0x2fec
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x2fd0
	.byte	0x0
	.uleb128 0x25
	.long	0x307c
	.byte	0x1
	.string	"cudaEventCreateWithFlags"
	.byte	0x1
	.value	0x2fa
	.byte	0x1
	.long	0x11aa
	.quad	.LFB52
	.quad	.LFE52
	.long	.LLST39
	.uleb128 0x28
	.long	.LASF37
	.byte	0x1
	.value	0x2f9
	.long	0x2fd0
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF12
	.byte	0x1
	.value	0x2fa
	.long	0xbd
	.byte	0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x2fb
	.long	0x307c
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x2fc
	.long	0x3045
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10586
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e97
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10587
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x3082
	.uleb128 0x2b
	.long	0x3097
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x2fd0
	.uleb128 0x2c
	.long	0xbd
	.byte	0x0
	.uleb128 0x25
	.long	0x311e
	.byte	0x1
	.string	"cudaEventRecord"
	.byte	0x1
	.value	0x30a
	.byte	0x1
	.long	0x11aa
	.quad	.LFB53
	.quad	.LFE53
	.long	.LLST40
	.uleb128 0x28
	.long	.LASF37
	.byte	0x1
	.value	0x309
	.long	0x11e7
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF36
	.byte	0x1
	.value	0x30a
	.long	0x11be
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x30b
	.long	0x311e
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x30c
	.long	0x30e7
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10607
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e92
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10608
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x3124
	.uleb128 0x2b
	.long	0x3139
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x11e7
	.uleb128 0x2c
	.long	0x11be
	.byte	0x0
	.uleb128 0x25
	.long	0x31b0
	.byte	0x1
	.string	"cudaEventQuery"
	.byte	0x1
	.value	0x319
	.byte	0x1
	.long	0x11aa
	.quad	.LFB54
	.quad	.LFE54
	.long	.LLST41
	.uleb128 0x28
	.long	.LASF37
	.byte	0x1
	.value	0x319
	.long	0x11e7
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x31a
	.long	0x31b0
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x31b
	.long	0x3179
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10626
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e8d
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10627
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x31b6
	.uleb128 0x2b
	.long	0x31c6
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x11e7
	.byte	0x0
	.uleb128 0x25
	.long	0x3243
	.byte	0x1
	.string	"cudaEventSynchronize"
	.byte	0x1
	.value	0x328
	.byte	0x1
	.long	0x11aa
	.quad	.LFB55
	.quad	.LFE55
	.long	.LLST42
	.uleb128 0x28
	.long	.LASF37
	.byte	0x1
	.value	0x328
	.long	0x11e7
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x329
	.long	0x31b0
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x32a
	.long	0x320c
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10645
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e88
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10646
	.byte	0x0
	.uleb128 0x25
	.long	0x32bc
	.byte	0x1
	.string	"cudaEventDestroy"
	.byte	0x1
	.value	0x337
	.byte	0x1
	.long	0x11aa
	.quad	.LFB56
	.quad	.LFE56
	.long	.LLST43
	.uleb128 0x28
	.long	.LASF37
	.byte	0x1
	.value	0x337
	.long	0x11e7
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x338
	.long	0x31b0
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x339
	.long	0x3285
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10664
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e83
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10665
	.byte	0x0
	.uleb128 0x25
	.long	0x3358
	.byte	0x1
	.string	"cudaEventElapsedTime"
	.byte	0x1
	.value	0x347
	.byte	0x1
	.long	0x11aa
	.quad	.LFB57
	.quad	.LFE57
	.long	.LLST44
	.uleb128 0x27
	.string	"ms"
	.byte	0x1
	.value	0x346
	.long	0x3358
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x27
	.string	"start"
	.byte	0x1
	.value	0x346
	.long	0x11e7
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x27
	.string	"end"
	.byte	0x1
	.value	0x347
	.long	0x11e7
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x349
	.long	0x335e
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x34a
	.long	0x3321
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10687
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e7e
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10688
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x13e7
	.uleb128 0x8
	.byte	0x8
	.long	0x3364
	.uleb128 0x2b
	.long	0x337e
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x3358
	.uleb128 0x2c
	.long	0x11e7
	.uleb128 0x2c
	.long	0x11e7
	.byte	0x0
	.uleb128 0x25
	.long	0x3424
	.byte	0x1
	.string	"rcudaConfigureCall"
	.byte	0x1
	.value	0x35a
	.byte	0x1
	.long	0x11aa
	.quad	.LFB58
	.quad	.LFE58
	.long	.LLST45
	.uleb128 0x28
	.long	.LASF38
	.byte	0x1
	.value	0x359
	.long	0x1469
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF39
	.byte	0x1
	.value	0x359
	.long	0x1469
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x28
	.long	.LASF40
	.byte	0x1
	.value	0x35a
	.long	0x81
	.byte	0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x28
	.long	.LASF36
	.byte	0x1
	.value	0x35a
	.long	0x11be
	.byte	0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x28
	.long	.LASF31
	.byte	0x1
	.value	0x35a
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x2a
	.long	.LASF27
	.byte	0x1
	.value	0x35b
	.long	0x1f41
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e79
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10709
	.byte	0x0
	.uleb128 0x25
	.long	0x34cc
	.byte	0x1
	.string	"lcudaConfigureCall"
	.byte	0x1
	.value	0x37a
	.byte	0x1
	.long	0x11aa
	.quad	.LFB59
	.quad	.LFE59
	.long	.LLST46
	.uleb128 0x28
	.long	.LASF38
	.byte	0x1
	.value	0x379
	.long	0x1469
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF39
	.byte	0x1
	.value	0x379
	.long	0x1469
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF40
	.byte	0x1
	.value	0x37a
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF36
	.byte	0x1
	.value	0x37a
	.long	0x11be
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x37d
	.long	0x34cc
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x37e
	.long	0x3495
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10756
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e74
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10757
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x34d2
	.uleb128 0x2b
	.long	0x34f1
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x1469
	.uleb128 0x2c
	.long	0x1469
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x11be
	.byte	0x0
	.uleb128 0x25
	.long	0x3562
	.byte	0x1
	.string	"cudaConfigureCall"
	.byte	0x1
	.value	0x3a6
	.byte	0x1
	.long	0x11aa
	.quad	.LFB60
	.quad	.LFE60
	.long	.LLST47
	.uleb128 0x28
	.long	.LASF38
	.byte	0x1
	.value	0x3a5
	.long	0x1469
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF39
	.byte	0x1
	.value	0x3a5
	.long	0x1469
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF40
	.byte	0x1
	.value	0x3a6
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF36
	.byte	0x1
	.value	0x3a6
	.long	0x11be
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.byte	0x0
	.uleb128 0x25
	.long	0x35f7
	.byte	0x1
	.string	"rcudaSetupArgument"
	.byte	0x1
	.value	0x3ab
	.byte	0x1
	.long	0x11aa
	.quad	.LFB61
	.quad	.LFE61
	.long	.LLST48
	.uleb128 0x27
	.string	"arg"
	.byte	0x1
	.value	0x3ab
	.long	0x14a2
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF11
	.byte	0x1
	.value	0x3ab
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF13
	.byte	0x1
	.value	0x3ab
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF31
	.byte	0x1
	.value	0x3ab
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -60
	.uleb128 0x2a
	.long	.LASF27
	.byte	0x1
	.value	0x3ac
	.long	0x1f41
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e6f
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10785
	.byte	0x0
	.uleb128 0x25
	.long	0x3690
	.byte	0x1
	.string	"lcudaSetupArgument"
	.byte	0x1
	.value	0x3cf
	.byte	0x1
	.long	0x11aa
	.quad	.LFB62
	.quad	.LFE62
	.long	.LLST49
	.uleb128 0x27
	.string	"arg"
	.byte	0x1
	.value	0x3cf
	.long	0x14a2
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF11
	.byte	0x1
	.value	0x3cf
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF13
	.byte	0x1
	.value	0x3cf
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x3d2
	.long	0x3690
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x3d3
	.long	0x3659
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10816
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e6a
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10817
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x3696
	.uleb128 0x2b
	.long	0x36b0
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x14a2
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.byte	0x0
	.uleb128 0x25
	.long	0x3721
	.byte	0x1
	.string	"cudaSetupArgument"
	.byte	0x1
	.value	0x3ea
	.byte	0x1
	.long	0x11aa
	.quad	.LFB63
	.quad	.LFE63
	.long	.LLST50
	.uleb128 0x27
	.string	"arg"
	.byte	0x1
	.value	0x3ea
	.long	0x14a2
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF11
	.byte	0x1
	.value	0x3ea
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF13
	.byte	0x1
	.value	0x3ea
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x26
	.string	"ret"
	.byte	0x1
	.value	0x3eb
	.long	0x11aa
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.byte	0x0
	.uleb128 0x25
	.long	0x37b0
	.byte	0x1
	.string	"cudaFuncSetCacheConfig"
	.byte	0x1
	.value	0x3f5
	.byte	0x1
	.long	0x11aa
	.quad	.LFB64
	.quad	.LFE64
	.long	.LLST51
	.uleb128 0x27
	.string	"func"
	.byte	0x1
	.value	0x3f4
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF33
	.byte	0x1
	.value	0x3f5
	.long	0xdd5
	.byte	0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x3f7
	.long	0x37b0
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x3f8
	.long	0x3779
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10853
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e65
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10854
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x37b6
	.uleb128 0x2b
	.long	0x37cb
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x3d0
	.uleb128 0x2c
	.long	0xdd5
	.byte	0x0
	.uleb128 0x25
	.long	0x383d
	.byte	0x1
	.string	"rcudaLaunch"
	.byte	0x1
	.value	0x406
	.byte	0x1
	.long	0x11aa
	.quad	.LFB65
	.quad	.LFE65
	.long	.LLST52
	.uleb128 0x27
	.string	"entry"
	.byte	0x1
	.value	0x406
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF31
	.byte	0x1
	.value	0x406
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x2a
	.long	.LASF27
	.byte	0x1
	.value	0x407
	.long	0x1f41
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e60
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10872
	.byte	0x0
	.uleb128 0x25
	.long	0x38b3
	.byte	0x1
	.string	"lcudaLaunch"
	.byte	0x1
	.value	0x41d
	.byte	0x1
	.long	0x11aa
	.quad	.LFB66
	.quad	.LFE66
	.long	.LLST53
	.uleb128 0x27
	.string	"entry"
	.byte	0x1
	.value	0x41d
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x41f
	.long	0x38b3
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x420
	.long	0x387c
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10891
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e5b
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10892
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x38b9
	.uleb128 0x2b
	.long	0x38c9
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x3d0
	.byte	0x0
	.uleb128 0x25
	.long	0x3917
	.byte	0x1
	.string	"cudaLaunch"
	.byte	0x1
	.value	0x433
	.byte	0x1
	.long	0x11aa
	.quad	.LFB67
	.quad	.LFE67
	.long	.LLST54
	.uleb128 0x27
	.string	"entry"
	.byte	0x1
	.value	0x433
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x26
	.string	"ret"
	.byte	0x1
	.value	0x434
	.long	0x11aa
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.byte	0x0
	.uleb128 0x25
	.long	0x39a6
	.byte	0x1
	.string	"cudaFuncGetAttributes"
	.byte	0x1
	.value	0x43d
	.byte	0x1
	.long	0x11aa
	.quad	.LFB68
	.quad	.LFE68
	.long	.LLST55
	.uleb128 0x27
	.string	"attr"
	.byte	0x1
	.value	0x43c
	.long	0x39a6
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x27
	.string	"func"
	.byte	0x1
	.value	0x43d
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x43f
	.long	0x39ac
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x440
	.long	0x396f
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10926
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e56
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10927
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0xcf9
	.uleb128 0x8
	.byte	0x8
	.long	0x39b2
	.uleb128 0x2b
	.long	0x39c7
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x39a6
	.uleb128 0x2c
	.long	0x3d0
	.byte	0x0
	.uleb128 0x25
	.long	0x3a44
	.byte	0x1
	.string	"cudaSetDoubleForDevice"
	.byte	0x1
	.value	0x44d
	.byte	0x1
	.long	0x11aa
	.quad	.LFB69
	.quad	.LFE69
	.long	.LLST56
	.uleb128 0x27
	.string	"d"
	.byte	0x1
	.value	0x44d
	.long	0x3a44
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x44e
	.long	0x3a4a
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x44f
	.long	0x3a0d
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10945
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e51
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10946
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x141b
	.uleb128 0x8
	.byte	0x8
	.long	0x3a50
	.uleb128 0x2b
	.long	0x3a60
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x3a44
	.byte	0x0
	.uleb128 0x25
	.long	0x3adb
	.byte	0x1
	.string	"cudaSetDoubleForHost"
	.byte	0x1
	.value	0x45c
	.byte	0x1
	.long	0x11aa
	.quad	.LFB70
	.quad	.LFE70
	.long	.LLST57
	.uleb128 0x27
	.string	"d"
	.byte	0x1
	.value	0x45c
	.long	0x3a44
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x45f
	.long	0x3a4a
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e4c
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10962
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x460
	.long	0x3aa4
	.byte	0x9
	.byte	0x3
	.quad	pFunc.10965
	.byte	0x0
	.uleb128 0x25
	.long	0x3b5a
	.byte	0x1
	.string	"rcudaMalloc"
	.byte	0x1
	.value	0x46c
	.byte	0x1
	.long	0x11aa
	.quad	.LFB71
	.quad	.LFE71
	.long	.LLST58
	.uleb128 0x28
	.long	.LASF41
	.byte	0x1
	.value	0x46c
	.long	0x3db
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF11
	.byte	0x1
	.value	0x46c
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF31
	.byte	0x1
	.value	0x46c
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x2a
	.long	.LASF27
	.byte	0x1
	.value	0x46d
	.long	0x1f41
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e47
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.10984
	.byte	0x0
	.uleb128 0x25
	.long	0x3bdd
	.byte	0x1
	.string	"lcudaMalloc"
	.byte	0x1
	.value	0x488
	.byte	0x1
	.long	0x11aa
	.quad	.LFB72
	.quad	.LFE72
	.long	.LLST59
	.uleb128 0x28
	.long	.LASF41
	.byte	0x1
	.value	0x488
	.long	0x3db
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF11
	.byte	0x1
	.value	0x488
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x48a
	.long	0x3bdd
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x48b
	.long	0x3ba6
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11015
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e42
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11016
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x3be3
	.uleb128 0x2b
	.long	0x3bf8
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x3db
	.uleb128 0x2c
	.long	0x81
	.byte	0x0
	.uleb128 0x25
	.long	0x3c53
	.byte	0x1
	.string	"cudaMalloc"
	.byte	0x1
	.value	0x4a0
	.byte	0x1
	.long	0x11aa
	.quad	.LFB73
	.quad	.LFE73
	.long	.LLST60
	.uleb128 0x28
	.long	.LASF41
	.byte	0x1
	.value	0x4a0
	.long	0x3db
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF11
	.byte	0x1
	.value	0x4a0
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x26
	.string	"ret"
	.byte	0x1
	.value	0x4a1
	.long	0x11aa
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.byte	0x0
	.uleb128 0x25
	.long	0x3cd9
	.byte	0x1
	.string	"cudaMallocHost"
	.byte	0x1
	.value	0x4a9
	.byte	0x1
	.long	0x11aa
	.quad	.LFB74
	.quad	.LFE74
	.long	.LLST61
	.uleb128 0x27
	.string	"ptr"
	.byte	0x1
	.value	0x4a9
	.long	0x3db
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF11
	.byte	0x1
	.value	0x4a9
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x4aa
	.long	0x3bdd
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x4ab
	.long	0x3ca2
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11051
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e3d
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11052
	.byte	0x0
	.uleb128 0x25
	.long	0x3d7e
	.byte	0x1
	.string	"cudaMallocPitch"
	.byte	0x1
	.value	0x4ba
	.byte	0x1
	.long	0x11aa
	.quad	.LFB75
	.quad	.LFE75
	.long	.LLST62
	.uleb128 0x28
	.long	.LASF41
	.byte	0x1
	.value	0x4b9
	.long	0x3db
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF2
	.byte	0x1
	.value	0x4b9
	.long	0x3ca
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF3
	.byte	0x1
	.value	0x4b9
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF4
	.byte	0x1
	.value	0x4ba
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x4bc
	.long	0x3d7e
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x4bd
	.long	0x3d47
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11076
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e38
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11077
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x3d84
	.uleb128 0x2b
	.long	0x3da3
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x3db
	.uleb128 0x2c
	.long	0x3ca
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.byte	0x0
	.uleb128 0x25
	.long	0x3e57
	.byte	0x1
	.string	"cudaMallocArray"
	.byte	0x1
	.value	0x4cc
	.byte	0x1
	.long	0x11aa
	.quad	.LFB76
	.quad	.LFE76
	.long	.LLST63
	.uleb128 0x28
	.long	.LASF42
	.byte	0x1
	.value	0x4ca
	.long	0x3e57
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF43
	.byte	0x1
	.value	0x4cb
	.long	0x3e5d
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF3
	.byte	0x1
	.value	0x4cb
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF4
	.byte	0x1
	.value	0x4cc
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF12
	.byte	0x1
	.value	0x4cc
	.long	0xbd
	.byte	0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x4ce
	.long	0x3e68
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x4cf
	.long	0x3e20
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11103
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e33
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11104
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0xcf3
	.uleb128 0x8
	.byte	0x8
	.long	0x3e63
	.uleb128 0xb
	.long	0xaa4
	.uleb128 0x8
	.byte	0x8
	.long	0x3e6e
	.uleb128 0x2b
	.long	0x3e92
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x3e57
	.uleb128 0x2c
	.long	0x3e5d
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0xbd
	.byte	0x0
	.uleb128 0x25
	.long	0x3f00
	.byte	0x1
	.string	"rcudaFree"
	.byte	0x1
	.value	0x4dd
	.byte	0x1
	.long	0x11aa
	.quad	.LFB77
	.quad	.LFE77
	.long	.LLST64
	.uleb128 0x28
	.long	.LASF41
	.byte	0x1
	.value	0x4dd
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF31
	.byte	0x1
	.value	0x4dd
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x2a
	.long	.LASF27
	.byte	0x1
	.value	0x4de
	.long	0x1f41
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e2e
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11122
	.byte	0x0
	.uleb128 0x25
	.long	0x3f72
	.byte	0x1
	.string	"lcudaFree"
	.byte	0x1
	.value	0x4fc
	.byte	0x1
	.long	0x11aa
	.quad	.LFB78
	.quad	.LFE78
	.long	.LLST65
	.uleb128 0x28
	.long	.LASF41
	.byte	0x1
	.value	0x4fc
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x4fe
	.long	0x3f72
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x4ff
	.long	0x3f3b
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11144
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e29
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11145
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x3f78
	.uleb128 0x2b
	.long	0x3f88
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x133
	.byte	0x0
	.uleb128 0x25
	.long	0x3fd2
	.byte	0x1
	.string	"cudaFree"
	.byte	0x1
	.value	0x518
	.byte	0x1
	.long	0x11aa
	.quad	.LFB79
	.quad	.LFE79
	.long	.LLST66
	.uleb128 0x28
	.long	.LASF41
	.byte	0x1
	.value	0x518
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x26
	.string	"ret"
	.byte	0x1
	.value	0x519
	.long	0x11aa
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.byte	0x0
	.uleb128 0x25
	.long	0x4047
	.byte	0x1
	.string	"cudaFreeHost"
	.byte	0x1
	.value	0x521
	.byte	0x1
	.long	0x11aa
	.quad	.LFB80
	.quad	.LFE80
	.long	.LLST67
	.uleb128 0x27
	.string	"ptr"
	.byte	0x1
	.value	0x521
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x522
	.long	0x3f72
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x523
	.long	0x4010
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11177
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e14
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11178
	.byte	0x0
	.uleb128 0x25
	.long	0x40bd
	.byte	0x1
	.string	"cudaFreeArray"
	.byte	0x1
	.value	0x530
	.byte	0x1
	.long	0x11aa
	.quad	.LFB81
	.quad	.LFE81
	.long	.LLST68
	.uleb128 0x28
	.long	.LASF42
	.byte	0x1
	.value	0x530
	.long	0xcf3
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x531
	.long	0x40bd
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x532
	.long	0x4086
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11196
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e0f
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11197
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x40c3
	.uleb128 0x2b
	.long	0x40d3
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0xcf3
	.byte	0x0
	.uleb128 0x25
	.long	0x4169
	.byte	0x1
	.string	"cudaHostAlloc"
	.byte	0x1
	.value	0x541
	.byte	0x1
	.long	0x11aa
	.quad	.LFB82
	.quad	.LFE82
	.long	.LLST69
	.uleb128 0x27
	.string	"pHost"
	.byte	0x1
	.value	0x541
	.long	0x3db
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF11
	.byte	0x1
	.value	0x541
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF12
	.byte	0x1
	.value	0x541
	.long	0xbd
	.byte	0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x542
	.long	0x4169
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x543
	.long	0x4132
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11219
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e0a
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11220
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x416f
	.uleb128 0x2b
	.long	0x4189
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x3db
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0xbd
	.byte	0x0
	.uleb128 0x25
	.long	0x422e
	.byte	0x1
	.string	"cudaHostGetDevicePointer"
	.byte	0x1
	.value	0x552
	.byte	0x1
	.long	0x11aa
	.quad	.LFB83
	.quad	.LFE83
	.long	.LLST70
	.uleb128 0x27
	.string	"pDevice"
	.byte	0x1
	.value	0x551
	.long	0x3db
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x27
	.string	"pHost"
	.byte	0x1
	.value	0x551
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF12
	.byte	0x1
	.value	0x552
	.long	0xbd
	.byte	0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x554
	.long	0x422e
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x555
	.long	0x41f7
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11242
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e05
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11243
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x4234
	.uleb128 0x2b
	.long	0x424e
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x3db
	.uleb128 0x2c
	.long	0x133
	.uleb128 0x2c
	.long	0xbd
	.byte	0x0
	.uleb128 0x25
	.long	0x42db
	.byte	0x1
	.string	"cudaHostGetFlags"
	.byte	0x1
	.value	0x562
	.byte	0x1
	.long	0x11aa
	.quad	.LFB84
	.quad	.LFE84
	.long	.LLST71
	.uleb128 0x27
	.string	"pFlags"
	.byte	0x1
	.value	0x562
	.long	0x42db
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x27
	.string	"pHost"
	.byte	0x1
	.value	0x562
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x563
	.long	0x42e1
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x564
	.long	0x42a4
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11263
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7e00
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11264
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0xbd
	.uleb128 0x8
	.byte	0x8
	.long	0x42e7
	.uleb128 0x2b
	.long	0x42fc
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x42db
	.uleb128 0x2c
	.long	0x133
	.byte	0x0
	.uleb128 0x25
	.long	0x4380
	.byte	0x1
	.string	"cudaMalloc3D"
	.byte	0x1
	.value	0x573
	.byte	0x1
	.long	0x11aa
	.quad	.LFB85
	.quad	.LFE85
	.long	.LLST72
	.uleb128 0x28
	.long	.LASF44
	.byte	0x1
	.value	0x572
	.long	0x4380
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF5
	.byte	0x1
	.value	0x573
	.long	0xbcf
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x575
	.long	0x4386
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x576
	.long	0x4349
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11284
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7deb
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11285
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0xb7b
	.uleb128 0x8
	.byte	0x8
	.long	0x438c
	.uleb128 0x2b
	.long	0x43a1
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x4380
	.uleb128 0x2c
	.long	0xbcf
	.byte	0x0
	.uleb128 0x25
	.long	0x4448
	.byte	0x1
	.string	"cudaMalloc3DArray"
	.byte	0x1
	.value	0x586
	.byte	0x1
	.long	0x11aa
	.quad	.LFB86
	.quad	.LFE86
	.long	.LLST73
	.uleb128 0x28
	.long	.LASF42
	.byte	0x1
	.value	0x584
	.long	0x3e57
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF43
	.byte	0x1
	.value	0x585
	.long	0x3e5d
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF5
	.byte	0x1
	.value	0x585
	.long	0xbcf
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x28
	.long	.LASF12
	.byte	0x1
	.value	0x586
	.long	0xbd
	.byte	0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x589
	.long	0x4448
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x58a
	.long	0x4411
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11310
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7de6
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11311
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x444e
	.uleb128 0x2b
	.long	0x446d
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x3e57
	.uleb128 0x2c
	.long	0x3e5d
	.uleb128 0x2c
	.long	0xbcf
	.uleb128 0x2c
	.long	0xbd
	.byte	0x0
	.uleb128 0x25
	.long	0x44e0
	.byte	0x1
	.string	"cudaMemcpy3D"
	.byte	0x1
	.value	0x597
	.byte	0x1
	.long	0x11aa
	.quad	.LFB87
	.quad	.LFE87
	.long	.LLST74
	.uleb128 0x27
	.string	"p"
	.byte	0x1
	.value	0x597
	.long	0x44e0
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x598
	.long	0x44eb
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x599
	.long	0x44a9
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11329
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7de1
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11330
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x44e6
	.uleb128 0xb
	.long	0xc44
	.uleb128 0x8
	.byte	0x8
	.long	0x44f1
	.uleb128 0x2b
	.long	0x4501
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x44e0
	.byte	0x0
	.uleb128 0x25
	.long	0x4588
	.byte	0x1
	.string	"cudaMemcpy3DAsync"
	.byte	0x1
	.value	0x5a6
	.byte	0x1
	.long	0x11aa
	.quad	.LFB88
	.quad	.LFE88
	.long	.LLST75
	.uleb128 0x27
	.string	"p"
	.byte	0x1
	.value	0x5a5
	.long	0x44e0
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF36
	.byte	0x1
	.value	0x5a6
	.long	0x11be
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x5a8
	.long	0x4588
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x5a9
	.long	0x4551
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11350
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7ddc
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11351
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x458e
	.uleb128 0x2b
	.long	0x45a3
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x44e0
	.uleb128 0x2c
	.long	0x11be
	.byte	0x0
	.uleb128 0x25
	.long	0x462c
	.byte	0x1
	.string	"cudaMemGetInfo"
	.byte	0x1
	.value	0x5b6
	.byte	0x1
	.long	0x11aa
	.quad	.LFB89
	.quad	.LFE89
	.long	.LLST76
	.uleb128 0x27
	.string	"free"
	.byte	0x1
	.value	0x5b6
	.long	0x3ca
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x27
	.string	"total"
	.byte	0x1
	.value	0x5b6
	.long	0x3ca
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x5b7
	.long	0x462c
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x5b8
	.long	0x45f5
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11371
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7dd7
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11372
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x4632
	.uleb128 0x2b
	.long	0x4647
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x3ca
	.uleb128 0x2c
	.long	0x3ca
	.byte	0x0
	.uleb128 0x25
	.long	0x46e4
	.byte	0x1
	.string	"rcudaMemcpy"
	.byte	0x1
	.value	0x5c6
	.byte	0x1
	.long	0x11aa
	.quad	.LFB90
	.quad	.LFE90
	.long	.LLST77
	.uleb128 0x27
	.string	"dst"
	.byte	0x1
	.value	0x5c5
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x27
	.string	"src"
	.byte	0x1
	.value	0x5c5
	.long	0x14a2
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x5c5
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x5c6
	.long	0xaff
	.byte	0x2
	.byte	0x91
	.sleb128 -60
	.uleb128 0x28
	.long	.LASF31
	.byte	0x1
	.value	0x5c6
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x2a
	.long	.LASF27
	.byte	0x1
	.value	0x5c7
	.long	0x1f41
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7dc2
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11393
	.byte	0x0
	.uleb128 0x25
	.long	0x4785
	.byte	0x1
	.string	"lcudaMemcpy"
	.byte	0x1
	.value	0x5e4
	.byte	0x1
	.long	0x11aa
	.quad	.LFB91
	.quad	.LFE91
	.long	.LLST78
	.uleb128 0x27
	.string	"dst"
	.byte	0x1
	.value	0x5e3
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x27
	.string	"src"
	.byte	0x1
	.value	0x5e3
	.long	0x14a2
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x5e3
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x5e4
	.long	0xaff
	.byte	0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x5e6
	.long	0x4785
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x5e7
	.long	0x474e
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11430
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7dbd
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11431
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x478b
	.uleb128 0x2b
	.long	0x47aa
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x133
	.uleb128 0x2c
	.long	0x14a2
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0xaff
	.byte	0x0
	.uleb128 0x25
	.long	0x4823
	.byte	0x1
	.string	"cudaMemcpy"
	.byte	0x1
	.value	0x602
	.byte	0x1
	.long	0x11aa
	.quad	.LFB92
	.quad	.LFE92
	.long	.LLST79
	.uleb128 0x27
	.string	"dst"
	.byte	0x1
	.value	0x601
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x27
	.string	"src"
	.byte	0x1
	.value	0x601
	.long	0x14a2
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x601
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x602
	.long	0xaff
	.byte	0x2
	.byte	0x91
	.sleb128 -60
	.uleb128 0x26
	.string	"ret"
	.byte	0x1
	.value	0x603
	.long	0x11aa
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.byte	0x0
	.uleb128 0x25
	.long	0x48e8
	.byte	0x1
	.string	"cudaMemcpyToArray"
	.byte	0x1
	.value	0x60e
	.byte	0x1
	.long	0x11aa
	.quad	.LFB93
	.quad	.LFE93
	.long	.LLST80
	.uleb128 0x27
	.string	"dst"
	.byte	0x1
	.value	0x60d
	.long	0xcf3
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF45
	.byte	0x1
	.value	0x60d
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF46
	.byte	0x1
	.value	0x60e
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x27
	.string	"src"
	.byte	0x1
	.value	0x60e
	.long	0x14a2
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x60e
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x60e
	.long	0xaff
	.byte	0x2
	.byte	0x91
	.sleb128 -60
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x611
	.long	0x48e8
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x612
	.long	0x48b1
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11476
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7da8
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11477
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x48ee
	.uleb128 0x2b
	.long	0x4917
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0xcf3
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x14a2
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0xaff
	.byte	0x0
	.uleb128 0x25
	.long	0x49de
	.byte	0x1
	.string	"cudaMemcpyFromArray"
	.byte	0x1
	.value	0x620
	.byte	0x1
	.long	0x11aa
	.quad	.LFB94
	.quad	.LFE94
	.long	.LLST81
	.uleb128 0x27
	.string	"dst"
	.byte	0x1
	.value	0x61f
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x27
	.string	"src"
	.byte	0x1
	.value	0x61f
	.long	0x49de
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF45
	.byte	0x1
	.value	0x620
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF46
	.byte	0x1
	.value	0x620
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x620
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x620
	.long	0xaff
	.byte	0x2
	.byte	0x91
	.sleb128 -60
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x623
	.long	0x49e9
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x624
	.long	0x49a7
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11505
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7da3
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11506
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x49e4
	.uleb128 0xb
	.long	0xce7
	.uleb128 0x8
	.byte	0x8
	.long	0x49ef
	.uleb128 0x2b
	.long	0x4a18
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x133
	.uleb128 0x2c
	.long	0x49de
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0xaff
	.byte	0x0
	.uleb128 0x25
	.long	0x4b01
	.byte	0x1
	.string	"cudaMemcpyArrayToArray"
	.byte	0x1
	.value	0x634
	.byte	0x1
	.long	0x11aa
	.quad	.LFB95
	.quad	.LFE95
	.long	.LLST82
	.uleb128 0x27
	.string	"dst"
	.byte	0x1
	.value	0x631
	.long	0xcf3
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF47
	.byte	0x1
	.value	0x632
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF48
	.byte	0x1
	.value	0x632
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x27
	.string	"src"
	.byte	0x1
	.value	0x632
	.long	0x49de
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF49
	.byte	0x1
	.value	0x633
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x28
	.long	.LASF50
	.byte	0x1
	.value	0x633
	.long	0x81
	.byte	0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x633
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x634
	.long	0xaff
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x637
	.long	0x4b01
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x638
	.long	0x4aca
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11538
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d9e
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11539
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x4b07
	.uleb128 0x2b
	.long	0x4b3a
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0xcf3
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x49de
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0xaff
	.byte	0x0
	.uleb128 0x25
	.long	0x4c0a
	.byte	0x1
	.string	"cudaMemcpy2D"
	.byte	0x1
	.value	0x648
	.byte	0x1
	.long	0x11aa
	.quad	.LFB96
	.quad	.LFE96
	.long	.LLST83
	.uleb128 0x27
	.string	"dst"
	.byte	0x1
	.value	0x647
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF51
	.byte	0x1
	.value	0x647
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x27
	.string	"src"
	.byte	0x1
	.value	0x647
	.long	0x14a2
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF52
	.byte	0x1
	.value	0x648
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF3
	.byte	0x1
	.value	0x648
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x28
	.long	.LASF4
	.byte	0x1
	.value	0x648
	.long	0x81
	.byte	0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x648
	.long	0xaff
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x64b
	.long	0x4c0a
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x64c
	.long	0x4bd3
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11569
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d99
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11570
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x4c10
	.uleb128 0x2b
	.long	0x4c3e
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x133
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x14a2
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0xaff
	.byte	0x0
	.uleb128 0x25
	.long	0x4d24
	.byte	0x1
	.string	"cudaMemcpy2DToArray"
	.byte	0x1
	.value	0x65b
	.byte	0x1
	.long	0x11aa
	.quad	.LFB97
	.quad	.LFE97
	.long	.LLST84
	.uleb128 0x27
	.string	"dst"
	.byte	0x1
	.value	0x659
	.long	0xcf3
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF45
	.byte	0x1
	.value	0x659
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF46
	.byte	0x1
	.value	0x65a
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x27
	.string	"src"
	.byte	0x1
	.value	0x65a
	.long	0x14a2
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF52
	.byte	0x1
	.value	0x65a
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x28
	.long	.LASF3
	.byte	0x1
	.value	0x65a
	.long	0x81
	.byte	0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x28
	.long	.LASF4
	.byte	0x1
	.value	0x65b
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x65b
	.long	0xaff
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x65f
	.long	0x4d24
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x660
	.long	0x4ced
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11602
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d94
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11603
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x4d2a
	.uleb128 0x2b
	.long	0x4d5d
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0xcf3
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x14a2
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0xaff
	.byte	0x0
	.uleb128 0x25
	.long	0x4e45
	.byte	0x1
	.string	"cudaMemcpy2DFromArray"
	.byte	0x1
	.value	0x66f
	.byte	0x1
	.long	0x11aa
	.quad	.LFB98
	.quad	.LFE98
	.long	.LLST85
	.uleb128 0x27
	.string	"dst"
	.byte	0x1
	.value	0x66d
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF51
	.byte	0x1
	.value	0x66d
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x27
	.string	"src"
	.byte	0x1
	.value	0x66e
	.long	0x49de
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF45
	.byte	0x1
	.value	0x66e
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF46
	.byte	0x1
	.value	0x66e
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x28
	.long	.LASF3
	.byte	0x1
	.value	0x66f
	.long	0x81
	.byte	0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x28
	.long	.LASF4
	.byte	0x1
	.value	0x66f
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x66f
	.long	0xaff
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x672
	.long	0x4e45
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x673
	.long	0x4e0e
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11635
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d8f
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11636
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x4e4b
	.uleb128 0x2b
	.long	0x4e7e
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x133
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x49de
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0xaff
	.byte	0x0
	.uleb128 0x25
	.long	0x4f78
	.byte	0x1
	.string	"cudaMemcpy2DArrayToArray"
	.byte	0x1
	.value	0x683
	.byte	0x1
	.long	0x11aa
	.quad	.LFB99
	.quad	.LFE99
	.long	.LLST86
	.uleb128 0x27
	.string	"dst"
	.byte	0x1
	.value	0x680
	.long	0xcf3
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF47
	.byte	0x1
	.value	0x681
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF48
	.byte	0x1
	.value	0x681
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x27
	.string	"src"
	.byte	0x1
	.value	0x681
	.long	0x49de
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF49
	.byte	0x1
	.value	0x682
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x28
	.long	.LASF50
	.byte	0x1
	.value	0x682
	.long	0x81
	.byte	0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x28
	.long	.LASF3
	.byte	0x1
	.value	0x682
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x28
	.long	.LASF4
	.byte	0x1
	.value	0x682
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x683
	.long	0xaff
	.byte	0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x687
	.long	0x4f78
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x688
	.long	0x4f41
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11670
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d8a
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11671
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x4f7e
	.uleb128 0x2b
	.long	0x4fb6
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0xcf3
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x49de
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0xaff
	.byte	0x0
	.uleb128 0x25
	.long	0x506b
	.byte	0x1
	.string	"rcudaMemcpyToSymbol"
	.byte	0x1
	.value	0x698
	.byte	0x1
	.long	0x11aa
	.quad	.LFB100
	.quad	.LFE100
	.long	.LLST87
	.uleb128 0x28
	.long	.LASF53
	.byte	0x1
	.value	0x696
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x27
	.string	"src"
	.byte	0x1
	.value	0x696
	.long	0x14a2
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x697
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF13
	.byte	0x1
	.value	0x697
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x698
	.long	0xaff
	.byte	0x3
	.byte	0x91
	.sleb128 -68
	.uleb128 0x2a
	.long	.LASF27
	.byte	0x1
	.value	0x699
	.long	0x1f41
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x2a
	.long	.LASF20
	.byte	0x1
	.value	0x69c
	.long	0x135
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d85
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11693
	.byte	0x0
	.uleb128 0x25
	.long	0x5123
	.byte	0x1
	.string	"lcudaMemcpyToSymbol"
	.byte	0x1
	.value	0x6ce
	.byte	0x1
	.long	0x11aa
	.quad	.LFB101
	.quad	.LFE101
	.long	.LLST88
	.uleb128 0x28
	.long	.LASF53
	.byte	0x1
	.value	0x6cc
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x27
	.string	"src"
	.byte	0x1
	.value	0x6cc
	.long	0x14a2
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x6cd
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF13
	.byte	0x1
	.value	0x6cd
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x6ce
	.long	0xaff
	.byte	0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x6d0
	.long	0x5123
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x6d1
	.long	0x50ec
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11737
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d80
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11738
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x5129
	.uleb128 0x2b
	.long	0x514d
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x3d0
	.uleb128 0x2c
	.long	0x14a2
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0xaff
	.byte	0x0
	.uleb128 0x25
	.long	0x51e2
	.byte	0x1
	.string	"cudaMemcpyToSymbol"
	.byte	0x1
	.value	0x6e1
	.byte	0x1
	.long	0x11aa
	.quad	.LFB102
	.quad	.LFE102
	.long	.LLST89
	.uleb128 0x28
	.long	.LASF53
	.byte	0x1
	.value	0x6df
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x27
	.string	"src"
	.byte	0x1
	.value	0x6df
	.long	0x14a2
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x6e0
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF13
	.byte	0x1
	.value	0x6e0
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x6e1
	.long	0xaff
	.byte	0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d7b
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11758
	.byte	0x0
	.uleb128 0x25
	.long	0x5299
	.byte	0x1
	.string	"rcudaMemcpyFromSymbol"
	.byte	0x1
	.value	0x6f0
	.byte	0x1
	.long	0x11aa
	.quad	.LFB103
	.quad	.LFE103
	.long	.LLST90
	.uleb128 0x27
	.string	"dst"
	.byte	0x1
	.value	0x6ee
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF53
	.byte	0x1
	.value	0x6ee
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x6ef
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF13
	.byte	0x1
	.value	0x6ef
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x6f0
	.long	0xaff
	.byte	0x3
	.byte	0x91
	.sleb128 -68
	.uleb128 0x2a
	.long	.LASF27
	.byte	0x1
	.value	0x6f1
	.long	0x1f41
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x2a
	.long	.LASF20
	.byte	0x1
	.value	0x6f4
	.long	0x135
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d76
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11776
	.byte	0x0
	.uleb128 0x25
	.long	0x5353
	.byte	0x1
	.string	"lcudaMemcpyFromSymbol"
	.byte	0x1
	.value	0x728
	.byte	0x1
	.long	0x11aa
	.quad	.LFB104
	.quad	.LFE104
	.long	.LLST91
	.uleb128 0x27
	.string	"dst"
	.byte	0x1
	.value	0x726
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF53
	.byte	0x1
	.value	0x726
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x727
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF13
	.byte	0x1
	.value	0x727
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x728
	.long	0xaff
	.byte	0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x72a
	.long	0x5353
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x72b
	.long	0x531c
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11820
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d71
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11821
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x5359
	.uleb128 0x2b
	.long	0x537d
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x133
	.uleb128 0x2c
	.long	0x3d0
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0xaff
	.byte	0x0
	.uleb128 0x25
	.long	0x5414
	.byte	0x1
	.string	"cudaMemcpyFromSymbol"
	.byte	0x1
	.value	0x73b
	.byte	0x1
	.long	0x11aa
	.quad	.LFB105
	.quad	.LFE105
	.long	.LLST92
	.uleb128 0x27
	.string	"dst"
	.byte	0x1
	.value	0x739
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF53
	.byte	0x1
	.value	0x739
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x73a
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF13
	.byte	0x1
	.value	0x73a
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x73b
	.long	0xaff
	.byte	0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d6c
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11841
	.byte	0x0
	.uleb128 0x25
	.long	0x54c8
	.byte	0x1
	.string	"cudaMemcpyAsync"
	.byte	0x1
	.value	0x747
	.byte	0x1
	.long	0x11aa
	.quad	.LFB106
	.quad	.LFE106
	.long	.LLST93
	.uleb128 0x27
	.string	"dst"
	.byte	0x1
	.value	0x746
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x27
	.string	"src"
	.byte	0x1
	.value	0x746
	.long	0x14a2
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x746
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x747
	.long	0xaff
	.byte	0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x28
	.long	.LASF36
	.byte	0x1
	.value	0x747
	.long	0x11be
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x749
	.long	0x54c8
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x74a
	.long	0x5491
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11863
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d67
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11864
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x54ce
	.uleb128 0x2b
	.long	0x54f2
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x133
	.uleb128 0x2c
	.long	0x14a2
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0xaff
	.uleb128 0x2c
	.long	0x11be
	.byte	0x0
	.uleb128 0x25
	.long	0x55cc
	.byte	0x1
	.string	"cudaMemcpyToArrayAsync"
	.byte	0x1
	.value	0x75a
	.byte	0x1
	.long	0x11aa
	.quad	.LFB107
	.quad	.LFE107
	.long	.LLST94
	.uleb128 0x27
	.string	"dst"
	.byte	0x1
	.value	0x758
	.long	0xcf3
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF45
	.byte	0x1
	.value	0x759
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF46
	.byte	0x1
	.value	0x759
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x27
	.string	"src"
	.byte	0x1
	.value	0x759
	.long	0x14a2
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x759
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x75a
	.long	0xaff
	.byte	0x3
	.byte	0x91
	.sleb128 -68
	.uleb128 0x28
	.long	.LASF36
	.byte	0x1
	.value	0x75a
	.long	0x11be
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x75d
	.long	0x55cc
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x75e
	.long	0x5595
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11894
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d62
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11895
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x55d2
	.uleb128 0x2b
	.long	0x5600
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0xcf3
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x14a2
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0xaff
	.uleb128 0x2c
	.long	0x11be
	.byte	0x0
	.uleb128 0x25
	.long	0x56dc
	.byte	0x1
	.string	"cudaMemcpyFromArrayAsync"
	.byte	0x1
	.value	0x76e
	.byte	0x1
	.long	0x11aa
	.quad	.LFB108
	.quad	.LFE108
	.long	.LLST95
	.uleb128 0x27
	.string	"dst"
	.byte	0x1
	.value	0x76c
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x27
	.string	"src"
	.byte	0x1
	.value	0x76d
	.long	0x49de
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF45
	.byte	0x1
	.value	0x76d
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF46
	.byte	0x1
	.value	0x76d
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x76e
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x76e
	.long	0xaff
	.byte	0x3
	.byte	0x91
	.sleb128 -68
	.uleb128 0x28
	.long	.LASF36
	.byte	0x1
	.value	0x76e
	.long	0x11be
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x771
	.long	0x56dc
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x772
	.long	0x56a5
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11925
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d5d
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11926
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x56e2
	.uleb128 0x2b
	.long	0x5710
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x133
	.uleb128 0x2c
	.long	0x49de
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0xaff
	.uleb128 0x2c
	.long	0x11be
	.byte	0x0
	.uleb128 0x25
	.long	0x57f4
	.byte	0x1
	.string	"cudaMemcpy2DAsync"
	.byte	0x1
	.value	0x782
	.byte	0x1
	.long	0x11aa
	.quad	.LFB109
	.quad	.LFE109
	.long	.LLST96
	.uleb128 0x27
	.string	"dst"
	.byte	0x1
	.value	0x780
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF51
	.byte	0x1
	.value	0x780
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x27
	.string	"src"
	.byte	0x1
	.value	0x780
	.long	0x14a2
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF52
	.byte	0x1
	.value	0x781
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF3
	.byte	0x1
	.value	0x781
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x28
	.long	.LASF4
	.byte	0x1
	.value	0x781
	.long	0x81
	.byte	0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x781
	.long	0xaff
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x28
	.long	.LASF36
	.byte	0x1
	.value	0x782
	.long	0x11be
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x785
	.long	0x57f4
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x786
	.long	0x57bd
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11958
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d58
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11959
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x57fa
	.uleb128 0x2b
	.long	0x582d
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x133
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x14a2
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0xaff
	.uleb128 0x2c
	.long	0x11be
	.byte	0x0
	.uleb128 0x25
	.long	0x5927
	.byte	0x1
	.string	"cudaMemcpy2DToArrayAsync"
	.byte	0x1
	.value	0x797
	.byte	0x1
	.long	0x11aa
	.quad	.LFB110
	.quad	.LFE110
	.long	.LLST97
	.uleb128 0x27
	.string	"dst"
	.byte	0x1
	.value	0x794
	.long	0xcf3
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF45
	.byte	0x1
	.value	0x795
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF46
	.byte	0x1
	.value	0x795
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x27
	.string	"src"
	.byte	0x1
	.value	0x795
	.long	0x14a2
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF52
	.byte	0x1
	.value	0x795
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x28
	.long	.LASF3
	.byte	0x1
	.value	0x796
	.long	0x81
	.byte	0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x28
	.long	.LASF4
	.byte	0x1
	.value	0x796
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x796
	.long	0xaff
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x28
	.long	.LASF36
	.byte	0x1
	.value	0x797
	.long	0x11be
	.byte	0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x79a
	.long	0x5927
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x79b
	.long	0x58f0
	.byte	0x9
	.byte	0x3
	.quad	pFunc.11993
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d53
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.11994
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x592d
	.uleb128 0x2b
	.long	0x5965
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0xcf3
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x14a2
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0xaff
	.uleb128 0x2c
	.long	0x11be
	.byte	0x0
	.uleb128 0x25
	.long	0x5a61
	.byte	0x1
	.string	"cudaMemcpy2DFromArrayAsync"
	.byte	0x1
	.value	0x7ad
	.byte	0x1
	.long	0x11aa
	.quad	.LFB111
	.quad	.LFE111
	.long	.LLST98
	.uleb128 0x27
	.string	"dst"
	.byte	0x1
	.value	0x7aa
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF51
	.byte	0x1
	.value	0x7aa
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x27
	.string	"src"
	.byte	0x1
	.value	0x7ab
	.long	0x49de
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF45
	.byte	0x1
	.value	0x7ab
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF46
	.byte	0x1
	.value	0x7ab
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x28
	.long	.LASF3
	.byte	0x1
	.value	0x7ac
	.long	0x81
	.byte	0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x28
	.long	.LASF4
	.byte	0x1
	.value	0x7ac
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x7ac
	.long	0xaff
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x28
	.long	.LASF36
	.byte	0x1
	.value	0x7ad
	.long	0x11be
	.byte	0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x7b1
	.long	0x5a61
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x7b2
	.long	0x5a2a
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12028
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d4e
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12029
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x5a67
	.uleb128 0x2b
	.long	0x5a9f
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x133
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x49de
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0xaff
	.uleb128 0x2c
	.long	0x11be
	.byte	0x0
	.uleb128 0x25
	.long	0x5b6a
	.byte	0x1
	.string	"cudaMemcpyToSymbolAsync"
	.byte	0x1
	.value	0x7c3
	.byte	0x1
	.long	0x11aa
	.quad	.LFB112
	.quad	.LFE112
	.long	.LLST99
	.uleb128 0x28
	.long	.LASF53
	.byte	0x1
	.value	0x7c1
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x27
	.string	"src"
	.byte	0x1
	.value	0x7c1
	.long	0x14a2
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x7c2
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF13
	.byte	0x1
	.value	0x7c2
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x7c2
	.long	0xaff
	.byte	0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x28
	.long	.LASF36
	.byte	0x1
	.value	0x7c3
	.long	0x11be
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x7c6
	.long	0x5b6a
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x7c7
	.long	0x5b33
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12057
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d49
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12058
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x5b70
	.uleb128 0x2b
	.long	0x5b99
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x3d0
	.uleb128 0x2c
	.long	0x14a2
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0xaff
	.uleb128 0x2c
	.long	0x11be
	.byte	0x0
	.uleb128 0x25
	.long	0x5c66
	.byte	0x1
	.string	"cudaMemcpyFromSymbolAsync"
	.byte	0x1
	.value	0x7d7
	.byte	0x1
	.long	0x11aa
	.quad	.LFB113
	.quad	.LFE113
	.long	.LLST100
	.uleb128 0x27
	.string	"dst"
	.byte	0x1
	.value	0x7d5
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF53
	.byte	0x1
	.value	0x7d5
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x7d6
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF13
	.byte	0x1
	.value	0x7d6
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF6
	.byte	0x1
	.value	0x7d6
	.long	0xaff
	.byte	0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x28
	.long	.LASF36
	.byte	0x1
	.value	0x7d7
	.long	0x11be
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x7da
	.long	0x5c66
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x7db
	.long	0x5c2f
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12086
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d44
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12087
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x5c6c
	.uleb128 0x2b
	.long	0x5c95
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x133
	.uleb128 0x2c
	.long	0x3d0
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0xaff
	.uleb128 0x2c
	.long	0x11be
	.byte	0x0
	.uleb128 0x25
	.long	0x5d26
	.byte	0x1
	.string	"cudaMemset"
	.byte	0x1
	.value	0x7ea
	.byte	0x1
	.long	0x11aa
	.quad	.LFB114
	.quad	.LFE114
	.long	.LLST101
	.uleb128 0x28
	.long	.LASF41
	.byte	0x1
	.value	0x7ea
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF32
	.byte	0x1
	.value	0x7ea
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x7ea
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x7eb
	.long	0x5d26
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x7ec
	.long	0x5cef
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12109
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d2f
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12110
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x5d2c
	.uleb128 0x2b
	.long	0x5d46
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x133
	.uleb128 0x2c
	.long	0xe9
	.uleb128 0x2c
	.long	0x81
	.byte	0x0
	.uleb128 0x25
	.long	0x5df7
	.byte	0x1
	.string	"cudaMemset2D"
	.byte	0x1
	.value	0x7fb
	.byte	0x1
	.long	0x11aa
	.quad	.LFB115
	.quad	.LFE115
	.long	.LLST102
	.uleb128 0x28
	.long	.LASF41
	.byte	0x1
	.value	0x7fa
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF2
	.byte	0x1
	.value	0x7fa
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF32
	.byte	0x1
	.value	0x7fa
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x28
	.long	.LASF3
	.byte	0x1
	.value	0x7fb
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF4
	.byte	0x1
	.value	0x7fb
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x7fd
	.long	0x5df7
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x7fe
	.long	0x5dc0
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12136
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d1a
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12137
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x5dfd
	.uleb128 0x2b
	.long	0x5e21
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x133
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0xe9
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.byte	0x0
	.uleb128 0x25
	.long	0x5eb4
	.byte	0x1
	.string	"cudaMemset3D"
	.byte	0x1
	.value	0x80c
	.byte	0x1
	.long	0x11aa
	.quad	.LFB116
	.quad	.LFE116
	.long	.LLST103
	.uleb128 0x28
	.long	.LASF44
	.byte	0x1
	.value	0x80b
	.long	0xb7b
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x28
	.long	.LASF32
	.byte	0x1
	.value	0x80b
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x28
	.long	.LASF5
	.byte	0x1
	.value	0x80c
	.long	0xbcf
	.byte	0x2
	.byte	0x91
	.sleb128 32
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x80e
	.long	0x5eb4
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x80f
	.long	0x5e7d
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12159
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d15
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12160
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x5eba
	.uleb128 0x2b
	.long	0x5ed4
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0xb7b
	.uleb128 0x2c
	.long	0xe9
	.uleb128 0x2c
	.long	0xbcf
	.byte	0x0
	.uleb128 0x25
	.long	0x5f79
	.byte	0x1
	.string	"cudaMemsetAsync"
	.byte	0x1
	.value	0x81d
	.byte	0x1
	.long	0x11aa
	.quad	.LFB117
	.quad	.LFE117
	.long	.LLST104
	.uleb128 0x28
	.long	.LASF41
	.byte	0x1
	.value	0x81c
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF32
	.byte	0x1
	.value	0x81c
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x81c
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF36
	.byte	0x1
	.value	0x81d
	.long	0x11be
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x81f
	.long	0x5f79
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x820
	.long	0x5f42
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12184
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7d00
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12185
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x5f7f
	.uleb128 0x2b
	.long	0x5f9e
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x133
	.uleb128 0x2c
	.long	0xe9
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x11be
	.byte	0x0
	.uleb128 0x25
	.long	0x6063
	.byte	0x1
	.string	"cudaMemset2DAsync"
	.byte	0x1
	.value	0x82e
	.byte	0x1
	.long	0x11aa
	.quad	.LFB118
	.quad	.LFE118
	.long	.LLST105
	.uleb128 0x28
	.long	.LASF41
	.byte	0x1
	.value	0x82d
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF2
	.byte	0x1
	.value	0x82d
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF32
	.byte	0x1
	.value	0x82d
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x28
	.long	.LASF3
	.byte	0x1
	.value	0x82e
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF4
	.byte	0x1
	.value	0x82e
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF36
	.byte	0x1
	.value	0x82e
	.long	0x11be
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x830
	.long	0x6063
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x831
	.long	0x602c
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12213
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7cfb
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12214
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x6069
	.uleb128 0x2b
	.long	0x6092
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x133
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0xe9
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x11be
	.byte	0x0
	.uleb128 0x25
	.long	0x6139
	.byte	0x1
	.string	"cudaMemset3DAsync"
	.byte	0x1
	.value	0x83f
	.byte	0x1
	.long	0x11aa
	.quad	.LFB119
	.quad	.LFE119
	.long	.LLST106
	.uleb128 0x28
	.long	.LASF44
	.byte	0x1
	.value	0x83e
	.long	0xb7b
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x28
	.long	.LASF32
	.byte	0x1
	.value	0x83f
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x28
	.long	.LASF5
	.byte	0x1
	.value	0x83f
	.long	0xbcf
	.byte	0x2
	.byte	0x91
	.sleb128 32
	.uleb128 0x28
	.long	.LASF36
	.byte	0x1
	.value	0x83f
	.long	0x11be
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x841
	.long	0x6139
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x842
	.long	0x6102
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12238
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7cf6
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12239
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x613f
	.uleb128 0x2b
	.long	0x615e
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0xb7b
	.uleb128 0x2c
	.long	0xe9
	.uleb128 0x2c
	.long	0xbcf
	.uleb128 0x2c
	.long	0x11be
	.byte	0x0
	.uleb128 0x25
	.long	0x61ea
	.byte	0x1
	.string	"cudaGetSymbolAddress"
	.byte	0x1
	.value	0x850
	.byte	0x1
	.long	0x11aa
	.quad	.LFB120
	.quad	.LFE120
	.long	.LLST107
	.uleb128 0x28
	.long	.LASF41
	.byte	0x1
	.value	0x850
	.long	0x3db
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF53
	.byte	0x1
	.value	0x850
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x851
	.long	0x61ea
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x852
	.long	0x61b3
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12259
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7cf1
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12260
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x61f0
	.uleb128 0x2b
	.long	0x6205
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x3db
	.uleb128 0x2c
	.long	0x3d0
	.byte	0x0
	.uleb128 0x25
	.long	0x628e
	.byte	0x1
	.string	"cudaGetSymbolSize"
	.byte	0x1
	.value	0x860
	.byte	0x1
	.long	0x11aa
	.quad	.LFB121
	.quad	.LFE121
	.long	.LLST108
	.uleb128 0x28
	.long	.LASF11
	.byte	0x1
	.value	0x860
	.long	0x3ca
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF53
	.byte	0x1
	.value	0x860
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x861
	.long	0x628e
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x862
	.long	0x6257
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12280
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7cec
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12281
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x6294
	.uleb128 0x2b
	.long	0x62a9
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x3ca
	.uleb128 0x2c
	.long	0x3d0
	.byte	0x0
	.uleb128 0x25
	.long	0x6330
	.byte	0x1
	.string	"cudaGraphicsUnregisterResource"
	.byte	0x1
	.value	0x872
	.byte	0x1
	.long	0x11aa
	.quad	.LFB122
	.quad	.LFE122
	.long	.LLST109
	.uleb128 0x28
	.long	.LASF54
	.byte	0x1
	.value	0x872
	.long	0x6347
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x873
	.long	0x634d
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x874
	.long	0x62f9
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12299
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7ce7
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12300
	.byte	0x0
	.uleb128 0x12
	.string	"cudaGraphicsResource"
	.byte	0x1
	.uleb128 0x8
	.byte	0x8
	.long	0x6330
	.uleb128 0x8
	.byte	0x8
	.long	0x6353
	.uleb128 0x2b
	.long	0x6363
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x6347
	.byte	0x0
	.uleb128 0x25
	.long	0x63fa
	.byte	0x1
	.string	"cudaGraphicsResourceSetMapFlags"
	.byte	0x1
	.value	0x882
	.byte	0x1
	.long	0x11aa
	.quad	.LFB123
	.quad	.LFE123
	.long	.LLST110
	.uleb128 0x28
	.long	.LASF54
	.byte	0x1
	.value	0x882
	.long	0x6347
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF12
	.byte	0x1
	.value	0x882
	.long	0xbd
	.byte	0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x884
	.long	0x63fa
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x885
	.long	0x63c3
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12320
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7cd2
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12321
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x6400
	.uleb128 0x2b
	.long	0x6415
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x6347
	.uleb128 0x2c
	.long	0xbd
	.byte	0x0
	.uleb128 0x25
	.long	0x64b4
	.byte	0x1
	.string	"cudaGraphicsMapResources"
	.byte	0x1
	.value	0x893
	.byte	0x1
	.long	0x11aa
	.quad	.LFB124
	.quad	.LFE124
	.long	.LLST111
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x892
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x28
	.long	.LASF55
	.byte	0x1
	.value	0x893
	.long	0x64b4
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF36
	.byte	0x1
	.value	0x893
	.long	0x11be
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x895
	.long	0x64ba
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x896
	.long	0x647d
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12343
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7ccd
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12344
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x6347
	.uleb128 0x8
	.byte	0x8
	.long	0x64c0
	.uleb128 0x2b
	.long	0x64da
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0xe9
	.uleb128 0x2c
	.long	0x64b4
	.uleb128 0x2c
	.long	0x11be
	.byte	0x0
	.uleb128 0x25
	.long	0x657b
	.byte	0x1
	.string	"cudaGraphicsUnmapResources"
	.byte	0x1
	.value	0x8a4
	.byte	0x1
	.long	0x11aa
	.quad	.LFB125
	.quad	.LFE125
	.long	.LLST112
	.uleb128 0x28
	.long	.LASF34
	.byte	0x1
	.value	0x8a3
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x28
	.long	.LASF55
	.byte	0x1
	.value	0x8a4
	.long	0x64b4
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF36
	.byte	0x1
	.value	0x8a4
	.long	0x11be
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x8a6
	.long	0x64ba
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x8a7
	.long	0x6544
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12366
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7cc8
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12367
	.byte	0x0
	.uleb128 0x25
	.long	0x6626
	.byte	0x1
	.string	"cudaGraphicsResourceGetMappedPointer"
	.byte	0x1
	.value	0x8b5
	.byte	0x1
	.long	0x11aa
	.quad	.LFB126
	.quad	.LFE126
	.long	.LLST113
	.uleb128 0x28
	.long	.LASF41
	.byte	0x1
	.value	0x8b4
	.long	0x3db
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF11
	.byte	0x1
	.value	0x8b5
	.long	0x3ca
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF54
	.byte	0x1
	.value	0x8b5
	.long	0x6347
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x8b7
	.long	0x6626
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x8b8
	.long	0x65ef
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12389
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7cc3
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12390
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x662c
	.uleb128 0x2b
	.long	0x6646
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x3db
	.uleb128 0x2c
	.long	0x3ca
	.uleb128 0x2c
	.long	0x6347
	.byte	0x0
	.uleb128 0x25
	.long	0x670d
	.byte	0x1
	.string	"cudaGraphicsSubResourceGetMappedArray"
	.byte	0x1
	.value	0x8c8
	.byte	0x1
	.long	0x11aa
	.quad	.LFB127
	.quad	.LFE127
	.long	.LLST114
	.uleb128 0x28
	.long	.LASF42
	.byte	0x1
	.value	0x8c7
	.long	0x3e57
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF54
	.byte	0x1
	.value	0x8c7
	.long	0x6347
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x27
	.string	"arrayIndex"
	.byte	0x1
	.value	0x8c8
	.long	0xbd
	.byte	0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x27
	.string	"mipLevel"
	.byte	0x1
	.value	0x8c8
	.long	0xbd
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x8cb
	.long	0x670d
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x8cc
	.long	0x66d6
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12414
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7cae
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12415
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x6713
	.uleb128 0x2b
	.long	0x6732
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x3e57
	.uleb128 0x2c
	.long	0x6347
	.uleb128 0x2c
	.long	0xbd
	.uleb128 0x2c
	.long	0xbd
	.byte	0x0
	.uleb128 0x25
	.long	0x67bc
	.byte	0x1
	.string	"cudaGetChannelDesc"
	.byte	0x1
	.value	0x8dd
	.byte	0x1
	.long	0x11aa
	.quad	.LFB128
	.quad	.LFE128
	.long	.LLST115
	.uleb128 0x28
	.long	.LASF43
	.byte	0x1
	.value	0x8dc
	.long	0x1a8e
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF42
	.byte	0x1
	.value	0x8dd
	.long	0x49de
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x8df
	.long	0x67bc
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x8e0
	.long	0x6785
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12435
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7c99
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12436
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x67c2
	.uleb128 0x2b
	.long	0x67d7
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x1a8e
	.uleb128 0x2c
	.long	0x49de
	.byte	0x0
	.uleb128 0x25
	.long	0x68ad
	.byte	0x1
	.string	"cudaCreateChannelDesc"
	.byte	0x1
	.value	0x8f5
	.byte	0x1
	.long	0xaa4
	.quad	.LFB129
	.quad	.LFE129
	.long	.LLST116
	.uleb128 0x27
	.string	"x"
	.byte	0x1
	.value	0x8f4
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x27
	.string	"y"
	.byte	0x1
	.value	0x8f4
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x27
	.string	"z"
	.byte	0x1
	.value	0x8f4
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -60
	.uleb128 0x27
	.string	"w"
	.byte	0x1
	.value	0x8f5
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x27
	.string	"f"
	.byte	0x1
	.value	0x8f5
	.long	0xa0e
	.byte	0x3
	.byte	0x91
	.sleb128 -68
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x8f7
	.long	0x68ad
	.uleb128 0x2e
	.long	0x6882
	.quad	.LBB2
	.quad	.LBE2
	.uleb128 0x2a
	.long	.LASF43
	.byte	0x1
	.value	0x8fe
	.long	0xaa4
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.byte	0x0
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x8f8
	.long	0x6851
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12462
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7c94
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12464
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x68b3
	.uleb128 0x2b
	.long	0x68d7
	.byte	0x1
	.long	0xaa4
	.uleb128 0x2c
	.long	0xe9
	.uleb128 0x2c
	.long	0xe9
	.uleb128 0x2c
	.long	0xe9
	.uleb128 0x2c
	.long	0xe9
	.uleb128 0x2c
	.long	0xa0e
	.byte	0x0
	.uleb128 0x25
	.long	0x698b
	.byte	0x1
	.string	"cudaBindTexture"
	.byte	0x1
	.value	0x90d
	.byte	0x1
	.long	0x11aa
	.quad	.LFB130
	.quad	.LFE130
	.long	.LLST117
	.uleb128 0x28
	.long	.LASF13
	.byte	0x1
	.value	0x90b
	.long	0x3ca
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF56
	.byte	0x1
	.value	0x90c
	.long	0x698b
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF41
	.byte	0x1
	.value	0x90c
	.long	0x14a2
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF43
	.byte	0x1
	.value	0x90d
	.long	0x3e5d
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF11
	.byte	0x1
	.value	0x90d
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x910
	.long	0x6996
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x911
	.long	0x6954
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12491
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7c8f
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12492
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x6991
	.uleb128 0xb
	.long	0x131e
	.uleb128 0x8
	.byte	0x8
	.long	0x699c
	.uleb128 0x2b
	.long	0x69c0
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x3ca
	.uleb128 0x2c
	.long	0x698b
	.uleb128 0x2c
	.long	0x14a2
	.uleb128 0x2c
	.long	0x3e5d
	.uleb128 0x2c
	.long	0x81
	.byte	0x0
	.uleb128 0x25
	.long	0x6a95
	.byte	0x1
	.string	"cudaBindTexture2D"
	.byte	0x1
	.value	0x922
	.byte	0x1
	.long	0x11aa
	.quad	.LFB131
	.quad	.LFE131
	.long	.LLST118
	.uleb128 0x28
	.long	.LASF13
	.byte	0x1
	.value	0x91f
	.long	0x3ca
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF56
	.byte	0x1
	.value	0x920
	.long	0x698b
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF41
	.byte	0x1
	.value	0x920
	.long	0x14a2
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF43
	.byte	0x1
	.value	0x921
	.long	0x3e5d
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF3
	.byte	0x1
	.value	0x921
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x28
	.long	.LASF4
	.byte	0x1
	.value	0x921
	.long	0x81
	.byte	0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x28
	.long	.LASF2
	.byte	0x1
	.value	0x922
	.long	0x81
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x926
	.long	0x6a95
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x927
	.long	0x6a5e
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12522
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7c8a
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12523
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x6a9b
	.uleb128 0x2b
	.long	0x6ac9
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x3ca
	.uleb128 0x2c
	.long	0x698b
	.uleb128 0x2c
	.long	0x14a2
	.uleb128 0x2c
	.long	0x3e5d
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.uleb128 0x2c
	.long	0x81
	.byte	0x0
	.uleb128 0x25
	.long	0x6b66
	.byte	0x1
	.string	"cudaBindTextureToArray"
	.byte	0x1
	.value	0x936
	.byte	0x1
	.long	0x11aa
	.quad	.LFB132
	.quad	.LFE132
	.long	.LLST119
	.uleb128 0x28
	.long	.LASF56
	.byte	0x1
	.value	0x935
	.long	0x698b
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF42
	.byte	0x1
	.value	0x935
	.long	0x49de
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF43
	.byte	0x1
	.value	0x936
	.long	0x3e5d
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x939
	.long	0x6b66
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x93a
	.long	0x6b2f
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12545
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7c85
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12546
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x6b6c
	.uleb128 0x2b
	.long	0x6b86
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x698b
	.uleb128 0x2c
	.long	0x49de
	.uleb128 0x2c
	.long	0x3e5d
	.byte	0x0
	.uleb128 0x25
	.long	0x6c00
	.byte	0x1
	.string	"cudaUnbindTexture"
	.byte	0x1
	.value	0x948
	.byte	0x1
	.long	0x11aa
	.quad	.LFB133
	.quad	.LFE133
	.long	.LLST120
	.uleb128 0x28
	.long	.LASF56
	.byte	0x1
	.value	0x948
	.long	0x698b
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x949
	.long	0x6c00
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x94a
	.long	0x6bc9
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12564
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7c80
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12565
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x6c06
	.uleb128 0x2b
	.long	0x6c16
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x698b
	.byte	0x0
	.uleb128 0x25
	.long	0x6cab
	.byte	0x1
	.string	"cudaGetTextureAlignmentOffset"
	.byte	0x1
	.value	0x959
	.byte	0x1
	.long	0x11aa
	.quad	.LFB134
	.quad	.LFE134
	.long	.LLST121
	.uleb128 0x28
	.long	.LASF13
	.byte	0x1
	.value	0x958
	.long	0x3ca
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF56
	.byte	0x1
	.value	0x959
	.long	0x698b
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x95b
	.long	0x6cab
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x95c
	.long	0x6c74
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12585
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7c6b
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12586
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x6cb1
	.uleb128 0x2b
	.long	0x6cc6
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x3ca
	.uleb128 0x2c
	.long	0x698b
	.byte	0x0
	.uleb128 0x25
	.long	0x6d55
	.byte	0x1
	.string	"cudaGetTextureReference"
	.byte	0x1
	.value	0x96a
	.byte	0x1
	.long	0x11aa
	.quad	.LFB135
	.quad	.LFE135
	.long	.LLST122
	.uleb128 0x28
	.long	.LASF56
	.byte	0x1
	.value	0x96a
	.long	0x6d55
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF53
	.byte	0x1
	.value	0x96a
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x96c
	.long	0x6d5b
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x96d
	.long	0x6d1e
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12606
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7c56
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12607
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x698b
	.uleb128 0x8
	.byte	0x8
	.long	0x6d61
	.uleb128 0x2b
	.long	0x6d76
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x6d55
	.uleb128 0x2c
	.long	0x3d0
	.byte	0x0
	.uleb128 0x25
	.long	0x6e17
	.byte	0x1
	.string	"cudaBindSurfaceToArray"
	.byte	0x1
	.value	0x97f
	.byte	0x1
	.long	0x11aa
	.quad	.LFB136
	.quad	.LFE136
	.long	.LLST123
	.uleb128 0x27
	.string	"surfref"
	.byte	0x1
	.value	0x97e
	.long	0x6e17
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF42
	.byte	0x1
	.value	0x97e
	.long	0x49de
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF43
	.byte	0x1
	.value	0x97f
	.long	0x3e5d
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x982
	.long	0x6e22
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x983
	.long	0x6de0
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12629
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7c51
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12630
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x6e1d
	.uleb128 0xb
	.long	0x1245
	.uleb128 0x8
	.byte	0x8
	.long	0x6e28
	.uleb128 0x2b
	.long	0x6e42
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x6e17
	.uleb128 0x2c
	.long	0x49de
	.uleb128 0x2c
	.long	0x3e5d
	.byte	0x0
	.uleb128 0x25
	.long	0x6ed5
	.byte	0x1
	.string	"cudaGetSurfaceReference"
	.byte	0x1
	.value	0x992
	.byte	0x1
	.long	0x11aa
	.quad	.LFB137
	.quad	.LFE137
	.long	.LLST124
	.uleb128 0x27
	.string	"surfref"
	.byte	0x1
	.value	0x992
	.long	0x6ed5
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF53
	.byte	0x1
	.value	0x992
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x994
	.long	0x6edb
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x995
	.long	0x6e9e
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12650
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7c3c
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12651
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x6e17
	.uleb128 0x8
	.byte	0x8
	.long	0x6ee1
	.uleb128 0x2b
	.long	0x6ef6
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x6ed5
	.uleb128 0x2c
	.long	0x3d0
	.byte	0x0
	.uleb128 0x25
	.long	0x6f7d
	.byte	0x1
	.string	"cudaDriverGetVersion"
	.byte	0x1
	.value	0x9a4
	.byte	0x1
	.long	0x11aa
	.quad	.LFB138
	.quad	.LFE138
	.long	.LLST125
	.uleb128 0x27
	.string	"driverVersion"
	.byte	0x1
	.value	0x9a4
	.long	0x147b
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x9a5
	.long	0x270f
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x9a6
	.long	0x6f46
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12669
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7c37
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12670
	.byte	0x0
	.uleb128 0x25
	.long	0x7006
	.byte	0x1
	.string	"cudaRuntimeGetVersion"
	.byte	0x1
	.value	0x9b4
	.byte	0x1
	.long	0x11aa
	.quad	.LFB139
	.quad	.LFE139
	.long	.LLST126
	.uleb128 0x27
	.string	"runtimeVersion"
	.byte	0x1
	.value	0x9b4
	.long	0x147b
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x9b5
	.long	0x270f
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x9b6
	.long	0x6fcf
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12688
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7c32
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12689
	.byte	0x0
	.uleb128 0x25
	.long	0x70a5
	.byte	0x1
	.string	"cudaGetExportTable"
	.byte	0x1
	.value	0x9c6
	.byte	0x1
	.long	0x11aa
	.quad	.LFB140
	.quad	.LFE140
	.long	.LLST127
	.uleb128 0x27
	.string	"ppExportTable"
	.byte	0x1
	.value	0x9c5
	.long	0x70a5
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x27
	.string	"pExportTableId"
	.byte	0x1
	.value	0x9c6
	.long	0x70ab
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0x9c8
	.long	0x70b6
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0x9c9
	.long	0x706e
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12709
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7c2d
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12710
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x14a2
	.uleb128 0x8
	.byte	0x8
	.long	0x70b1
	.uleb128 0xb
	.long	0x120e
	.uleb128 0x8
	.byte	0x8
	.long	0x70bc
	.uleb128 0x2b
	.long	0x70d1
	.byte	0x1
	.long	0x11aa
	.uleb128 0x2c
	.long	0x70a5
	.uleb128 0x2c
	.long	0x70ab
	.byte	0x0
	.uleb128 0x25
	.long	0x71a8
	.byte	0x1
	.string	"r__cudaRegisterFatBinary"
	.byte	0x1
	.value	0x9e5
	.byte	0x1
	.long	0x3db
	.quad	.LFB141
	.quad	.LFE141
	.long	.LLST128
	.uleb128 0x27
	.string	"fatC"
	.byte	0x1
	.value	0x9e5
	.long	0x133
	.byte	0x3
	.byte	0x91
	.sleb128 -104
	.uleb128 0x2a
	.long	.LASF27
	.byte	0x1
	.value	0x9e6
	.long	0x1f41
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x26
	.string	"entries_cached"
	.byte	0x1
	.value	0x9e9
	.long	0x1de9
	.byte	0x3
	.byte	0x91
	.sleb128 -96
	.uleb128 0x26
	.string	"fb_size"
	.byte	0x1
	.value	0x9eb
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x2a
	.long	.LASF14
	.byte	0x1
	.value	0x9ec
	.long	0x3db
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x26
	.string	"pSrcFatC"
	.byte	0x1
	.value	0x9f6
	.long	0x1d43
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x26
	.string	"pPackedFat"
	.byte	0x1
	.value	0x9f8
	.long	0x135
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7c28
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12733
	.byte	0x0
	.uleb128 0x25
	.long	0x721f
	.byte	0x1
	.string	"l__cudaRegisterFatBinary"
	.byte	0x1
	.value	0xa25
	.byte	0x1
	.long	0x3db
	.quad	.LFB142
	.quad	.LFE142
	.long	.LLST129
	.uleb128 0x27
	.string	"fatC"
	.byte	0x1
	.value	0xa25
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x26
	.string	"func"
	.byte	0x1
	.value	0xa27
	.long	0x7c0d
	.byte	0x9
	.byte	0x3
	.quad	func.12776
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7c23
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12777
	.byte	0x0
	.uleb128 0x25
	.long	0x727e
	.byte	0x1
	.string	"__cudaRegisterFatBinary"
	.byte	0x1
	.value	0xa35
	.byte	0x1
	.long	0x3db
	.quad	.LFB143
	.quad	.LFE143
	.long	.LLST130
	.uleb128 0x27
	.string	"fatC"
	.byte	0x1
	.value	0xa35
	.long	0x133
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7bf8
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12793
	.byte	0x0
	.uleb128 0x2f
	.long	0x72ea
	.byte	0x1
	.string	"r__cudaUnregisterFatBinary"
	.byte	0x1
	.value	0xa43
	.byte	0x1
	.quad	.LFB144
	.quad	.LFE144
	.long	.LLST131
	.uleb128 0x28
	.long	.LASF14
	.byte	0x1
	.value	0xa43
	.long	0x3db
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x2a
	.long	.LASF27
	.byte	0x1
	.value	0xa44
	.long	0x1f41
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7bf3
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12808
	.byte	0x0
	.uleb128 0x2f
	.long	0x7369
	.byte	0x1
	.string	"l__cudaUnregisterFatBinary"
	.byte	0x1
	.value	0xa61
	.byte	0x1
	.quad	.LFB145
	.quad	.LFE145
	.long	.LLST132
	.uleb128 0x28
	.long	.LASF14
	.byte	0x1
	.value	0xa61
	.long	0x3db
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0xa62
	.long	0x7369
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0xa63
	.long	0x7332
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12835
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7bee
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12836
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x736f
	.uleb128 0x2b
	.long	0x737f
	.byte	0x1
	.long	0x3db
	.uleb128 0x2c
	.long	0x3db
	.byte	0x0
	.uleb128 0x2f
	.long	0x73c7
	.byte	0x1
	.string	"__cudaUnregisterFatBinary"
	.byte	0x1
	.value	0xa71
	.byte	0x1
	.quad	.LFB146
	.quad	.LFE146
	.long	.LLST133
	.uleb128 0x28
	.long	.LASF14
	.byte	0x1
	.value	0xa71
	.long	0x3db
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.byte	0x0
	.uleb128 0x2f
	.long	0x74d9
	.byte	0x1
	.string	"r__cudaRegisterFunction"
	.byte	0x1
	.value	0xa7a
	.byte	0x1
	.quad	.LFB147
	.quad	.LFE147
	.long	.LLST134
	.uleb128 0x28
	.long	.LASF14
	.byte	0x1
	.value	0xa78
	.long	0x3db
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF15
	.byte	0x1
	.value	0xa78
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x28
	.long	.LASF16
	.byte	0x1
	.value	0xa79
	.long	0x135
	.byte	0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x28
	.long	.LASF17
	.byte	0x1
	.value	0xa79
	.long	0x3d0
	.byte	0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x28
	.long	.LASF18
	.byte	0x1
	.value	0xa79
	.long	0xe9
	.byte	0x3
	.byte	0x91
	.sleb128 -84
	.uleb128 0x27
	.string	"tid"
	.byte	0x1
	.value	0xa79
	.long	0x1929
	.byte	0x3
	.byte	0x91
	.sleb128 -96
	.uleb128 0x27
	.string	"bid"
	.byte	0x1
	.value	0xa7a
	.long	0x1929
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x27
	.string	"bDim"
	.byte	0x1
	.value	0xa7a
	.long	0x192f
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x27
	.string	"gDim"
	.byte	0x1
	.value	0xa7a
	.long	0x192f
	.byte	0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x28
	.long	.LASF19
	.byte	0x1
	.value	0xa7a
	.long	0x147b
	.byte	0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x2a
	.long	.LASF27
	.byte	0x1
	.value	0xa7b
	.long	0x1f41
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x2a
	.long	.LASF11
	.byte	0x1
	.value	0xa85
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x26
	.string	"p"
	.byte	0x1
	.value	0xa87
	.long	0x135
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7bd9
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12866
	.byte	0x0
	.uleb128 0x2f
	.long	0x75df
	.byte	0x1
	.string	"l__cudaRegisterFunction"
	.byte	0x1
	.value	0xaa5
	.byte	0x1
	.quad	.LFB148
	.quad	.LFE148
	.long	.LLST135
	.uleb128 0x28
	.long	.LASF14
	.byte	0x1
	.value	0xaa3
	.long	0x3db
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF15
	.byte	0x1
	.value	0xaa3
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF16
	.byte	0x1
	.value	0xaa4
	.long	0x135
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF17
	.byte	0x1
	.value	0xaa4
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF18
	.byte	0x1
	.value	0xaa4
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -60
	.uleb128 0x27
	.string	"tid"
	.byte	0x1
	.value	0xaa4
	.long	0x1929
	.byte	0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x27
	.string	"bid"
	.byte	0x1
	.value	0xaa5
	.long	0x1929
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x27
	.string	"bDim"
	.byte	0x1
	.value	0xaa5
	.long	0x192f
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x27
	.string	"gDim"
	.byte	0x1
	.value	0xaa5
	.long	0x192f
	.byte	0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x28
	.long	.LASF19
	.byte	0x1
	.value	0xaa5
	.long	0x147b
	.byte	0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0xaa8
	.long	0x75df
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0xaaa
	.long	0x75a8
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12917
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7bd4
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12918
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x75e5
	.uleb128 0x2b
	.long	0x7622
	.byte	0x1
	.long	0x3db
	.uleb128 0x2c
	.long	0x3db
	.uleb128 0x2c
	.long	0x3d0
	.uleb128 0x2c
	.long	0x135
	.uleb128 0x2c
	.long	0x3d0
	.uleb128 0x2c
	.long	0xe9
	.uleb128 0x2c
	.long	0x1929
	.uleb128 0x2c
	.long	0x1929
	.uleb128 0x2c
	.long	0x192f
	.uleb128 0x2c
	.long	0x192f
	.uleb128 0x2c
	.long	0x147b
	.byte	0x0
	.uleb128 0x2f
	.long	0x76f0
	.byte	0x1
	.string	"__cudaRegisterFunction"
	.byte	0x1
	.value	0xabb
	.byte	0x1
	.quad	.LFB149
	.quad	.LFE149
	.long	.LLST136
	.uleb128 0x28
	.long	.LASF14
	.byte	0x1
	.value	0xab9
	.long	0x3db
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF15
	.byte	0x1
	.value	0xab9
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF16
	.byte	0x1
	.value	0xaba
	.long	0x135
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF17
	.byte	0x1
	.value	0xaba
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF18
	.byte	0x1
	.value	0xaba
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x27
	.string	"tid"
	.byte	0x1
	.value	0xaba
	.long	0x1929
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x27
	.string	"bid"
	.byte	0x1
	.value	0xabb
	.long	0x1929
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x27
	.string	"bDim"
	.byte	0x1
	.value	0xabb
	.long	0x192f
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x27
	.string	"gDim"
	.byte	0x1
	.value	0xabb
	.long	0x192f
	.byte	0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x28
	.long	.LASF19
	.byte	0x1
	.value	0xabb
	.long	0x147b
	.byte	0x2
	.byte	0x91
	.sleb128 24
	.byte	0x0
	.uleb128 0x2f
	.long	0x77d2
	.byte	0x1
	.string	"l__cudaRegisterVar"
	.byte	0x1
	.value	0xac6
	.byte	0x1
	.quad	.LFB150
	.quad	.LFE150
	.long	.LLST137
	.uleb128 0x28
	.long	.LASF14
	.byte	0x1
	.value	0xac4
	.long	0x3db
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF20
	.byte	0x1
	.value	0xac4
	.long	0x135
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF21
	.byte	0x1
	.value	0xac5
	.long	0x135
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF17
	.byte	0x1
	.value	0xac5
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x27
	.string	"ext"
	.byte	0x1
	.value	0xac5
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -60
	.uleb128 0x27
	.string	"vsize"
	.byte	0x1
	.value	0xac5
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x28
	.long	.LASF22
	.byte	0x1
	.value	0xac6
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x28
	.long	.LASF23
	.byte	0x1
	.value	0xac6
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0xac9
	.long	0x77d2
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0xaca
	.long	0x779b
	.byte	0x9
	.byte	0x3
	.quad	pFunc.12963
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7bbf
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12964
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x77d8
	.uleb128 0x2b
	.long	0x780b
	.byte	0x1
	.long	0x3db
	.uleb128 0x2c
	.long	0x3db
	.uleb128 0x2c
	.long	0x135
	.uleb128 0x2c
	.long	0x135
	.uleb128 0x2c
	.long	0x3d0
	.uleb128 0x2c
	.long	0xe9
	.uleb128 0x2c
	.long	0xe9
	.uleb128 0x2c
	.long	0xe9
	.uleb128 0x2c
	.long	0xe9
	.byte	0x0
	.uleb128 0x2f
	.long	0x791e
	.byte	0x1
	.string	"r__cudaRegisterVar"
	.byte	0x1
	.value	0xadc
	.byte	0x1
	.quad	.LFB151
	.quad	.LFE151
	.long	.LLST138
	.uleb128 0x28
	.long	.LASF14
	.byte	0x1
	.value	0xada
	.long	0x3db
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF20
	.byte	0x1
	.value	0xada
	.long	0x135
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x28
	.long	.LASF21
	.byte	0x1
	.value	0xadb
	.long	0x135
	.byte	0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x28
	.long	.LASF17
	.byte	0x1
	.value	0xadb
	.long	0x3d0
	.byte	0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x27
	.string	"ext"
	.byte	0x1
	.value	0xadb
	.long	0xe9
	.byte	0x3
	.byte	0x91
	.sleb128 -84
	.uleb128 0x27
	.string	"vsize"
	.byte	0x1
	.value	0xadb
	.long	0xe9
	.byte	0x3
	.byte	0x91
	.sleb128 -88
	.uleb128 0x28
	.long	.LASF22
	.byte	0x1
	.value	0xadc
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x28
	.long	.LASF23
	.byte	0x1
	.value	0xadc
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x2a
	.long	.LASF27
	.byte	0x1
	.value	0xadd
	.long	0x1f41
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x2a
	.long	.LASF11
	.byte	0x1
	.value	0xae7
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x26
	.string	"p"
	.byte	0x1
	.value	0xae9
	.long	0x135
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7bb5
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.12985
	.uleb128 0x30
	.string	"__PRETTY_FUNCTION__"
	.long	0x7bba
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__PRETTY_FUNCTION__.12988
	.byte	0x0
	.uleb128 0x2f
	.long	0x79c9
	.byte	0x1
	.string	"__cudaRegisterVar"
	.byte	0x1
	.value	0xb1a
	.byte	0x1
	.quad	.LFB152
	.quad	.LFE152
	.long	.LLST139
	.uleb128 0x28
	.long	.LASF14
	.byte	0x1
	.value	0xb18
	.long	0x3db
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x28
	.long	.LASF20
	.byte	0x1
	.value	0xb18
	.long	0x135
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF21
	.byte	0x1
	.value	0xb19
	.long	0x135
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF17
	.byte	0x1
	.value	0xb19
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x27
	.string	"ext"
	.byte	0x1
	.value	0xb19
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x27
	.string	"vsize"
	.byte	0x1
	.value	0xb19
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x28
	.long	.LASF22
	.byte	0x1
	.value	0xb1a
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x28
	.long	.LASF23
	.byte	0x1
	.value	0xb1a
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.byte	0x0
	.uleb128 0x2f
	.long	0x7a9e
	.byte	0x1
	.string	"__cudaRegisterTexture"
	.byte	0x1
	.value	0xb28
	.byte	0x1
	.quad	.LFB153
	.quad	.LFE153
	.long	.LLST140
	.uleb128 0x28
	.long	.LASF14
	.byte	0x1
	.value	0xb26
	.long	0x3db
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF20
	.byte	0x1
	.value	0xb27
	.long	0x698b
	.byte	0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x28
	.long	.LASF21
	.byte	0x1
	.value	0xb27
	.long	0x70a5
	.byte	0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x28
	.long	.LASF17
	.byte	0x1
	.value	0xb28
	.long	0x3d0
	.byte	0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x27
	.string	"dim"
	.byte	0x1
	.value	0xb28
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -60
	.uleb128 0x27
	.string	"norm"
	.byte	0x1
	.value	0xb28
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x27
	.string	"ext"
	.byte	0x1
	.value	0xb28
	.long	0xe9
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0xb2b
	.long	0x7a9e
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0xb2c
	.long	0x7a67
	.byte	0x9
	.byte	0x3
	.quad	pFunc.13055
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7ba0
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.13056
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x7aa4
	.uleb128 0x2b
	.long	0x7ad2
	.byte	0x1
	.long	0x3db
	.uleb128 0x2c
	.long	0x3db
	.uleb128 0x2c
	.long	0x698b
	.uleb128 0x2c
	.long	0x70a5
	.uleb128 0x2c
	.long	0x3d0
	.uleb128 0x2c
	.long	0xe9
	.uleb128 0x2c
	.long	0xe9
	.uleb128 0x2c
	.long	0xe9
	.byte	0x0
	.uleb128 0x2f
	.long	0x7b60
	.byte	0x1
	.string	"__cudaRegisterShared"
	.byte	0x1
	.value	0xb3a
	.byte	0x1
	.quad	.LFB154
	.quad	.LFE154
	.long	.LLST141
	.uleb128 0x28
	.long	.LASF14
	.byte	0x1
	.value	0xb3a
	.long	0x3db
	.byte	0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x27
	.string	"devicePtr"
	.byte	0x1
	.value	0xb3a
	.long	0x3db
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x29
	.long	.LASF29
	.byte	0x1
	.value	0xb3b
	.long	0x7b60
	.uleb128 0x2a
	.long	.LASF30
	.byte	0x1
	.value	0xb3c
	.long	0x7b29
	.byte	0x9
	.byte	0x3
	.quad	pFunc.13073
	.uleb128 0x1e
	.long	.LASF25
	.long	0x7b8b
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	__FUNCTION__.13074
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x7b66
	.uleb128 0x2b
	.long	0x7b7b
	.byte	0x1
	.long	0x3db
	.uleb128 0x2c
	.long	0x3db
	.uleb128 0x2c
	.long	0x3db
	.byte	0x0
	.uleb128 0x5
	.long	0x7b8b
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0x14
	.byte	0x0
	.uleb128 0xb
	.long	0x7b7b
	.uleb128 0x5
	.long	0x7ba0
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0x15
	.byte	0x0
	.uleb128 0xb
	.long	0x7b90
	.uleb128 0x5
	.long	0x7bb5
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0x12
	.byte	0x0
	.uleb128 0xb
	.long	0x7ba5
	.uleb128 0xb
	.long	0x7ba5
	.uleb128 0xb
	.long	0x7ba5
	.uleb128 0x5
	.long	0x7bd4
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0x17
	.byte	0x0
	.uleb128 0xb
	.long	0x7bc4
	.uleb128 0xb
	.long	0x7bc4
	.uleb128 0x5
	.long	0x7bee
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0x1a
	.byte	0x0
	.uleb128 0xb
	.long	0x7bde
	.uleb128 0xb
	.long	0x7bde
	.uleb128 0xb
	.long	0x7bc4
	.uleb128 0x2b
	.long	0x7c0d
	.byte	0x1
	.long	0x3db
	.uleb128 0x2c
	.long	0x133
	.byte	0x0
	.uleb128 0x8
	.byte	0x8
	.long	0x7bfd
	.uleb128 0x5
	.long	0x7c23
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0x18
	.byte	0x0
	.uleb128 0xb
	.long	0x7c13
	.uleb128 0xb
	.long	0x7c13
	.uleb128 0xb
	.long	0x7ba5
	.uleb128 0xb
	.long	0x7b90
	.uleb128 0xb
	.long	0x7b7b
	.uleb128 0xb
	.long	0x7bc4
	.uleb128 0x5
	.long	0x7c51
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0x16
	.byte	0x0
	.uleb128 0xb
	.long	0x7c41
	.uleb128 0xb
	.long	0x7bc4
	.uleb128 0x5
	.long	0x7c6b
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0x1d
	.byte	0x0
	.uleb128 0xb
	.long	0x7c5b
	.uleb128 0x5
	.long	0x7c80
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0x11
	.byte	0x0
	.uleb128 0xb
	.long	0x7c70
	.uleb128 0xb
	.long	0x7c41
	.uleb128 0xb
	.long	0x7c70
	.uleb128 0xb
	.long	0x14a9
	.uleb128 0xb
	.long	0x7b90
	.uleb128 0xb
	.long	0x7ba5
	.uleb128 0x5
	.long	0x7cae
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0x25
	.byte	0x0
	.uleb128 0xb
	.long	0x7c9e
	.uleb128 0x5
	.long	0x7cc3
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0x24
	.byte	0x0
	.uleb128 0xb
	.long	0x7cb3
	.uleb128 0xb
	.long	0x7bde
	.uleb128 0xb
	.long	0x7c13
	.uleb128 0xb
	.long	0x1492
	.uleb128 0x5
	.long	0x7ce7
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0x1e
	.byte	0x0
	.uleb128 0xb
	.long	0x7cd7
	.uleb128 0xb
	.long	0x7c70
	.uleb128 0xb
	.long	0x7b7b
	.uleb128 0xb
	.long	0x7c70
	.uleb128 0xb
	.long	0x7c70
	.uleb128 0xb
	.long	0x14a9
	.uleb128 0x5
	.long	0x7d15
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0xc
	.byte	0x0
	.uleb128 0xb
	.long	0x7d05
	.uleb128 0xb
	.long	0x7d05
	.uleb128 0x5
	.long	0x7d2f
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0xa
	.byte	0x0
	.uleb128 0xb
	.long	0x7d1f
	.uleb128 0x5
	.long	0x7d44
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0x19
	.byte	0x0
	.uleb128 0xb
	.long	0x7d34
	.uleb128 0xb
	.long	0x7bc4
	.uleb128 0xb
	.long	0x7bde
	.uleb128 0xb
	.long	0x7c13
	.uleb128 0xb
	.long	0x7c70
	.uleb128 0xb
	.long	0x7c13
	.uleb128 0xb
	.long	0x7c41
	.uleb128 0xb
	.long	0x14a9
	.uleb128 0xb
	.long	0x7b7b
	.uleb128 0xb
	.long	0x7b90
	.uleb128 0xb
	.long	0x7b90
	.uleb128 0xb
	.long	0x7ba5
	.uleb128 0xb
	.long	0x454
	.uleb128 0xb
	.long	0x454
	.uleb128 0xb
	.long	0x7c13
	.uleb128 0xb
	.long	0x7b90
	.uleb128 0xb
	.long	0x454
	.uleb128 0xb
	.long	0x7d05
	.uleb128 0xb
	.long	0x7c41
	.uleb128 0xb
	.long	0x454
	.uleb128 0xb
	.long	0x7c70
	.uleb128 0x5
	.long	0x7dbd
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0xb
	.byte	0x0
	.uleb128 0xb
	.long	0x7dad
	.uleb128 0xb
	.long	0x7dad
	.uleb128 0x5
	.long	0x7dd7
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0xe
	.byte	0x0
	.uleb128 0xb
	.long	0x7dc7
	.uleb128 0xb
	.long	0x7c70
	.uleb128 0xb
	.long	0x7d05
	.uleb128 0xb
	.long	0x7c70
	.uleb128 0xb
	.long	0x7d05
	.uleb128 0x5
	.long	0x7e00
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0x10
	.byte	0x0
	.uleb128 0xb
	.long	0x7df0
	.uleb128 0xb
	.long	0x7c13
	.uleb128 0xb
	.long	0x1d33
	.uleb128 0xb
	.long	0x1d33
	.uleb128 0xb
	.long	0x7d05
	.uleb128 0x5
	.long	0x7e29
	.long	0x13b
	.uleb128 0x6
	.long	0x12c
	.byte	0x9
	.byte	0x0
	.uleb128 0xb
	.long	0x7e19
	.uleb128 0xb
	.long	0x7e19
	.uleb128 0xb
	.long	0x14a9
	.uleb128 0xb
	.long	0x14a9
	.uleb128 0xb
	.long	0x7dc7
	.uleb128 0xb
	.long	0x7dad
	.uleb128 0xb
	.long	0x7dad
	.uleb128 0xb
	.long	0x7b7b
	.uleb128 0xb
	.long	0x7c41
	.uleb128 0xb
	.long	0x7b90
	.uleb128 0xb
	.long	0x7dad
	.uleb128 0xb
	.long	0x7dad
	.uleb128 0xb
	.long	0x7c41
	.uleb128 0xb
	.long	0x7ba5
	.uleb128 0xb
	.long	0x7ba5
	.uleb128 0xb
	.long	0x7ba5
	.uleb128 0xb
	.long	0x7ba5
	.uleb128 0xb
	.long	0x7b7b
	.uleb128 0xb
	.long	0x7df0
	.uleb128 0xb
	.long	0x7b7b
	.uleb128 0xb
	.long	0x7dc7
	.uleb128 0xb
	.long	0x14a9
	.uleb128 0xb
	.long	0x7c13
	.uleb128 0xb
	.long	0x14a9
	.uleb128 0xb
	.long	0x14a9
	.uleb128 0xb
	.long	0x7b90
	.uleb128 0xb
	.long	0x454
	.uleb128 0xb
	.long	0x7c70
	.uleb128 0xb
	.long	0x7df0
	.uleb128 0xb
	.long	0x7ba5
	.uleb128 0xb
	.long	0x454
	.uleb128 0xb
	.long	0x7dc7
	.uleb128 0xb
	.long	0x7dc7
	.uleb128 0xb
	.long	0x7df0
	.uleb128 0xb
	.long	0x7c13
	.uleb128 0xb
	.long	0x7c13
	.uleb128 0xb
	.long	0x454
	.uleb128 0xb
	.long	0x454
	.uleb128 0xb
	.long	0x7ba5
	.uleb128 0xb
	.long	0x454
	.uleb128 0xb
	.long	0x7c70
	.uleb128 0xb
	.long	0x7c70
	.uleb128 0xb
	.long	0x7c13
	.uleb128 0xb
	.long	0x7c13
	.uleb128 0xb
	.long	0x7ba5
	.uleb128 0xb
	.long	0x7ba5
	.uleb128 0xb
	.long	0x7c41
	.uleb128 0xb
	.long	0x7c41
	.uleb128 0xb
	.long	0x14a9
	.uleb128 0xb
	.long	0x14a9
	.uleb128 0xb
	.long	0x14a9
	.uleb128 0x1d
	.string	"cudaErrorDL"
	.byte	0x1
	.byte	0x40
	.long	0x11aa
	.byte	0x9
	.byte	0x3
	.quad	cudaErrorDL
	.uleb128 0x1d
	.string	"cuda_err"
	.byte	0x1
	.byte	0x43
	.long	0x11aa
	.byte	0x9
	.byte	0x3
	.quad	cuda_err
	.uleb128 0x1d
	.string	"regHostVarsTab"
	.byte	0x1
	.byte	0x52
	.long	0x1d69
	.byte	0x9
	.byte	0x3
	.quad	regHostVarsTab
	.uleb128 0x1d
	.string	"LOCAL_EXEC"
	.byte	0x1
	.byte	0x54
	.long	0xe9
	.byte	0x9
	.byte	0x3
	.quad	LOCAL_EXEC
	.uleb128 0x1d
	.string	"CUR_DEV"
	.byte	0x1
	.byte	0x56
	.long	0xe9
	.byte	0x9
	.byte	0x3
	.quad	CUR_DEV
	.uleb128 0x31
	.string	"stdout"
	.byte	0xd
	.byte	0x8f
	.long	0x438
	.byte	0x1
	.byte	0x1
	.uleb128 0x32
	.string	"pFatBinaryHandle"
	.byte	0x1
	.value	0x9db
	.long	0x3db
	.byte	0x1
	.byte	0x9
	.byte	0x3
	.quad	pFatBinaryHandle
	.byte	0x0
	.section	.debug_abbrev
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x10
	.uleb128 0x6
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x25
	.uleb128 0x8
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1b
	.uleb128 0x8
	.byte	0x0
	.byte	0x0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x6
	.uleb128 0x21
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x7
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x8
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x9
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0xa
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0xb
	.uleb128 0x26
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xc
	.uleb128 0x16
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0xd
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0xe
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0xf
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x10
	.uleb128 0x28
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1c
	.uleb128 0xd
	.byte	0x0
	.byte	0x0
	.uleb128 0x11
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x12
	.uleb128 0x13
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.uleb128 0x13
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.byte	0x0
	.byte	0x0
	.uleb128 0x14
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x15
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.byte	0x0
	.byte	0x0
	.uleb128 0x16
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0x5
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.uleb128 0x16
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x18
	.uleb128 0x26
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x19
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x1a
	.uleb128 0x17
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x1b
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x1c
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0x1d
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x1e
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x34
	.uleb128 0xc
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x1f
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0x20
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x21
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x22
	.uleb128 0x16
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x23
	.uleb128 0x15
	.byte	0x0
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x24
	.uleb128 0x2e
	.byte	0x0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0x25
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0x26
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x27
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x28
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x29
	.uleb128 0x16
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x2a
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x2b
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x2c
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x2d
	.uleb128 0x2e
	.byte	0x0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0x2e
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.byte	0x0
	.byte	0x0
	.uleb128 0x2f
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0x30
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x34
	.uleb128 0xc
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.uleb128 0x32
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section	.debug_pubnames,"",@progbits
	.long	0xd28
	.value	0x2
	.long	.Ldebug_info0
	.long	0x7fe9
	.long	0x1e04
	.string	"l_handleDlError"
	.long	0x1e67
	.string	"l_printFuncSig"
	.long	0x1ea6
	.string	"l_printFuncSigImpl"
	.long	0x1ee9
	.string	"l_setMetThrReq"
	.long	0x1f47
	.string	"l_remoteInitMetThrReq"
	.long	0x1fa9
	.string	"rcudaThreadExit"
	.long	0x1ffd
	.string	"lcudaThreadExit"
	.long	0x206f
	.string	"cudaThreadExit"
	.long	0x209b
	.string	"rcudaThreadSynchronize"
	.long	0x2104
	.string	"lcudaThreadSynchronize"
	.long	0x2171
	.string	"cudaThreadSynchronize"
	.long	0x21b9
	.string	"cudaThreadSetLimit"
	.long	0x2260
	.string	"cudaThreadGetLimit"
	.long	0x230a
	.string	"cudaThreadGetCacheConfig"
	.long	0x23b0
	.string	"cudaThreadSetCacheConfig"
	.long	0x2447
	.string	"rcudaGetLastError"
	.long	0x2490
	.string	"lcudaGetLastError"
	.long	0x24fb
	.string	"cudaGetLastError"
	.long	0x252a
	.string	"cudaPeekAtLastError"
	.long	0x2597
	.string	"cudaGetErrorString"
	.long	0x262a
	.string	"rcudaGetDeviceCount"
	.long	0x2693
	.string	"lcudaGetDeviceCount"
	.long	0x2725
	.string	"cudaGetDeviceCount"
	.long	0x276a
	.string	"rcudaGetDeviceProperties"
	.long	0x27ee
	.string	"lcudaGetDeviceProperties"
	.long	0x289a
	.string	"cudaGetDeviceProperties"
	.long	0x28f4
	.string	"cudaChooseDevice"
	.long	0x29a3
	.string	"rcudaSetDevice"
	.long	0x2a16
	.string	"lcudaSetDevice"
	.long	0x2aa3
	.string	"cudaSetDevice"
	.long	0x2af2
	.string	"cudaGetDevice"
	.long	0x2b41
	.string	"cudaSetValidDevices"
	.long	0x2bee
	.string	"cudaSetDeviceFlags"
	.long	0x2c7f
	.string	"cudaStreamCreate"
	.long	0x2d18
	.string	"cudaStreamDestroy"
	.long	0x2da8
	.string	"cudaStreamWaitEvent"
	.long	0x2e62
	.string	"cudaStreamSynchronize"
	.long	0x2ee0
	.string	"cudaStreamQuery"
	.long	0x2f58
	.string	"cudaEventCreate"
	.long	0x2fec
	.string	"cudaEventCreateWithFlags"
	.long	0x3097
	.string	"cudaEventRecord"
	.long	0x3139
	.string	"cudaEventQuery"
	.long	0x31c6
	.string	"cudaEventSynchronize"
	.long	0x3243
	.string	"cudaEventDestroy"
	.long	0x32bc
	.string	"cudaEventElapsedTime"
	.long	0x337e
	.string	"rcudaConfigureCall"
	.long	0x3424
	.string	"lcudaConfigureCall"
	.long	0x34f1
	.string	"cudaConfigureCall"
	.long	0x3562
	.string	"rcudaSetupArgument"
	.long	0x35f7
	.string	"lcudaSetupArgument"
	.long	0x36b0
	.string	"cudaSetupArgument"
	.long	0x3721
	.string	"cudaFuncSetCacheConfig"
	.long	0x37cb
	.string	"rcudaLaunch"
	.long	0x383d
	.string	"lcudaLaunch"
	.long	0x38c9
	.string	"cudaLaunch"
	.long	0x3917
	.string	"cudaFuncGetAttributes"
	.long	0x39c7
	.string	"cudaSetDoubleForDevice"
	.long	0x3a60
	.string	"cudaSetDoubleForHost"
	.long	0x3adb
	.string	"rcudaMalloc"
	.long	0x3b5a
	.string	"lcudaMalloc"
	.long	0x3bf8
	.string	"cudaMalloc"
	.long	0x3c53
	.string	"cudaMallocHost"
	.long	0x3cd9
	.string	"cudaMallocPitch"
	.long	0x3da3
	.string	"cudaMallocArray"
	.long	0x3e92
	.string	"rcudaFree"
	.long	0x3f00
	.string	"lcudaFree"
	.long	0x3f88
	.string	"cudaFree"
	.long	0x3fd2
	.string	"cudaFreeHost"
	.long	0x4047
	.string	"cudaFreeArray"
	.long	0x40d3
	.string	"cudaHostAlloc"
	.long	0x4189
	.string	"cudaHostGetDevicePointer"
	.long	0x424e
	.string	"cudaHostGetFlags"
	.long	0x42fc
	.string	"cudaMalloc3D"
	.long	0x43a1
	.string	"cudaMalloc3DArray"
	.long	0x446d
	.string	"cudaMemcpy3D"
	.long	0x4501
	.string	"cudaMemcpy3DAsync"
	.long	0x45a3
	.string	"cudaMemGetInfo"
	.long	0x4647
	.string	"rcudaMemcpy"
	.long	0x46e4
	.string	"lcudaMemcpy"
	.long	0x47aa
	.string	"cudaMemcpy"
	.long	0x4823
	.string	"cudaMemcpyToArray"
	.long	0x4917
	.string	"cudaMemcpyFromArray"
	.long	0x4a18
	.string	"cudaMemcpyArrayToArray"
	.long	0x4b3a
	.string	"cudaMemcpy2D"
	.long	0x4c3e
	.string	"cudaMemcpy2DToArray"
	.long	0x4d5d
	.string	"cudaMemcpy2DFromArray"
	.long	0x4e7e
	.string	"cudaMemcpy2DArrayToArray"
	.long	0x4fb6
	.string	"rcudaMemcpyToSymbol"
	.long	0x506b
	.string	"lcudaMemcpyToSymbol"
	.long	0x514d
	.string	"cudaMemcpyToSymbol"
	.long	0x51e2
	.string	"rcudaMemcpyFromSymbol"
	.long	0x5299
	.string	"lcudaMemcpyFromSymbol"
	.long	0x537d
	.string	"cudaMemcpyFromSymbol"
	.long	0x5414
	.string	"cudaMemcpyAsync"
	.long	0x54f2
	.string	"cudaMemcpyToArrayAsync"
	.long	0x5600
	.string	"cudaMemcpyFromArrayAsync"
	.long	0x5710
	.string	"cudaMemcpy2DAsync"
	.long	0x582d
	.string	"cudaMemcpy2DToArrayAsync"
	.long	0x5965
	.string	"cudaMemcpy2DFromArrayAsync"
	.long	0x5a9f
	.string	"cudaMemcpyToSymbolAsync"
	.long	0x5b99
	.string	"cudaMemcpyFromSymbolAsync"
	.long	0x5c95
	.string	"cudaMemset"
	.long	0x5d46
	.string	"cudaMemset2D"
	.long	0x5e21
	.string	"cudaMemset3D"
	.long	0x5ed4
	.string	"cudaMemsetAsync"
	.long	0x5f9e
	.string	"cudaMemset2DAsync"
	.long	0x6092
	.string	"cudaMemset3DAsync"
	.long	0x615e
	.string	"cudaGetSymbolAddress"
	.long	0x6205
	.string	"cudaGetSymbolSize"
	.long	0x62a9
	.string	"cudaGraphicsUnregisterResource"
	.long	0x6363
	.string	"cudaGraphicsResourceSetMapFlags"
	.long	0x6415
	.string	"cudaGraphicsMapResources"
	.long	0x64da
	.string	"cudaGraphicsUnmapResources"
	.long	0x657b
	.string	"cudaGraphicsResourceGetMappedPointer"
	.long	0x6646
	.string	"cudaGraphicsSubResourceGetMappedArray"
	.long	0x6732
	.string	"cudaGetChannelDesc"
	.long	0x67d7
	.string	"cudaCreateChannelDesc"
	.long	0x68d7
	.string	"cudaBindTexture"
	.long	0x69c0
	.string	"cudaBindTexture2D"
	.long	0x6ac9
	.string	"cudaBindTextureToArray"
	.long	0x6b86
	.string	"cudaUnbindTexture"
	.long	0x6c16
	.string	"cudaGetTextureAlignmentOffset"
	.long	0x6cc6
	.string	"cudaGetTextureReference"
	.long	0x6d76
	.string	"cudaBindSurfaceToArray"
	.long	0x6e42
	.string	"cudaGetSurfaceReference"
	.long	0x6ef6
	.string	"cudaDriverGetVersion"
	.long	0x6f7d
	.string	"cudaRuntimeGetVersion"
	.long	0x7006
	.string	"cudaGetExportTable"
	.long	0x70d1
	.string	"r__cudaRegisterFatBinary"
	.long	0x71a8
	.string	"l__cudaRegisterFatBinary"
	.long	0x721f
	.string	"__cudaRegisterFatBinary"
	.long	0x727e
	.string	"r__cudaUnregisterFatBinary"
	.long	0x72ea
	.string	"l__cudaUnregisterFatBinary"
	.long	0x737f
	.string	"__cudaUnregisterFatBinary"
	.long	0x73c7
	.string	"r__cudaRegisterFunction"
	.long	0x74d9
	.string	"l__cudaRegisterFunction"
	.long	0x7622
	.string	"__cudaRegisterFunction"
	.long	0x76f0
	.string	"l__cudaRegisterVar"
	.long	0x780b
	.string	"r__cudaRegisterVar"
	.long	0x791e
	.string	"__cudaRegisterVar"
	.long	0x79c9
	.string	"__cudaRegisterTexture"
	.long	0x7ad2
	.string	"__cudaRegisterShared"
	.long	0x7fc4
	.string	"pFatBinaryHandle"
	.long	0x0
	.section	.debug_aranges,"",@progbits
	.long	0x2c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0x0
	.value	0x0
	.value	0x0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0x0
	.quad	0x0
	.section	.debug_str,"",@progbits
.LASF39:
	.string	"blockDim"
.LASF37:
	.string	"event"
.LASF50:
	.string	"hOffsetSrc"
.LASF44:
	.string	"pitchedDevPtr"
.LASF38:
	.string	"gridDim"
.LASF31:
	.string	"index"
.LASF43:
	.string	"desc"
.LASF4:
	.string	"height"
.LASF15:
	.string	"hostFun"
.LASF52:
	.string	"spitch"
.LASF45:
	.string	"wOffset"
.LASF20:
	.string	"hostVar"
.LASF32:
	.string	"value"
.LASF11:
	.string	"size"
.LASF14:
	.string	"fatCubinHandle"
.LASF27:
	.string	"pPacket"
.LASF53:
	.string	"symbol"
.LASF2:
	.string	"pitch"
.LASF49:
	.string	"wOffsetSrc"
.LASF6:
	.string	"kind"
.LASF22:
	.string	"constant"
.LASF56:
	.string	"texref"
.LASF10:
	.string	"gpuProfileName"
.LASF41:
	.string	"devPtr"
.LASF26:
	.string	"pSignature"
.LASF24:
	.string	"method_id"
.LASF47:
	.string	"wOffsetDst"
.LASF23:
	.string	"global"
.LASF46:
	.string	"hOffset"
.LASF48:
	.string	"hOffsetDst"
.LASF54:
	.string	"resource"
.LASF55:
	.string	"resources"
.LASF7:
	.string	"maxThreadsPerBlock"
.LASF18:
	.string	"thread_limit"
.LASF35:
	.string	"device"
.LASF21:
	.string	"deviceAddress"
.LASF0:
	.string	"long unsigned int"
.LASF17:
	.string	"deviceName"
.LASF51:
	.string	"dpitch"
.LASF29:
	.string	"pFuncType"
.LASF1:
	.string	"_IO_FILE"
.LASF9:
	.string	"channelDesc"
.LASF19:
	.string	"wSize"
.LASF33:
	.string	"cacheConfig"
.LASF3:
	.string	"width"
.LASF13:
	.string	"offset"
.LASF30:
	.string	"pFunc"
.LASF5:
	.string	"extent"
.LASF16:
	.string	"deviceFun"
.LASF42:
	.string	"array"
.LASF8:
	.string	"__cudaReserved"
.LASF40:
	.string	"sharedMem"
.LASF34:
	.string	"count"
.LASF28:
	.string	"methodId"
.LASF25:
	.string	"__FUNCTION__"
.LASF36:
	.string	"stream"
.LASF12:
	.string	"flags"
	.ident	"GCC: (GNU) 4.1.2 20080704 (Red Hat 4.1.2-51)"
	.section	.note.GNU-stack,"",@progbits

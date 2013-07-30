	.file	"mem.c"
	.text
	.globl	initMemOld
	.align	16, 0x90
	.type	initMemOld,@function
initMemOld:                             # @initMemOld
.Ltmp2:
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp3:
	.cfi_def_cfa_offset 16
.Ltmp4:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp5:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movabsq	$127, %rdi
	callq	malloc
	movq	%rax, HRAM
	cmpq	$0, HRAM
	jne	.LBB0_2
# BB#1:
	movl	$-1, -4(%rbp)
	jmp	.LBB0_31
.LBB0_2:
	movabsq	$128, %rdi
	callq	malloc
	movq	%rax, IOBUF
	cmpq	$0, IOBUF
	jne	.LBB0_4
# BB#3:
	movl	$-1, -4(%rbp)
	jmp	.LBB0_31
.LBB0_4:
	movabsq	$8192, %rdi             # imm = 0x2000
	callq	malloc
	movq	%rax, VRAM
	cmpq	$0, VRAM
	jne	.LBB0_6
# BB#5:
	movl	$-1, -4(%rbp)
	jmp	.LBB0_31
.LBB0_6:
	movl	$0, -8(%rbp)
.LBB0_7:                                # =>This Inner Loop Header: Depth=1
	cmpl	$8192, -8(%rbp)         # imm = 0x2000
	jge	.LBB0_10
# BB#8:                                 #   in Loop: Header=BB0_7 Depth=1
	movslq	-8(%rbp), %rax
	movq	VRAM, %rcx
	movb	$0, (%rcx,%rax)
# BB#9:                                 #   in Loop: Header=BB0_7 Depth=1
	movl	-8(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -8(%rbp)
	jmp	.LBB0_7
.LBB0_10:
	movabsq	$32768, %rdi            # imm = 0x8000
	callq	malloc
	movq	%rax, ERAM
	cmpq	$0, ERAM
	jne	.LBB0_12
# BB#11:
	movl	$-1, -4(%rbp)
	jmp	.LBB0_31
.LBB0_12:
	movabsq	$8192, %rdi             # imm = 0x2000
	callq	malloc
	movq	%rax, WRAM1
	cmpq	$0, WRAM1
	jne	.LBB0_14
# BB#13:
	movl	$-1, -4(%rbp)
	jmp	.LBB0_31
.LBB0_14:
	movl	$0, -8(%rbp)
.LBB0_15:                               # =>This Inner Loop Header: Depth=1
	cmpl	$8192, -8(%rbp)         # imm = 0x2000
	jge	.LBB0_18
# BB#16:                                #   in Loop: Header=BB0_15 Depth=1
	movslq	-8(%rbp), %rax
	movq	WRAM1, %rcx
	movb	$0, (%rcx,%rax)
# BB#17:                                #   in Loop: Header=BB0_15 Depth=1
	movl	-8(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -8(%rbp)
	jmp	.LBB0_15
.LBB0_18:
	movabsq	$4096, %rdi             # imm = 0x1000
	callq	malloc
	movq	%rax, WRAM2
	cmpq	$0, WRAM2
	jne	.LBB0_20
# BB#19:
	movl	$-1, -4(%rbp)
	jmp	.LBB0_31
.LBB0_20:
	movl	$0, -8(%rbp)
.LBB0_21:                               # =>This Inner Loop Header: Depth=1
	cmpl	$4096, -8(%rbp)         # imm = 0x1000
	jge	.LBB0_24
# BB#22:                                #   in Loop: Header=BB0_21 Depth=1
	movslq	-8(%rbp), %rax
	movq	WRAM2, %rcx
	movb	$0, (%rcx,%rax)
# BB#23:                                #   in Loop: Header=BB0_21 Depth=1
	movl	-8(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -8(%rbp)
	jmp	.LBB0_21
.LBB0_24:
	movabsq	$256, %rdi              # imm = 0x100
	callq	malloc
	movq	%rax, OAM
	cmpq	$0, OAM
	jne	.LBB0_26
# BB#25:
	movl	$-1, -4(%rbp)
	jmp	.LBB0_31
.LBB0_26:
	movl	$0, -8(%rbp)
.LBB0_27:                               # =>This Inner Loop Header: Depth=1
	cmpl	$256, -8(%rbp)          # imm = 0x100
	jge	.LBB0_30
# BB#28:                                #   in Loop: Header=BB0_27 Depth=1
	movslq	-8(%rbp), %rax
	movq	OAM, %rcx
	movb	$0, (%rcx,%rax)
# BB#29:                                #   in Loop: Header=BB0_27 Depth=1
	movl	-8(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -8(%rbp)
	jmp	.LBB0_27
.LBB0_30:
	movl	$0, %eax
	movl	$256, %ecx              # imm = 0x100
	movl	$16, %edx
	movl	%eax, %edi
	movl	%ecx, %esi
	movl	%edx, -12(%rbp)         # 4-byte Spill
	movl	%ecx, %edx
	movl	-12(%rbp), %ecx         # 4-byte Reload
	movl	%eax, %r8d
	movl	%eax, %r9d
	movl	$0, (%rsp)
	movl	$0, 8(%rsp)
	callq	SDL_CreateRGBSurface
	movq	%rax, tiles
	movb	$-1, jpbuf
	movq	IOBUF, %rax
	movb	$15, (%rax)
	movl	$0, rampage
	movl	$1, rompage
	movl	$0, mbcmode
	movl	$0, ramenable
	movl	$0, -4(%rbp)
.LBB0_31:
	movl	-4(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	ret
.Ltmp6:
	.size	initMemOld, .Ltmp6-initMemOld
.Ltmp7:
	.cfi_endproc
.Leh_func_end0:

	.globl	initMem
	.align	16, 0x90
	.type	initMem,@function
initMem:                                # @initMem
.Ltmp10:
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp11:
	.cfi_def_cfa_offset 16
.Ltmp12:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp13:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movabsq	$65536, %rdi            # imm = 0x10000
	callq	malloc
	movq	%rax, MEM
	cmpq	$0, MEM
	jne	.LBB1_2
# BB#1:
	movl	$-1, -4(%rbp)
	jmp	.LBB1_17
.LBB1_2:
	movq	MEM, %rax
	addq	$65408, %rax            # imm = 0xFF80
	movq	%rax, HRAM
	movq	MEM, %rax
	addq	$65280, %rax            # imm = 0xFF00
	movq	%rax, IOBUF
	movq	MEM, %rax
	addq	$32768, %rax            # imm = 0x8000
	movq	%rax, VRAM
	movl	$0, -8(%rbp)
.LBB1_3:                                # =>This Inner Loop Header: Depth=1
	cmpl	$8192, -8(%rbp)         # imm = 0x2000
	jge	.LBB1_6
# BB#4:                                 #   in Loop: Header=BB1_3 Depth=1
	movslq	-8(%rbp), %rax
	movq	VRAM, %rcx
	movb	$0, (%rcx,%rax)
# BB#5:                                 #   in Loop: Header=BB1_3 Depth=1
	movl	-8(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -8(%rbp)
	jmp	.LBB1_3
.LBB1_6:
	movq	MEM, %rax
	addq	$40960, %rax            # imm = 0xA000
	movq	%rax, ERAM
	cmpq	$0, ERAM
	jne	.LBB1_8
# BB#7:
	movl	$-1, -4(%rbp)
	jmp	.LBB1_17
.LBB1_8:
	movq	MEM, %rax
	addq	$49152, %rax            # imm = 0xC000
	movq	%rax, WRAM1
	movl	$0, -8(%rbp)
.LBB1_9:                                # =>This Inner Loop Header: Depth=1
	cmpl	$8192, -8(%rbp)         # imm = 0x2000
	jge	.LBB1_12
# BB#10:                                #   in Loop: Header=BB1_9 Depth=1
	movslq	-8(%rbp), %rax
	movq	WRAM1, %rcx
	movb	$0, (%rcx,%rax)
# BB#11:                                #   in Loop: Header=BB1_9 Depth=1
	movl	-8(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -8(%rbp)
	jmp	.LBB1_9
.LBB1_12:
	movq	MEM, %rax
	addq	$65024, %rax            # imm = 0xFE00
	movq	%rax, OAM
	movl	$0, -8(%rbp)
.LBB1_13:                               # =>This Inner Loop Header: Depth=1
	cmpl	$256, -8(%rbp)          # imm = 0x100
	jge	.LBB1_16
# BB#14:                                #   in Loop: Header=BB1_13 Depth=1
	movslq	-8(%rbp), %rax
	movq	OAM, %rcx
	movb	$0, (%rcx,%rax)
# BB#15:                                #   in Loop: Header=BB1_13 Depth=1
	movl	-8(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -8(%rbp)
	jmp	.LBB1_13
.LBB1_16:
	movl	$0, %eax
	movl	$256, %ecx              # imm = 0x100
	movl	$16, %edx
	movl	%eax, %edi
	movl	%ecx, %esi
	movl	%edx, -12(%rbp)         # 4-byte Spill
	movl	%ecx, %edx
	movl	-12(%rbp), %ecx         # 4-byte Reload
	movl	%eax, %r8d
	movl	%eax, %r9d
	movl	$0, (%rsp)
	movl	$0, 8(%rsp)
	callq	SDL_CreateRGBSurface
	movq	%rax, tiles
	movb	$-1, jpbuf
	movq	IOBUF, %rax
	movb	$15, (%rax)
	movl	$0, rampage
	movl	$1, rompage
	movl	$0, mbcmode
	movl	$0, ramenable
	movl	$0, -4(%rbp)
.LBB1_17:
	movl	-4(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	ret
.Ltmp14:
	.size	initMem, .Ltmp14-initMem
.Ltmp15:
	.cfi_endproc
.Leh_func_end1:

	.globl	resetJpButton
	.align	16, 0x90
	.type	resetJpButton,@function
resetJpButton:                          # @resetJpButton
.Ltmp18:
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp19:
	.cfi_def_cfa_offset 16
.Ltmp20:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp21:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movb	%dil, %al
	movb	%al, -1(%rbp)
	movzbl	-1(%rbp), %ecx
                                        # kill: CL<def> ECX<kill>
	movl	$1, %edi
	shll	%cl, %edi
	movb	%dil, %al
	movb	%al, -2(%rbp)
	movzbl	jpbuf, %edi
	movzbl	-2(%rbp), %edx
	orl	%edi, %edx
	movb	%dl, %al
	movb	%al, jpbuf
	callq	changeJpRegs
	movl	$5, %edi
	callq	intRequest
	addq	$16, %rsp
	popq	%rbp
	ret
.Ltmp22:
	.size	resetJpButton, .Ltmp22-resetJpButton
.Ltmp23:
	.cfi_endproc
.Leh_func_end2:

	.globl	setJpButton
	.align	16, 0x90
	.type	setJpButton,@function
setJpButton:                            # @setJpButton
.Ltmp26:
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp27:
	.cfi_def_cfa_offset 16
.Ltmp28:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp29:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movb	%dil, %al
	movb	%al, -1(%rbp)
	movzbl	-1(%rbp), %ecx
                                        # kill: CL<def> ECX<kill>
	movl	$1, %edi
	shll	%cl, %edi
	xorl	$4294967295, %edi       # imm = 0xFFFFFFFF
	movb	%dil, %al
	movb	%al, -2(%rbp)
	movzbl	jpbuf, %edi
	movzbl	-2(%rbp), %edx
	andl	%edi, %edx
	movb	%dl, %al
	movb	%al, jpbuf
	callq	changeJpRegs
	addq	$16, %rsp
	popq	%rbp
	ret
.Ltmp30:
	.size	setJpButton, .Ltmp30-setJpButton
.Ltmp31:
	.cfi_endproc
.Leh_func_end3:

	.globl	changeJpRegs
	.align	16, 0x90
	.type	changeJpRegs,@function
changeJpRegs:                           # @changeJpRegs
.Ltmp34:
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp35:
	.cfi_def_cfa_offset 16
.Ltmp36:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp37:
	.cfi_def_cfa_register %rbp
	callq	jpDirections
	cmpb	$0, %al
	jne	.LBB4_2
# BB#1:
	movzbl	jpbuf, %eax
	sarl	$4, %eax
	movb	%al, %cl
	movzbl	%cl, %edi
	callq	writejpReg
	jmp	.LBB4_5
.LBB4_2:
	callq	jpButtons
	cmpb	$0, %al
	jne	.LBB4_4
# BB#3:
	movzbl	jpbuf, %edi
	callq	writejpReg
.LBB4_4:
.LBB4_5:
	popq	%rbp
	ret
.Ltmp38:
	.size	changeJpRegs, .Ltmp38-changeJpRegs
.Ltmp39:
	.cfi_endproc
.Leh_func_end4:

	.globl	writejpReg
	.align	16, 0x90
	.type	writejpReg,@function
writejpReg:                             # @writejpReg
.Ltmp40:
	.cfi_startproc
# BB#0:
	movb	%dil, %al
	movb	%al, -1(%rsp)
	movq	IOBUF, %rcx
	movzbl	(%rcx), %edi
	andl	$240, %edi
	movzbl	-1(%rsp), %edx
	andl	$15, %edx
	orl	%edi, %edx
	movb	%dl, %al
	movq	IOBUF, %rcx
	movb	%al, (%rcx)
	ret
.Ltmp41:
	.size	writejpReg, .Ltmp41-writejpReg
.Ltmp42:
	.cfi_endproc
.Leh_func_end5:

	.globl	jpDirections
	.align	16, 0x90
	.type	jpDirections,@function
jpDirections:                           # @jpDirections
.Ltmp43:
	.cfi_startproc
# BB#0:
	movq	IOBUF, %rax
	movzbl	(%rax), %ecx
	sarl	$4, %ecx
	andl	$1, %ecx
	movb	%cl, %dl
	movzbl	%dl, %eax
	ret
.Ltmp44:
	.size	jpDirections, .Ltmp44-jpDirections
.Ltmp45:
	.cfi_endproc
.Leh_func_end6:

	.globl	jpButtons
	.align	16, 0x90
	.type	jpButtons,@function
jpButtons:                              # @jpButtons
.Ltmp46:
	.cfi_startproc
# BB#0:
	movq	IOBUF, %rax
	movzbl	(%rax), %ecx
	sarl	$5, %ecx
	andl	$1, %ecx
	movb	%cl, %dl
	movzbl	%dl, %eax
	ret
.Ltmp47:
	.size	jpButtons, .Ltmp47-jpButtons
.Ltmp48:
	.cfi_endproc
.Leh_func_end7:

	.globl	readbyte
	.align	16, 0x90
	.type	readbyte,@function
readbyte:                               # @readbyte
.Ltmp51:
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp52:
	.cfi_def_cfa_offset 16
.Ltmp53:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp54:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movw	%di, %ax
	movw	%ax, -2(%rbp)
	movzwl	-2(%rbp), %edi
	callq	fastread
	movzbl	%al, %eax
	addq	$16, %rsp
	popq	%rbp
	ret
.Ltmp55:
	.size	readbyte, .Ltmp55-readbyte
.Ltmp56:
	.cfi_endproc
.Leh_func_end8:

	.globl	fastread
	.align	16, 0x90
	.type	fastread,@function
fastread:                               # @fastread
.Ltmp57:
	.cfi_startproc
# BB#0:
	movw	%di, %ax
	movw	%ax, -4(%rsp)
	movzwl	-4(%rsp), %edi
	cmpl	$16383, %edi            # imm = 0x3FFF
	jg	.LBB9_2
# BB#1:
	movzwl	-4(%rsp), %eax
	movq	ROM, %rcx
	movb	(%rcx,%rax), %dl
	movb	%dl, -1(%rsp)
	jmp	.LBB9_10
.LBB9_2:
	movzwl	-4(%rsp), %eax
	cmpl	$32767, %eax            # imm = 0x7FFF
	jg	.LBB9_4
# BB#3:
	movzwl	-4(%rsp), %eax
	addl	romoffset, %eax
	movslq	%eax, %rcx
	movq	ROM, %rdx
	movb	(%rdx,%rcx), %sil
	movb	%sil, -1(%rsp)
	jmp	.LBB9_10
.LBB9_4:
	movzwl	-4(%rsp), %eax
	cmpl	$49151, %eax            # imm = 0xBFFF
	jg	.LBB9_7
# BB#5:
	movzwl	-4(%rsp), %eax
	cmpl	$40960, %eax            # imm = 0xA000
	jl	.LBB9_7
# BB#6:
	movzwl	-4(%rsp), %eax
	subl	$40960, %eax            # imm = 0xA000
	addl	ramoffset, %eax
	movslq	%eax, %rcx
	movq	ERAM, %rdx
	movb	(%rdx,%rcx), %sil
	movb	%sil, -1(%rsp)
	jmp	.LBB9_10
.LBB9_7:
# BB#8:
# BB#9:
	movzwl	-4(%rsp), %eax
	movq	MEM, %rcx
	movb	(%rcx,%rax), %dl
	movb	%dl, -1(%rsp)
.LBB9_10:
	movzbl	-1(%rsp), %eax
	ret
.Ltmp58:
	.size	fastread, .Ltmp58-fastread
.Ltmp59:
	.cfi_endproc
.Leh_func_end9:

	.globl	readword
	.align	16, 0x90
	.type	readword,@function
readword:                               # @readword
.Ltmp62:
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp63:
	.cfi_def_cfa_offset 16
.Ltmp64:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp65:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movw	%di, %ax
	movw	%ax, -2(%rbp)
	movzwl	-2(%rbp), %edi
	callq	fastread
	movzbl	%al, %edi
	movzwl	-2(%rbp), %ecx
	addl	$1, %ecx
	movw	%cx, %dx
	movzwl	%dx, %ecx
	movl	%edi, -8(%rbp)          # 4-byte Spill
	movl	%ecx, %edi
	callq	fastread
	movzbl	%al, %ecx
	shll	$8, %ecx
	movl	-8(%rbp), %edi          # 4-byte Reload
	orl	%edi, %ecx
	movw	%cx, %dx
	movzwl	%dx, %eax
	addq	$16, %rsp
	popq	%rbp
	ret
.Ltmp66:
	.size	readword, .Ltmp66-readword
.Ltmp67:
	.cfi_endproc
.Leh_func_end10:

	.globl	writebyte
	.align	16, 0x90
	.type	writebyte,@function
writebyte:                              # @writebyte
.Ltmp70:
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp71:
	.cfi_def_cfa_offset 16
.Ltmp72:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp73:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movb	%sil, %al
	movw	%di, %cx
	movw	%cx, -2(%rbp)
	movb	%al, -3(%rbp)
	movw	-2(%rbp), %cx
	movzwl	%cx, %edi
	movzbl	-3(%rbp), %esi
	callq	fastwrite
	movzwl	%ax, %eax
	addq	$16, %rsp
	popq	%rbp
	ret
.Ltmp74:
	.size	writebyte, .Ltmp74-writebyte
.Ltmp75:
	.cfi_endproc
.Leh_func_end11:

	.globl	fastwrite
	.align	16, 0x90
	.type	fastwrite,@function
fastwrite:                              # @fastwrite
.Ltmp78:
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp79:
	.cfi_def_cfa_offset 16
.Ltmp80:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp81:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movb	%sil, %al
	movw	%di, %cx
	movw	%cx, -4(%rbp)
	movb	%al, -5(%rbp)
	movzwl	-4(%rbp), %esi
	cmpl	$32767, %esi            # imm = 0x7FFF
	jg	.LBB12_4
# BB#1:
	cmpq	$0, mreader
	jne	.LBB12_3
# BB#2:
	movw	$0, -2(%rbp)
	jmp	.LBB12_32
.LBB12_3:
	movl	$1, %edx
	movq	mwriter, %rax
	movzwl	-4(%rbp), %edi
	movzbl	-5(%rbp), %esi
	movq	%rax, -16(%rbp)         # 8-byte Spill
	movb	$0, %al
	movq	-16(%rbp), %rcx         # 8-byte Reload
	callq	*%rcx
	movw	$0, -2(%rbp)
	jmp	.LBB12_32
.LBB12_4:
	movzwl	-4(%rbp), %eax
	cmpl	$49151, %eax            # imm = 0xBFFF
	jg	.LBB12_9
# BB#5:
	movzwl	-4(%rbp), %eax
	cmpl	$40960, %eax            # imm = 0xA000
	jl	.LBB12_9
# BB#6:
	cmpq	$0, mwriter
	jne	.LBB12_8
# BB#7:
	movb	-5(%rbp), %al
	movzwl	-4(%rbp), %ecx
	subl	$40960, %ecx            # imm = 0xA000
	movslq	%ecx, %rdx
	movq	ERAM, %rsi
	movb	%al, (%rsi,%rdx)
	movw	$0, -2(%rbp)
	jmp	.LBB12_32
.LBB12_8:
	movl	$1, %edx
	movq	mwriter, %rax
	movzwl	-4(%rbp), %edi
	movzbl	-5(%rbp), %esi
	movq	%rax, -24(%rbp)         # 8-byte Spill
	movb	$0, %al
	movq	-24(%rbp), %rcx         # 8-byte Reload
	callq	*%rcx
	movw	$0, -2(%rbp)
	jmp	.LBB12_32
.LBB12_9:
# BB#10:
	movb	-5(%rbp), %al
	movzwl	-4(%rbp), %ecx
	movq	MEM, %rdx
	movb	%al, (%rdx,%rcx)
	movzwl	-4(%rbp), %esi
	cmpl	$32768, %esi            # imm = 0x8000
	jl	.LBB12_13
# BB#11:
	movzwl	-4(%rbp), %eax
	cmpl	$38911, %eax            # imm = 0x97FF
	jg	.LBB12_13
# BB#12:
	movzwl	-4(%rbp), %eax
	subl	$32768, %eax            # imm = 0x8000
	movw	%ax, %cx
	movzwl	%cx, %edi
	callq	writeTileMem
	movw	$0, -2(%rbp)
	jmp	.LBB12_32
.LBB12_13:
	movzwl	-4(%rbp), %eax
	cmpl	$65407, %eax            # imm = 0xFF7F
	jg	.LBB12_30
# BB#14:
	movzwl	-4(%rbp), %eax
	cmpl	$65280, %eax            # imm = 0xFF00
	jl	.LBB12_30
# BB#15:
	movzwl	-4(%rbp), %eax
	subl	$65280, %eax            # imm = 0xFF00
	movw	%ax, %cx
	movw	%cx, -8(%rbp)
	movb	-5(%rbp), %dl
	movzwl	-8(%rbp), %esi
	movq	IOBUF, %rdi
	movb	%dl, (%rdi,%rsi)
	movzwl	-4(%rbp), %eax
	cmpl	$65350, %eax            # imm = 0xFF46
	jne	.LBB12_17
# BB#16:
	movzbl	-5(%rbp), %edi
	callq	doDma
.LBB12_17:
	movzwl	-4(%rbp), %eax
	cmpl	$65280, %eax            # imm = 0xFF00
	jne	.LBB12_19
# BB#18:
	callq	changeJpRegs
.LBB12_19:
	movzwl	-4(%rbp), %eax
	cmpl	$65287, %eax            # imm = 0xFF07
	jne	.LBB12_29
# BB#20:
	movzbl	-5(%rbp), %eax
	andl	$3, %eax
	movl	%eax, %ecx
	cmpl	$3, %eax
	movq	%rcx, -32(%rbp)         # 8-byte Spill
	ja	.LBB12_25
# BB#33:
	movq	-32(%rbp), %rax         # 8-byte Reload
	movq	.LJTI12_0(,%rax,8), %rcx
	jmpq	*%rcx
.LBB12_21:
	movl	$4096, ICS              # imm = 0x1000
	jmp	.LBB12_25
.LBB12_22:
	movl	$262144, ICS            # imm = 0x40000
	jmp	.LBB12_25
.LBB12_23:
	movl	$65536, ICS             # imm = 0x10000
	jmp	.LBB12_25
.LBB12_24:
	movl	$16384, ICS             # imm = 0x4000
.LBB12_25:
	movzbl	-5(%rbp), %eax
	sarl	$2, %eax
	cmpl	$0, %eax
	je	.LBB12_27
# BB#26:
	movb	$1, TENABLE
	jmp	.LBB12_28
.LBB12_27:
	movb	$0, TENABLE
.LBB12_28:
.LBB12_29:
	movw	$0, -2(%rbp)
	jmp	.LBB12_32
.LBB12_30:
# BB#31:
	movw	$0, -2(%rbp)
.LBB12_32:
	movzwl	-2(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	ret
.Ltmp82:
	.size	fastwrite, .Ltmp82-fastwrite
.Ltmp83:
	.cfi_endproc
.Leh_func_end12:
	.section	.rodata,"a",@progbits
	.align	8
.LJTI12_0:
	.quad	.LBB12_21
	.quad	.LBB12_22
	.quad	.LBB12_23
	.quad	.LBB12_24

	.text
	.globl	writeword
	.align	16, 0x90
	.type	writeword,@function
writeword:                              # @writeword
.Ltmp86:
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp87:
	.cfi_def_cfa_offset 16
.Ltmp88:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp89:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movw	%si, %ax
	movw	%di, %cx
	movw	%cx, -2(%rbp)
	movw	%ax, -4(%rbp)
	movw	-2(%rbp), %ax
	movzwl	-4(%rbp), %esi
	andl	$255, %esi
	movb	%sil, %dl
	movzwl	%ax, %edi
	movzbl	%dl, %esi
	callq	fastwrite
	movzwl	-2(%rbp), %esi
	addl	$1, %esi
	movw	%si, %cx
	movzwl	-4(%rbp), %esi
	sarl	$8, %esi
	movb	%sil, %dl
	movzwl	%cx, %edi
	movzbl	%dl, %esi
	movw	%ax, -6(%rbp)           # 2-byte Spill
	callq	fastwrite
	movzwl	%ax, %eax
	addq	$16, %rsp
	popq	%rbp
	ret
.Ltmp90:
	.size	writeword, .Ltmp90-writeword
.Ltmp91:
	.cfi_endproc
.Leh_func_end13:

	.globl	writeTileMem
	.align	16, 0x90
	.type	writeTileMem,@function
writeTileMem:                           # @writeTileMem
.Ltmp92:
	.cfi_startproc
# BB#0:
	movw	%di, %ax
	movw	%ax, -2(%rsp)
	movzwl	-2(%rsp), %edi
	sarl	$4, %edi
	movl	%edi, -8(%rsp)
	movq	VRAM, %rcx
	movl	-8(%rsp), %edi
	shll	$4, %edi
	movslq	%edi, %rdx
	addq	%rcx, %rdx
	movq	%rdx, -16(%rsp)
	movq	tiles, %rcx
	movq	32(%rcx), %rcx
	movq	%rcx, -24(%rsp)
	movl	-8(%rsp), %edi
	andl	$15, %edi
	shll	$3, %edi
	movw	%di, %ax
	movw	%ax, -26(%rsp)
	movl	-8(%rsp), %edi
	andl	$4080, %edi             # imm = 0xFF0
	sarl	$4, %edi
	shll	$3, %edi
	movw	%di, %ax
	movw	%ax, -28(%rsp)
	movzwl	-2(%rsp), %edi
	andl	$14, %edi
	movl	%edi, -32(%rsp)
	movl	$0, -36(%rsp)
.LBB14_1:                               # =>This Inner Loop Header: Depth=1
	cmpl	$8, -36(%rsp)
	jge	.LBB14_4
# BB#2:                                 #   in Loop: Header=BB14_1 Depth=1
	movslq	-32(%rsp), %rax
	movq	-16(%rsp), %rcx
	movzbl	(%rcx,%rax), %edx
	movl	-36(%rsp), %ecx
                                        # kill: CL<def> ECX<kill>
	sarl	%cl, %edx
	andl	$1, %edx
	movb	%dl, %cl
	movb	%cl, -39(%rsp)
	movl	-32(%rsp), %edx
	addl	$1, %edx
	movslq	%edx, %rax
	movq	-16(%rsp), %rsi
	movzbl	(%rsi,%rax), %edx
	movl	-36(%rsp), %ecx
                                        # kill: CL<def> ECX<kill>
	sarl	%cl, %edx
	andl	$1, %edx
	movb	%dl, %cl
	movb	%cl, -40(%rsp)
	movzbl	-40(%rsp), %edx
	movzbl	-39(%rsp), %edi
	shll	$1, %edi
	orl	%edx, %edi
	movb	%dil, %cl
	movb	%cl, -41(%rsp)
	movzwl	-28(%rsp), %edx
	movl	-32(%rsp), %edi
	sarl	$1, %edi
	addl	%edx, %edi
	shll	$8, %edi
	movzwl	-26(%rsp), %edx
	addl	%edi, %edx
	movl	$8, %edi
	subl	-36(%rsp), %edi
	addl	%edx, %edi
	movw	%di, %r8w
	movw	%r8w, -38(%rsp)
	movzbl	-41(%rsp), %eax
	movw	pal(,%rax,2), %r8w
	movzwl	-38(%rsp), %eax
	movq	-24(%rsp), %rsi
	movw	%r8w, (%rsi,%rax,2)
# BB#3:                                 #   in Loop: Header=BB14_1 Depth=1
	movl	-36(%rsp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rsp)
	jmp	.LBB14_1
.LBB14_4:
	ret
.Ltmp93:
	.size	writeTileMem, .Ltmp93-writeTileMem
.Ltmp94:
	.cfi_endproc
.Leh_func_end14:

	.globl	doDma
	.align	16, 0x90
	.type	doDma,@function
doDma:                                  # @doDma
.Ltmp95:
	.cfi_startproc
# BB#0:
	movb	%dil, %al
	movb	%al, -1(%rsp)
	movzbl	-1(%rsp), %edi
	shll	$8, %edi
	movw	%di, %cx
	movw	%cx, -4(%rsp)
	movq	MEM, %rdx
	movzwl	-4(%rsp), %edi
	movslq	%edi, %rsi
	addq	%rdx, %rsi
	movq	%rsi, OAM
	ret
.Ltmp96:
	.size	doDma, .Ltmp96-doDma
.Ltmp97:
	.cfi_endproc
.Leh_func_end15:

	.globl	oldDoDma
	.align	16, 0x90
	.type	oldDoDma,@function
oldDoDma:                               # @oldDoDma
.Ltmp100:
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp101:
	.cfi_def_cfa_offset 16
.Ltmp102:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp103:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movb	%dil, %al
	movl	$159, %edx
	movl	$114, %ecx
	movb	%al, -1(%rbp)
	movzbl	-1(%rbp), %edi
	shll	$8, %edi
	movw	%di, %si
	movw	%si, -4(%rbp)
	movzwl	-4(%rbp), %edi
	movq	OAM, %rsi
	callq	map
	movb	$-116, DMADELAY
	movl	%eax, -8(%rbp)          # 4-byte Spill
	addq	$16, %rsp
	popq	%rbp
	ret
.Ltmp104:
	.size	oldDoDma, .Ltmp104-oldDoDma
.Ltmp105:
	.cfi_endproc
.Leh_func_end16:

	.globl	map
	.align	16, 0x90
	.type	map,@function
map:                                    # @map
.Ltmp108:
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp109:
	.cfi_def_cfa_offset 16
.Ltmp110:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp111:
	.cfi_def_cfa_register %rbp
	subq	$112, %rsp
	movb	%cl, %al
	movl	%edi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movb	%al, -21(%rbp)
	cmpq	$0, mreader
	jne	.LBB17_23
# BB#1:
	cmpl	$32767, -8(%rbp)        # imm = 0x7FFF
	ja	.LBB17_23
# BB#2:
	cmpl	$16383, -8(%rbp)        # imm = 0x3FFF
	ja	.LBB17_12
# BB#3:
	cmpl	$0, -8(%rbp)
	jb	.LBB17_12
# BB#4:
	movsbl	-21(%rbp), %eax
	cmpl	$114, %eax
	jne	.LBB17_9
# BB#5:
	cmpl	$1, -20(%rbp)
	jne	.LBB17_7
# BB#6:
	movl	-8(%rbp), %eax
	movq	ROM, %rcx
	movb	(%rcx,%rax), %dl
	movq	-16(%rbp), %rax
	movb	%dl, (%rax)
	jmp	.LBB17_8
.LBB17_7:
	movq	-16(%rbp), %rdi
	movq	ROM, %rax
	movl	-8(%rbp), %ecx
	addq	%rax, %rcx
	movslq	-20(%rbp), %rdx
	movq	%rcx, %rsi
	callq	memcpy
.LBB17_8:
	movl	$0, -4(%rbp)
	jmp	.LBB17_168
.LBB17_9:
	movsbl	-21(%rbp), %eax
	cmpl	$119, %eax
	jne	.LBB17_11
# BB#10:
	movl	$-4, -4(%rbp)
	jmp	.LBB17_168
.LBB17_11:
.LBB17_12:
	cmpl	$32767, -8(%rbp)        # imm = 0x7FFF
	ja	.LBB17_22
# BB#13:
	cmpl	$16384, -8(%rbp)        # imm = 0x4000
	jb	.LBB17_22
# BB#14:
	movsbl	-21(%rbp), %eax
	cmpl	$114, %eax
	jne	.LBB17_19
# BB#15:
	cmpl	$1, -20(%rbp)
	jne	.LBB17_17
# BB#16:
	movl	-8(%rbp), %eax
	movq	ROM, %rcx
	movb	(%rcx,%rax), %dl
	movq	-16(%rbp), %rax
	movb	%dl, (%rax)
	jmp	.LBB17_18
.LBB17_17:
	movq	-16(%rbp), %rdi
	movq	ROM, %rax
	movl	-8(%rbp), %ecx
	addq	%rax, %rcx
	movslq	-20(%rbp), %rdx
	movq	%rcx, %rsi
	callq	memcpy
.LBB17_18:
	movl	$0, -4(%rbp)
	jmp	.LBB17_168
.LBB17_19:
	movsbl	-21(%rbp), %eax
	cmpl	$119, %eax
	jne	.LBB17_21
# BB#20:
	movl	$-4, -4(%rbp)
	jmp	.LBB17_168
.LBB17_21:
.LBB17_22:
	jmp	.LBB17_31
.LBB17_23:
	cmpl	$32767, -8(%rbp)        # imm = 0x7FFF
	ja	.LBB17_30
# BB#24:
	movsbl	-21(%rbp), %eax
	cmpl	$114, %eax
	jne	.LBB17_28
# BB#25:
	movq	mreader, %rax
	movl	-8(%rbp), %ecx
	movw	%cx, %dx
	movzwl	%dx, %edi
	movq	%rax, -48(%rbp)         # 8-byte Spill
	movb	$0, %al
	movq	-48(%rbp), %rsi         # 8-byte Reload
	callq	*%rsi
	movq	-16(%rbp), %rsi
	movb	%al, (%rsi)
	cmpl	$2, -20(%rbp)
	jne	.LBB17_27
# BB#26:
	movq	mreader, %rax
	movl	-8(%rbp), %ecx
	movw	%cx, %dx
	movzwl	%dx, %ecx
	addl	$1, %ecx
	movl	%ecx, %edi
	movq	%rax, -56(%rbp)         # 8-byte Spill
	movb	$0, %al
	movq	-56(%rbp), %rsi         # 8-byte Reload
	callq	*%rsi
	movq	-16(%rbp), %rsi
	movb	%al, 1(%rsi)
.LBB17_27:
	jmp	.LBB17_29
.LBB17_28:
	movl	$1, %edx
	movq	mwriter, %rax
	movl	-8(%rbp), %ecx
	movw	%cx, %si
	movzwl	%si, %edi
	movq	-16(%rbp), %r8
	movzbl	(%r8), %esi
	movq	%rax, -64(%rbp)         # 8-byte Spill
	movb	$0, %al
	movq	-64(%rbp), %r8          # 8-byte Reload
	callq	*%r8
.LBB17_29:
	movl	$0, -4(%rbp)
	jmp	.LBB17_168
.LBB17_30:
.LBB17_31:
	cmpl	$32768, -8(%rbp)        # imm = 0x8000
	jb	.LBB17_49
# BB#32:
	cmpl	$40959, -8(%rbp)        # imm = 0x9FFF
	ja	.LBB17_49
# BB#33:
	movl	-8(%rbp), %eax
	subl	$32768, %eax            # imm = 0x8000
	movl	%eax, -8(%rbp)
	movsbl	-21(%rbp), %eax
	cmpl	$114, %eax
	jne	.LBB17_38
# BB#34:
	cmpl	$1, -20(%rbp)
	jne	.LBB17_36
# BB#35:
	movl	-8(%rbp), %eax
	movq	VRAM, %rcx
	movb	(%rcx,%rax), %dl
	movq	-16(%rbp), %rax
	movb	%dl, (%rax)
	jmp	.LBB17_37
.LBB17_36:
	movq	-16(%rbp), %rdi
	movq	VRAM, %rax
	movl	-8(%rbp), %ecx
	addq	%rax, %rcx
	movslq	-20(%rbp), %rdx
	movq	%rcx, %rsi
	callq	memcpy
.LBB17_37:
	movl	$0, -4(%rbp)
	jmp	.LBB17_168
.LBB17_38:
	movsbl	-21(%rbp), %eax
	cmpl	$119, %eax
	jne	.LBB17_48
# BB#39:
	cmpl	$1, -20(%rbp)
	jne	.LBB17_41
# BB#40:
	movq	-16(%rbp), %rax
	movb	(%rax), %cl
	movl	-8(%rbp), %eax
	movq	VRAM, %rdx
	movb	%cl, (%rdx,%rax)
	jmp	.LBB17_42
.LBB17_41:
	movq	VRAM, %rax
	movl	-8(%rbp), %ecx
	addq	%rax, %rcx
	movq	-16(%rbp), %rsi
	movslq	-20(%rbp), %rdx
	movq	%rcx, %rdi
	callq	memcpy
.LBB17_42:
	cmpl	$6143, -8(%rbp)         # imm = 0x17FF
	ja	.LBB17_47
# BB#43:
	cmpl	$0, -8(%rbp)
	jb	.LBB17_47
# BB#44:
	movl	-8(%rbp), %eax
	movw	%ax, %cx
	movw	%cx, -24(%rbp)
	movsbl	-21(%rbp), %eax
	cmpl	$119, %eax
	jne	.LBB17_46
# BB#45:
	movzwl	-24(%rbp), %edi
	callq	writeTileMem
	movl	$0, -4(%rbp)
	jmp	.LBB17_168
.LBB17_46:
.LBB17_47:
	movl	$0, -4(%rbp)
	jmp	.LBB17_168
.LBB17_48:
.LBB17_49:
	cmpl	$49151, -8(%rbp)        # imm = 0xBFFF
	ja	.LBB17_88
# BB#50:
	cmpl	$40960, -8(%rbp)        # imm = 0xA000
	jb	.LBB17_88
# BB#51:
	cmpq	$0, mwriter
	jne	.LBB17_63
# BB#52:
	movl	-8(%rbp), %eax
	subl	$40960, %eax            # imm = 0xA000
	movl	%eax, -8(%rbp)
	movsbl	-21(%rbp), %eax
	cmpl	$114, %eax
	jne	.LBB17_57
# BB#53:
	cmpl	$1, -20(%rbp)
	jne	.LBB17_55
# BB#54:
	movl	-8(%rbp), %eax
	movq	ERAM, %rcx
	movb	(%rcx,%rax), %dl
	movq	-16(%rbp), %rax
	movb	%dl, (%rax)
	jmp	.LBB17_56
.LBB17_55:
	movq	-16(%rbp), %rdi
	movq	ERAM, %rax
	movl	-8(%rbp), %ecx
	addq	%rax, %rcx
	movslq	-20(%rbp), %rdx
	movq	%rcx, %rsi
	callq	memcpy
.LBB17_56:
	movl	$0, -4(%rbp)
	jmp	.LBB17_168
.LBB17_57:
	movsbl	-21(%rbp), %eax
	cmpl	$119, %eax
	jne	.LBB17_62
# BB#58:
	cmpl	$1, -20(%rbp)
	jne	.LBB17_60
# BB#59:
	movq	-16(%rbp), %rax
	movb	(%rax), %cl
	movl	-8(%rbp), %eax
	movq	ERAM, %rdx
	movb	%cl, (%rdx,%rax)
	jmp	.LBB17_61
.LBB17_60:
	movq	ERAM, %rax
	movl	-8(%rbp), %ecx
	addq	%rax, %rcx
	movq	-16(%rbp), %rsi
	movslq	-20(%rbp), %rdx
	movq	%rcx, %rdi
	callq	memcpy
.LBB17_61:
	movl	$0, -4(%rbp)
	jmp	.LBB17_168
.LBB17_62:
	jmp	.LBB17_87
.LBB17_63:
	movsbl	-21(%rbp), %eax
	cmpl	$114, %eax
	jne	.LBB17_75
# BB#64:
	cmpl	$1, -20(%rbp)
	je	.LBB17_66
# BB#65:
	cmpl	$2, -20(%rbp)
	jne	.LBB17_69
.LBB17_66:
	movq	mreader, %rax
	movl	-8(%rbp), %ecx
	movw	%cx, %dx
	movzwl	%dx, %edi
	movq	%rax, -72(%rbp)         # 8-byte Spill
	movb	$0, %al
	movq	-72(%rbp), %rsi         # 8-byte Reload
	callq	*%rsi
	movq	-16(%rbp), %rsi
	movb	%al, (%rsi)
	cmpl	$2, -20(%rbp)
	jne	.LBB17_68
# BB#67:
	movq	mreader, %rax
	movl	-8(%rbp), %ecx
	movw	%cx, %dx
	movzwl	%dx, %ecx
	addl	$1, %ecx
	movl	%ecx, %edi
	movq	%rax, -80(%rbp)         # 8-byte Spill
	movb	$0, %al
	movq	-80(%rbp), %rsi         # 8-byte Reload
	callq	*%rsi
	movq	-16(%rbp), %rsi
	movb	%al, 1(%rsi)
.LBB17_68:
	jmp	.LBB17_74
.LBB17_69:
	movl	$0, -28(%rbp)
.LBB17_70:                              # =>This Inner Loop Header: Depth=1
	movl	-28(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB17_73
# BB#71:                                #   in Loop: Header=BB17_70 Depth=1
	movq	mreader, %rax
	movl	-8(%rbp), %ecx
	movw	%cx, %dx
	movzwl	%dx, %ecx
	addl	-28(%rbp), %ecx
	movl	%ecx, %edi
	movq	%rax, -88(%rbp)         # 8-byte Spill
	movb	$0, %al
	movq	-88(%rbp), %rsi         # 8-byte Reload
	callq	*%rsi
	movslq	-28(%rbp), %rsi
	movq	-16(%rbp), %r8
	movb	%al, (%r8,%rsi)
# BB#72:                                #   in Loop: Header=BB17_70 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB17_70
.LBB17_73:
.LBB17_74:
	jmp	.LBB17_86
.LBB17_75:
	cmpl	$1, -20(%rbp)
	je	.LBB17_77
# BB#76:
	cmpl	$2, -20(%rbp)
	jne	.LBB17_80
.LBB17_77:
	movl	$1, %edx
	movq	mwriter, %rax
	movl	-8(%rbp), %ecx
	movw	%cx, %si
	movzwl	%si, %edi
	movq	-16(%rbp), %r8
	movzbl	(%r8), %esi
	movq	%rax, -96(%rbp)         # 8-byte Spill
	movb	$0, %al
	movq	-96(%rbp), %r8          # 8-byte Reload
	callq	*%r8
	cmpl	$2, -20(%rbp)
	jne	.LBB17_79
# BB#78:
	movl	$1, %edx
	movq	mwriter, %rax
	movl	-8(%rbp), %ecx
	movw	%cx, %si
	movzwl	%si, %ecx
	addl	$1, %ecx
	movq	-16(%rbp), %rdi
	movzbl	1(%rdi), %esi
	movl	%ecx, %edi
	movq	%rax, -104(%rbp)        # 8-byte Spill
	movb	$0, %al
	movq	-104(%rbp), %r8         # 8-byte Reload
	callq	*%r8
.LBB17_79:
	jmp	.LBB17_85
.LBB17_80:
	movl	$0, -28(%rbp)
.LBB17_81:                              # =>This Inner Loop Header: Depth=1
	movl	-28(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	.LBB17_84
# BB#82:                                #   in Loop: Header=BB17_81 Depth=1
	movl	$1, %edx
	movq	mwriter, %rax
	movl	-8(%rbp), %ecx
	movw	%cx, %si
	movzwl	%si, %ecx
	addl	-28(%rbp), %ecx
	movslq	-28(%rbp), %rdi
	movq	-16(%rbp), %r8
	movzbl	(%r8,%rdi), %esi
	movl	%ecx, %edi
	movq	%rax, -112(%rbp)        # 8-byte Spill
	movb	$0, %al
	movq	-112(%rbp), %r8         # 8-byte Reload
	callq	*%r8
# BB#83:                                #   in Loop: Header=BB17_81 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB17_81
.LBB17_84:
.LBB17_85:
.LBB17_86:
	movl	$0, -4(%rbp)
	jmp	.LBB17_168
.LBB17_87:
.LBB17_88:
	cmpl	$57343, -8(%rbp)        # imm = 0xDFFF
	ja	.LBB17_101
# BB#89:
	cmpl	$49152, -8(%rbp)        # imm = 0xC000
	jb	.LBB17_101
# BB#90:
	movl	-8(%rbp), %eax
	subl	$49152, %eax            # imm = 0xC000
	movl	%eax, -8(%rbp)
	movsbl	-21(%rbp), %eax
	cmpl	$114, %eax
	jne	.LBB17_95
# BB#91:
	cmpl	$1, -20(%rbp)
	jne	.LBB17_93
# BB#92:
	movl	-8(%rbp), %eax
	movq	WRAM1, %rcx
	movb	(%rcx,%rax), %dl
	movq	-16(%rbp), %rax
	movb	%dl, (%rax)
	jmp	.LBB17_94
.LBB17_93:
	movq	-16(%rbp), %rdi
	movq	WRAM1, %rax
	movl	-8(%rbp), %ecx
	addq	%rax, %rcx
	movslq	-20(%rbp), %rdx
	movq	%rcx, %rsi
	callq	memcpy
.LBB17_94:
	movl	$0, -4(%rbp)
	jmp	.LBB17_168
.LBB17_95:
	movsbl	-21(%rbp), %eax
	cmpl	$119, %eax
	jne	.LBB17_100
# BB#96:
	cmpl	$1, -20(%rbp)
	jne	.LBB17_98
# BB#97:
	movq	-16(%rbp), %rax
	movb	(%rax), %cl
	movl	-8(%rbp), %eax
	movq	WRAM1, %rdx
	movb	%cl, (%rdx,%rax)
	jmp	.LBB17_99
.LBB17_98:
	movq	WRAM1, %rax
	movl	-8(%rbp), %ecx
	addq	%rax, %rcx
	movq	-16(%rbp), %rsi
	movslq	-20(%rbp), %rdx
	movq	%rcx, %rdi
	callq	memcpy
.LBB17_99:
	movl	$0, -4(%rbp)
	jmp	.LBB17_168
.LBB17_100:
.LBB17_101:
	cmpl	$65023, -8(%rbp)        # imm = 0xFDFF
	ja	.LBB17_114
# BB#102:
	cmpl	$57344, -8(%rbp)        # imm = 0xE000
	jb	.LBB17_114
# BB#103:
	movl	-8(%rbp), %eax
	subl	$57344, %eax            # imm = 0xE000
	movl	%eax, -8(%rbp)
	movsbl	-21(%rbp), %eax
	cmpl	$114, %eax
	jne	.LBB17_108
# BB#104:
	cmpl	$1, -20(%rbp)
	jne	.LBB17_106
# BB#105:
	movl	-8(%rbp), %eax
	movq	WRAM1, %rcx
	movb	(%rcx,%rax), %dl
	movq	-16(%rbp), %rax
	movb	%dl, (%rax)
	jmp	.LBB17_107
.LBB17_106:
	movq	-16(%rbp), %rdi
	movq	WRAM1, %rax
	movl	-8(%rbp), %ecx
	addq	%rax, %rcx
	movslq	-20(%rbp), %rdx
	movq	%rcx, %rsi
	callq	memcpy
.LBB17_107:
	movl	$0, -4(%rbp)
	jmp	.LBB17_168
.LBB17_108:
	movsbl	-21(%rbp), %eax
	cmpl	$119, %eax
	jne	.LBB17_113
# BB#109:
	cmpl	$1, -20(%rbp)
	jne	.LBB17_111
# BB#110:
	movq	-16(%rbp), %rax
	movb	(%rax), %cl
	movl	-8(%rbp), %eax
	movq	WRAM1, %rdx
	movb	%cl, (%rdx,%rax)
	jmp	.LBB17_112
.LBB17_111:
	movq	WRAM1, %rax
	movl	-8(%rbp), %ecx
	addq	%rax, %rcx
	movq	-16(%rbp), %rsi
	movslq	-20(%rbp), %rdx
	movq	%rcx, %rdi
	callq	memcpy
.LBB17_112:
	movl	$0, -4(%rbp)
	jmp	.LBB17_168
.LBB17_113:
.LBB17_114:
	cmpl	$65183, -8(%rbp)        # imm = 0xFE9F
	ja	.LBB17_127
# BB#115:
	cmpl	$65024, -8(%rbp)        # imm = 0xFE00
	jb	.LBB17_127
# BB#116:
	movl	-8(%rbp), %eax
	subl	$65024, %eax            # imm = 0xFE00
	movl	%eax, -8(%rbp)
	movsbl	-21(%rbp), %eax
	cmpl	$114, %eax
	jne	.LBB17_121
# BB#117:
	cmpl	$1, -20(%rbp)
	jne	.LBB17_119
# BB#118:
	movl	-8(%rbp), %eax
	movq	OAM, %rcx
	movb	(%rcx,%rax), %dl
	movq	-16(%rbp), %rax
	movb	%dl, (%rax)
	jmp	.LBB17_120
.LBB17_119:
	movq	-16(%rbp), %rdi
	movq	OAM, %rax
	movl	-8(%rbp), %ecx
	addq	%rax, %rcx
	movslq	-20(%rbp), %rdx
	movq	%rcx, %rsi
	callq	memcpy
.LBB17_120:
	movl	$0, -4(%rbp)
	jmp	.LBB17_168
.LBB17_121:
	movsbl	-21(%rbp), %eax
	cmpl	$119, %eax
	jne	.LBB17_126
# BB#122:
	cmpl	$1, -20(%rbp)
	jne	.LBB17_124
# BB#123:
	movq	-16(%rbp), %rax
	movb	(%rax), %cl
	movl	-8(%rbp), %eax
	movq	OAM, %rdx
	movb	%cl, (%rdx,%rax)
	jmp	.LBB17_125
.LBB17_124:
	movq	OAM, %rax
	movl	-8(%rbp), %ecx
	addq	%rax, %rcx
	movq	-16(%rbp), %rsi
	movslq	-20(%rbp), %rdx
	movq	%rcx, %rdi
	callq	memcpy
.LBB17_125:
	movl	$0, -4(%rbp)
	jmp	.LBB17_168
.LBB17_126:
.LBB17_127:
	cmpl	$65407, -8(%rbp)        # imm = 0xFF7F
	ja	.LBB17_154
# BB#128:
	cmpl	$65280, -8(%rbp)        # imm = 0xFF00
	jb	.LBB17_154
# BB#129:
	movl	-8(%rbp), %eax
	subl	$65280, %eax            # imm = 0xFF00
	movw	%ax, %cx
	movw	%cx, -30(%rbp)
	movsbl	-21(%rbp), %eax
	cmpl	$114, %eax
	jne	.LBB17_134
# BB#130:
	cmpl	$1, -20(%rbp)
	jne	.LBB17_132
# BB#131:
	movzwl	-30(%rbp), %eax
	movq	IOBUF, %rcx
	movb	(%rcx,%rax), %dl
	movq	-16(%rbp), %rax
	movb	%dl, (%rax)
	jmp	.LBB17_133
.LBB17_132:
	movq	-16(%rbp), %rdi
	movq	IOBUF, %rax
	movzwl	-30(%rbp), %ecx
	movslq	%ecx, %rdx
	addq	%rax, %rdx
	movslq	-20(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdx
	callq	memcpy
.LBB17_133:
	movl	$0, -4(%rbp)
	jmp	.LBB17_168
.LBB17_134:
	movsbl	-21(%rbp), %eax
	cmpl	$119, %eax
	jne	.LBB17_153
# BB#135:
	cmpl	$1, -20(%rbp)
	jne	.LBB17_137
# BB#136:
	movq	-16(%rbp), %rax
	movb	(%rax), %cl
	movzwl	-30(%rbp), %eax
	movq	IOBUF, %rdx
	movb	%cl, (%rdx,%rax)
	jmp	.LBB17_138
.LBB17_137:
	movq	IOBUF, %rax
	movzwl	-30(%rbp), %ecx
	movslq	%ecx, %rdx
	addq	%rax, %rdx
	movq	-16(%rbp), %rsi
	movslq	-20(%rbp), %rax
	movq	%rdx, %rdi
	movq	%rax, %rdx
	callq	memcpy
.LBB17_138:
	cmpl	$65350, -8(%rbp)        # imm = 0xFF46
	jne	.LBB17_140
# BB#139:
	movq	-16(%rbp), %rax
	movzbl	(%rax), %edi
	callq	doDma
	jmp	.LBB17_152
.LBB17_140:
	cmpl	$65280, -8(%rbp)        # imm = 0xFF00
	jne	.LBB17_142
# BB#141:
	callq	changeJpRegs
	jmp	.LBB17_151
.LBB17_142:
	cmpl	$65351, -8(%rbp)        # imm = 0xFF47
	jne	.LBB17_144
# BB#143:
	movq	-16(%rbp), %rax
	movb	(%rax), %cl
	movb	%cl, -31(%rbp)
	movzbl	-31(%rbp), %edx
	andl	$3, %edx
	movb	%dl, %cl
	movb	%cl, bgp
	movzbl	-31(%rbp), %edx
	sarl	$2, %edx
	andl	$3, %edx
	movb	%dl, %cl
	movb	%cl, bgp+1
	movzbl	-31(%rbp), %edx
	sarl	$4, %edx
	andl	$3, %edx
	movb	%dl, %cl
	movb	%cl, bgp+2
	movzbl	-31(%rbp), %edx
	sarl	$6, %edx
	andl	$3, %edx
	movb	%dl, %cl
	movb	%cl, bgp+3
	jmp	.LBB17_150
.LBB17_144:
	cmpl	$65352, -8(%rbp)        # imm = 0xFF48
	jne	.LBB17_146
# BB#145:
	movq	-16(%rbp), %rax
	movb	(%rax), %cl
	movb	%cl, -32(%rbp)
	movzbl	-32(%rbp), %edx
	andl	$3, %edx
	movb	%dl, %cl
	movb	%cl, sgp1
	movzbl	-32(%rbp), %edx
	sarl	$2, %edx
	andl	$3, %edx
	movb	%dl, %cl
	movb	%cl, sgp1+1
	movzbl	-32(%rbp), %edx
	sarl	$4, %edx
	andl	$3, %edx
	movb	%dl, %cl
	movb	%cl, sgp1+2
	movzbl	-32(%rbp), %edx
	sarl	$6, %edx
	andl	$3, %edx
	movb	%dl, %cl
	movb	%cl, sgp1+3
	jmp	.LBB17_149
.LBB17_146:
	cmpl	$65353, -8(%rbp)        # imm = 0xFF49
	jne	.LBB17_148
# BB#147:
	movq	-16(%rbp), %rax
	movb	(%rax), %cl
	movb	%cl, -33(%rbp)
	movzbl	-33(%rbp), %edx
	andl	$3, %edx
	movb	%dl, %cl
	movb	%cl, sgp2
	movzbl	-33(%rbp), %edx
	sarl	$2, %edx
	andl	$3, %edx
	movb	%dl, %cl
	movb	%cl, sgp2+1
	movzbl	-33(%rbp), %edx
	sarl	$4, %edx
	andl	$3, %edx
	movb	%dl, %cl
	movb	%cl, sgp2+2
	movzbl	-33(%rbp), %edx
	sarl	$6, %edx
	andl	$3, %edx
	movb	%dl, %cl
	movb	%cl, sgp2+3
.LBB17_148:
.LBB17_149:
.LBB17_150:
.LBB17_151:
.LBB17_152:
	movl	$0, -4(%rbp)
	jmp	.LBB17_168
.LBB17_153:
.LBB17_154:
	cmpl	$65535, -8(%rbp)        # imm = 0xFFFF
	ja	.LBB17_167
# BB#155:
	cmpl	$65408, -8(%rbp)        # imm = 0xFF80
	jb	.LBB17_167
# BB#156:
	movl	-8(%rbp), %eax
	subl	$65408, %eax            # imm = 0xFF80
	movl	%eax, -8(%rbp)
	movsbl	-21(%rbp), %eax
	cmpl	$114, %eax
	jne	.LBB17_161
# BB#157:
	cmpl	$1, -20(%rbp)
	jne	.LBB17_159
# BB#158:
	movl	-8(%rbp), %eax
	movq	HRAM, %rcx
	movb	(%rcx,%rax), %dl
	movq	-16(%rbp), %rax
	movb	%dl, (%rax)
	jmp	.LBB17_160
.LBB17_159:
	movq	-16(%rbp), %rdi
	movq	HRAM, %rax
	movl	-8(%rbp), %ecx
	addq	%rax, %rcx
	movslq	-20(%rbp), %rdx
	movq	%rcx, %rsi
	callq	memcpy
.LBB17_160:
	movl	$0, -4(%rbp)
	jmp	.LBB17_168
.LBB17_161:
	movsbl	-21(%rbp), %eax
	cmpl	$119, %eax
	jne	.LBB17_166
# BB#162:
	cmpl	$1, -20(%rbp)
	jne	.LBB17_164
# BB#163:
	movq	-16(%rbp), %rax
	movb	(%rax), %cl
	movl	-8(%rbp), %eax
	movq	HRAM, %rdx
	movb	%cl, (%rdx,%rax)
	jmp	.LBB17_165
.LBB17_164:
	movq	HRAM, %rax
	movl	-8(%rbp), %ecx
	addq	%rax, %rcx
	movq	-16(%rbp), %rsi
	movslq	-20(%rbp), %rdx
	movq	%rcx, %rdi
	callq	memcpy
.LBB17_165:
	movl	$0, -4(%rbp)
	jmp	.LBB17_168
.LBB17_166:
.LBB17_167:
	movl	$-1, -4(%rbp)
.LBB17_168:
	movl	-4(%rbp), %eax
	addq	$112, %rsp
	popq	%rbp
	ret
.Ltmp112:
	.size	map, .Ltmp112-map
.Ltmp113:
	.cfi_endproc
.Leh_func_end17:

	.globl	writeByte
	.align	16, 0x90
	.type	writeByte,@function
writeByte:                              # @writeByte
.Ltmp116:
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp117:
	.cfi_def_cfa_offset 16
.Ltmp118:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp119:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movb	%dil, %al
	leaq	-1(%rbp), %rdi
	movabsq	$1, %rcx
	movb	%al, -1(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rsi
	movq	%rsi, -24(%rbp)         # 8-byte Spill
	movq	%rcx, %rsi
	movq	%rcx, %rdx
	movq	-24(%rbp), %rcx         # 8-byte Reload
	callq	fwrite
	movq	%rax, -32(%rbp)         # 8-byte Spill
	addq	$32, %rsp
	popq	%rbp
	ret
.Ltmp120:
	.size	writeByte, .Ltmp120-writeByte
.Ltmp121:
	.cfi_endproc
.Leh_func_end18:

	.globl	writeWord
	.align	16, 0x90
	.type	writeWord,@function
writeWord:                              # @writeWord
.Ltmp124:
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp125:
	.cfi_def_cfa_offset 16
.Ltmp126:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp127:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movw	%di, %ax
	movabsq	$2, %rcx
	movabsq	$1, %rdx
	leaq	-2(%rbp), %r8
	movw	%ax, -2(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rsi
	movq	%r8, %rdi
	movq	%rsi, -24(%rbp)         # 8-byte Spill
	movq	%rcx, %rsi
	movq	-24(%rbp), %rcx         # 8-byte Reload
	callq	fwrite
	movq	%rax, -32(%rbp)         # 8-byte Spill
	addq	$32, %rsp
	popq	%rbp
	ret
.Ltmp128:
	.size	writeWord, .Ltmp128-writeWord
.Ltmp129:
	.cfi_endproc
.Leh_func_end19:

	.globl	readByte
	.align	16, 0x90
	.type	readByte,@function
readByte:                               # @readByte
.Ltmp132:
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp133:
	.cfi_def_cfa_offset 16
.Ltmp134:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp135:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movabsq	$1, %rax
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rcx
	movq	%rax, %rsi
	movq	%rax, %rdx
	callq	fread
	movq	%rax, -24(%rbp)         # 8-byte Spill
	addq	$32, %rsp
	popq	%rbp
	ret
.Ltmp136:
	.size	readByte, .Ltmp136-readByte
.Ltmp137:
	.cfi_endproc
.Leh_func_end20:

	.globl	readWord
	.align	16, 0x90
	.type	readWord,@function
readWord:                               # @readWord
.Ltmp140:
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp141:
	.cfi_def_cfa_offset 16
.Ltmp142:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp143:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movabsq	$2, %rax
	movabsq	$1, %rdx
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rsi
	movq	-16(%rbp), %rcx
	movq	%rsi, %rdi
	movq	%rax, %rsi
	callq	fread
	movq	%rax, -24(%rbp)         # 8-byte Spill
	addq	$32, %rsp
	popq	%rbp
	ret
.Ltmp144:
	.size	readWord, .Ltmp144-readWord
.Ltmp145:
	.cfi_endproc
.Leh_func_end21:

	.globl	saveState
	.align	16, 0x90
	.type	saveState,@function
saveState:                              # @saveState
.Ltmp148:
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp149:
	.cfi_def_cfa_offset 16
.Ltmp150:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp151:
	.cfi_def_cfa_register %rbp
	subq	$80, %rsp
	leaq	.L.str, %rsi
	movq	%rdi, -8(%rbp)
	movl	$0, -20(%rbp)
	movq	-8(%rbp), %rdi
	callq	fopen
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB22_2
# BB#1:
	leaq	.L.str1, %rsi
	movq	stderr, %rdi
	movb	$0, %al
	callq	fprintf
	movl	%eax, -28(%rbp)         # 4-byte Spill
	jmp	.LBB22_7
.LBB22_2:
	movl	$0, -20(%rbp)
.LBB22_3:                               # =>This Inner Loop Header: Depth=1
	cmpl	$65535, -20(%rbp)       # imm = 0xFFFF
	jg	.LBB22_6
# BB#4:                                 #   in Loop: Header=BB22_3 Depth=1
	leaq	-21(%rbp), %rsi
	movl	$1, %edx
	movl	$114, %ecx
	movl	-20(%rbp), %edi
	callq	map
	leaq	-21(%rbp), %rdi
	movabsq	$1, %rsi
	movq	-16(%rbp), %rcx
	movq	%rsi, -40(%rbp)         # 8-byte Spill
	movq	-40(%rbp), %rdx         # 8-byte Reload
	movl	%eax, -44(%rbp)         # 4-byte Spill
	callq	fwrite
	movq	%rax, -56(%rbp)         # 8-byte Spill
# BB#5:                                 #   in Loop: Header=BB22_3 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB22_3
.LBB22_6:
	movabsq	$1, %rsi
	movabsq	$32768, %rdx            # imm = 0x8000
	movq	ERAM, %rdi
	movq	-16(%rbp), %rcx
	callq	fwrite
	movb	OLDDIV, %r8b
	movq	-16(%rbp), %rsi
	movzbl	%r8b, %edi
	movq	%rax, -64(%rbp)         # 8-byte Spill
	callq	writeByte
	movb	IEMASTER, %r8b
	movq	-16(%rbp), %rsi
	movzbl	%r8b, %edi
	callq	writeByte
	movb	IEMASTERR, %r8b
	movq	-16(%rbp), %rsi
	movzbl	%r8b, %edi
	callq	writeByte
	movb	ICLK, %r8b
	movq	-16(%rbp), %rsi
	movzbl	%r8b, %edi
	callq	writeByte
	movb	ICLKE, %r8b
	movq	-16(%rbp), %rsi
	movzbl	%r8b, %edi
	callq	writeByte
	movl	$1, %edi
	callq	read8r
	movq	-16(%rbp), %rsi
	movzbl	%al, %edi
	callq	writeByte
	movl	$2, %edi
	callq	read8r
	movq	-16(%rbp), %rsi
	movzbl	%al, %edi
	callq	writeByte
	movl	$3, %edi
	callq	read8r
	movq	-16(%rbp), %rsi
	movzbl	%al, %edi
	callq	writeByte
	movl	$4, %edi
	callq	read8r
	movq	-16(%rbp), %rsi
	movzbl	%al, %edi
	callq	writeByte
	movl	$5, %edi
	callq	read8r
	movq	-16(%rbp), %rsi
	movzbl	%al, %edi
	callq	writeByte
	movl	$6, %edi
	callq	read8r
	movq	-16(%rbp), %rsi
	movzbl	%al, %edi
	callq	writeByte
	movl	$7, %edi
	callq	read8r
	movq	-16(%rbp), %rsi
	movzbl	%al, %edi
	callq	writeByte
	movl	$8, %edi
	callq	read8r
	movq	-16(%rbp), %rsi
	movzbl	%al, %edi
	callq	writeByte
	movl	$9, %edi
	callq	read16r
	movq	-16(%rbp), %rsi
	movzwl	%ax, %edi
	callq	writeWord
	movl	$10, %edi
	callq	read16r
	movq	-16(%rbp), %rsi
	movzwl	%ax, %edi
	callq	writeWord
	movq	-16(%rbp), %rdi
	callq	fclose
	movl	%eax, -68(%rbp)         # 4-byte Spill
.LBB22_7:
	addq	$80, %rsp
	popq	%rbp
	ret
.Ltmp152:
	.size	saveState, .Ltmp152-saveState
.Ltmp153:
	.cfi_endproc
.Leh_func_end22:

	.globl	loadState
	.align	16, 0x90
	.type	loadState,@function
loadState:                              # @loadState
.Ltmp156:
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp157:
	.cfi_def_cfa_offset 16
.Ltmp158:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp159:
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	leaq	.L.str2, %rsi
	movq	%rdi, -8(%rbp)
	movl	$0, -20(%rbp)
	movq	-8(%rbp), %rdi
	callq	fopen
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.LBB23_2
# BB#1:
	leaq	.L.str3, %rsi
	movq	stderr, %rdi
	movb	$0, %al
	callq	fprintf
	movl	%eax, -28(%rbp)         # 4-byte Spill
	jmp	.LBB23_7
.LBB23_2:
	movl	$0, -20(%rbp)
.LBB23_3:                               # =>This Inner Loop Header: Depth=1
	cmpl	$65535, -20(%rbp)       # imm = 0xFFFF
	jg	.LBB23_6
# BB#4:                                 #   in Loop: Header=BB23_3 Depth=1
	leaq	-21(%rbp), %rdi
	movabsq	$1, %rax
	movq	-16(%rbp), %rcx
	movq	%rax, %rsi
	movq	%rax, %rdx
	callq	fread
	leaq	-21(%rbp), %rsi
	movl	$1, %edx
	movl	$119, %ecx
	movl	-20(%rbp), %edi
	movq	%rax, -40(%rbp)         # 8-byte Spill
	callq	map
	movl	%eax, -44(%rbp)         # 4-byte Spill
# BB#5:                                 #   in Loop: Header=BB23_3 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB23_3
.LBB23_6:
	movabsq	$1, %rsi
	movabsq	$32768, %rdx            # imm = 0x8000
	movq	ERAM, %rdi
	movq	-16(%rbp), %rcx
	callq	fread
	leaq	OLDDIV, %rdi
	movq	-16(%rbp), %rsi
	movq	%rax, -56(%rbp)         # 8-byte Spill
	callq	readByte
	leaq	IEMASTER, %rdi
	movq	-16(%rbp), %rsi
	callq	readByte
	leaq	IEMASTERR, %rdi
	movq	-16(%rbp), %rsi
	callq	readByte
	leaq	ICLK, %rdi
	movq	-16(%rbp), %rsi
	callq	readByte
	leaq	ICLKE, %rdi
	movq	-16(%rbp), %rsi
	callq	readByte
	leaq	-21(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	readByte
	movl	$1, %edi
	movzbl	-21(%rbp), %esi
	callq	write8r
	leaq	-21(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	readByte
	movl	$2, %edi
	movzbl	-21(%rbp), %esi
	callq	write8r
	leaq	-21(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	readByte
	movl	$3, %edi
	movzbl	-21(%rbp), %esi
	callq	write8r
	leaq	-21(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	readByte
	movl	$4, %edi
	movzbl	-21(%rbp), %esi
	callq	write8r
	leaq	-21(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	readByte
	movl	$5, %edi
	movzbl	-21(%rbp), %esi
	callq	write8r
	leaq	-21(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	readByte
	movl	$6, %edi
	movzbl	-21(%rbp), %esi
	callq	write8r
	leaq	-21(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	readByte
	movl	$7, %edi
	movzbl	-21(%rbp), %esi
	callq	write8r
	leaq	-21(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	readByte
	movl	$8, %edi
	movzbl	-21(%rbp), %esi
	callq	write8r
	leaq	-24(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	readWord
	movl	$9, %edi
	movzwl	-24(%rbp), %esi
	callq	write16r
	leaq	-24(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	readWord
	movl	$10, %edi
	movzwl	-24(%rbp), %esi
	callq	write16r
.LBB23_7:
	addq	$64, %rsp
	popq	%rbp
	ret
.Ltmp160:
	.size	loadState, .Ltmp160-loadState
.Ltmp161:
	.cfi_endproc
.Leh_func_end23:

	.type	dmaOffset,@object       # @dmaOffset
	.bss
	.globl	dmaOffset
	.align	2
dmaOffset:
	.short	0                       # 0x0
	.size	dmaOffset, 2

	.type	HRAM,@object            # @HRAM
	.comm	HRAM,8,8
	.type	IOBUF,@object           # @IOBUF
	.comm	IOBUF,8,8
	.type	VRAM,@object            # @VRAM
	.comm	VRAM,8,8
	.type	ERAM,@object            # @ERAM
	.comm	ERAM,8,8
	.type	WRAM1,@object           # @WRAM1
	.comm	WRAM1,8,8
	.type	WRAM2,@object           # @WRAM2
	.comm	WRAM2,8,8
	.type	OAM,@object             # @OAM
	.comm	OAM,8,8
	.type	tiles,@object           # @tiles
	.comm	tiles,8,8
	.type	jpbuf,@object           # @jpbuf
	.comm	jpbuf,1,1
	.type	MEM,@object             # @MEM
	.comm	MEM,8,8
	.type	mreader,@object         # @mreader
	.comm	mreader,8,8
	.type	mwriter,@object         # @mwriter
	.comm	mwriter,8,8
	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	 "w"
	.size	.L.str, 2

	.type	.L.str1,@object         # @.str1
.L.str1:
	.asciz	 "Problem opening file. State NOT saved.\n"
	.size	.L.str1, 40

	.type	.L.str2,@object         # @.str2
.L.str2:
	.asciz	 "r"
	.size	.L.str2, 2

	.type	.L.str3,@object         # @.str3
.L.str3:
	.asciz	 "Problem opening file. State NOT loaded.\n"
	.size	.L.str3, 41

	.type	map8,@object            # @map8
	.comm	map8,2048,16
	.type	map8arg1,@object        # @map8arg1
	.comm	map8arg1,256,16
	.type	map8arg2,@object        # @map8arg2
	.comm	map8arg2,256,16
	.type	map8icount,@object      # @map8icount
	.comm	map8icount,256,16
	.type	map8timing,@object      # @map8timing
	.comm	map8timing,256,16
	.type	map16,@object           # @map16
	.comm	map16,2048,16
	.type	map16arg,@object        # @map16arg
	.comm	map16arg,256,16
	.type	map16timing,@object     # @map16timing
	.comm	map16timing,256,16
	.type	rmap,@object            # @rmap
	.comm	rmap,72,16
	.type	IEREG,@object           # @IEREG
	.comm	IEREG,1,1

	.section	".note.GNU-stack","",@progbits

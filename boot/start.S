#include "asm.h"
.code16
.globl start
start:
	cli
	
	movw	$0x13, %ax
	int	$0x10

	xorw 	%ax,%ax
	movw	%ax,%ds
	movw	%ax,%es
	movw 	%ax,%ss

	movw 	$0x2401,%ax
	int 	$0x15

	lgdt 	gdtdesc
	movl	%cr0,%eax
	orl	$0x1,%eax
	movl 	%eax,%cr0

	ljmp	$GDT_ENTRY(1),$start32

.code32
start32:
	movw	$GDT_ENTRY(2),%ax
	movw	%ax,%ds
	movw	%ax,%es
	movw	%ax,%ss

	movl	$0x8000,%esp
	call 	bootmain

.p2align 2
gdt:
	SEG_NULLASM
	SEG_ASM(0xa,0x0,0xffffffff)
	SEG_ASM(0x2,0x0,0xffffffff)

gdtdesc:
	.word	(gdtdesc-gdt-1)
	.long	gdt

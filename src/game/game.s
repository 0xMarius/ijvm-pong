/*
This file is part of gamelib-x64.

Copyright (C) 2014 Tim Hegeman

gamelib-x64 is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

gamelib-x64 is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with gamelib-x64. If not, see <http://www.gnu.org/licenses/>.
*/

.file "src/game/game.s"

.global gameInit
.global gameLoop

.section .game.data
	WINDOW_OX:		.int		0x0;
	WINDOW_OY:		.int		0x0;
	WINDOW_X:			.int		0x4F;
	WINDOW_Y:			.int		0x18;
	BALL_X:			.int		0x27;
	BALL_Y:			.int		0xB;
	DIRECTION_X:		.int		0x1;
	DIRECTION_Y:		.int		0x1;
	LEFTPADDLE_Y:		.int		0xB;
	RIGHTPADDLE_Y:		.int		0xB;
	P1_SCORE:			.int		0x30;
	P2_SCORE:			.int		0x30;
	P1_GAMEWIN:		.int		0x0;
	P2_GAMEWIN:		.int		0x0;
	TEMP:			.int		0x0;
.section .game.text

gameInit:
	pushq %rbp
	movq	%rsp, %rbp
	
	movq	%rbp, %rsp
	popq	%rbp
	ret
gameLoop:
	pushq %rbp
	movq	%rsp, %rbp
	
	call	clearScreen
	
	cmp	$0x39, (P1_SCORE)
	jge	drawWinnerP1
	cmp	$0x39, (P2_SCORE)
	jge	drawWinnerP2
	
	movl	(RIGHTPADDLE_Y), %r9d
	movl	(LEFTPADDLE_Y), %r8d
	movl	(P2_SCORE), %eax
	movl	(P1_SCORE), %ebx
	movl	(BALL_Y), %ecx
	movl	(BALL_X), %edx
	movl	(DIRECTION_Y), %esi
	movl	(DIRECTION_X), %edi
	call	moveBall
	movl	(RIGHTPADDLE_Y), %esi
	movl	(LEFTPADDLE_Y), %edi
	call	movePaddles
	
	movq	(BALL_Y), %rsi
	movq	(BALL_X), %rdi
	call	drawBall
	movq	(LEFTPADDLE_Y), %rsi
	call	drawLeftPaddle
	movq	(RIGHTPADDLE_Y), %rsi
	call drawRightPaddle
	call	drawScores
	
	movq	$0x48D378, %rdi
	call	setTimer
	
	jmp	gameLoopEnd
drawWinnerP1:
	movb	$'P', %dl
	movb	$0x0F, %cl
	movq	$0xB, %rsi
	movq	$0x22, %rdi
	call	putChar
	movb	$'l', %dl
	movb	$0x0F, %cl
	movq	$0xB, %rsi
	movq	$0x23, %rdi
	call	putChar
	movb	$'a', %dl
	movb	$0x0F, %cl
	movq	$0xB, %rsi
	movq	$0x24, %rdi
	call	putChar
	movb	$'y', %dl
	movb	$0x0F, %cl
	movq	$0xB, %rsi
	movq	$0x25, %rdi
	call	putChar
	movb	$'e', %dl
	movb	$0x0F, %cl
	movq	$0xB, %rsi
	movq	$0x26, %rdi
	call	putChar
	movb	$'r', %dl
	movb	$0x0F, %cl
	movq	$0xB, %rsi
	movq	$0x27, %rdi
	call	putChar
	movb	$'1', %dl
	movb	$0x0F, %cl
	movq	$0xB, %rsi
	movq	$0x29, %rdi
	call	putChar
	movb	$'W', %dl
	movb	$0x0F, %cl
	movq	$0xB, %rsi
	movq	$0x2B, %rdi
	call	putChar
	movb	$'i', %dl
	movb	$0x0F, %cl
	movq	$0xB, %rsi
	movq	$0x2C, %rdi
	call	putChar
	movb	$'n', %dl
	movb	$0x0F, %cl
	movq	$0xB, %rsi
	movq	$0x2D, %rdi
	call	putChar
	movb	$'s', %dl
	movb	$0x0F, %cl
	movq	$0xB, %rsi
	movq	$0x2E, %rdi
	call	putChar
	
	jmp	gameLoopEnd
drawWinnerP2:
	movb	$'P', %dl
	movb	$0x0F, %cl
	movq	$0xB, %rsi
	movq	$0x22, %rdi
	call	putChar
	movb	$'l', %dl
	movb	$0x0F, %cl
	movq	$0xB, %rsi
	movq	$0x23, %rdi
	call	putChar
	movb	$'a', %dl
	movb	$0x0F, %cl
	movq	$0xB, %rsi
	movq	$0x24, %rdi
	call	putChar
	movb	$'y', %dl
	movb	$0x0F, %cl
	movq	$0xB, %rsi
	movq	$0x25, %rdi
	call	putChar
	movb	$'e', %dl
	movb	$0x0F, %cl
	movq	$0xB, %rsi
	movq	$0x26, %rdi
	call	putChar
	movb	$'r', %dl
	movb	$0x0F, %cl
	movq	$0xB, %rsi
	movq	$0x27, %rdi
	call	putChar
	movb	$'2', %dl
	movb	$0x0F, %cl
	movq	$0xB, %rsi
	movq	$0x29, %rdi
	call	putChar
	movb	$'W', %dl
	movb	$0x0F, %cl
	movq	$0xB, %rsi
	movq	$0x2B, %rdi
	call	putChar
	movb	$'i', %dl
	movb	$0x0F, %cl
	movq	$0xB, %rsi
	movq	$0x2C, %rdi
	call	putChar
	movb	$'n', %dl
	movb	$0x0F, %cl
	movq	$0xB, %rsi
	movq	$0x2D, %rdi
	call	putChar
	movb	$'s', %dl
	movb	$0x0F, %cl
	movq	$0xB, %rsi
	movq	$0x2E, %rdi
	call	putChar
	
	jmp	gameLoopEnd
gameLoopEnd:
	movq	%rbp, %rsp
	popq	%rbp
	ret
clearScreen:
	pushq %rbp
	movq	%rsp, %rbp
	
	movb $' ', %al
	movb $0x0E, %ah
	movq $0x7D0, %rcx
	movq $video_mem_start, %rdi
	cld
	rep stosw
	
	movq	%rbp, %rsp
	popq	%rbp
	ret
movePaddles:
	pushq %rbp
	movq	%rsp, %rbp
	
	call	readKeyCode
	cmpq	$0x1E, %rax
	je	1f
	cmpq	$0x20, %rax
	je	2f
	cmpq	$0x24, %rax
	je	3f
	cmpq	$0x26, %rax
	je	4f
	jmp	5f
fixStartLP:
	mov	$0x0, %edi
	jmp	5f
fixHeightLP:
	mov	$0x18, %edi
	jmp	5f
fixStartRP:
	mov	$0x0, %esi
	jmp	5f
fixHeightRP:
	mov	$0x18, %esi
	jmp	5f
1:
	cmp	$0x0, %edi
	jle	fixStartLP
	dec	%edi
	jmp	5f
2:
	cmp	$0x18, %edi
	jge	fixHeightLP
	inc	%edi
	jmp	5f
3:
	cmp	$0x0, %esi
	jle	fixStartRP
	dec	%esi
	jmp	5f
4:
	cmp	$0x18, %esi
	jge	fixHeightRP
	inc	%esi
	jmp	5f
5:
	movl	%edi, (LEFTPADDLE_Y)
	movl	%esi, (RIGHTPADDLE_Y)
	movq	%rbp, %rsp
	popq	%rbp
	ret
moveBall:
	pushq %rbp
	movq	%rsp, %rbp
checkX:
	cmp	$0x0, %edx
	je	checkLP
	cmp	$0x4F, %edx
	je	checkRP
checkY:
	cmp	$0x0, %ecx
	je	4f
	cmp	$0x18, %ecx
	je	4f
	jmp	5f
checkLP:
	cmp	%ecx, %r8d
	je	extra
	jmp	1f
checkRP:
	cmp	%ecx, %r9d
	je	extra
	jmp	2f
extra:
	neg	%edi
	jmp	5f
1:
	movl	$0x27, %edx
	movl	$0xB, %ecx
	inc  %ebx
	jmp	3f
2:
	movl	$0x27, %edx
	movl	$0xB, %ecx
	inc  %eax
3:
	neg	%edi
4:
	neg	%esi
5:
	// Add direction (x;y) to ball (x;y)
	add	%edi, %edx
	add	%esi, %ecx
6:
	// Write registers to variables
	movl	%edi, (DIRECTION_X)
	movl	%esi, (DIRECTION_Y)
	movl	%edx, (BALL_X)
	movl	%ecx, (BALL_Y)
	movl	%ebx, (P1_SCORE)
	movl	%eax, (P2_SCORE)
	movl	%r8d, (LEFTPADDLE_Y)
	movl	%r9d, (RIGHTPADDLE_Y)
	movq	%rbp, %rsp
	popq	%rbp
	ret	
	
drawBall:
	pushq %rbp
	movq	%rsp, %rbp

	movb	$0xFE, %dl
	movb	$0x0F, %cl
	movq	%rsi, %rsi
	movq	%rdi, %rdi
	call	putChar
	
	movq	%rbp, %rsp
	popq	%rbp
	ret
drawLeftPaddle:
	pushq %rbp
	movq	%rsp, %rbp

	movb	$0xDD, %dl
	movb	$0x0F, %cl
	movq	%rsi, %rsi
	movq	$0, %rdi
	call	putChar

	movq	%rbp, %rsp
	popq	%rbp
	ret
drawRightPaddle:
	pushq %rbp
	movq	%rsp, %rbp
	
	movb	$0xDD, %dl
	movb	$0x0F, %cl
	movq	%rsi, %rsi
	movq	$0x4F, %rdi
	call	putChar

	movq	%rbp, %rsp
	popq	%rbp
	ret
drawScores:
	pushq %rbp
	movq	%rsp, %rbp
	
	movb	(P1_SCORE), %dl
	movb	$0x0F, %cl
	movq	$0x0, %rsi
	movq	$0x24, %rdi
	call	putChar
	movb	(P2_SCORE), %dl
	movb	$0x0F, %cl
	movq	$0x0, %rsi
	movq	$0x28, %rdi
	call	putChar
	
	movq	%rbp, %rsp
	popq	%rbp
	ret

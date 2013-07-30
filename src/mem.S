	.section __TEXT,__text,regular,pure_instructions
	.section __TEXT,__picsymbolstub1,symbol_stubs,pure_instructions,32
	.machine ppc
	.text
	.align 2
	.globl _initMemOld
_initMemOld:
	mflr r0
	stmw r30,-8(r1)
	stw r0,8(r1)
	stwu r1,-96(r1)
	mr r30,r1
	bcl 20,31,"L00000000001$pb"
"L00000000001$pb":
	mflr r31
	li r3,127
	bl L_malloc$stub
	mr r0,r3
	addis r2,r31,ha16(L_HRAM$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_HRAM$non_lazy_ptr-"L00000000001$pb")(r2)
	stw r0,0(r2)
	addis r2,r31,ha16(L_HRAM$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_HRAM$non_lazy_ptr-"L00000000001$pb")(r2)
	lwz r0,0(r2)
	cmpwi cr7,r0,0
	bne cr7,L2
	li r0,-1
	stw r0,72(r30)
	b L4
L2:
	li r3,128
	bl L_malloc$stub
	mr r0,r3
	addis r2,r31,ha16(L_IOBUF$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_IOBUF$non_lazy_ptr-"L00000000001$pb")(r2)
	stw r0,0(r2)
	addis r2,r31,ha16(L_IOBUF$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_IOBUF$non_lazy_ptr-"L00000000001$pb")(r2)
	lwz r0,0(r2)
	cmpwi cr7,r0,0
	bne cr7,L5
	li r0,-1
	stw r0,72(r30)
	b L4
L5:
	li r3,8192
	bl L_malloc$stub
	mr r0,r3
	addis r2,r31,ha16(L_VRAM$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_VRAM$non_lazy_ptr-"L00000000001$pb")(r2)
	stw r0,0(r2)
	addis r2,r31,ha16(L_VRAM$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_VRAM$non_lazy_ptr-"L00000000001$pb")(r2)
	lwz r0,0(r2)
	cmpwi cr7,r0,0
	bne cr7,L7
	li r0,-1
	stw r0,72(r30)
	b L4
L7:
	li r0,0
	stw r0,56(r30)
	b L9
L10:
	addis r2,r31,ha16(L_VRAM$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_VRAM$non_lazy_ptr-"L00000000001$pb")(r2)
	lwz r2,0(r2)
	lwz r0,56(r30)
	add r2,r2,r0
	li r0,0
	stb r0,0(r2)
	lwz r2,56(r30)
	addi r0,r2,1
	stw r0,56(r30)
L9:
	lwz r0,56(r30)
	cmpwi cr7,r0,8191
	ble cr7,L10
	li r3,0
	ori r3,r3,32768
	bl L_malloc$stub
	mr r0,r3
	addis r2,r31,ha16(L_ERAM$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_ERAM$non_lazy_ptr-"L00000000001$pb")(r2)
	stw r0,0(r2)
	addis r2,r31,ha16(L_ERAM$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_ERAM$non_lazy_ptr-"L00000000001$pb")(r2)
	lwz r0,0(r2)
	cmpwi cr7,r0,0
	bne cr7,L12
	li r0,-1
	stw r0,72(r30)
	b L4
L12:
	li r3,8192
	bl L_malloc$stub
	mr r0,r3
	addis r2,r31,ha16(L_WRAM1$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_WRAM1$non_lazy_ptr-"L00000000001$pb")(r2)
	stw r0,0(r2)
	addis r2,r31,ha16(L_WRAM1$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_WRAM1$non_lazy_ptr-"L00000000001$pb")(r2)
	lwz r0,0(r2)
	cmpwi cr7,r0,0
	bne cr7,L14
	li r0,-1
	stw r0,72(r30)
	b L4
L14:
	li r0,0
	stw r0,56(r30)
	b L16
L17:
	addis r2,r31,ha16(L_WRAM1$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_WRAM1$non_lazy_ptr-"L00000000001$pb")(r2)
	lwz r2,0(r2)
	lwz r0,56(r30)
	add r2,r2,r0
	li r0,0
	stb r0,0(r2)
	lwz r2,56(r30)
	addi r0,r2,1
	stw r0,56(r30)
L16:
	lwz r0,56(r30)
	cmpwi cr7,r0,8191
	ble cr7,L17
	li r3,4096
	bl L_malloc$stub
	mr r0,r3
	addis r2,r31,ha16(L_WRAM2$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_WRAM2$non_lazy_ptr-"L00000000001$pb")(r2)
	stw r0,0(r2)
	addis r2,r31,ha16(L_WRAM2$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_WRAM2$non_lazy_ptr-"L00000000001$pb")(r2)
	lwz r0,0(r2)
	cmpwi cr7,r0,0
	bne cr7,L19
	li r0,-1
	stw r0,72(r30)
	b L4
L19:
	li r0,0
	stw r0,56(r30)
	b L21
L22:
	addis r2,r31,ha16(L_WRAM2$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_WRAM2$non_lazy_ptr-"L00000000001$pb")(r2)
	lwz r2,0(r2)
	lwz r0,56(r30)
	add r2,r2,r0
	li r0,0
	stb r0,0(r2)
	lwz r2,56(r30)
	addi r0,r2,1
	stw r0,56(r30)
L21:
	lwz r0,56(r30)
	cmpwi cr7,r0,4095
	ble cr7,L22
	li r3,256
	bl L_malloc$stub
	mr r0,r3
	addis r2,r31,ha16(L_OAM$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_OAM$non_lazy_ptr-"L00000000001$pb")(r2)
	stw r0,0(r2)
	addis r2,r31,ha16(L_OAM$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_OAM$non_lazy_ptr-"L00000000001$pb")(r2)
	lwz r0,0(r2)
	cmpwi cr7,r0,0
	bne cr7,L24
	li r0,-1
	stw r0,72(r30)
	b L4
L24:
	li r0,0
	stw r0,56(r30)
	b L26
L27:
	addis r2,r31,ha16(L_OAM$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_OAM$non_lazy_ptr-"L00000000001$pb")(r2)
	lwz r2,0(r2)
	lwz r0,56(r30)
	add r2,r2,r0
	li r0,0
	stb r0,0(r2)
	lwz r2,56(r30)
	addi r0,r2,1
	stw r0,56(r30)
L26:
	lwz r0,56(r30)
	cmpwi cr7,r0,255
	ble cr7,L27
	li r3,0
	li r4,256
	li r5,256
	li r6,16
	li r7,0
	li r8,0
	li r9,0
	li r10,0
	bl L_SDL_CreateRGBSurface$stub
	mr r0,r3
	addis r2,r31,ha16(L_tiles$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_tiles$non_lazy_ptr-"L00000000001$pb")(r2)
	stw r0,0(r2)
	addis r2,r31,ha16(L_jpbuf$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_jpbuf$non_lazy_ptr-"L00000000001$pb")(r2)
	li r0,-1
	stb r0,0(r2)
	addis r2,r31,ha16(L_IOBUF$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_IOBUF$non_lazy_ptr-"L00000000001$pb")(r2)
	lwz r2,0(r2)
	li r0,15
	stb r0,0(r2)
	addis r2,r31,ha16(L_rampage$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_rampage$non_lazy_ptr-"L00000000001$pb")(r2)
	li r0,0
	stw r0,0(r2)
	addis r2,r31,ha16(L_rompage$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_rompage$non_lazy_ptr-"L00000000001$pb")(r2)
	li r0,1
	stw r0,0(r2)
	addis r2,r31,ha16(L_mbcmode$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_mbcmode$non_lazy_ptr-"L00000000001$pb")(r2)
	li r0,0
	stw r0,0(r2)
	addis r2,r31,ha16(L_ramenable$non_lazy_ptr-"L00000000001$pb")
	lwz r2,lo16(L_ramenable$non_lazy_ptr-"L00000000001$pb")(r2)
	li r0,0
	stw r0,0(r2)
	li r0,0
	stw r0,72(r30)
L4:
	lwz r0,72(r30)
	mr r3,r0
	lwz r1,0(r1)
	lwz r0,8(r1)
	mtlr r0
	lmw r30,-8(r1)
	blr
	.align 2
	.globl _initMem
_initMem:
	mflr r0
	stmw r30,-8(r1)
	stw r0,8(r1)
	stwu r1,-96(r1)
	mr r30,r1
	bcl 20,31,"L00000000002$pb"
"L00000000002$pb":
	mflr r31
	lis r3,0x1
	bl L_malloc$stub
	mr r0,r3
	addis r2,r31,ha16(L_MEM$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_MEM$non_lazy_ptr-"L00000000002$pb")(r2)
	stw r0,0(r2)
	addis r2,r31,ha16(L_MEM$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_MEM$non_lazy_ptr-"L00000000002$pb")(r2)
	lwz r0,0(r2)
	cmpwi cr7,r0,0
	bne cr7,L31
	li r0,-1
	stw r0,72(r30)
	b L33
L31:
	addis r2,r31,ha16(L_MEM$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_MEM$non_lazy_ptr-"L00000000002$pb")(r2)
	lwz r2,0(r2)
	addis r2,r2,0x1
	addi r0,r2,-128
	addis r2,r31,ha16(L_HRAM$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_HRAM$non_lazy_ptr-"L00000000002$pb")(r2)
	stw r0,0(r2)
	addis r2,r31,ha16(L_MEM$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_MEM$non_lazy_ptr-"L00000000002$pb")(r2)
	lwz r2,0(r2)
	addis r2,r2,0x1
	addi r0,r2,-256
	addis r2,r31,ha16(L_IOBUF$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_IOBUF$non_lazy_ptr-"L00000000002$pb")(r2)
	stw r0,0(r2)
	addis r2,r31,ha16(L_MEM$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_MEM$non_lazy_ptr-"L00000000002$pb")(r2)
	lwz r2,0(r2)
	addis r2,r2,0x1
	addi r0,r2,-32768
	addis r2,r31,ha16(L_VRAM$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_VRAM$non_lazy_ptr-"L00000000002$pb")(r2)
	stw r0,0(r2)
	li r0,0
	stw r0,56(r30)
	b L34
L35:
	addis r2,r31,ha16(L_VRAM$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_VRAM$non_lazy_ptr-"L00000000002$pb")(r2)
	lwz r2,0(r2)
	lwz r0,56(r30)
	add r2,r2,r0
	li r0,0
	stb r0,0(r2)
	lwz r2,56(r30)
	addi r0,r2,1
	stw r0,56(r30)
L34:
	lwz r0,56(r30)
	cmpwi cr7,r0,8191
	ble cr7,L35
	addis r2,r31,ha16(L_MEM$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_MEM$non_lazy_ptr-"L00000000002$pb")(r2)
	lwz r2,0(r2)
	addis r2,r2,0x1
	addi r0,r2,-24576
	addis r2,r31,ha16(L_ERAM$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_ERAM$non_lazy_ptr-"L00000000002$pb")(r2)
	stw r0,0(r2)
	addis r2,r31,ha16(L_ERAM$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_ERAM$non_lazy_ptr-"L00000000002$pb")(r2)
	lwz r0,0(r2)
	cmpwi cr7,r0,0
	bne cr7,L37
	li r0,-1
	stw r0,72(r30)
	b L33
L37:
	addis r2,r31,ha16(L_MEM$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_MEM$non_lazy_ptr-"L00000000002$pb")(r2)
	lwz r2,0(r2)
	addis r2,r2,0x1
	addi r0,r2,-16384
	addis r2,r31,ha16(L_WRAM1$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_WRAM1$non_lazy_ptr-"L00000000002$pb")(r2)
	stw r0,0(r2)
	li r0,0
	stw r0,56(r30)
	b L39
L40:
	addis r2,r31,ha16(L_WRAM1$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_WRAM1$non_lazy_ptr-"L00000000002$pb")(r2)
	lwz r2,0(r2)
	lwz r0,56(r30)
	add r2,r2,r0
	li r0,0
	stb r0,0(r2)
	lwz r2,56(r30)
	addi r0,r2,1
	stw r0,56(r30)
L39:
	lwz r0,56(r30)
	cmpwi cr7,r0,8191
	ble cr7,L40
	addis r2,r31,ha16(L_MEM$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_MEM$non_lazy_ptr-"L00000000002$pb")(r2)
	lwz r2,0(r2)
	addis r2,r2,0x1
	addi r0,r2,-512
	addis r2,r31,ha16(L_OAM$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_OAM$non_lazy_ptr-"L00000000002$pb")(r2)
	stw r0,0(r2)
	li r0,0
	stw r0,56(r30)
	b L42
L43:
	addis r2,r31,ha16(L_OAM$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_OAM$non_lazy_ptr-"L00000000002$pb")(r2)
	lwz r2,0(r2)
	lwz r0,56(r30)
	add r2,r2,r0
	li r0,0
	stb r0,0(r2)
	lwz r2,56(r30)
	addi r0,r2,1
	stw r0,56(r30)
L42:
	lwz r0,56(r30)
	cmpwi cr7,r0,255
	ble cr7,L43
	li r3,0
	li r4,256
	li r5,256
	li r6,16
	li r7,0
	li r8,0
	li r9,0
	li r10,0
	bl L_SDL_CreateRGBSurface$stub
	mr r0,r3
	addis r2,r31,ha16(L_tiles$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_tiles$non_lazy_ptr-"L00000000002$pb")(r2)
	stw r0,0(r2)
	addis r2,r31,ha16(L_jpbuf$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_jpbuf$non_lazy_ptr-"L00000000002$pb")(r2)
	li r0,-1
	stb r0,0(r2)
	addis r2,r31,ha16(L_IOBUF$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_IOBUF$non_lazy_ptr-"L00000000002$pb")(r2)
	lwz r2,0(r2)
	li r0,15
	stb r0,0(r2)
	addis r2,r31,ha16(L_rampage$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_rampage$non_lazy_ptr-"L00000000002$pb")(r2)
	li r0,0
	stw r0,0(r2)
	addis r2,r31,ha16(L_rompage$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_rompage$non_lazy_ptr-"L00000000002$pb")(r2)
	li r0,1
	stw r0,0(r2)
	addis r2,r31,ha16(L_mbcmode$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_mbcmode$non_lazy_ptr-"L00000000002$pb")(r2)
	li r0,0
	stw r0,0(r2)
	addis r2,r31,ha16(L_ramenable$non_lazy_ptr-"L00000000002$pb")
	lwz r2,lo16(L_ramenable$non_lazy_ptr-"L00000000002$pb")(r2)
	li r0,0
	stw r0,0(r2)
	li r0,0
	stw r0,72(r30)
L33:
	lwz r0,72(r30)
	mr r3,r0
	lwz r1,0(r1)
	lwz r0,8(r1)
	mtlr r0
	lmw r30,-8(r1)
	blr
	.align 2
	.globl _resetJpButton
_resetJpButton:
	mflr r0
	stmw r30,-8(r1)
	stw r0,8(r1)
	stwu r1,-96(r1)
	mr r30,r1
	bcl 20,31,"L00000000003$pb"
"L00000000003$pb":
	mflr r31
	mr r0,r3
	stb r0,120(r30)
	lbz r0,120(r30)
	rlwinm r2,r0,0,0xff
	li r0,1
	slw r0,r0,r2
	stb r0,56(r30)
	addis r2,r31,ha16(L_jpbuf$non_lazy_ptr-"L00000000003$pb")
	lwz r2,lo16(L_jpbuf$non_lazy_ptr-"L00000000003$pb")(r2)
	lbz r0,0(r2)
	rlwinm r2,r0,0,0xff
	lbz r0,56(r30)
	or r0,r2,r0
	rlwinm r0,r0,0,0xff
	addis r2,r31,ha16(L_jpbuf$non_lazy_ptr-"L00000000003$pb")
	lwz r2,lo16(L_jpbuf$non_lazy_ptr-"L00000000003$pb")(r2)
	stb r0,0(r2)
	bl L_changeJpRegs$stub
	li r3,5
	bl L_intRequest$stub
	lwz r1,0(r1)
	lwz r0,8(r1)
	mtlr r0
	lmw r30,-8(r1)
	blr
	.align 2
	.globl _setJpButton
_setJpButton:
	mflr r0
	stmw r30,-8(r1)
	stw r0,8(r1)
	stwu r1,-96(r1)
	mr r30,r1
	bcl 20,31,"L00000000004$pb"
"L00000000004$pb":
	mflr r31
	mr r0,r3
	stb r0,120(r30)
	lbz r0,120(r30)
	rlwinm r2,r0,0,0xff
	li r0,1
	slw r0,r0,r2
	extsb r0,r0
	nor r0,r0,r0
	extsb r0,r0
	stb r0,56(r30)
	addis r2,r31,ha16(L_jpbuf$non_lazy_ptr-"L00000000004$pb")
	lwz r2,lo16(L_jpbuf$non_lazy_ptr-"L00000000004$pb")(r2)
	lbz r0,0(r2)
	rlwinm r2,r0,0,0xff
	lbz r0,56(r30)
	and r0,r2,r0
	rlwinm r0,r0,0,0xff
	addis r2,r31,ha16(L_jpbuf$non_lazy_ptr-"L00000000004$pb")
	lwz r2,lo16(L_jpbuf$non_lazy_ptr-"L00000000004$pb")(r2)
	stb r0,0(r2)
	bl L_changeJpRegs$stub
	lwz r1,0(r1)
	lwz r0,8(r1)
	mtlr r0
	lmw r30,-8(r1)
	blr
	.align 2
	.globl _changeJpRegs
_changeJpRegs:
	mflr r0
	stmw r30,-8(r1)
	stw r0,8(r1)
	stwu r1,-80(r1)
	mr r30,r1
	bcl 20,31,"L00000000005$pb"
"L00000000005$pb":
	mflr r31
	bl L_jpDirections$stub
	mr r0,r3
	cmpwi cr7,r0,0
	bne cr7,L51
	addis r2,r31,ha16(L_jpbuf$non_lazy_ptr-"L00000000005$pb")
	lwz r2,lo16(L_jpbuf$non_lazy_ptr-"L00000000005$pb")(r2)
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	srwi r0,r0,4
	rlwinm r0,r0,0,0xff
	mr r3,r0
	bl L_writejpReg$stub
	b L55
L51:
	bl L_jpButtons$stub
	mr r0,r3
	cmpwi cr7,r0,0
	bne cr7,L55
	addis r2,r31,ha16(L_jpbuf$non_lazy_ptr-"L00000000005$pb")
	lwz r2,lo16(L_jpbuf$non_lazy_ptr-"L00000000005$pb")(r2)
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	mr r3,r0
	bl L_writejpReg$stub
L55:
	lwz r1,0(r1)
	lwz r0,8(r1)
	mtlr r0
	lmw r30,-8(r1)
	blr
	.align 2
	.globl _jpDirections
_jpDirections:
	stmw r30,-8(r1)
	stwu r1,-48(r1)
	mr r30,r1
	mflr r0
	bcl 20,31,"L00000000006$pb"
"L00000000006$pb":
	mflr r10
	mtlr r0
	addis r2,r10,ha16(L_IOBUF$non_lazy_ptr-"L00000000006$pb")
	lwz r2,lo16(L_IOBUF$non_lazy_ptr-"L00000000006$pb")(r2)
	lwz r2,0(r2)
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	srwi r0,r0,4
	rlwinm r0,r0,0,0xff
	rlwinm r0,r0,0,31,31
	mr r3,r0
	lwz r1,0(r1)
	lmw r30,-8(r1)
	blr
	.align 2
	.globl _jpButtons
_jpButtons:
	stmw r30,-8(r1)
	stwu r1,-48(r1)
	mr r30,r1
	mflr r0
	bcl 20,31,"L00000000007$pb"
"L00000000007$pb":
	mflr r10
	mtlr r0
	addis r2,r10,ha16(L_IOBUF$non_lazy_ptr-"L00000000007$pb")
	lwz r2,lo16(L_IOBUF$non_lazy_ptr-"L00000000007$pb")(r2)
	lwz r2,0(r2)
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	srwi r0,r0,5
	rlwinm r0,r0,0,0xff
	rlwinm r0,r0,0,31,31
	mr r3,r0
	lwz r1,0(r1)
	lmw r30,-8(r1)
	blr
	.align 2
	.globl _writejpReg
_writejpReg:
	stmw r30,-8(r1)
	stwu r1,-48(r1)
	mr r30,r1
	mflr r0
	bcl 20,31,"L00000000008$pb"
"L00000000008$pb":
	mflr r10
	mtlr r0
	mr r0,r3
	stb r0,72(r30)
	addis r2,r10,ha16(L_IOBUF$non_lazy_ptr-"L00000000008$pb")
	lwz r2,lo16(L_IOBUF$non_lazy_ptr-"L00000000008$pb")(r2)
	lwz r9,0(r2)
	addis r2,r10,ha16(L_IOBUF$non_lazy_ptr-"L00000000008$pb")
	lwz r2,lo16(L_IOBUF$non_lazy_ptr-"L00000000008$pb")(r2)
	lwz r2,0(r2)
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	extsb r2,r0
	li r0,-16
	and r0,r2,r0
	extsb r2,r0
	lbz r0,72(r30)
	extsb r0,r0
	rlwinm r0,r0,0,0xff
	rlwinm r0,r0,0,28,31
	or r0,r2,r0
	extsb r0,r0
	rlwinm r0,r0,0,0xff
	stb r0,0(r9)
	lwz r1,0(r1)
	lmw r30,-8(r1)
	blr
	.align 2
	.globl _readbyte
_readbyte:
	mflr r0
	stmw r30,-8(r1)
	stw r0,8(r1)
	stwu r1,-80(r1)
	mr r30,r1
	mr r0,r3
	sth r0,104(r30)
	lhz r0,104(r30)
	rlwinm r0,r0,0,0xffff
	mr r3,r0
	bl L_fastread$stub
	mr r0,r3
	mr r3,r0
	lwz r1,0(r1)
	lwz r0,8(r1)
	mtlr r0
	lmw r30,-8(r1)
	blr
	.align 2
	.globl _readword
_readword:
	mflr r0
	stmw r29,-12(r1)
	stw r0,8(r1)
	stwu r1,-80(r1)
	mr r30,r1
	mr r0,r3
	sth r0,104(r30)
	lhz r0,104(r30)
	rlwinm r0,r0,0,0xffff
	mr r3,r0
	bl L_fastread$stub
	mr r0,r3
	mr r29,r0
	lhz r0,104(r30)
	extsh r2,r0
	addi r0,r2,1
	extsh r0,r0
	rlwinm r0,r0,0,0xffff
	mr r3,r0
	bl L_fastread$stub
	mr r0,r3
	slwi r0,r0,8
	extsh r0,r0
	or r0,r29,r0
	extsh r0,r0
	rlwinm r0,r0,0,0xffff
	mr r3,r0
	lwz r1,0(r1)
	lwz r0,8(r1)
	mtlr r0
	lmw r29,-12(r1)
	blr
	.align 2
	.globl _writebyte
_writebyte:
	mflr r0
	stmw r30,-8(r1)
	stw r0,8(r1)
	stwu r1,-80(r1)
	mr r30,r1
	mr r0,r3
	mr r2,r4
	sth r0,104(r30)
	stb r2,108(r30)
	lhz r0,104(r30)
	rlwinm r2,r0,0,0xffff
	lbz r0,108(r30)
	rlwinm r0,r0,0,0xff
	mr r3,r2
	mr r4,r0
	bl L_fastwrite$stub
	mr r0,r3
	mr r3,r0
	lwz r1,0(r1)
	lwz r0,8(r1)
	mtlr r0
	lmw r30,-8(r1)
	blr
	.align 2
	.globl _writeword
_writeword:
	mflr r0
	stmw r30,-8(r1)
	stw r0,8(r1)
	stwu r1,-80(r1)
	mr r30,r1
	mr r0,r3
	mr r2,r4
	sth r0,104(r30)
	sth r2,108(r30)
	lhz r0,108(r30)
	extsb r0,r0
	rlwinm r0,r0,0,0xff
	mr r2,r0
	lhz r0,104(r30)
	rlwinm r0,r0,0,0xffff
	mr r3,r0
	mr r4,r2
	bl L_fastwrite$stub
	lhz r0,104(r30)
	extsh r2,r0
	addi r0,r2,1
	extsh r0,r0
	rlwinm r2,r0,0,0xffff
	lhz r0,108(r30)
	rlwinm r0,r0,0,0xffff
	srwi r0,r0,8
	rlwinm r0,r0,0,0xffff
	rlwinm r0,r0,0,0xff
	mr r3,r2
	mr r4,r0
	bl L_fastwrite$stub
	mr r0,r3
	mr r3,r0
	lwz r1,0(r1)
	lwz r0,8(r1)
	mtlr r0
	lmw r30,-8(r1)
	blr
	.align 2
	.globl _writeTileMem
_writeTileMem:
	stmw r30,-8(r1)
	stwu r1,-80(r1)
	mr r30,r1
	mflr r0
	bcl 20,31,"L00000000009$pb"
"L00000000009$pb":
	mflr r10
	mtlr r0
	mr r0,r3
	sth r0,104(r30)
	lhz r0,104(r30)
	rlwinm r0,r0,0,0xffff
	srwi r0,r0,4
	rlwinm r0,r0,0,0xffff
	stw r0,52(r30)
	lwz r0,52(r30)
	slwi r0,r0,4
	mr r9,r0
	addis r2,r10,ha16(L_VRAM$non_lazy_ptr-"L00000000009$pb")
	lwz r2,lo16(L_VRAM$non_lazy_ptr-"L00000000009$pb")(r2)
	lwz r0,0(r2)
	add r0,r9,r0
	stw r0,48(r30)
	addis r2,r10,ha16(L_tiles$non_lazy_ptr-"L00000000009$pb")
	lwz r2,lo16(L_tiles$non_lazy_ptr-"L00000000009$pb")(r2)
	lwz r2,0(r2)
	lwz r0,20(r2)
	stw r0,36(r30)
	lwz r0,52(r30)
	rlwinm r0,r0,0,28,31
	slwi r0,r0,3
	sth r0,32(r30)
	lwz r0,52(r30)
	rlwinm r0,r0,0,20,27
	srawi r0,r0,4
	slwi r0,r0,3
	sth r0,30(r30)
	lhz r0,30(r30)
	rlwinm r0,r0,0,0xffff
	slwi r0,r0,8
	extsh r2,r0
	lhz r0,32(r30)
	extsh r0,r0
	add r0,r2,r0
	extsh r0,r0
	sth r0,28(r30)
	li r0,0
	stw r0,44(r30)
	b L71
L72:
	li r0,0
	stw r0,40(r30)
	b L73
L74:
	lwz r0,44(r30)
	mr r2,r0
	lwz r0,48(r30)
	add r2,r2,r0
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	mr r2,r0
	lwz r0,40(r30)
	sraw r0,r2,r0
	extsb r0,r0
	rlwinm r0,r0,0,0xff
	rlwinm r0,r0,0,31,31
	stb r0,26(r30)
	lwz r2,44(r30)
	lwz r0,48(r30)
	add r2,r2,r0
	addi r2,r2,1
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	mr r2,r0
	lwz r0,40(r30)
	sraw r0,r2,r0
	extsb r0,r0
	rlwinm r0,r0,0,0xff
	rlwinm r0,r0,0,31,31
	stb r0,25(r30)
	lbz r0,26(r30)
	rlwinm r0,r0,0,0xff
	slwi r0,r0,1
	extsb r2,r0
	lbz r0,25(r30)
	extsb r0,r0
	or r0,r2,r0
	extsb r0,r0
	stb r0,24(r30)
	lhz r0,30(r30)
	rlwinm r2,r0,0,0xffff
	lwz r0,44(r30)
	srawi r0,r0,1
	add r0,r2,r0
	slwi r0,r0,8
	extsh r2,r0
	lhz r0,32(r30)
	extsh r0,r0
	add r0,r2,r0
	extsh r2,r0
	lwz r0,40(r30)
	extsh r0,r0
	subf r0,r0,r2
	extsh r2,r0
	addi r0,r2,8
	extsh r0,r0
	sth r0,28(r30)
	lhz r0,28(r30)
	rlwinm r0,r0,0,0xffff
	slwi r0,r0,1
	mr r2,r0
	lwz r0,36(r30)
	add r9,r2,r0
	lbz r0,24(r30)
	rlwinm r0,r0,0,0xff
	addis r2,r10,ha16(L_pal$non_lazy_ptr-"L00000000009$pb")
	lwz r2,lo16(L_pal$non_lazy_ptr-"L00000000009$pb")(r2)
	slwi r0,r0,1
	add r2,r0,r2
	lhz r0,0(r2)
	rlwinm r0,r0,0,0xffff
	sth r0,0(r9)
	lwz r2,40(r30)
	addi r0,r2,1
	stw r0,40(r30)
L73:
	lwz r0,40(r30)
	cmpwi cr7,r0,7
	ble cr7,L74
	lwz r2,44(r30)
	addi r0,r2,2
	stw r0,44(r30)
L71:
	lwz r0,44(r30)
	cmpwi cr7,r0,15
	ble cr7,L72
	lwz r1,0(r1)
	lmw r30,-8(r1)
	blr
	.align 2
	.globl _doDma
_doDma:
	mflr r0
	stmw r30,-8(r1)
	stw r0,8(r1)
	stwu r1,-96(r1)
	mr r30,r1
	bcl 20,31,"L00000000010$pb"
"L00000000010$pb":
	mflr r31
	mr r0,r3
	stb r0,120(r30)
	lbz r0,120(r30)
	rlwinm r0,r0,0,0xff
	slwi r0,r0,8
	sth r0,56(r30)
	lhz r0,56(r30)
	rlwinm r9,r0,0,0xffff
	addis r2,r31,ha16(L_OAM$non_lazy_ptr-"L00000000010$pb")
	lwz r2,lo16(L_OAM$non_lazy_ptr-"L00000000010$pb")(r2)
	lwz r0,0(r2)
	mr r3,r9
	mr r4,r0
	li r5,159
	li r6,114
	bl L_map$stub
	addis r2,r31,ha16(L_DMADELAY$non_lazy_ptr-"L00000000010$pb")
	lwz r2,lo16(L_DMADELAY$non_lazy_ptr-"L00000000010$pb")(r2)
	li r0,-116
	stb r0,0(r2)
	lwz r1,0(r1)
	lwz r0,8(r1)
	mtlr r0
	lmw r30,-8(r1)
	blr
	.align 2
	.globl _map
_map:
	mflr r0
	stmw r29,-12(r1)
	stw r0,8(r1)
	stwu r1,-96(r1)
	mr r30,r1
	bcl 20,31,"L00000000011$pb"
"L00000000011$pb":
	mflr r31
	stw r3,120(r30)
	stw r4,124(r30)
	stw r5,128(r30)
	mr r0,r6
	stb r0,132(r30)
	addis r2,r31,ha16(L_mreader$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_mreader$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r0,0(r2)
	cmpwi cr7,r0,0
	bne cr7,L81
	lwz r0,120(r30)
	cmplwi cr7,r0,32767
	bgt cr7,L81
	lwz r0,120(r30)
	cmplwi cr7,r0,16383
	bgt cr7,L84
	lbz r0,132(r30)
	extsb r0,r0
	cmpwi cr7,r0,114
	bne cr7,L86
	lwz r0,128(r30)
	cmpwi cr7,r0,1
	bne cr7,L88
	addis r2,r31,ha16(L_ROM$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_ROM$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r2,r2,r0
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	lwz r2,124(r30)
	stb r0,0(r2)
	b L90
L88:
	addis r2,r31,ha16(L_ROM$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_ROM$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r2,r2,r0
	lwz r9,128(r30)
	lwz r0,124(r30)
	mr r3,r0
	mr r4,r2
	mr r5,r9
	bl L_memcpy$stub
L90:
	li r0,0
	stw r0,72(r30)
	b L91
L86:
	lbz r0,132(r30)
	extsb r0,r0
	cmpwi cr7,r0,119
	bne cr7,L84
	li r0,-4
	stw r0,72(r30)
	b L91
L84:
	lwz r0,120(r30)
	cmplwi cr7,r0,32767
	bgt cr7,L93
	lwz r0,120(r30)
	cmplwi cr7,r0,16383
	ble cr7,L93
	lbz r0,132(r30)
	extsb r0,r0
	cmpwi cr7,r0,114
	bne cr7,L96
	lwz r0,128(r30)
	cmpwi cr7,r0,1
	bne cr7,L98
	addis r2,r31,ha16(L_ROM$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_ROM$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r2,r2,r0
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	lwz r2,124(r30)
	stb r0,0(r2)
	b L100
L98:
	addis r2,r31,ha16(L_ROM$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_ROM$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r2,r2,r0
	lwz r9,128(r30)
	lwz r0,124(r30)
	mr r3,r0
	mr r4,r2
	mr r5,r9
	bl L_memcpy$stub
L100:
	li r0,0
	stw r0,72(r30)
	b L91
L96:
	lbz r0,132(r30)
	extsb r0,r0
	cmpwi cr7,r0,119
	bne cr7,L93
	li r0,-4
	stw r0,72(r30)
	b L91
L81:
	lwz r0,120(r30)
	cmplwi cr7,r0,32767
	bgt cr7,L93
	lbz r0,132(r30)
	extsb r0,r0
	cmpwi cr7,r0,114
	bne cr7,L103
	addis r2,r31,ha16(L_mreader$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_mreader$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	rlwinm r0,r0,0,0xffff
	mr r3,r0
	mr r12,r2
	mtctr r12
	bctrl
	mr r0,r3
	lwz r2,124(r30)
	stb r0,0(r2)
	lwz r0,128(r30)
	cmpwi cr7,r0,2
	bne cr7,L105
	lwz r2,124(r30)
	addi r29,r2,1
	addis r2,r31,ha16(L_mreader$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_mreader$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r9,0(r2)
	lwz r0,120(r30)
	rlwinm r0,r0,0,0xffff
	mr r2,r0
	addi r0,r2,1
	mr r3,r0
	mr r12,r9
	mtctr r12
	bctrl
	mr r0,r3
	stb r0,0(r29)
	b L105
L103:
	addis r2,r31,ha16(L_mwriter$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_mwriter$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r11,0(r2)
	lwz r0,120(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	lwz r2,124(r30)
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	mr r3,r9
	mr r4,r0
	li r5,1
	mr r12,r11
	mtctr r12
	bctrl
L105:
	li r0,0
	stw r0,72(r30)
	b L91
L93:
	lwz r0,120(r30)
	cmplwi cr7,r0,32767
	ble cr7,L107
	lwz r0,120(r30)
	li r2,0
	ori r2,r2,40959
	cmplw cr7,r0,r2
	bgt cr7,L107
	lwz r2,120(r30)
	addi r0,r2,-32768
	stw r0,120(r30)
	lbz r0,132(r30)
	extsb r0,r0
	cmpwi cr7,r0,114
	bne cr7,L110
	lwz r0,128(r30)
	cmpwi cr7,r0,1
	bne cr7,L112
	addis r2,r31,ha16(L_VRAM$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_VRAM$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r2,r2,r0
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	lwz r2,124(r30)
	stb r0,0(r2)
	b L114
L112:
	addis r2,r31,ha16(L_VRAM$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_VRAM$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r2,r2,r0
	lwz r9,128(r30)
	lwz r0,124(r30)
	mr r3,r0
	mr r4,r2
	mr r5,r9
	bl L_memcpy$stub
L114:
	li r0,0
	stw r0,72(r30)
	b L91
L110:
	lbz r0,132(r30)
	extsb r0,r0
	cmpwi cr7,r0,119
	bne cr7,L107
	lwz r0,128(r30)
	cmpwi cr7,r0,1
	bne cr7,L116
	addis r2,r31,ha16(L_VRAM$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_VRAM$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r9,r2,r0
	lwz r2,124(r30)
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	stb r0,0(r9)
	b L118
L116:
	addis r2,r31,ha16(L_VRAM$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_VRAM$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r2,r2,r0
	lwz r9,128(r30)
	lwz r0,124(r30)
	mr r3,r2
	mr r4,r0
	mr r5,r9
	bl L_memcpy$stub
L118:
	lwz r0,120(r30)
	cmplwi cr7,r0,6143
	bgt cr7,L119
	lwz r0,120(r30)
	sth r0,68(r30)
	lbz r0,132(r30)
	extsb r0,r0
	cmpwi cr7,r0,119
	bne cr7,L119
	lhz r0,68(r30)
	rlwinm r0,r0,0,0xffff
	mr r3,r0
	bl _writeTileMem
	b L80
L119:
	li r0,0
	stw r0,72(r30)
	b L91
L107:
	lwz r0,120(r30)
	li r2,0
	ori r2,r2,49151
	cmplw cr7,r0,r2
	bgt cr7,L122
	lwz r0,120(r30)
	li r2,0
	ori r2,r2,40959
	cmplw cr7,r0,r2
	ble cr7,L122
	addis r2,r31,ha16(L_mwriter$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_mwriter$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r0,0(r2)
	cmpwi cr7,r0,0
	bne cr7,L125
	lwz r2,120(r30)
	addis r2,r2,0xffff
	addi r0,r2,24576
	stw r0,120(r30)
	lbz r0,132(r30)
	extsb r0,r0
	cmpwi cr7,r0,114
	bne cr7,L127
	lwz r0,128(r30)
	cmpwi cr7,r0,1
	bne cr7,L129
	addis r2,r31,ha16(L_ERAM$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_ERAM$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r2,r2,r0
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	lwz r2,124(r30)
	stb r0,0(r2)
	b L131
L129:
	addis r2,r31,ha16(L_ERAM$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_ERAM$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r2,r2,r0
	lwz r9,128(r30)
	lwz r0,124(r30)
	mr r3,r0
	mr r4,r2
	mr r5,r9
	bl L_memcpy$stub
L131:
	li r0,0
	stw r0,72(r30)
	b L91
L127:
	lbz r0,132(r30)
	extsb r0,r0
	cmpwi cr7,r0,119
	bne cr7,L122
	lwz r0,128(r30)
	cmpwi cr7,r0,1
	bne cr7,L133
	addis r2,r31,ha16(L_ERAM$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_ERAM$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r9,r2,r0
	lwz r2,124(r30)
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	stb r0,0(r9)
	b L135
L133:
	addis r2,r31,ha16(L_ERAM$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_ERAM$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r2,r2,r0
	lwz r9,128(r30)
	lwz r0,124(r30)
	mr r3,r2
	mr r4,r0
	mr r5,r9
	bl L_memcpy$stub
L135:
	li r0,0
	stw r0,72(r30)
	b L91
L125:
	lbz r0,132(r30)
	extsb r0,r0
	cmpwi cr7,r0,114
	bne cr7,L136
	lwz r0,128(r30)
	cmpwi cr7,r0,1
	beq cr7,L138
	lwz r0,128(r30)
	cmpwi cr7,r0,2
	bne cr7,L140
L138:
	addis r2,r31,ha16(L_mreader$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_mreader$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	rlwinm r0,r0,0,0xffff
	mr r3,r0
	mr r12,r2
	mtctr r12
	bctrl
	mr r0,r3
	lwz r2,124(r30)
	stb r0,0(r2)
	lwz r0,128(r30)
	cmpwi cr7,r0,2
	bne cr7,L141
	lwz r2,124(r30)
	addi r29,r2,1
	addis r2,r31,ha16(L_mreader$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_mreader$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r9,0(r2)
	lwz r0,120(r30)
	rlwinm r0,r0,0,0xffff
	mr r2,r0
	addi r0,r2,1
	mr r3,r0
	mr r12,r9
	mtctr r12
	bctrl
	mr r0,r3
	stb r0,0(r29)
	b L141
L140:
	li r0,0
	stw r0,64(r30)
	b L143
L144:
	lwz r0,64(r30)
	mr r2,r0
	lwz r0,124(r30)
	add r29,r2,r0
	addis r2,r31,ha16(L_mreader$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_mreader$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r9,0(r2)
	lwz r0,120(r30)
	rlwinm r0,r0,0,0xffff
	mr r2,r0
	lwz r0,64(r30)
	add r0,r2,r0
	mr r3,r0
	mr r12,r9
	mtctr r12
	bctrl
	mr r0,r3
	stb r0,0(r29)
	lwz r2,64(r30)
	addi r0,r2,1
	stw r0,64(r30)
L143:
	lwz r0,64(r30)
	lwz r2,128(r30)
	cmpw cr7,r0,r2
	blt cr7,L144
	b L141
L136:
	lwz r0,128(r30)
	cmpwi cr7,r0,1
	beq cr7,L145
	lwz r0,128(r30)
	cmpwi cr7,r0,2
	bne cr7,L147
L145:
	addis r2,r31,ha16(L_mwriter$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_mwriter$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r11,0(r2)
	lwz r0,120(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	lwz r2,124(r30)
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	mr r3,r9
	mr r4,r0
	li r5,1
	mr r12,r11
	mtctr r12
	bctrl
	lwz r0,128(r30)
	cmpwi cr7,r0,2
	bne cr7,L141
	addis r2,r31,ha16(L_mwriter$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_mwriter$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r11,0(r2)
	lwz r0,120(r30)
	rlwinm r0,r0,0,0xffff
	mr r2,r0
	addi r9,r2,1
	lwz r2,124(r30)
	addi r2,r2,1
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	mr r3,r9
	mr r4,r0
	li r5,1
	mr r12,r11
	mtctr r12
	bctrl
	b L141
L147:
	li r0,0
	stw r0,64(r30)
	b L149
L150:
	addis r2,r31,ha16(L_mwriter$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_mwriter$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r11,0(r2)
	lwz r0,120(r30)
	rlwinm r0,r0,0,0xffff
	mr r2,r0
	lwz r0,64(r30)
	add r9,r2,r0
	lwz r0,64(r30)
	mr r2,r0
	lwz r0,124(r30)
	add r2,r2,r0
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	mr r3,r9
	mr r4,r0
	li r5,1
	mr r12,r11
	mtctr r12
	bctrl
	lwz r2,64(r30)
	addi r0,r2,1
	stw r0,64(r30)
L149:
	lwz r0,64(r30)
	lwz r2,128(r30)
	cmpw cr7,r0,r2
	blt cr7,L150
L141:
	li r0,0
	stw r0,72(r30)
	b L91
L122:
	lwz r0,120(r30)
	li r2,0
	ori r2,r2,57343
	cmplw cr7,r0,r2
	bgt cr7,L151
	lwz r0,120(r30)
	li r2,0
	ori r2,r2,49151
	cmplw cr7,r0,r2
	ble cr7,L151
	lwz r2,120(r30)
	addis r2,r2,0xffff
	addi r0,r2,16384
	stw r0,120(r30)
	lbz r0,132(r30)
	extsb r0,r0
	cmpwi cr7,r0,114
	bne cr7,L154
	lwz r0,128(r30)
	cmpwi cr7,r0,1
	bne cr7,L156
	addis r2,r31,ha16(L_WRAM1$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_WRAM1$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r2,r2,r0
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	lwz r2,124(r30)
	stb r0,0(r2)
	b L158
L156:
	addis r2,r31,ha16(L_WRAM1$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_WRAM1$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r2,r2,r0
	lwz r9,128(r30)
	lwz r0,124(r30)
	mr r3,r0
	mr r4,r2
	mr r5,r9
	bl L_memcpy$stub
L158:
	li r0,0
	stw r0,72(r30)
	b L91
L154:
	lbz r0,132(r30)
	extsb r0,r0
	cmpwi cr7,r0,119
	bne cr7,L151
	lwz r0,128(r30)
	cmpwi cr7,r0,1
	bne cr7,L160
	addis r2,r31,ha16(L_WRAM1$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_WRAM1$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r9,r2,r0
	lwz r2,124(r30)
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	stb r0,0(r9)
	b L162
L160:
	addis r2,r31,ha16(L_WRAM1$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_WRAM1$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r2,r2,r0
	lwz r9,128(r30)
	lwz r0,124(r30)
	mr r3,r2
	mr r4,r0
	mr r5,r9
	bl L_memcpy$stub
L162:
	li r0,0
	stw r0,72(r30)
	b L91
L151:
	lwz r0,120(r30)
	li r2,0
	ori r2,r2,65023
	cmplw cr7,r0,r2
	bgt cr7,L163
	lwz r0,120(r30)
	li r2,0
	ori r2,r2,57343
	cmplw cr7,r0,r2
	ble cr7,L163
	lwz r2,120(r30)
	addis r2,r2,0xffff
	addi r0,r2,8192
	stw r0,120(r30)
	lbz r0,132(r30)
	extsb r0,r0
	cmpwi cr7,r0,114
	bne cr7,L166
	lwz r0,128(r30)
	cmpwi cr7,r0,1
	bne cr7,L168
	addis r2,r31,ha16(L_WRAM1$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_WRAM1$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r2,r2,r0
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	lwz r2,124(r30)
	stb r0,0(r2)
	b L170
L168:
	addis r2,r31,ha16(L_WRAM1$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_WRAM1$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r2,r2,r0
	lwz r9,128(r30)
	lwz r0,124(r30)
	mr r3,r0
	mr r4,r2
	mr r5,r9
	bl L_memcpy$stub
L170:
	li r0,0
	stw r0,72(r30)
	b L91
L166:
	lbz r0,132(r30)
	extsb r0,r0
	cmpwi cr7,r0,119
	bne cr7,L163
	lwz r0,128(r30)
	cmpwi cr7,r0,1
	bne cr7,L172
	addis r2,r31,ha16(L_WRAM1$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_WRAM1$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r9,r2,r0
	lwz r2,124(r30)
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	stb r0,0(r9)
	b L174
L172:
	addis r2,r31,ha16(L_WRAM1$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_WRAM1$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r2,r2,r0
	lwz r9,128(r30)
	lwz r0,124(r30)
	mr r3,r2
	mr r4,r0
	mr r5,r9
	bl L_memcpy$stub
L174:
	li r0,0
	stw r0,72(r30)
	b L91
L163:
	lwz r0,120(r30)
	li r2,0
	ori r2,r2,65183
	cmplw cr7,r0,r2
	bgt cr7,L175
	lwz r0,120(r30)
	li r2,0
	ori r2,r2,65023
	cmplw cr7,r0,r2
	ble cr7,L175
	lwz r2,120(r30)
	addis r2,r2,0xffff
	addi r0,r2,512
	stw r0,120(r30)
	lbz r0,132(r30)
	extsb r0,r0
	cmpwi cr7,r0,114
	bne cr7,L178
	lwz r0,128(r30)
	cmpwi cr7,r0,1
	bne cr7,L180
	addis r2,r31,ha16(L_OAM$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_OAM$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r2,r2,r0
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	lwz r2,124(r30)
	stb r0,0(r2)
	b L182
L180:
	addis r2,r31,ha16(L_OAM$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_OAM$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r2,r2,r0
	lwz r9,128(r30)
	lwz r0,124(r30)
	mr r3,r0
	mr r4,r2
	mr r5,r9
	bl L_memcpy$stub
L182:
	li r0,0
	stw r0,72(r30)
	b L91
L178:
	lbz r0,132(r30)
	extsb r0,r0
	cmpwi cr7,r0,119
	bne cr7,L175
	lwz r0,128(r30)
	cmpwi cr7,r0,1
	bne cr7,L184
	addis r2,r31,ha16(L_OAM$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_OAM$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r9,r2,r0
	lwz r2,124(r30)
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	stb r0,0(r9)
	b L186
L184:
	addis r2,r31,ha16(L_OAM$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_OAM$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r2,r2,r0
	lwz r9,128(r30)
	lwz r0,124(r30)
	mr r3,r2
	mr r4,r0
	mr r5,r9
	bl L_memcpy$stub
L186:
	li r0,0
	stw r0,72(r30)
	b L91
L175:
	lwz r0,120(r30)
	li r2,0
	ori r2,r2,65407
	cmplw cr7,r0,r2
	bgt cr7,L187
	lwz r0,120(r30)
	li r2,0
	ori r2,r2,65279
	cmplw cr7,r0,r2
	ble cr7,L187
	lwz r0,120(r30)
	rlwinm r2,r0,0,0xffff
	addi r0,r2,256
	sth r0,60(r30)
	lbz r0,132(r30)
	extsb r0,r0
	cmpwi cr7,r0,114
	bne cr7,L190
	lwz r0,128(r30)
	cmpwi cr7,r0,1
	bne cr7,L192
	lhz r0,60(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r31,ha16(L_IOBUF$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_IOBUF$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	lwz r2,124(r30)
	stb r0,0(r2)
	b L194
L192:
	lhz r0,60(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r31,ha16(L_IOBUF$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_IOBUF$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lwz r9,128(r30)
	lwz r0,124(r30)
	mr r3,r0
	mr r4,r2
	mr r5,r9
	bl L_memcpy$stub
L194:
	li r0,0
	stw r0,72(r30)
	b L91
L190:
	lbz r0,132(r30)
	extsb r0,r0
	cmpwi cr7,r0,119
	bne cr7,L187
	lwz r0,128(r30)
	cmpwi cr7,r0,1
	bne cr7,L196
	lhz r0,60(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r31,ha16(L_IOBUF$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_IOBUF$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r0,0(r2)
	add r9,r9,r0
	lwz r2,124(r30)
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	stb r0,0(r9)
	b L198
L196:
	lhz r0,60(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r31,ha16(L_IOBUF$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_IOBUF$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lwz r9,128(r30)
	lwz r0,124(r30)
	mr r3,r2
	mr r4,r0
	mr r5,r9
	bl L_memcpy$stub
L198:
	lwz r0,120(r30)
	li r2,0
	ori r2,r2,65350
	cmpw cr7,r0,r2
	bne cr7,L199
	lwz r2,124(r30)
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	mr r3,r0
	bl _doDma
	b L201
L199:
	lwz r0,120(r30)
	li r2,0
	ori r2,r2,65280
	cmpw cr7,r0,r2
	bne cr7,L202
	bl _changeJpRegs
	b L201
L202:
	lwz r0,120(r30)
	li r2,0
	ori r2,r2,65351
	cmpw cr7,r0,r2
	bne cr7,L204
	lwz r2,124(r30)
	lbz r0,0(r2)
	stb r0,58(r30)
	lbz r0,58(r30)
	rlwinm r0,r0,0,0xff
	rlwinm r0,r0,0,30,31
	addis r2,r31,ha16(L_bgp$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_bgp$non_lazy_ptr-"L00000000011$pb")(r2)
	stb r0,0(r2)
	lbz r0,58(r30)
	rlwinm r0,r0,0,0xff
	srwi r0,r0,2
	rlwinm r0,r0,0,0xff
	rlwinm r0,r0,0,30,31
	addis r2,r31,ha16(L_bgp$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_bgp$non_lazy_ptr-"L00000000011$pb")(r2)
	stb r0,1(r2)
	lbz r0,58(r30)
	rlwinm r0,r0,0,0xff
	srwi r0,r0,4
	rlwinm r0,r0,0,0xff
	rlwinm r0,r0,0,30,31
	addis r2,r31,ha16(L_bgp$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_bgp$non_lazy_ptr-"L00000000011$pb")(r2)
	stb r0,2(r2)
	lbz r0,58(r30)
	rlwinm r0,r0,0,0xff
	srwi r0,r0,6
	rlwinm r0,r0,0,0xff
	rlwinm r0,r0,0,30,31
	addis r2,r31,ha16(L_bgp$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_bgp$non_lazy_ptr-"L00000000011$pb")(r2)
	stb r0,3(r2)
	b L201
L204:
	lwz r0,120(r30)
	li r2,0
	ori r2,r2,65352
	cmpw cr7,r0,r2
	bne cr7,L206
	lwz r2,124(r30)
	lbz r0,0(r2)
	stb r0,57(r30)
	lbz r0,57(r30)
	rlwinm r0,r0,0,0xff
	rlwinm r0,r0,0,30,31
	addis r2,r31,ha16(L_sgp1$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_sgp1$non_lazy_ptr-"L00000000011$pb")(r2)
	stb r0,0(r2)
	lbz r0,57(r30)
	rlwinm r0,r0,0,0xff
	srwi r0,r0,2
	rlwinm r0,r0,0,0xff
	rlwinm r0,r0,0,30,31
	addis r2,r31,ha16(L_sgp1$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_sgp1$non_lazy_ptr-"L00000000011$pb")(r2)
	stb r0,1(r2)
	lbz r0,57(r30)
	rlwinm r0,r0,0,0xff
	srwi r0,r0,4
	rlwinm r0,r0,0,0xff
	rlwinm r0,r0,0,30,31
	addis r2,r31,ha16(L_sgp1$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_sgp1$non_lazy_ptr-"L00000000011$pb")(r2)
	stb r0,2(r2)
	lbz r0,57(r30)
	rlwinm r0,r0,0,0xff
	srwi r0,r0,6
	rlwinm r0,r0,0,0xff
	rlwinm r0,r0,0,30,31
	addis r2,r31,ha16(L_sgp1$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_sgp1$non_lazy_ptr-"L00000000011$pb")(r2)
	stb r0,3(r2)
	b L201
L206:
	lwz r0,120(r30)
	li r2,0
	ori r2,r2,65353
	cmpw cr7,r0,r2
	bne cr7,L201
	lwz r2,124(r30)
	lbz r0,0(r2)
	stb r0,56(r30)
	lbz r0,56(r30)
	rlwinm r0,r0,0,0xff
	rlwinm r0,r0,0,30,31
	addis r2,r31,ha16(L_sgp2$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_sgp2$non_lazy_ptr-"L00000000011$pb")(r2)
	stb r0,0(r2)
	lbz r0,56(r30)
	rlwinm r0,r0,0,0xff
	srwi r0,r0,2
	rlwinm r0,r0,0,0xff
	rlwinm r0,r0,0,30,31
	addis r2,r31,ha16(L_sgp2$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_sgp2$non_lazy_ptr-"L00000000011$pb")(r2)
	stb r0,1(r2)
	lbz r0,56(r30)
	rlwinm r0,r0,0,0xff
	srwi r0,r0,4
	rlwinm r0,r0,0,0xff
	rlwinm r0,r0,0,30,31
	addis r2,r31,ha16(L_sgp2$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_sgp2$non_lazy_ptr-"L00000000011$pb")(r2)
	stb r0,2(r2)
	lbz r0,56(r30)
	rlwinm r0,r0,0,0xff
	srwi r0,r0,6
	rlwinm r0,r0,0,0xff
	rlwinm r0,r0,0,30,31
	addis r2,r31,ha16(L_sgp2$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_sgp2$non_lazy_ptr-"L00000000011$pb")(r2)
	stb r0,3(r2)
L201:
	li r0,0
	stw r0,72(r30)
	b L91
L187:
	lwz r0,120(r30)
	li r2,0
	ori r2,r2,65535
	cmplw cr7,r0,r2
	bgt cr7,L209
	lwz r0,120(r30)
	li r2,0
	ori r2,r2,65407
	cmplw cr7,r0,r2
	ble cr7,L209
	lwz r2,120(r30)
	addis r2,r2,0xffff
	addi r0,r2,128
	stw r0,120(r30)
	lbz r0,132(r30)
	extsb r0,r0
	cmpwi cr7,r0,114
	bne cr7,L212
	lwz r0,128(r30)
	cmpwi cr7,r0,1
	bne cr7,L214
	addis r2,r31,ha16(L_HRAM$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_HRAM$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r2,r2,r0
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	lwz r2,124(r30)
	stb r0,0(r2)
	b L216
L214:
	addis r2,r31,ha16(L_HRAM$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_HRAM$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r2,r2,r0
	lwz r9,128(r30)
	lwz r0,124(r30)
	mr r3,r0
	mr r4,r2
	mr r5,r9
	bl L_memcpy$stub
L216:
	li r0,0
	stw r0,72(r30)
	b L91
L212:
	lbz r0,132(r30)
	extsb r0,r0
	cmpwi cr7,r0,119
	bne cr7,L209
	lwz r0,128(r30)
	cmpwi cr7,r0,1
	bne cr7,L218
	addis r2,r31,ha16(L_HRAM$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_HRAM$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r9,r2,r0
	lwz r2,124(r30)
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	stb r0,0(r9)
	b L220
L218:
	addis r2,r31,ha16(L_HRAM$non_lazy_ptr-"L00000000011$pb")
	lwz r2,lo16(L_HRAM$non_lazy_ptr-"L00000000011$pb")(r2)
	lwz r2,0(r2)
	lwz r0,120(r30)
	add r2,r2,r0
	lwz r9,128(r30)
	lwz r0,124(r30)
	mr r3,r2
	mr r4,r0
	mr r5,r9
	bl L_memcpy$stub
L220:
	li r0,0
	stw r0,72(r30)
	b L91
L209:
	li r0,-1
	stw r0,72(r30)
L91:
	lwz r0,72(r30)
	stw r0,76(r30)
L80:
	lwz r3,76(r30)
	lwz r1,0(r1)
	lwz r0,8(r1)
	mtlr r0
	lmw r29,-12(r1)
	blr
	.align 2
	.globl _fastread
_fastread:
	stmw r30,-8(r1)
	stwu r1,-48(r1)
	mr r30,r1
	mflr r0
	bcl 20,31,"L00000000012$pb"
"L00000000012$pb":
	mflr r10
	mtlr r0
	mr r0,r3
	sth r0,72(r30)
	lhz r0,72(r30)
	rlwinm r0,r0,0,0xffff
	cmplwi cr7,r0,16383
	bgt cr7,L223
	lhz r0,72(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r10,ha16(L_ROM$non_lazy_ptr-"L00000000012$pb")
	lwz r2,lo16(L_ROM$non_lazy_ptr-"L00000000012$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	stw r0,24(r30)
	b L225
L223:
	lhz r0,72(r30)
	extsh r0,r0
	cmpwi cr7,r0,0
	blt cr7,L226
	lhz r0,72(r30)
	rlwinm r9,r0,0,0xffff
	addis r2,r10,ha16(L_romoffset$non_lazy_ptr-"L00000000012$pb")
	lwz r2,lo16(L_romoffset$non_lazy_ptr-"L00000000012$pb")(r2)
	lwz r0,0(r2)
	add r0,r9,r0
	mr r9,r0
	addis r2,r10,ha16(L_ROM$non_lazy_ptr-"L00000000012$pb")
	lwz r2,lo16(L_ROM$non_lazy_ptr-"L00000000012$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	stw r0,24(r30)
	b L225
L226:
	lhz r0,72(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,49151
	cmplw cr7,r2,r0
	bgt cr7,L228
	lhz r0,72(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,40959
	cmplw cr7,r2,r0
	ble cr7,L228
	addis r2,r10,ha16(L_ERAM$non_lazy_ptr-"L00000000012$pb")
	lwz r2,lo16(L_ERAM$non_lazy_ptr-"L00000000012$pb")(r2)
	lwz r11,0(r2)
	lhz r0,72(r30)
	rlwinm r9,r0,0,0xffff
	addis r2,r10,ha16(L_ramoffset$non_lazy_ptr-"L00000000012$pb")
	lwz r2,lo16(L_ramoffset$non_lazy_ptr-"L00000000012$pb")(r2)
	lwz r0,0(r2)
	add r0,r9,r0
	add r2,r11,r0
	addis r2,r2,0xffff
	addi r2,r2,24576
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	stw r0,24(r30)
	b L225
L228:
	lhz r0,72(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r10,ha16(L_MEM$non_lazy_ptr-"L00000000012$pb")
	lwz r2,lo16(L_MEM$non_lazy_ptr-"L00000000012$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	stw r0,24(r30)
L225:
	lwz r0,24(r30)
	mr r3,r0
	lwz r1,0(r1)
	lmw r30,-8(r1)
	blr
	.align 2
	.globl _fastwrite
_fastwrite:
	mflr r0
	stmw r30,-8(r1)
	stw r0,8(r1)
	stwu r1,-96(r1)
	mr r30,r1
	bcl 20,31,"L00000000013$pb"
"L00000000013$pb":
	mflr r31
	mr r0,r3
	mr r2,r4
	sth r0,120(r30)
	stb r2,124(r30)
	lhz r0,120(r30)
	extsh r0,r0
	cmpwi cr7,r0,0
	blt cr7,L233
	addis r2,r31,ha16(L_mreader$non_lazy_ptr-"L00000000013$pb")
	lwz r2,lo16(L_mreader$non_lazy_ptr-"L00000000013$pb")(r2)
	lwz r0,0(r2)
	cmpwi cr7,r0,0
	bne cr7,L235
	li r0,0
	stw r0,76(r30)
	b L237
L235:
	addis r2,r31,ha16(L_mwriter$non_lazy_ptr-"L00000000013$pb")
	lwz r2,lo16(L_mwriter$non_lazy_ptr-"L00000000013$pb")(r2)
	lwz r9,0(r2)
	lhz r0,120(r30)
	rlwinm r2,r0,0,0xffff
	lbz r0,124(r30)
	rlwinm r0,r0,0,0xff
	mr r3,r2
	mr r4,r0
	li r5,1
	mr r12,r9
	mtctr r12
	bctrl
	li r0,0
	stw r0,76(r30)
	b L237
L233:
	lhz r0,120(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,49151
	cmplw cr7,r2,r0
	bgt cr7,L238
	lhz r0,120(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,40959
	cmplw cr7,r2,r0
	ble cr7,L238
	addis r2,r31,ha16(L_mwriter$non_lazy_ptr-"L00000000013$pb")
	lwz r2,lo16(L_mwriter$non_lazy_ptr-"L00000000013$pb")(r2)
	lwz r0,0(r2)
	cmpwi cr7,r0,0
	bne cr7,L241
	lhz r0,120(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r31,ha16(L_ERAM$non_lazy_ptr-"L00000000013$pb")
	lwz r2,lo16(L_ERAM$non_lazy_ptr-"L00000000013$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	addis r2,r2,0xffff
	addi r2,r2,24576
	lbz r0,124(r30)
	stb r0,0(r2)
	li r2,0
	stw r2,76(r30)
	b L237
L241:
	addis r2,r31,ha16(L_mwriter$non_lazy_ptr-"L00000000013$pb")
	lwz r2,lo16(L_mwriter$non_lazy_ptr-"L00000000013$pb")(r2)
	lwz r9,0(r2)
	lhz r0,120(r30)
	rlwinm r2,r0,0,0xffff
	lbz r0,124(r30)
	rlwinm r0,r0,0,0xff
	mr r3,r2
	mr r4,r0
	li r5,1
	mr r12,r9
	mtctr r12
	bctrl
	li r0,0
	stw r0,76(r30)
	b L237
L238:
	lhz r0,120(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r31,ha16(L_MEM$non_lazy_ptr-"L00000000013$pb")
	lwz r2,lo16(L_MEM$non_lazy_ptr-"L00000000013$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lbz r0,124(r30)
	stb r0,0(r2)
	lhz r0,120(r30)
	extsh r0,r0
	cmpwi cr7,r0,0
	bge cr7,L243
	lhz r0,120(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,38911
	cmplw cr7,r2,r0
	bgt cr7,L243
	lhz r0,120(r30)
	extsh r2,r0
	li r0,-32768
	subf r0,r0,r2
	extsh r0,r0
	rlwinm r0,r0,0,0xffff
	mr r3,r0
	bl _writeTileMem
	li r0,0
	stw r0,76(r30)
	b L237
L243:
	lhz r0,120(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,65407
	cmplw cr7,r2,r0
	bgt cr7,L246
	lhz r0,120(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,65279
	cmplw cr7,r2,r0
	ble cr7,L246
	lhz r0,120(r30)
	extsh r2,r0
	li r0,-256
	subf r0,r0,r2
	extsh r0,r0
	sth r0,56(r30)
	lhz r0,56(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r31,ha16(L_IOBUF$non_lazy_ptr-"L00000000013$pb")
	lwz r2,lo16(L_IOBUF$non_lazy_ptr-"L00000000013$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lbz r0,124(r30)
	stb r0,0(r2)
	lhz r0,120(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,65350
	cmpw cr7,r2,r0
	bne cr7,L249
	lbz r0,124(r30)
	rlwinm r0,r0,0,0xff
	mr r3,r0
	bl _doDma
L249:
	lhz r0,120(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,65280
	cmpw cr7,r2,r0
	bne cr7,L251
	bl _changeJpRegs
L251:
	lhz r0,120(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,65287
	cmpw cr7,r2,r0
	bne cr7,L253
	lbz r0,124(r30)
	rlwinm r0,r0,0,0xff
	rlwinm r2,r0,0,30,31
	stw r2,72(r30)
	lwz r0,72(r30)
	cmpwi cr7,r0,1
	beq cr7,L257
	lwz r2,72(r30)
	cmpwi cr7,r2,1
	bgt cr7,L260
	lwz r0,72(r30)
	cmpwi cr7,r0,0
	beq cr7,L256
	b L255
L260:
	lwz r2,72(r30)
	cmpwi cr7,r2,2
	beq cr7,L258
	lwz r0,72(r30)
	cmpwi cr7,r0,3
	beq cr7,L259
	b L255
L256:
	addis r2,r31,ha16(L_ICS$non_lazy_ptr-"L00000000013$pb")
	lwz r2,lo16(L_ICS$non_lazy_ptr-"L00000000013$pb")(r2)
	li r0,4096
	stw r0,0(r2)
	b L255
L257:
	addis r2,r31,ha16(L_ICS$non_lazy_ptr-"L00000000013$pb")
	lwz r2,lo16(L_ICS$non_lazy_ptr-"L00000000013$pb")(r2)
	lis r0,0x4
	stw r0,0(r2)
	b L255
L258:
	addis r2,r31,ha16(L_ICS$non_lazy_ptr-"L00000000013$pb")
	lwz r2,lo16(L_ICS$non_lazy_ptr-"L00000000013$pb")(r2)
	lis r0,0x1
	stw r0,0(r2)
	b L255
L259:
	addis r2,r31,ha16(L_ICS$non_lazy_ptr-"L00000000013$pb")
	lwz r2,lo16(L_ICS$non_lazy_ptr-"L00000000013$pb")(r2)
	li r0,16384
	stw r0,0(r2)
L255:
	lbz r0,124(r30)
	rlwinm r0,r0,0,0xff
	srwi r0,r0,2
	rlwinm r0,r0,0,0xff
	cmpwi cr7,r0,0
	beq cr7,L261
	addis r2,r31,ha16(L_TENABLE$non_lazy_ptr-"L00000000013$pb")
	lwz r2,lo16(L_TENABLE$non_lazy_ptr-"L00000000013$pb")(r2)
	li r0,1
	stb r0,0(r2)
	b L253
L261:
	addis r2,r31,ha16(L_TENABLE$non_lazy_ptr-"L00000000013$pb")
	lwz r2,lo16(L_TENABLE$non_lazy_ptr-"L00000000013$pb")(r2)
	li r0,0
	stb r0,0(r2)
L253:
	li r2,0
	stw r2,76(r30)
	b L237
L246:
	li r0,0
	stw r0,76(r30)
L237:
	lwz r0,76(r30)
	mr r3,r0
	lwz r1,0(r1)
	lwz r0,8(r1)
	mtlr r0
	lmw r30,-8(r1)
	blr
	.align 2
	.globl _fastmap
_fastmap:
	mflr r0
	stmw r30,-8(r1)
	stw r0,8(r1)
	stwu r1,-112(r1)
	mr r30,r1
	bcl 20,31,"L00000000014$pb"
"L00000000014$pb":
	mflr r31
	mr r0,r3
	mr r2,r4
	mr r9,r5
	sth r0,136(r30)
	stb r2,140(r30)
	stb r9,144(r30)
	lhz r0,136(r30)
	extsh r0,r0
	cmpwi cr7,r0,0
	blt cr7,L265
	addis r2,r31,ha16(L_mreader$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_mreader$non_lazy_ptr-"L00000000014$pb")(r2)
	lwz r0,0(r2)
	cmpwi cr7,r0,0
	bne cr7,L267
	lhz r0,136(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r31,ha16(L_ROM$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_ROM$non_lazy_ptr-"L00000000014$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	stw r0,76(r30)
L269:
	lwz r0,76(r30)
	stw r0,80(r30)
	b L264
L267:
	lbz r0,144(r30)
	extsb r0,r0
	cmpwi cr7,r0,114
	bne cr7,L270
	addis r2,r31,ha16(L_mreader$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_mreader$non_lazy_ptr-"L00000000014$pb")(r2)
	lwz r2,0(r2)
	lhz r0,136(r30)
	rlwinm r0,r0,0,0xffff
	mr r3,r0
	mr r12,r2
	mtctr r12
	bctrl
	mr r0,r3
	stw r0,76(r30)
	b L269
L270:
	addis r2,r31,ha16(L_mwriter$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_mwriter$non_lazy_ptr-"L00000000014$pb")(r2)
	lwz r9,0(r2)
	lhz r0,136(r30)
	rlwinm r2,r0,0,0xffff
	lbz r0,140(r30)
	rlwinm r0,r0,0,0xff
	mr r3,r2
	mr r4,r0
	li r5,1
	mr r12,r9
	mtctr r12
	bctrl
	li r0,0
	stw r0,76(r30)
	b L269
L265:
	lhz r0,136(r30)
	extsh r0,r0
	cmpwi cr7,r0,0
	bge cr7,L272
	lhz r0,136(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,40959
	cmplw cr7,r2,r0
	bgt cr7,L272
	lhz r0,136(r30)
	extsh r2,r0
	li r0,-32768
	subf r0,r0,r2
	extsh r0,r0
	sth r0,136(r30)
	lbz r0,144(r30)
	extsb r0,r0
	cmpwi cr7,r0,114
	bne cr7,L275
	lhz r0,136(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r31,ha16(L_VRAM$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_VRAM$non_lazy_ptr-"L00000000014$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	stw r0,76(r30)
	b L269
L275:
	lhz r0,136(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r31,ha16(L_VRAM$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_VRAM$non_lazy_ptr-"L00000000014$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lbz r0,140(r30)
	stb r0,0(r2)
	lhz r0,136(r30)
	rlwinm r0,r0,0,0xffff
	cmplwi cr7,r0,6143
	bgt cr7,L277
	lhz r0,136(r30)
	rlwinm r0,r0,0,0xffff
	mr r3,r0
	bl _writeTileMem
L277:
	li r0,0
	stw r0,76(r30)
	b L269
L272:
	lhz r0,136(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,49151
	cmplw cr7,r2,r0
	bgt cr7,L279
	lhz r0,136(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,40959
	cmplw cr7,r2,r0
	ble cr7,L279
	addis r2,r31,ha16(L_mwriter$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_mwriter$non_lazy_ptr-"L00000000014$pb")(r2)
	lwz r0,0(r2)
	cmpwi cr7,r0,0
	bne cr7,L282
	lhz r0,136(r30)
	extsh r2,r0
	li r0,-24576
	subf r0,r0,r2
	extsh r0,r0
	sth r0,136(r30)
	lbz r0,144(r30)
	extsb r0,r0
	cmpwi cr7,r0,114
	bne cr7,L284
	lhz r0,136(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r31,ha16(L_ERAM$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_ERAM$non_lazy_ptr-"L00000000014$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	stw r0,76(r30)
	b L269
L284:
	lhz r0,136(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r31,ha16(L_ERAM$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_ERAM$non_lazy_ptr-"L00000000014$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lbz r0,140(r30)
	stb r0,0(r2)
	li r2,0
	stw r2,76(r30)
	b L269
L282:
	lbz r0,144(r30)
	extsb r0,r0
	cmpwi cr7,r0,114
	bne cr7,L286
	addis r2,r31,ha16(L_mreader$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_mreader$non_lazy_ptr-"L00000000014$pb")(r2)
	lwz r2,0(r2)
	lhz r0,136(r30)
	rlwinm r0,r0,0,0xffff
	mr r3,r0
	mr r12,r2
	mtctr r12
	bctrl
	mr r0,r3
	stw r0,76(r30)
	b L269
L286:
	addis r2,r31,ha16(L_mwriter$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_mwriter$non_lazy_ptr-"L00000000014$pb")(r2)
	lwz r9,0(r2)
	lhz r0,136(r30)
	rlwinm r2,r0,0,0xffff
	lbz r0,140(r30)
	rlwinm r0,r0,0,0xff
	mr r3,r2
	mr r4,r0
	li r5,1
	mr r12,r9
	mtctr r12
	bctrl
	li r0,0
	stw r0,76(r30)
	b L269
L279:
	lhz r0,136(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,57343
	cmplw cr7,r2,r0
	bgt cr7,L288
	lhz r0,136(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,49151
	cmplw cr7,r2,r0
	ble cr7,L288
	lhz r0,136(r30)
	extsh r2,r0
	li r0,-16384
	subf r0,r0,r2
	extsh r0,r0
	sth r0,136(r30)
	lbz r0,144(r30)
	extsb r0,r0
	cmpwi cr7,r0,114
	bne cr7,L291
	lhz r0,136(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r31,ha16(L_WRAM1$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_WRAM1$non_lazy_ptr-"L00000000014$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	stw r0,76(r30)
	b L269
L291:
	lhz r0,136(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r31,ha16(L_WRAM1$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_WRAM1$non_lazy_ptr-"L00000000014$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lbz r0,140(r30)
	stb r0,0(r2)
	li r2,0
	stw r2,76(r30)
	b L269
L288:
	lhz r0,136(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,65023
	cmplw cr7,r2,r0
	bgt cr7,L293
	lhz r0,136(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,57343
	cmplw cr7,r2,r0
	ble cr7,L293
	lhz r0,136(r30)
	extsh r2,r0
	li r0,-8192
	subf r0,r0,r2
	extsh r0,r0
	sth r0,136(r30)
	lbz r0,144(r30)
	extsb r0,r0
	cmpwi cr7,r0,114
	bne cr7,L296
	lhz r0,136(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r31,ha16(L_WRAM1$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_WRAM1$non_lazy_ptr-"L00000000014$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	stw r0,76(r30)
	b L269
L296:
	lhz r0,136(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r31,ha16(L_WRAM1$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_WRAM1$non_lazy_ptr-"L00000000014$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lbz r0,140(r30)
	stb r0,0(r2)
	li r0,0
	stw r0,76(r30)
	b L269
L293:
	lhz r0,136(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,65183
	cmplw cr7,r2,r0
	bgt cr7,L298
	lhz r0,136(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,65023
	cmplw cr7,r2,r0
	ble cr7,L298
	lhz r0,136(r30)
	extsh r2,r0
	li r0,-512
	subf r0,r0,r2
	extsh r0,r0
	sth r0,136(r30)
	lbz r0,144(r30)
	extsb r0,r0
	cmpwi cr7,r0,114
	bne cr7,L301
	lhz r0,136(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r31,ha16(L_OAM$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_OAM$non_lazy_ptr-"L00000000014$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	stw r0,76(r30)
	b L269
L301:
	lhz r0,136(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r31,ha16(L_OAM$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_OAM$non_lazy_ptr-"L00000000014$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lbz r0,140(r30)
	stb r0,0(r2)
	li r2,0
	stw r2,76(r30)
	b L269
L298:
	lhz r0,136(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,65407
	cmplw cr7,r2,r0
	bgt cr7,L303
	lhz r0,136(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,65279
	cmplw cr7,r2,r0
	ble cr7,L303
	lhz r0,136(r30)
	extsh r2,r0
	li r0,-256
	subf r0,r0,r2
	extsh r0,r0
	sth r0,56(r30)
	lbz r0,144(r30)
	extsb r0,r0
	cmpwi cr7,r0,114
	bne cr7,L306
	lhz r0,56(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r31,ha16(L_IOBUF$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_IOBUF$non_lazy_ptr-"L00000000014$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	stw r0,76(r30)
	b L269
L306:
	lhz r0,56(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r31,ha16(L_IOBUF$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_IOBUF$non_lazy_ptr-"L00000000014$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lbz r0,140(r30)
	stb r0,0(r2)
	lhz r0,136(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,65350
	cmpw cr7,r2,r0
	bne cr7,L308
	lbz r0,140(r30)
	rlwinm r0,r0,0,0xff
	mr r3,r0
	bl _doDma
L308:
	lhz r0,136(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,65280
	cmpw cr7,r2,r0
	bne cr7,L310
	bl _changeJpRegs
L310:
	lhz r0,136(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,65287
	cmpw cr7,r2,r0
	bne cr7,L312
	lbz r0,140(r30)
	rlwinm r0,r0,0,0xff
	rlwinm r2,r0,0,30,31
	stw r2,72(r30)
	lwz r0,72(r30)
	cmpwi cr7,r0,1
	beq cr7,L316
	lwz r2,72(r30)
	cmpwi cr7,r2,1
	bgt cr7,L319
	lwz r0,72(r30)
	cmpwi cr7,r0,0
	beq cr7,L315
	b L314
L319:
	lwz r2,72(r30)
	cmpwi cr7,r2,2
	beq cr7,L317
	lwz r0,72(r30)
	cmpwi cr7,r0,3
	beq cr7,L318
	b L314
L315:
	addis r2,r31,ha16(L_ICS$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_ICS$non_lazy_ptr-"L00000000014$pb")(r2)
	li r0,4096
	stw r0,0(r2)
	b L314
L316:
	addis r2,r31,ha16(L_ICS$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_ICS$non_lazy_ptr-"L00000000014$pb")(r2)
	lis r0,0x4
	stw r0,0(r2)
	b L314
L317:
	addis r2,r31,ha16(L_ICS$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_ICS$non_lazy_ptr-"L00000000014$pb")(r2)
	lis r0,0x1
	stw r0,0(r2)
	b L314
L318:
	addis r2,r31,ha16(L_ICS$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_ICS$non_lazy_ptr-"L00000000014$pb")(r2)
	li r0,16384
	stw r0,0(r2)
L314:
	lbz r0,140(r30)
	rlwinm r0,r0,0,0xff
	srwi r0,r0,2
	rlwinm r0,r0,0,0xff
	cmpwi cr7,r0,0
	beq cr7,L320
	addis r2,r31,ha16(L_TENABLE$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_TENABLE$non_lazy_ptr-"L00000000014$pb")(r2)
	li r0,1
	stb r0,0(r2)
	b L312
L320:
	addis r2,r31,ha16(L_TENABLE$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_TENABLE$non_lazy_ptr-"L00000000014$pb")(r2)
	li r0,0
	stb r0,0(r2)
L312:
	li r2,0
	stw r2,76(r30)
	b L269
L303:
	lhz r0,136(r30)
	rlwinm r2,r0,0,0xffff
	li r0,0
	ori r0,r0,65407
	cmplw cr7,r2,r0
	ble cr7,L322
	lhz r0,136(r30)
	extsh r2,r0
	li r0,-128
	subf r0,r0,r2
	extsh r0,r0
	sth r0,136(r30)
	lbz r0,144(r30)
	extsb r0,r0
	cmpwi cr7,r0,114
	bne cr7,L324
	lhz r0,136(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r31,ha16(L_HRAM$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_HRAM$non_lazy_ptr-"L00000000014$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	stw r0,76(r30)
	b L269
L324:
	lhz r0,136(r30)
	rlwinm r0,r0,0,0xffff
	mr r9,r0
	addis r2,r31,ha16(L_HRAM$non_lazy_ptr-"L00000000014$pb")
	lwz r2,lo16(L_HRAM$non_lazy_ptr-"L00000000014$pb")(r2)
	lwz r0,0(r2)
	add r2,r9,r0
	lbz r0,140(r30)
	stb r0,0(r2)
	li r0,0
	stw r0,76(r30)
	b L269
L322:
	b L264
L264:
	lwz r3,80(r30)
	lwz r1,0(r1)
	lwz r0,8(r1)
	mtlr r0
	lmw r30,-8(r1)
	blr
	.align 2
	.globl _writeByte
_writeByte:
	mflr r0
	stmw r30,-8(r1)
	stw r0,8(r1)
	stwu r1,-80(r1)
	mr r30,r1
	mr r0,r3
	stw r4,108(r30)
	stb r0,104(r30)
	addi r3,r30,104
	li r4,1
	li r5,1
	lwz r6,108(r30)
	bl L_fwrite$stub
	lwz r1,0(r1)
	lwz r0,8(r1)
	mtlr r0
	lmw r30,-8(r1)
	blr
	.align 2
	.globl _writeWord
_writeWord:
	mflr r0
	stmw r30,-8(r1)
	stw r0,8(r1)
	stwu r1,-80(r1)
	mr r30,r1
	mr r0,r3
	stw r4,108(r30)
	sth r0,104(r30)
	addi r3,r30,104
	li r4,2
	li r5,1
	lwz r6,108(r30)
	bl L_fwrite$stub
	lwz r1,0(r1)
	lwz r0,8(r1)
	mtlr r0
	lmw r30,-8(r1)
	blr
	.align 2
	.globl _readByte
_readByte:
	mflr r0
	stmw r30,-8(r1)
	stw r0,8(r1)
	stwu r1,-80(r1)
	mr r30,r1
	stw r3,104(r30)
	stw r4,108(r30)
	lwz r3,104(r30)
	li r4,1
	li r5,1
	lwz r6,108(r30)
	bl L_fread$stub
	lwz r1,0(r1)
	lwz r0,8(r1)
	mtlr r0
	lmw r30,-8(r1)
	blr
	.align 2
	.globl _readWord
_readWord:
	mflr r0
	stmw r30,-8(r1)
	stw r0,8(r1)
	stwu r1,-80(r1)
	mr r30,r1
	stw r3,104(r30)
	stw r4,108(r30)
	lwz r3,104(r30)
	li r4,2
	li r5,1
	lwz r6,108(r30)
	bl L_fread$stub
	lwz r1,0(r1)
	lwz r0,8(r1)
	mtlr r0
	lmw r30,-8(r1)
	blr
	.cstring
	.align 2
LC0:
	.ascii "w\0"
	.align 2
LC1:
	.ascii "Problem opening file. State NOT saved.\12\0"
	.text
	.align 2
	.globl _saveState
_saveState:
	mflr r0
	stmw r30,-8(r1)
	stw r0,8(r1)
	stwu r1,-96(r1)
	mr r30,r1
	bcl 20,31,"L00000000015$pb"
"L00000000015$pb":
	mflr r31
	stw r3,120(r30)
	li r0,0
	stw r0,56(r30)
	lwz r3,120(r30)
	addis r2,r31,ha16(LC0-"L00000000015$pb")
	la r4,lo16(LC0-"L00000000015$pb")(r2)
	bl L_fopen$stub
	mr r0,r3
	stw r0,60(r30)
	lwz r0,60(r30)
	cmpwi cr7,r0,0
	bne cr7,L336
	addis r2,r31,ha16(L___sF$non_lazy_ptr-"L00000000015$pb")
	lwz r2,lo16(L___sF$non_lazy_ptr-"L00000000015$pb")(r2)
	addi r0,r2,176
	mr r3,r0
	addis r2,r31,ha16(LC1-"L00000000015$pb")
	la r4,lo16(LC1-"L00000000015$pb")(r2)
	bl L_fprintf$LDBLStub$stub
	b L342
L336:
	li r0,0
	stw r0,56(r30)
	b L339
L340:
	lwz r0,56(r30)
	addi r2,r30,64
	mr r3,r0
	mr r4,r2
	li r5,1
	li r6,114
	bl _map
	addi r0,r30,64
	mr r3,r0
	li r4,1
	li r5,1
	lwz r6,60(r30)
	bl L_fwrite$stub
	lwz r2,56(r30)
	addi r0,r2,1
	stw r0,56(r30)
L339:
	lwz r0,56(r30)
	li r2,0
	ori r2,r2,65535
	cmpw cr7,r0,r2
	ble cr7,L340
	addis r2,r31,ha16(L_ERAM$non_lazy_ptr-"L00000000015$pb")
	lwz r2,lo16(L_ERAM$non_lazy_ptr-"L00000000015$pb")(r2)
	lwz r0,0(r2)
	mr r3,r0
	li r4,1
	li r5,0
	ori r5,r5,32768
	lwz r6,60(r30)
	bl L_fwrite$stub
	addis r2,r31,ha16(L_OLDDIV$non_lazy_ptr-"L00000000015$pb")
	lwz r2,lo16(L_OLDDIV$non_lazy_ptr-"L00000000015$pb")(r2)
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	mr r3,r0
	lwz r4,60(r30)
	bl _writeByte
	addis r2,r31,ha16(L_IEMASTER$non_lazy_ptr-"L00000000015$pb")
	lwz r2,lo16(L_IEMASTER$non_lazy_ptr-"L00000000015$pb")(r2)
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	mr r3,r0
	lwz r4,60(r30)
	bl _writeByte
	addis r2,r31,ha16(L_IEMASTERR$non_lazy_ptr-"L00000000015$pb")
	lwz r2,lo16(L_IEMASTERR$non_lazy_ptr-"L00000000015$pb")(r2)
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	mr r3,r0
	lwz r4,60(r30)
	bl _writeByte
	addis r2,r31,ha16(L_ICLK$non_lazy_ptr-"L00000000015$pb")
	lwz r2,lo16(L_ICLK$non_lazy_ptr-"L00000000015$pb")(r2)
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	mr r3,r0
	lwz r4,60(r30)
	bl _writeByte
	addis r2,r31,ha16(L_ICLKE$non_lazy_ptr-"L00000000015$pb")
	lwz r2,lo16(L_ICLKE$non_lazy_ptr-"L00000000015$pb")(r2)
	lbz r0,0(r2)
	rlwinm r0,r0,0,0xff
	mr r3,r0
	lwz r4,60(r30)
	bl _writeByte
	li r3,1
	bl L_read8r$stub
	mr r0,r3
	mr r3,r0
	lwz r4,60(r30)
	bl _writeByte
	li r3,2
	bl L_read8r$stub
	mr r0,r3
	mr r3,r0
	lwz r4,60(r30)
	bl _writeByte
	li r3,3
	bl L_read8r$stub
	mr r0,r3
	mr r3,r0
	lwz r4,60(r30)
	bl _writeByte
	li r3,4
	bl L_read8r$stub
	mr r0,r3
	mr r3,r0
	lwz r4,60(r30)
	bl _writeByte
	li r3,5
	bl L_read8r$stub
	mr r0,r3
	mr r3,r0
	lwz r4,60(r30)
	bl _writeByte
	li r3,6
	bl L_read8r$stub
	mr r0,r3
	mr r3,r0
	lwz r4,60(r30)
	bl _writeByte
	li r3,7
	bl L_read8r$stub
	mr r0,r3
	mr r3,r0
	lwz r4,60(r30)
	bl _writeByte
	li r3,8
	bl L_read8r$stub
	mr r0,r3
	mr r3,r0
	lwz r4,60(r30)
	bl _writeByte
	li r3,9
	bl L_read16r$stub
	mr r0,r3
	mr r3,r0
	lwz r4,60(r30)
	bl _writeWord
	li r3,10
	bl L_read16r$stub
	mr r0,r3
	mr r3,r0
	lwz r4,60(r30)
	bl _writeWord
	lwz r3,60(r30)
	bl L_fclose$stub
L342:
	lwz r1,0(r1)
	lwz r0,8(r1)
	mtlr r0
	lmw r30,-8(r1)
	blr
	.cstring
	.align 2
LC2:
	.ascii "r\0"
	.align 2
LC3:
	.ascii "Problem opening file. State NOT loaded.\12\0"
	.text
	.align 2
	.globl _loadState
_loadState:
	mflr r0
	stmw r30,-8(r1)
	stw r0,8(r1)
	stwu r1,-96(r1)
	mr r30,r1
	bcl 20,31,"L00000000016$pb"
"L00000000016$pb":
	mflr r31
	stw r3,120(r30)
	li r0,0
	stw r0,56(r30)
	lwz r3,120(r30)
	addis r2,r31,ha16(LC2-"L00000000016$pb")
	la r4,lo16(LC2-"L00000000016$pb")(r2)
	bl L_fopen$stub
	mr r0,r3
	stw r0,60(r30)
	lwz r0,60(r30)
	cmpwi cr7,r0,0
	bne cr7,L344
	addis r2,r31,ha16(L___sF$non_lazy_ptr-"L00000000016$pb")
	lwz r2,lo16(L___sF$non_lazy_ptr-"L00000000016$pb")(r2)
	addi r0,r2,176
	mr r3,r0
	addis r2,r31,ha16(LC3-"L00000000016$pb")
	la r4,lo16(LC3-"L00000000016$pb")(r2)
	bl L_fprintf$LDBLStub$stub
	b L350
L344:
	li r0,0
	stw r0,56(r30)
	b L347
L348:
	addi r0,r30,64
	mr r3,r0
	li r4,1
	li r5,1
	lwz r6,60(r30)
	bl L_fread$stub
	lwz r0,56(r30)
	addi r2,r30,64
	mr r3,r0
	mr r4,r2
	li r5,1
	li r6,119
	bl _map
	lwz r2,56(r30)
	addi r0,r2,1
	stw r0,56(r30)
L347:
	lwz r0,56(r30)
	li r2,0
	ori r2,r2,65535
	cmpw cr7,r0,r2
	ble cr7,L348
	addis r2,r31,ha16(L_ERAM$non_lazy_ptr-"L00000000016$pb")
	lwz r2,lo16(L_ERAM$non_lazy_ptr-"L00000000016$pb")(r2)
	lwz r0,0(r2)
	mr r3,r0
	li r4,1
	li r5,0
	ori r5,r5,32768
	lwz r6,60(r30)
	bl L_fread$stub
	addis r2,r31,ha16(L_OLDDIV$non_lazy_ptr-"L00000000016$pb")
	lwz r3,lo16(L_OLDDIV$non_lazy_ptr-"L00000000016$pb")(r2)
	lwz r4,60(r30)
	bl _readByte
	addis r2,r31,ha16(L_IEMASTER$non_lazy_ptr-"L00000000016$pb")
	lwz r3,lo16(L_IEMASTER$non_lazy_ptr-"L00000000016$pb")(r2)
	lwz r4,60(r30)
	bl _readByte
	addis r2,r31,ha16(L_IEMASTERR$non_lazy_ptr-"L00000000016$pb")
	lwz r3,lo16(L_IEMASTERR$non_lazy_ptr-"L00000000016$pb")(r2)
	lwz r4,60(r30)
	bl _readByte
	addis r2,r31,ha16(L_ICLK$non_lazy_ptr-"L00000000016$pb")
	lwz r3,lo16(L_ICLK$non_lazy_ptr-"L00000000016$pb")(r2)
	lwz r4,60(r30)
	bl _readByte
	addis r2,r31,ha16(L_ICLKE$non_lazy_ptr-"L00000000016$pb")
	lwz r3,lo16(L_ICLKE$non_lazy_ptr-"L00000000016$pb")(r2)
	lwz r4,60(r30)
	bl _readByte
	addi r0,r30,64
	mr r3,r0
	lwz r4,60(r30)
	bl _readByte
	lbz r0,64(r30)
	rlwinm r0,r0,0,0xff
	li r3,1
	mr r4,r0
	bl L_write8r$stub
	addi r0,r30,64
	mr r3,r0
	lwz r4,60(r30)
	bl _readByte
	lbz r0,64(r30)
	rlwinm r0,r0,0,0xff
	li r3,2
	mr r4,r0
	bl L_write8r$stub
	addi r0,r30,64
	mr r3,r0
	lwz r4,60(r30)
	bl _readByte
	lbz r0,64(r30)
	rlwinm r0,r0,0,0xff
	li r3,3
	mr r4,r0
	bl L_write8r$stub
	addi r0,r30,64
	mr r3,r0
	lwz r4,60(r30)
	bl _readByte
	lbz r0,64(r30)
	rlwinm r0,r0,0,0xff
	li r3,4
	mr r4,r0
	bl L_write8r$stub
	addi r0,r30,64
	mr r3,r0
	lwz r4,60(r30)
	bl _readByte
	lbz r0,64(r30)
	rlwinm r0,r0,0,0xff
	li r3,5
	mr r4,r0
	bl L_write8r$stub
	addi r0,r30,64
	mr r3,r0
	lwz r4,60(r30)
	bl _readByte
	lbz r0,64(r30)
	rlwinm r0,r0,0,0xff
	li r3,6
	mr r4,r0
	bl L_write8r$stub
	addi r0,r30,64
	mr r3,r0
	lwz r4,60(r30)
	bl _readByte
	lbz r0,64(r30)
	rlwinm r0,r0,0,0xff
	li r3,7
	mr r4,r0
	bl L_write8r$stub
	addi r0,r30,64
	mr r3,r0
	lwz r4,60(r30)
	bl _readByte
	lbz r0,64(r30)
	rlwinm r0,r0,0,0xff
	li r3,8
	mr r4,r0
	bl L_write8r$stub
	addi r0,r30,66
	mr r3,r0
	lwz r4,60(r30)
	bl _readWord
	lhz r0,66(r30)
	rlwinm r0,r0,0,0xffff
	li r3,9
	mr r4,r0
	bl L_write16r$stub
	addi r0,r30,66
	mr r3,r0
	lwz r4,60(r30)
	bl _readWord
	lhz r0,66(r30)
	rlwinm r0,r0,0,0xffff
	li r3,10
	mr r4,r0
	bl L_write16r$stub
L350:
	lwz r1,0(r1)
	lwz r0,8(r1)
	mtlr r0
	lmw r30,-8(r1)
	blr
.comm _tiles,4
.comm _IEREG,1
.comm _HRAM,4
.comm _IOBUF,4
.comm _VRAM,4
.comm _ERAM,4
.comm _WRAM1,4
.comm _WRAM2,4
.comm _OAM,4
.comm _MEM,4
.comm _mreader,4
.comm _mwriter,4
.comm _map8,1024
.comm _map8arg1,256
.comm _map8arg2,256
.comm _map8icount,256
.comm _map8timing,256
.comm _map16,1024
.comm _map16arg,256
.comm _map16timing,256
.comm _rmap,36
.comm _jpbuf,1
	.section __TEXT,__picsymbolstub1,symbol_stubs,pure_instructions,32
	.align 5
L_map$stub:
	.indirect_symbol _map
	mflr r0
	bcl 20,31,"L00000000001$spb"
"L00000000001$spb":
	mflr r11
	addis r11,r11,ha16(L_map$lazy_ptr-"L00000000001$spb")
	mtlr r0
	lwzu r12,lo16(L_map$lazy_ptr-"L00000000001$spb")(r11)
	mtctr r12
	bctr
	.lazy_symbol_pointer
L_map$lazy_ptr:
	.indirect_symbol _map
	.long	dyld_stub_binding_helper
	.non_lazy_symbol_pointer
L_IOBUF$non_lazy_ptr:
	.indirect_symbol _IOBUF
	.long	0
L_mreader$non_lazy_ptr:
	.indirect_symbol _mreader
	.long	0
	.section __TEXT,__picsymbolstub1,symbol_stubs,pure_instructions,32
	.align 5
L_fprintf$LDBLStub$stub:
	.indirect_symbol _fprintf$LDBLStub
	mflr r0
	bcl 20,31,"L00000000002$spb"
"L00000000002$spb":
	mflr r11
	addis r11,r11,ha16(L_fprintf$LDBLStub$lazy_ptr-"L00000000002$spb")
	mtlr r0
	lwzu r12,lo16(L_fprintf$LDBLStub$lazy_ptr-"L00000000002$spb")(r11)
	mtctr r12
	bctr
	.lazy_symbol_pointer
L_fprintf$LDBLStub$lazy_ptr:
	.indirect_symbol _fprintf$LDBLStub
	.long	dyld_stub_binding_helper
	.non_lazy_symbol_pointer
L_sgp2$non_lazy_ptr:
	.indirect_symbol _sgp2
	.long	0
L_ERAM$non_lazy_ptr:
	.indirect_symbol _ERAM
	.long	0
	.section __TEXT,__picsymbolstub1,symbol_stubs,pure_instructions,32
	.align 5
L_jpDirections$stub:
	.indirect_symbol _jpDirections
	mflr r0
	bcl 20,31,"L00000000003$spb"
"L00000000003$spb":
	mflr r11
	addis r11,r11,ha16(L_jpDirections$lazy_ptr-"L00000000003$spb")
	mtlr r0
	lwzu r12,lo16(L_jpDirections$lazy_ptr-"L00000000003$spb")(r11)
	mtctr r12
	bctr
	.lazy_symbol_pointer
L_jpDirections$lazy_ptr:
	.indirect_symbol _jpDirections
	.long	dyld_stub_binding_helper
	.non_lazy_symbol_pointer
L_WRAM2$non_lazy_ptr:
	.indirect_symbol _WRAM2
	.long	0
L_romoffset$non_lazy_ptr:
	.indirect_symbol _romoffset
	.long	0
L_ICLK$non_lazy_ptr:
	.indirect_symbol _ICLK
	.long	0
	.section __TEXT,__picsymbolstub1,symbol_stubs,pure_instructions,32
	.align 5
L_fastwrite$stub:
	.indirect_symbol _fastwrite
	mflr r0
	bcl 20,31,"L00000000004$spb"
"L00000000004$spb":
	mflr r11
	addis r11,r11,ha16(L_fastwrite$lazy_ptr-"L00000000004$spb")
	mtlr r0
	lwzu r12,lo16(L_fastwrite$lazy_ptr-"L00000000004$spb")(r11)
	mtctr r12
	bctr
	.lazy_symbol_pointer
L_fastwrite$lazy_ptr:
	.indirect_symbol _fastwrite
	.long	dyld_stub_binding_helper
	.non_lazy_symbol_pointer
L_mwriter$non_lazy_ptr:
	.indirect_symbol _mwriter
	.long	0
L_rampage$non_lazy_ptr:
	.indirect_symbol _rampage
	.long	0
	.section __TEXT,__picsymbolstub1,symbol_stubs,pure_instructions,32
	.align 5
L_malloc$stub:
	.indirect_symbol _malloc
	mflr r0
	bcl 20,31,"L00000000005$spb"
"L00000000005$spb":
	mflr r11
	addis r11,r11,ha16(L_malloc$lazy_ptr-"L00000000005$spb")
	mtlr r0
	lwzu r12,lo16(L_malloc$lazy_ptr-"L00000000005$spb")(r11)
	mtctr r12
	bctr
	.lazy_symbol_pointer
L_malloc$lazy_ptr:
	.indirect_symbol _malloc
	.long	dyld_stub_binding_helper
	.section __TEXT,__picsymbolstub1,symbol_stubs,pure_instructions,32
	.align 5
L_SDL_CreateRGBSurface$stub:
	.indirect_symbol _SDL_CreateRGBSurface
	mflr r0
	bcl 20,31,"L00000000006$spb"
"L00000000006$spb":
	mflr r11
	addis r11,r11,ha16(L_SDL_CreateRGBSurface$lazy_ptr-"L00000000006$spb")
	mtlr r0
	lwzu r12,lo16(L_SDL_CreateRGBSurface$lazy_ptr-"L00000000006$spb")(r11)
	mtctr r12
	bctr
	.lazy_symbol_pointer
L_SDL_CreateRGBSurface$lazy_ptr:
	.indirect_symbol _SDL_CreateRGBSurface
	.long	dyld_stub_binding_helper
	.non_lazy_symbol_pointer
L_OAM$non_lazy_ptr:
	.indirect_symbol _OAM
	.long	0
L_VRAM$non_lazy_ptr:
	.indirect_symbol _VRAM
	.long	0
	.section __TEXT,__picsymbolstub1,symbol_stubs,pure_instructions,32
	.align 5
L_fwrite$stub:
	.indirect_symbol _fwrite
	mflr r0
	bcl 20,31,"L00000000007$spb"
"L00000000007$spb":
	mflr r11
	addis r11,r11,ha16(L_fwrite$lazy_ptr-"L00000000007$spb")
	mtlr r0
	lwzu r12,lo16(L_fwrite$lazy_ptr-"L00000000007$spb")(r11)
	mtctr r12
	bctr
	.lazy_symbol_pointer
L_fwrite$lazy_ptr:
	.indirect_symbol _fwrite
	.long	dyld_stub_binding_helper
	.section __TEXT,__picsymbolstub1,symbol_stubs,pure_instructions,32
	.align 5
L_write16r$stub:
	.indirect_symbol _write16r
	mflr r0
	bcl 20,31,"L00000000008$spb"
"L00000000008$spb":
	mflr r11
	addis r11,r11,ha16(L_write16r$lazy_ptr-"L00000000008$spb")
	mtlr r0
	lwzu r12,lo16(L_write16r$lazy_ptr-"L00000000008$spb")(r11)
	mtctr r12
	bctr
	.lazy_symbol_pointer
L_write16r$lazy_ptr:
	.indirect_symbol _write16r
	.long	dyld_stub_binding_helper
	.non_lazy_symbol_pointer
L_bgp$non_lazy_ptr:
	.indirect_symbol _bgp
	.long	0
	.section __TEXT,__picsymbolstub1,symbol_stubs,pure_instructions,32
	.align 5
L_intRequest$stub:
	.indirect_symbol _intRequest
	mflr r0
	bcl 20,31,"L00000000009$spb"
"L00000000009$spb":
	mflr r11
	addis r11,r11,ha16(L_intRequest$lazy_ptr-"L00000000009$spb")
	mtlr r0
	lwzu r12,lo16(L_intRequest$lazy_ptr-"L00000000009$spb")(r11)
	mtctr r12
	bctr
	.lazy_symbol_pointer
L_intRequest$lazy_ptr:
	.indirect_symbol _intRequest
	.long	dyld_stub_binding_helper
	.non_lazy_symbol_pointer
L_HRAM$non_lazy_ptr:
	.indirect_symbol _HRAM
	.long	0
L_pal$non_lazy_ptr:
	.indirect_symbol _pal
	.long	0
	.section __TEXT,__picsymbolstub1,symbol_stubs,pure_instructions,32
	.align 5
L_jpButtons$stub:
	.indirect_symbol _jpButtons
	mflr r0
	bcl 20,31,"L00000000010$spb"
"L00000000010$spb":
	mflr r11
	addis r11,r11,ha16(L_jpButtons$lazy_ptr-"L00000000010$spb")
	mtlr r0
	lwzu r12,lo16(L_jpButtons$lazy_ptr-"L00000000010$spb")(r11)
	mtctr r12
	bctr
	.lazy_symbol_pointer
L_jpButtons$lazy_ptr:
	.indirect_symbol _jpButtons
	.long	dyld_stub_binding_helper
	.non_lazy_symbol_pointer
L_rompage$non_lazy_ptr:
	.indirect_symbol _rompage
	.long	0
L_mbcmode$non_lazy_ptr:
	.indirect_symbol _mbcmode
	.long	0
	.section __TEXT,__picsymbolstub1,symbol_stubs,pure_instructions,32
	.align 5
L_writejpReg$stub:
	.indirect_symbol _writejpReg
	mflr r0
	bcl 20,31,"L00000000011$spb"
"L00000000011$spb":
	mflr r11
	addis r11,r11,ha16(L_writejpReg$lazy_ptr-"L00000000011$spb")
	mtlr r0
	lwzu r12,lo16(L_writejpReg$lazy_ptr-"L00000000011$spb")(r11)
	mtctr r12
	bctr
	.lazy_symbol_pointer
L_writejpReg$lazy_ptr:
	.indirect_symbol _writejpReg
	.long	dyld_stub_binding_helper
	.non_lazy_symbol_pointer
L_MEM$non_lazy_ptr:
	.indirect_symbol _MEM
	.long	0
L_IEMASTER$non_lazy_ptr:
	.indirect_symbol _IEMASTER
	.long	0
	.section __TEXT,__picsymbolstub1,symbol_stubs,pure_instructions,32
	.align 5
L_changeJpRegs$stub:
	.indirect_symbol _changeJpRegs
	mflr r0
	bcl 20,31,"L00000000012$spb"
"L00000000012$spb":
	mflr r11
	addis r11,r11,ha16(L_changeJpRegs$lazy_ptr-"L00000000012$spb")
	mtlr r0
	lwzu r12,lo16(L_changeJpRegs$lazy_ptr-"L00000000012$spb")(r11)
	mtctr r12
	bctr
	.lazy_symbol_pointer
L_changeJpRegs$lazy_ptr:
	.indirect_symbol _changeJpRegs
	.long	dyld_stub_binding_helper
	.section __TEXT,__picsymbolstub1,symbol_stubs,pure_instructions,32
	.align 5
L_fclose$stub:
	.indirect_symbol _fclose
	mflr r0
	bcl 20,31,"L00000000013$spb"
"L00000000013$spb":
	mflr r11
	addis r11,r11,ha16(L_fclose$lazy_ptr-"L00000000013$spb")
	mtlr r0
	lwzu r12,lo16(L_fclose$lazy_ptr-"L00000000013$spb")(r11)
	mtctr r12
	bctr
	.lazy_symbol_pointer
L_fclose$lazy_ptr:
	.indirect_symbol _fclose
	.long	dyld_stub_binding_helper
	.non_lazy_symbol_pointer
L_sgp1$non_lazy_ptr:
	.indirect_symbol _sgp1
	.long	0
	.section __TEXT,__picsymbolstub1,symbol_stubs,pure_instructions,32
	.align 5
L_fread$stub:
	.indirect_symbol _fread
	mflr r0
	bcl 20,31,"L00000000014$spb"
"L00000000014$spb":
	mflr r11
	addis r11,r11,ha16(L_fread$lazy_ptr-"L00000000014$spb")
	mtlr r0
	lwzu r12,lo16(L_fread$lazy_ptr-"L00000000014$spb")(r11)
	mtctr r12
	bctr
	.lazy_symbol_pointer
L_fread$lazy_ptr:
	.indirect_symbol _fread
	.long	dyld_stub_binding_helper
	.non_lazy_symbol_pointer
L_ramenable$non_lazy_ptr:
	.indirect_symbol _ramenable
	.long	0
L_WRAM1$non_lazy_ptr:
	.indirect_symbol _WRAM1
	.long	0
L_jpbuf$non_lazy_ptr:
	.indirect_symbol _jpbuf
	.long	0
L_ROM$non_lazy_ptr:
	.indirect_symbol _ROM
	.long	0
L_ICS$non_lazy_ptr:
	.indirect_symbol _ICS
	.long	0
	.section __TEXT,__picsymbolstub1,symbol_stubs,pure_instructions,32
	.align 5
L_read8r$stub:
	.indirect_symbol _read8r
	mflr r0
	bcl 20,31,"L00000000015$spb"
"L00000000015$spb":
	mflr r11
	addis r11,r11,ha16(L_read8r$lazy_ptr-"L00000000015$spb")
	mtlr r0
	lwzu r12,lo16(L_read8r$lazy_ptr-"L00000000015$spb")(r11)
	mtctr r12
	bctr
	.lazy_symbol_pointer
L_read8r$lazy_ptr:
	.indirect_symbol _read8r
	.long	dyld_stub_binding_helper
	.non_lazy_symbol_pointer
L___sF$non_lazy_ptr:
	.indirect_symbol ___sF
	.long	0
L_ramoffset$non_lazy_ptr:
	.indirect_symbol _ramoffset
	.long	0
L_tiles$non_lazy_ptr:
	.indirect_symbol _tiles
	.long	0
	.section __TEXT,__picsymbolstub1,symbol_stubs,pure_instructions,32
	.align 5
L_memcpy$stub:
	.indirect_symbol _memcpy
	mflr r0
	bcl 20,31,"L00000000016$spb"
"L00000000016$spb":
	mflr r11
	addis r11,r11,ha16(L_memcpy$lazy_ptr-"L00000000016$spb")
	mtlr r0
	lwzu r12,lo16(L_memcpy$lazy_ptr-"L00000000016$spb")(r11)
	mtctr r12
	bctr
	.lazy_symbol_pointer
L_memcpy$lazy_ptr:
	.indirect_symbol _memcpy
	.long	dyld_stub_binding_helper
	.section __TEXT,__picsymbolstub1,symbol_stubs,pure_instructions,32
	.align 5
L_fopen$stub:
	.indirect_symbol _fopen
	mflr r0
	bcl 20,31,"L00000000017$spb"
"L00000000017$spb":
	mflr r11
	addis r11,r11,ha16(L_fopen$lazy_ptr-"L00000000017$spb")
	mtlr r0
	lwzu r12,lo16(L_fopen$lazy_ptr-"L00000000017$spb")(r11)
	mtctr r12
	bctr
	.lazy_symbol_pointer
L_fopen$lazy_ptr:
	.indirect_symbol _fopen
	.long	dyld_stub_binding_helper
	.non_lazy_symbol_pointer
L_TENABLE$non_lazy_ptr:
	.indirect_symbol _TENABLE
	.long	0
L_ICLKE$non_lazy_ptr:
	.indirect_symbol _ICLKE
	.long	0
L_IEMASTERR$non_lazy_ptr:
	.indirect_symbol _IEMASTERR
	.long	0
L_OLDDIV$non_lazy_ptr:
	.indirect_symbol _OLDDIV
	.long	0
	.section __TEXT,__picsymbolstub1,symbol_stubs,pure_instructions,32
	.align 5
L_write8r$stub:
	.indirect_symbol _write8r
	mflr r0
	bcl 20,31,"L00000000018$spb"
"L00000000018$spb":
	mflr r11
	addis r11,r11,ha16(L_write8r$lazy_ptr-"L00000000018$spb")
	mtlr r0
	lwzu r12,lo16(L_write8r$lazy_ptr-"L00000000018$spb")(r11)
	mtctr r12
	bctr
	.lazy_symbol_pointer
L_write8r$lazy_ptr:
	.indirect_symbol _write8r
	.long	dyld_stub_binding_helper
	.section __TEXT,__picsymbolstub1,symbol_stubs,pure_instructions,32
	.align 5
L_fastread$stub:
	.indirect_symbol _fastread
	mflr r0
	bcl 20,31,"L00000000019$spb"
"L00000000019$spb":
	mflr r11
	addis r11,r11,ha16(L_fastread$lazy_ptr-"L00000000019$spb")
	mtlr r0
	lwzu r12,lo16(L_fastread$lazy_ptr-"L00000000019$spb")(r11)
	mtctr r12
	bctr
	.lazy_symbol_pointer
L_fastread$lazy_ptr:
	.indirect_symbol _fastread
	.long	dyld_stub_binding_helper
	.section __TEXT,__picsymbolstub1,symbol_stubs,pure_instructions,32
	.align 5
L_read16r$stub:
	.indirect_symbol _read16r
	mflr r0
	bcl 20,31,"L00000000020$spb"
"L00000000020$spb":
	mflr r11
	addis r11,r11,ha16(L_read16r$lazy_ptr-"L00000000020$spb")
	mtlr r0
	lwzu r12,lo16(L_read16r$lazy_ptr-"L00000000020$spb")(r11)
	mtctr r12
	bctr
	.lazy_symbol_pointer
L_read16r$lazy_ptr:
	.indirect_symbol _read16r
	.long	dyld_stub_binding_helper
	.non_lazy_symbol_pointer
L_DMADELAY$non_lazy_ptr:
	.indirect_symbol _DMADELAY
	.long	0
	.subsections_via_symbols

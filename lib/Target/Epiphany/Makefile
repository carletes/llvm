##===- lib/Target/Epiphany/Makefile ------------------------*- Makefile -*-===##
#
#                     The LLVM Compiler Infrastructure
#
# This file is distributed under the University of Illinois Open Source
# License. See LICENSE.TXT for details.
#
##===----------------------------------------------------------------------===##

LEVEL = ../../..
LIBRARYNAME = LLVMEpiphanyCodeGen
TARGET = Epiphany

# Make sure that tblgen is run, first thing.
BUILT_SOURCES = \
		EpiphanyGenAsmMatcher.inc \
		EpiphanyGenAsmWriter.inc \
		EpiphanyGenCallingConv.inc \
		EpiphanyGenCodeEmitter.inc \
		EpiphanyGenDAGISel.inc i\
		EpiphanyGenDisassemblerTables.inc \
		EpiphanyGenInstrInfo.inc \
		EpiphanyGenMCCodeEmitter.inc \
		EpiphanyGenRegisterInfo.inc \
		EpiphanyGenSubtargetInfo.inc

DIRS = \
	AsmParser \
	Disassembler \
	InstrPrinter \
	MCTargetDesc \
	TargetInfo

include $(LEVEL)/Makefile.common

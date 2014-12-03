set(LLVM_TARGET_DEFINITIONS Epiphany.td)

tablegen(LLVM EpiphanyGenRegisterInfo.inc -gen-register-info)
tablegen(LLVM EpiphanyGenInstrInfo.inc -gen-instr-info)
tablegen(LLVM EpiphanyGenMCCodeEmitter.inc -gen-emitter -mc-emitter)
tablegen(LLVM EpiphanyGenMCPseudoLowering.inc -gen-pseudo-lowering)
tablegen(LLVM EpiphanyGenAsmWriter.inc -gen-asm-writer)
tablegen(LLVM EpiphanyGenAsmWriter1.inc -gen-asm-writer -asmwriternum=1)
tablegen(LLVM EpiphanyGenAsmMatcher.inc -gen-asm-matcher)
tablegen(LLVM EpiphanyGenDAGISel.inc -gen-dag-isel)
tablegen(LLVM EpiphanyGenFastISel.inc -gen-fast-isel)
tablegen(LLVM EpiphanyGenCallingConv.inc -gen-callingconv)
tablegen(LLVM EpiphanyGenSubtargetInfo.inc -gen-subtarget)
tablegen(LLVM EpiphanyGenDisassemblerTables.inc -gen-disassembler)
add_public_tablegen_target(EpiphanyCommonTableGen)

add_llvm_target(EpiphanyCodeGen
  EpiphanyTargetMachine.cpp
)

add_dependencies(LLVMEpiphanyCodeGen intrinsics_gen)

add_subdirectory(TargetInfo)
add_subdirectory(InstPrinter)
add_subdirectory(MCTargetDesc)

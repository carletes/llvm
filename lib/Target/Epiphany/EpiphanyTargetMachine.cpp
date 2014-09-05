//===-- EpiphanyTargetMachine.cpp - Define TargetMachine for Epiphany -----===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
//
//===----------------------------------------------------------------------===//

#include "EpiphanyTargetMachine.h"
#include "Epiphany.h"
#include "llvm/CodeGen/Passes.h"
#include "llvm/PassManager.h"
#include "llvm/Support/TargetRegistry.h"
using namespace llvm;

extern "C" void LLVMInitializeEpiphanyTarget() {
  // Register the target.
  RegisterTargetMachine<EpiphanyTargetMachine> X(TheEpiphanyTarget);
}

/// EpiphanyTargetMachine ctor - Create an ILP32 architecture model
///
EpiphanyTargetMachine::EpiphanyTargetMachine(const Target &T, StringRef TT,
                                             StringRef CPU, StringRef FS,
                                             const TargetOptions &Options,
                                             Reloc::Model RM,
                                             CodeModel::Model CM,
                                             CodeGenOpt::Level OL)
  : LLVMTargetMachine(T, TT, CPU, FS, Options, RM, CM, OL) {
  initAsmInfo();
}

namespace {
/// Epiphany Code Generator Pass Configuration Options.
class EpiphanyPassConfig : public TargetPassConfig {
public:
  EpiphanyPassConfig(EpiphanyTargetMachine *TM, PassManagerBase &PM)
    : TargetPassConfig(TM, PM) {}

  EpiphanyTargetMachine &getEpiphanyTargetMachine() const {
    return getTM<EpiphanyTargetMachine>();
  }

  bool addInstSelector() override;
  bool addPreEmitPass() override;
};
} // namespace

TargetPassConfig *EpiphanyTargetMachine::createPassConfig(PassManagerBase &PM) {
  return new EpiphanyPassConfig(this, PM);
}

bool EpiphanyPassConfig::addInstSelector() {
  addPass(createEpiphanyISelDag(getEpiphanyTargetMachine()));
  return false;
}

/// addPreEmitPass - This pass may be implemented by targets that want to run
/// passes immediately before machine code is emitted.  This should return
/// true if -print-machineinstrs should print out the code after the passes.
bool EpiphanyPassConfig::addPreEmitPass(){
  addPass(createEpiphanyDelaySlotFillerPass(getEpiphanyTargetMachine()));
  return true;
}

void EpiphanyTargetMachine::anchor() { }

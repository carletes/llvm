//===-- EpiphanyTargetMachine.h - Define TargetMachine for Epiphany -*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file declares the Epiphany specific subclass of TargetMachine.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_EPIPHANY_EPIPHANYTARGETMACHINE_H
#define LLVM_LIB_TARGET_EPIPHANY_EPIPHANYTARGETMACHINE_H

#if 0  // me
#include "EpiphanyInstrInfo.h"
#include "EpiphanySubtarget.h"
#endif
#include "llvm/Target/TargetMachine.h"

namespace llvm {

class EpiphanyTargetMachine : public LLVMTargetMachine {
  //EpiphanySubtarget Subtarget;
public:
  EpiphanyTargetMachine(const Target &T, StringRef TT, StringRef CPU,
                        StringRef FS, const TargetOptions &Options,
                        Reloc::Model RM, CodeModel::Model CM,
                        CodeGenOpt::Level OL);

#if 0  // me
  const EpiphanySubtarget *getSubtargetImpl() const override { return &Subtarget; }

  EpiphanySubtarget *getSubtargetImpl() {
    return static_cast<EpiphanySubtarget *>(TargetMachine::getSubtargetImpl());
  }
#endif

  // Pass Pipeline Configuration
  TargetPassConfig *createPassConfig(PassManagerBase &PM) override;
};

} // end namespace llvm

#endif

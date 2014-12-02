//===-- EpiphanyRegisterInfo.h - Epiphany register info impl ----*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the Epiphany implementation of the TargetRegisterInfo class.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_EPIPHANY_EPIPHANYREGISTERINFO_H
#define LLVM_LIB_TARGET_EPIPHANY_EPIPHANYREGISTERINFO_H

#include "llvm/Target/TargetRegisterInfo.h"

#define GET_REGINFO_HEADER
#include "EpiphanyGenRegisterInfo.inc"

namespace llvm {

class EpiphanySubtarget;
class TargetInstrInfo;
class Type;

struct EpiphanyRegisterInfo : public EpiphanyGenRegisterInfo {
  EpiphanySubtarget &Subtarget;

  EpiphanyRegisterInfo(EpiphanySubtarget &st);

  /// Code Generation virtual methods...
  const MCPhysReg *
  getCalleeSavedRegs(const MachineFunction *MF =nullptr) const override;
  const uint32_t* getCallPreservedMask(CallingConv::ID CC) const override;

  const uint32_t* getRTCallPreservedMask(CallingConv::ID CC) const;

  BitVector getReservedRegs(const MachineFunction &MF) const override;

  const TargetRegisterClass *getPointerRegClass(const MachineFunction &MF,
                                                unsigned Kind) const override;

  void eliminateFrameIndex(MachineBasicBlock::iterator II,
                           int SPAdj, unsigned FIOperandNum,
                           RegScavenger *RS = nullptr) const override;

  void processFunctionBeforeFrameFinalized(MachineFunction &MF,
                                       RegScavenger *RS = nullptr) const;

  // Debug information queries.
  unsigned getFrameRegister(const MachineFunction &MF) const override;
};

} // end namespace llvm

#endif

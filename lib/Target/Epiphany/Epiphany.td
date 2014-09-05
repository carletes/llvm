//===-- Epiphany.td - Describe the Epiphany Target Machine -*- tablegen -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Target-independent interfaces.
//===----------------------------------------------------------------------===//

include "llvm/Target/Target.td"

//===----------------------------------------------------------------------===//
// Epiphany Subtarget features.
//

//===----------------------------------------------------------------------===//
// Register file.
//===----------------------------------------------------------------------===//

include "EpiphanyRegisterInfo.td"

//===----------------------------------------------------------------------===//
// Calling convention.
//===----------------------------------------------------------------------===//

include "EpiphanyCallingConv.td"

//===----------------------------------------------------------------------===//
// Instruction descriptions.
//===----------------------------------------------------------------------===//

include "EpiphanyInstrInfo.td"

def EpiphanyInstrInfo : InstrInfo;

//===----------------------------------------------------------------------===//
// Epiphany processors supported.
//===----------------------------------------------------------------------===//

class Proc<string Name, list<SubtargetFeature> Features>
 : Processor<Name, NoItineraries, Features>;

def : Proc<"generic", []>;


//===----------------------------------------------------------------------===//
// Assembly writer.
//===----------------------------------------------------------------------===//

def EpiphanyAsmWriter : AsmWriter {
  string AsmWriterClassName  = "InstPrinter";
  bit isMCAsmWriter = 1;
}

//===----------------------------------------------------------------------===//
// Declare the target which we are implementing
//===----------------------------------------------------------------------===//

def Epiphany : Target {
  let InstructionSet = EpiphanyInstrInfo;
  let AssemblyWriters = [EpiphanyAsmWriter];
}

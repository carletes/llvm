//===-- EpiphanyRegisterInfo.td - Epiphany Register defs ---*- tablegen -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
//  Declarations that describe the Epiphany register file
//===----------------------------------------------------------------------===//

class EpiphanyReg<bits<16> Enc, string n> : Register<n> {
  let HWEncoding = Enc;
  let Namespace = "Epiphany";
}

// Registers R0 to R12.
foreach I = 0-12 in
  def R#I : EpiphanyReg<I, "r"#I>, DwarfRegNum<[I]>;

// The stack pointer register (R13).
def SP : EpiphanyReg<13, "sp">, DwarfRegNum<[13]>;

// The link register (R14).
def LR : EpiphanyReg<14, "lr">, DwarfRegNum<[14]>;

// Registers R15 to R63.
foreach I = 15-63 in
  def R#I : EpiphanyReg<I, "r"#I>, DwarfRegNum<[I]>;

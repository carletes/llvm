//===-- EpiphanyCallingConv.td - Calling Conventions -------*- tablegen -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This describes the calling conventions for the Epiphany architecture.
//
//===----------------------------------------------------------------------===//

// From the Epiphany SDK Reference, Appendix A (ABI):
//
//   R0  -  R3:        Argument passing and return values     Caller
//   R4  -  R8:        Register variables                     Callee
//   R9:               Register variable/static base          Callee
//   R10:              Register variable/stack limit          Callee
//   R11:              Register variable/frame pointer        Callee
//   R12:              Intra-procedure call scratch register  Caller
//   R13:        SP    Stack pointer
//   R14:        LR    Link register                          Callee
//   R15:              General purpose                        Callee
//   R16 - R27:        General purpose                        Caller
//   R28 - R31:        Constants
//   R32 - R43:        General purpose                        Callee
//   R44 - R63:        General purpose                        Caller


// Argument calling convention.

def CC_Epiphany : CallingConv<[
  // Put ByVal arguments directly on the stack.
  CCIfByVal<CCPassByVal<4, 4>>,

  // Small params are promoted to word size ...
  CCIfType<[i8,  i16], CCPromoteToType<i32>>,

  // ... and passed in the first four registers ...
  CCIfType<[i32, f32], CCAssignToReg<[R0, R1, R2, R3]>>,

  // ... if enough registers are available --- otherwise the stack is used.
  CCIfType<[i32, f32], CCAssignToStack<4, 4>>
]>;


// Return value calling convention.

def RetCC_Epiphany : CallingConv<[
  // Small return values are promoted to word size ...
  CCIfType<[i8,  i16], CCPromoteToType<i32>>,

  // ... and passed in the first four registers ...
  CCIfType<[i32, f32], CCAssignToReg<[R0, R1, R2, R3]>>,

  // ... if enough registers are available --- otherwise the stack is used.
  CCIfType<[i32, f32], CCAssignToStack<4, 4>>
]>;


// Callee-saved registers.

def CSR_Epiphany : CalleeSavedRegs<(add)> {
  let OtherPreserved = (add (sequence "R%u",  4, 11),
                            LR,
			    R15,
                            (sequence "R%u", 32, 43));
}

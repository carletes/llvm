; RUN: llc < %s -march=x86 -mattr=+sse2 -mcpu=yonah | FileCheck %s
; RUN: llc < %s -march=x86-64 -mattr=+sse2 -mcpu=core2 | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

define i32 @t(<2 x i64>* %val) nounwind  {
; CHECK-LABEL: t:
; CHECK-NOT: movd
; CHECK: movl 8(
; CHECK-NEXT: ret
	%tmp2 = load <2 x i64>* %val, align 16		; <<2 x i64>> [#uses=1]
	%tmp3 = bitcast <2 x i64> %tmp2 to <4 x i32>		; <<4 x i32>> [#uses=1]
	%tmp4 = extractelement <4 x i32> %tmp3, i32 2		; <i32> [#uses=1]
	ret i32 %tmp4
}

; Case where extractelement of load ends up as undef.
; (Making sure this doesn't crash.)
define i32 @t2(<8 x i32>* %xp) {
; CHECK-LABEL: t2:
; CHECK: ret
  %x = load <8 x i32>* %xp
  %Shuff68 = shufflevector <8 x i32> %x, <8 x i32> undef, <8 x i32> <i32
undef, i32 7, i32 9, i32 undef, i32 13, i32 15, i32 1, i32 3>
  %y = extractelement <8 x i32> %Shuff68, i32 0
  ret i32 %y
}

; This case could easily end up inf-looping in the DAG combiner due to an
; low alignment load of the vector which prevents us from reliably forming a
; narrow load.
; FIXME: It would be nice to detect whether the target has fast and legal
; unaligned loads and use them here.
define void @t3() {
; CHECK-LABEL: t3:
;
; This movs the entire vector, shuffling the high double down. If we fixed the
; FIXME above it would just move the high double directly.
; CHECK: movhpd %xmm

bb:
  %tmp13 = load <2 x double>* undef, align 1
  %.sroa.3.24.vec.extract = extractelement <2 x double> %tmp13, i32 1
  store double %.sroa.3.24.vec.extract, double* undef, align 8
  unreachable
}

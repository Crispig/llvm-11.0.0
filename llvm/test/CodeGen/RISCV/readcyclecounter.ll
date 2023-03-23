; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32I %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64I %s

; Verify that we lower @llvm.readcyclecounter() correctly.

declare i64 @llvm.readcyclecounter()

define i64 @test_builtin_readcyclecounter() nounwind {
; RV32I-LABEL: test_builtin_readcyclecounter:
; RV32I:       # %bb.0:
; RV32I-NEXT:  .LBB0_1: # =>This Inner Loop Header: Depth=1
; RV32I-NEXT:    rdcycleh a1
; RV32I-NEXT:    rdcycle a0
; RV32I-NEXT:    rdcycleh a2
; RV32I-NEXT:    bne a1, a2, .LBB0_1
; RV32I-NEXT:  # %bb.2:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: test_builtin_readcyclecounter:
; RV64I:       # %bb.0:
; RV64I-NEXT:    rdcycle a0
; RV64I-NEXT:    ret
  %1 = tail call i64 @llvm.readcyclecounter()
  ret i64 %1
}
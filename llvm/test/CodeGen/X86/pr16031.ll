; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i386-unknown-linux-gnu -mcpu=corei7-avx -enable-misched=false | FileCheck %s

define i64 @main(i1 %tobool1) nounwind {
; CHECK-LABEL: main:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushl %esi
; CHECK-NEXT:    testb $1, {{[0-9]+}}(%esp)
; CHECK-NEXT:    movl $-12, %eax
; CHECK-NEXT:    movl $-1, %edx
; CHECK-NEXT:    cmovel %edx, %eax
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    movl %eax, %esi
; CHECK-NEXT:    addl $-1, %esi
; CHECK-NEXT:    movl $-1, %esi
; CHECK-NEXT:    adcl $-1, %esi
; CHECK-NEXT:    cmovsl %ecx, %eax
; CHECK-NEXT:    cmovsl %ecx, %edx
; CHECK-NEXT:    popl %esi
; CHECK-NEXT:    retl
entry:
  %0 = zext i1 %tobool1 to i32
  %. = xor i32 %0, 1
  %.21 = select i1 %tobool1, i32 -12, i32 -1
  %conv = sext i32 %.21 to i64
  %1 = add i64 %conv, -1
  %cmp10 = icmp slt i64 %1, 0
  %sub17 = select i1 %cmp10, i64 0, i64 %conv
  ret i64 %sub17
}

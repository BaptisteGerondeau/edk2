//------------------------------------------------------------------------------
//
// Copyright (c) 2008 - 2010, Apple Inc. All rights reserved.<BR>
// Copyright (c) 2011-2013, ARM Limited. All rights reserved.
//
// SPDX-License-Identifier: BSD-2-Clause-Patent
//
//------------------------------------------------------------------------------



    INCLUDE AsmMacroExport.inc

    AREA    CODE, ARM
//------------------------------------------------------------------------------

 RVCT_ASM_EXPORT ArmIsMpCore
  mrc     p15,0,R0,c0,c0,5
  // Get Multiprocessing extension (bit31) & U bit (bit30)
  and     R0, R0, #0xC0000000
  // if (bit31 == 1) && (bit30 == 0) then the processor is part of a multiprocessor system
  cmp     R0, #0x80000000
  moveq   R0, #1
  movne   R0, #0
  bx      LR

 RVCT_ASM_EXPORT ArmEnableAsynchronousAbort
  cpsie   a
  isb
  bx      LR

 RVCT_ASM_EXPORT ArmDisableAsynchronousAbort
  cpsid   a
  isb
  bx      LR

 RVCT_ASM_EXPORT ArmEnableIrq
  cpsie   i
  isb
  bx      LR

 RVCT_ASM_EXPORT ArmDisableIrq
  cpsid   i
  isb
  bx      LR

 RVCT_ASM_EXPORT ArmEnableFiq
  cpsie   f
  isb
  bx      LR

 RVCT_ASM_EXPORT ArmDisableFiq
  cpsid   f
  isb
  bx      LR

 RVCT_ASM_EXPORT ArmEnableInterrupts
  cpsie   if
  isb
  bx      LR

 RVCT_ASM_EXPORT ArmDisableInterrupts
  cpsid   if
  isb
  bx      LR

// UINT32
// ReadCCSIDR (
//   IN UINT32 CSSELR
//   )
 RVCT_ASM_EXPORT ReadCCSIDR
  mcr p15,2,r0,c0,c0,0   ; Write Cache Size Selection Register (CSSELR)
  isb
  mrc p15,1,r0,c0,c0,0 ; Read current CP15 Cache Size ID Register (CCSIDR)
  bx  lr

// UINT32
// ReadCLIDR (
//   IN UINT32 CSSELR
//   )
 RVCT_ASM_EXPORT ReadCLIDR
  mrc p15,1,r0,c0,c0,1 ; Read CP15 Cache Level ID Register
  bx  lr

 RVCT_ASM_EXPORT ArmReadNsacr
  mrc     p15, 0, r0, c1, c1, 2
  bx      lr

 RVCT_ASM_EXPORT ArmWriteNsacr
  mcr     p15, 0, r0, c1, c1, 2
  bx      lr

  END

//
//  Copyright (c) 2016 - 2017, ARM Limited. All rights reserved.
//
//  SPDX-License-Identifier: BSD-2-Clause-Patent
//
//


    INCLUDE AsmMacroExport.inc

    AREA    CODE, ARM

 RVCT_ASM_EXPORT ArmCallSvc
    // r0 will be popped just after the SVC call
    push     {r0, r4-r8}

    // Load the SVC arguments values into the appropriate registers
    ldm     r0, {r0-r7}

    svc     #0

    // Load the ARM_SVC_ARGS structure address from the stack into r8
    ldr     r8, [sp]

    // Load the SVC returned values into the appropriate registers
    // A SVC call can return up to 4 values - we do not need to store back r4-r7.
    stm     r8, {r0-r3}

    mov     r0, r8

    // Restore the registers r4-r8
    pop     {r1, r4-r8}
    bx      lr

    END

// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s


// --------------------------------------------------------------------------//
// Immediate out of lower bound [-16, 14].

st2h {z12.h, z13.h}, p4, [x12, #-18, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [-16, 14].
// CHECK-NEXT: st2h {z12.h, z13.h}, p4, [x12, #-18, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

st2h {z7.h, z8.h}, p3, [x1, #16, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [-16, 14].
// CHECK-NEXT: st2h {z7.h, z8.h}, p3, [x1, #16, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:


// --------------------------------------------------------------------------//
// Immediate not a multiple of two.

st2h {z12.h, z13.h}, p4, [x12, #-7, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [-16, 14].
// CHECK-NEXT: st2h {z12.h, z13.h}, p4, [x12, #-7, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

st2h {z7.h, z8.h}, p3, [x1, #5, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [-16, 14].
// CHECK-NEXT: st2h {z7.h, z8.h}, p3, [x1, #5, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:


// --------------------------------------------------------------------------//
// error: restricted predicate has range [0, 7].

st2h {z2.h, z3.h}, p8, [x15, #10, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: st2h {z2.h, z3.h}, p8, [x15, #10, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:


// --------------------------------------------------------------------------//
// Invalid vector list.

st2h { }, p0, [x0]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector register expected
// CHECK-NEXT: st2h { }, p0, [x0]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

st2h { z0.h, z1.h, z2.h }, p0, [x0]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: st2h { z0.h, z1.h, z2.h }, p0, [x0]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

st2h { z0.h, z1.s }, p0, [x0]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: mismatched register size suffix
// CHECK-NEXT: st2h { z0.h, z1.s }, p0, [x0]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

st2h { z0.h, z2.h }, p0, [x0]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: registers must be sequential
// CHECK-NEXT: st2h { z0.h, z2.h }, p0, [x0]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

st2h { v0.2d, v1.2d }, p0, [x0]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: st2h { v0.2d, v1.2d }, p0, [x0]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

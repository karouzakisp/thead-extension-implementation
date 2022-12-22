; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-unknown-linux-gnu < %s | FileCheck %s

;------------------------------------------------------------------------------;
; Odd divisors
;------------------------------------------------------------------------------;

define i32 @test_srem_odd(i32 %X) nounwind {
; CHECK-LABEL: test_srem_odd:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #52429
; CHECK-NEXT:    mov w9, #39321
; CHECK-NEXT:    movk w8, #52428, lsl #16
; CHECK-NEXT:    movk w9, #6553, lsl #16
; CHECK-NEXT:    madd w8, w0, w8, w9
; CHECK-NEXT:    mov w9, #858993459
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    cset w0, lo
; CHECK-NEXT:    ret
  %srem = srem i32 %X, 5
  %cmp = icmp eq i32 %srem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

define i32 @test_srem_odd_25(i32 %X) nounwind {
; CHECK-LABEL: test_srem_odd_25:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #23593
; CHECK-NEXT:    mov w9, #47185
; CHECK-NEXT:    movk w8, #49807, lsl #16
; CHECK-NEXT:    movk w9, #1310, lsl #16
; CHECK-NEXT:    madd w8, w0, w8, w9
; CHECK-NEXT:    mov w9, #28835
; CHECK-NEXT:    movk w9, #2621, lsl #16
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    cset w0, lo
; CHECK-NEXT:    ret
  %srem = srem i32 %X, 25
  %cmp = icmp eq i32 %srem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

; This is like test_srem_odd, except the divisor has bit 30 set.
define i32 @test_srem_odd_bit30(i32 %X) nounwind {
; CHECK-LABEL: test_srem_odd_bit30:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #43691
; CHECK-NEXT:    orr w9, wzr, #0x1
; CHECK-NEXT:    movk w8, #27306, lsl #16
; CHECK-NEXT:    madd w8, w0, w8, w9
; CHECK-NEXT:    cmp w8, #3
; CHECK-NEXT:    cset w0, lo
; CHECK-NEXT:    ret
  %srem = srem i32 %X, 1073741827
  %cmp = icmp eq i32 %srem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

; This is like test_srem_odd, except the divisor has bit 31 set.
define i32 @test_srem_odd_bit31(i32 %X) nounwind {
; CHECK-LABEL: test_srem_odd_bit31:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #21845
; CHECK-NEXT:    orr w9, wzr, #0x1
; CHECK-NEXT:    movk w8, #54613, lsl #16
; CHECK-NEXT:    madd w8, w0, w8, w9
; CHECK-NEXT:    cmp w8, #3
; CHECK-NEXT:    cset w0, lo
; CHECK-NEXT:    ret
  %srem = srem i32 %X, 2147483651
  %cmp = icmp eq i32 %srem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

;------------------------------------------------------------------------------;
; Even divisors
;------------------------------------------------------------------------------;

define i16 @test_srem_even(i16 %X) nounwind {
; CHECK-LABEL: test_srem_even:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #28087
; CHECK-NEXT:    mov w9, #4680
; CHECK-NEXT:    madd w8, w0, w8, w9
; CHECK-NEXT:    lsl w10, w8, #15
; CHECK-NEXT:    bfxil w10, w8, #1, #15
; CHECK-NEXT:    cmp w9, w10, uxth
; CHECK-NEXT:    cset w0, lo
; CHECK-NEXT:    ret
  %srem = srem i16 %X, 14
  %cmp = icmp ne i16 %srem, 0
  %ret = zext i1 %cmp to i16
  ret i16 %ret
}

define i32 @test_srem_even_100(i32 %X) nounwind {
; CHECK-LABEL: test_srem_even_100:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #23593
; CHECK-NEXT:    mov w9, #47184
; CHECK-NEXT:    movk w8, #49807, lsl #16
; CHECK-NEXT:    movk w9, #1310, lsl #16
; CHECK-NEXT:    madd w8, w0, w8, w9
; CHECK-NEXT:    mov w9, #23593
; CHECK-NEXT:    movk w9, #655, lsl #16
; CHECK-NEXT:    ror w8, w8, #2
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    cset w0, lo
; CHECK-NEXT:    ret
  %srem = srem i32 %X, 100
  %cmp = icmp eq i32 %srem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

; This is like test_srem_even, except the divisor has bit 30 set.
define i32 @test_srem_even_bit30(i32 %X) nounwind {
; CHECK-LABEL: test_srem_even_bit30:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #20165
; CHECK-NEXT:    orr w9, wzr, #0x8
; CHECK-NEXT:    movk w8, #64748, lsl #16
; CHECK-NEXT:    madd w8, w0, w8, w9
; CHECK-NEXT:    ror w8, w8, #3
; CHECK-NEXT:    cmp w8, #3
; CHECK-NEXT:    cset w0, lo
; CHECK-NEXT:    ret
  %srem = srem i32 %X, 1073741928
  %cmp = icmp eq i32 %srem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

; This is like test_srem_odd, except the divisor has bit 31 set.
define i32 @test_srem_even_bit31(i32 %X) nounwind {
; CHECK-LABEL: test_srem_even_bit31:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1285
; CHECK-NEXT:    orr w9, wzr, #0x2
; CHECK-NEXT:    movk w8, #50437, lsl #16
; CHECK-NEXT:    madd w8, w0, w8, w9
; CHECK-NEXT:    ror w8, w8, #1
; CHECK-NEXT:    cmp w8, #3
; CHECK-NEXT:    cset w0, lo
; CHECK-NEXT:    ret
  %srem = srem i32 %X, 2147483750
  %cmp = icmp eq i32 %srem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

;------------------------------------------------------------------------------;
; Special case
;------------------------------------------------------------------------------;

; 'NE' predicate is fine too.
define i32 @test_srem_odd_setne(i32 %X) nounwind {
; CHECK-LABEL: test_srem_odd_setne:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #52429
; CHECK-NEXT:    mov w9, #39321
; CHECK-NEXT:    movk w8, #52428, lsl #16
; CHECK-NEXT:    movk w9, #6553, lsl #16
; CHECK-NEXT:    madd w8, w0, w8, w9
; CHECK-NEXT:    mov w9, #13106
; CHECK-NEXT:    movk w9, #13107, lsl #16
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    cset w0, hi
; CHECK-NEXT:    ret
  %srem = srem i32 %X, 5
  %cmp = icmp ne i32 %srem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

; The fold is only valid for positive divisors, negative-ones should be negated.
define i32 @test_srem_negative_odd(i32 %X) nounwind {
; CHECK-LABEL: test_srem_negative_odd:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #52429
; CHECK-NEXT:    mov w9, #39321
; CHECK-NEXT:    movk w8, #52428, lsl #16
; CHECK-NEXT:    movk w9, #6553, lsl #16
; CHECK-NEXT:    madd w8, w0, w8, w9
; CHECK-NEXT:    mov w9, #13106
; CHECK-NEXT:    movk w9, #13107, lsl #16
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    cset w0, hi
; CHECK-NEXT:    ret
  %srem = srem i32 %X, -5
  %cmp = icmp ne i32 %srem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}
define i32 @test_srem_negative_even(i32 %X) nounwind {
; CHECK-LABEL: test_srem_negative_even:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #28087
; CHECK-NEXT:    mov w9, #9362
; CHECK-NEXT:    movk w8, #46811, lsl #16
; CHECK-NEXT:    movk w9, #4681, lsl #16
; CHECK-NEXT:    madd w8, w0, w8, w9
; CHECK-NEXT:    ror w8, w8, #1
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    cset w0, hi
; CHECK-NEXT:    ret
  %srem = srem i32 %X, -14
  %cmp = icmp ne i32 %srem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

;------------------------------------------------------------------------------;
; Negative tests
;------------------------------------------------------------------------------;

; We can lower remainder of division by one much better elsewhere.
define i32 @test_srem_one(i32 %X) nounwind {
; CHECK-LABEL: test_srem_one:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w0, #1
; CHECK-NEXT:    ret
  %srem = srem i32 %X, 1
  %cmp = icmp eq i32 %srem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

; We can lower remainder of division by powers of two much better elsewhere.
define i32 @test_srem_pow2(i32 %X) nounwind {
; CHECK-LABEL: test_srem_pow2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    negs w8, w0
; CHECK-NEXT:    and w9, w0, #0xf
; CHECK-NEXT:    and w8, w8, #0xf
; CHECK-NEXT:    csneg w8, w9, w8, mi
; CHECK-NEXT:    cmp w8, #0
; CHECK-NEXT:    cset w0, eq
; CHECK-NEXT:    ret
  %srem = srem i32 %X, 16
  %cmp = icmp eq i32 %srem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

; The fold is only valid for positive divisors, and we can't negate INT_MIN.
define i32 @test_srem_int_min(i32 %X) nounwind {
; CHECK-LABEL: test_srem_int_min:
; CHECK:       // %bb.0:
; CHECK-NEXT:    negs w8, w0
; CHECK-NEXT:    and w9, w0, #0x7fffffff
; CHECK-NEXT:    and w8, w8, #0x7fffffff
; CHECK-NEXT:    csneg w8, w9, w8, mi
; CHECK-NEXT:    cmp w8, #0
; CHECK-NEXT:    cset w0, eq
; CHECK-NEXT:    ret
  %srem = srem i32 %X, 2147483648
  %cmp = icmp eq i32 %srem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

; We can lower remainder of division by all-ones much better elsewhere.
define i32 @test_srem_allones(i32 %X) nounwind {
; CHECK-LABEL: test_srem_allones:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w0, #1
; CHECK-NEXT:    ret
  %srem = srem i32 %X, 4294967295
  %cmp = icmp eq i32 %srem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}
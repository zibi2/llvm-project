; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s -mtriple aarch64-none-linux-gnu -mattr=+sve2p1 -stop-after=finalize-isel | FileCheck %s --check-prefix=CHECK

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-none-linux-gnu"

define <vscale x 16 x i8> @test_svadd_i8(<vscale x 16 x i8> %Zn, <vscale x 16 x i8> %Zm) {
  ; CHECK-LABEL: name: test_svadd_i8
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $z0, $z1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:zpr = COPY $z1
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:zpr = COPY $z0
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:zpr = COPY [[COPY1]]
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:zpr_3b = COPY [[COPY]]
  ; CHECK-NEXT:   INLINEASM &"add $0.b, $1.b, $2.b", 0 /* attdialect */, 5767178 /* regdef:ZPR */, def %2, 5767177 /* reguse:ZPR */, [[COPY2]], 6357001 /* reguse:ZPR_3b */, [[COPY3]]
  ; CHECK-NEXT:   $z0 = COPY %2
  ; CHECK-NEXT:   RET_ReallyLR implicit $z0
  %1 = tail call <vscale x 16 x i8> asm "add $0.b, $1.b, $2.b", "=w,w,y"(<vscale x 16 x i8> %Zn, <vscale x 16 x i8> %Zm)
  ret <vscale x 16 x i8> %1
}

define <vscale x 2 x i64> @test_svsub_i64(<vscale x 2 x i64> %Zn, <vscale x 2 x i64> %Zm) {
  ; CHECK-LABEL: name: test_svsub_i64
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $z0, $z1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:zpr = COPY $z1
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:zpr = COPY $z0
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:zpr = COPY [[COPY1]]
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:zpr_4b = COPY [[COPY]]
  ; CHECK-NEXT:   INLINEASM &"sub $0.d, $1.d, $2.d", 0 /* attdialect */, 5767178 /* regdef:ZPR */, def %2, 5767177 /* reguse:ZPR */, [[COPY2]], 6029321 /* reguse:ZPR_4b */, [[COPY3]]
  ; CHECK-NEXT:   $z0 = COPY %2
  ; CHECK-NEXT:   RET_ReallyLR implicit $z0
  %1 = tail call <vscale x 2 x i64> asm "sub $0.d, $1.d, $2.d", "=w,w,x"(<vscale x 2 x i64> %Zn, <vscale x 2 x i64> %Zm)
  ret <vscale x 2 x i64> %1
}

define <vscale x 8 x half> @test_svfmul_f16(<vscale x 8 x half> %Zn, <vscale x 8 x half> %Zm) {
  ; CHECK-LABEL: name: test_svfmul_f16
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $z0, $z1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:zpr = COPY $z1
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:zpr = COPY $z0
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:zpr = COPY [[COPY1]]
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:zpr_3b = COPY [[COPY]]
  ; CHECK-NEXT:   INLINEASM &"fmul $0.h, $1.h, $2.h", 0 /* attdialect */, 5767178 /* regdef:ZPR */, def %2, 5767177 /* reguse:ZPR */, [[COPY2]], 6357001 /* reguse:ZPR_3b */, [[COPY3]]
  ; CHECK-NEXT:   $z0 = COPY %2
  ; CHECK-NEXT:   RET_ReallyLR implicit $z0
  %1 = tail call <vscale x 8 x half> asm "fmul $0.h, $1.h, $2.h", "=w,w,y"(<vscale x 8 x half> %Zn, <vscale x 8 x half> %Zm)
  ret <vscale x 8 x half> %1
}

define <vscale x 4 x float> @test_svfmul_f(<vscale x 4 x float> %Zn, <vscale x 4 x float> %Zm) {
  ; CHECK-LABEL: name: test_svfmul_f
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $z0, $z1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:zpr = COPY $z1
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:zpr = COPY $z0
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:zpr = COPY [[COPY1]]
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:zpr_4b = COPY [[COPY]]
  ; CHECK-NEXT:   INLINEASM &"fmul $0.s, $1.s, $2.s", 0 /* attdialect */, 5767178 /* regdef:ZPR */, def %2, 5767177 /* reguse:ZPR */, [[COPY2]], 6029321 /* reguse:ZPR_4b */, [[COPY3]]
  ; CHECK-NEXT:   $z0 = COPY %2
  ; CHECK-NEXT:   RET_ReallyLR implicit $z0
  %1 = tail call <vscale x 4 x float> asm "fmul $0.s, $1.s, $2.s", "=w,w,x"(<vscale x 4 x float> %Zn, <vscale x 4 x float> %Zm)
  ret <vscale x 4 x float> %1
}

define <vscale x 8 x half> @test_svfadd_f16(<vscale x 16 x i1> %Pg, <vscale x 8 x half> %Zn, <vscale x 8 x half> %Zm) {
  ; CHECK-LABEL: name: test_svfadd_f16
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $p0, $z0, $z1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:zpr = COPY $z1
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:zpr = COPY $z0
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:ppr = COPY $p0
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:ppr_3b = COPY [[COPY2]]
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:zpr = COPY [[COPY1]]
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:zpr = COPY [[COPY]]
  ; CHECK-NEXT:   INLINEASM &"fadd $0.h, $1/m, $2.h, $3.h", 0 /* attdialect */, 5767178 /* regdef:ZPR */, def %3, 720905 /* reguse:PPR_3b */, [[COPY3]], 5767177 /* reguse:ZPR */, [[COPY4]], 5767177 /* reguse:ZPR */, [[COPY5]]
  ; CHECK-NEXT:   $z0 = COPY %3
  ; CHECK-NEXT:   RET_ReallyLR implicit $z0
  %1 = tail call <vscale x 8 x half> asm "fadd $0.h, $1/m, $2.h, $3.h", "=w,@3Upl,w,w"(<vscale x 16 x i1> %Pg, <vscale x 8 x half> %Zn, <vscale x 8 x half> %Zm)
  ret <vscale x 8 x half> %1
}

define <vscale x 4 x i32> @test_incp(<vscale x 16 x i1> %Pg, <vscale x 4 x i32> %Zn) {
  ; CHECK-LABEL: name: test_incp
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $p0, $z0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:zpr = COPY $z0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:ppr = COPY $p0
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:ppr = COPY [[COPY1]]
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:zpr = COPY [[COPY]]
  ; CHECK-NEXT:   INLINEASM &"incp $0.s, $1", 0 /* attdialect */, 5767178 /* regdef:ZPR */, def %2, 458761 /* reguse:PPR */, [[COPY2]], 2147483657 /* reguse tiedto:$0 */, [[COPY3]](tied-def 3)
  ; CHECK-NEXT:   $z0 = COPY %2
  ; CHECK-NEXT:   RET_ReallyLR implicit $z0
  %1 = tail call <vscale x 4 x i32> asm "incp $0.s, $1", "=w,@3Upa,0"(<vscale x 16 x i1> %Pg, <vscale x 4 x i32> %Zn)
  ret <vscale x 4 x i32> %1
}

define <vscale x 8 x half> @test_svfadd_f16_Uph_constraint(<vscale x 16 x i1> %Pg, <vscale x 8 x half> %Zn, <vscale x 8 x half> %Zm) {
  ; CHECK-LABEL: name: test_svfadd_f16_Uph_constraint
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $p0, $z0, $z1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:zpr = COPY $z1
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:zpr = COPY $z0
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:ppr = COPY $p0
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:ppr_p8to15 = COPY [[COPY2]]
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:zpr = COPY [[COPY1]]
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:zpr = COPY [[COPY]]
  ; CHECK-NEXT:   INLINEASM &"fadd $0.h, $1/m, $2.h, $3.h", 0 /* attdialect */, 5767178 /* regdef:ZPR */, def %3, 786441 /* reguse:PPR_p8to15 */, [[COPY3]], 5767177 /* reguse:ZPR */, [[COPY4]], 5767177 /* reguse:ZPR */, [[COPY5]]
  ; CHECK-NEXT:   $z0 = COPY %3
  ; CHECK-NEXT:   RET_ReallyLR implicit $z0
  %1 = tail call <vscale x 8 x half> asm "fadd $0.h, $1/m, $2.h, $3.h", "=w,@3Uph,w,w"(<vscale x 16 x i1> %Pg, <vscale x 8 x half> %Zn, <vscale x 8 x half> %Zm)
  ret <vscale x 8 x half> %1
}

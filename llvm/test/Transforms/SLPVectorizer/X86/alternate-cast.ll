; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -mtriple=x86_64-unknown -passes=slp-vectorizer -S | FileCheck %s --check-prefixes=CHECK,SSE2
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=slm -passes=slp-vectorizer -S | FileCheck %s --check-prefixes=CHECK,SLM
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=corei7-avx -passes=slp-vectorizer -S | FileCheck %s --check-prefixes=CHECK,AVX
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=core-avx2 -passes=slp-vectorizer -S | FileCheck %s --check-prefixes=CHECK,AVX2
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=knl -passes=slp-vectorizer -S | FileCheck %s --check-prefixes=CHECK,AVX512
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=skx -passes=slp-vectorizer -S | FileCheck %s --check-prefixes=CHECK,AVX512

define <8 x float> @sitofp_uitofp(<8 x i32> %a) {
; SSE2-LABEL: @sitofp_uitofp(
; SSE2-NEXT:    [[TMP1:%.*]] = shufflevector <8 x i32> [[A:%.*]], <8 x i32> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; SSE2-NEXT:    [[TMP2:%.*]] = sitofp <4 x i32> [[TMP1]] to <4 x float>
; SSE2-NEXT:    [[TMP3:%.*]] = shufflevector <8 x i32> [[A]], <8 x i32> poison, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
; SSE2-NEXT:    [[TMP4:%.*]] = uitofp <4 x i32> [[TMP3]] to <4 x float>
; SSE2-NEXT:    [[TMP6:%.*]] = shufflevector <4 x float> [[TMP2]], <4 x float> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
; SSE2-NEXT:    [[TMP5:%.*]] = call <8 x float> @llvm.vector.insert.v8f32.v4f32(<8 x float> [[TMP6]], <4 x float> [[TMP4]], i64 4)
; SSE2-NEXT:    ret <8 x float> [[TMP5]]
;
; SLM-LABEL: @sitofp_uitofp(
; SLM-NEXT:    [[TMP1:%.*]] = shufflevector <8 x i32> [[A:%.*]], <8 x i32> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; SLM-NEXT:    [[TMP2:%.*]] = sitofp <4 x i32> [[TMP1]] to <4 x float>
; SLM-NEXT:    [[TMP3:%.*]] = shufflevector <8 x i32> [[A]], <8 x i32> poison, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
; SLM-NEXT:    [[TMP4:%.*]] = uitofp <4 x i32> [[TMP3]] to <4 x float>
; SLM-NEXT:    [[TMP6:%.*]] = shufflevector <4 x float> [[TMP2]], <4 x float> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
; SLM-NEXT:    [[TMP5:%.*]] = call <8 x float> @llvm.vector.insert.v8f32.v4f32(<8 x float> [[TMP6]], <4 x float> [[TMP4]], i64 4)
; SLM-NEXT:    ret <8 x float> [[TMP5]]
;
; AVX-LABEL: @sitofp_uitofp(
; AVX-NEXT:    [[TMP1:%.*]] = sitofp <8 x i32> [[A:%.*]] to <8 x float>
; AVX-NEXT:    [[TMP2:%.*]] = uitofp <8 x i32> [[A]] to <8 x float>
; AVX-NEXT:    [[TMP3:%.*]] = shufflevector <8 x float> [[TMP1]], <8 x float> [[TMP2]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15>
; AVX-NEXT:    ret <8 x float> [[TMP3]]
;
; AVX2-LABEL: @sitofp_uitofp(
; AVX2-NEXT:    [[TMP1:%.*]] = sitofp <8 x i32> [[A:%.*]] to <8 x float>
; AVX2-NEXT:    [[TMP2:%.*]] = uitofp <8 x i32> [[A]] to <8 x float>
; AVX2-NEXT:    [[TMP3:%.*]] = shufflevector <8 x float> [[TMP1]], <8 x float> [[TMP2]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15>
; AVX2-NEXT:    ret <8 x float> [[TMP3]]
;
; AVX512-LABEL: @sitofp_uitofp(
; AVX512-NEXT:    [[TMP1:%.*]] = sitofp <8 x i32> [[A:%.*]] to <8 x float>
; AVX512-NEXT:    [[TMP2:%.*]] = uitofp <8 x i32> [[A]] to <8 x float>
; AVX512-NEXT:    [[TMP3:%.*]] = shufflevector <8 x float> [[TMP1]], <8 x float> [[TMP2]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15>
; AVX512-NEXT:    ret <8 x float> [[TMP3]]
;
  %a0 = extractelement <8 x i32> %a, i32 0
  %a1 = extractelement <8 x i32> %a, i32 1
  %a2 = extractelement <8 x i32> %a, i32 2
  %a3 = extractelement <8 x i32> %a, i32 3
  %a4 = extractelement <8 x i32> %a, i32 4
  %a5 = extractelement <8 x i32> %a, i32 5
  %a6 = extractelement <8 x i32> %a, i32 6
  %a7 = extractelement <8 x i32> %a, i32 7
  %ab0 = sitofp i32 %a0 to float
  %ab1 = sitofp i32 %a1 to float
  %ab2 = sitofp i32 %a2 to float
  %ab3 = sitofp i32 %a3 to float
  %ab4 = uitofp i32 %a4 to float
  %ab5 = uitofp i32 %a5 to float
  %ab6 = uitofp i32 %a6 to float
  %ab7 = uitofp i32 %a7 to float
  %r0 = insertelement <8 x float> undef, float %ab0, i32 0
  %r1 = insertelement <8 x float>   %r0, float %ab1, i32 1
  %r2 = insertelement <8 x float>   %r1, float %ab2, i32 2
  %r3 = insertelement <8 x float>   %r2, float %ab3, i32 3
  %r4 = insertelement <8 x float>   %r3, float %ab4, i32 4
  %r5 = insertelement <8 x float>   %r4, float %ab5, i32 5
  %r6 = insertelement <8 x float>   %r5, float %ab6, i32 6
  %r7 = insertelement <8 x float>   %r6, float %ab7, i32 7
  ret <8 x float> %r7
}

define <8 x i32> @fptosi_fptoui(<8 x float> %a) {
; SSE2-LABEL: @fptosi_fptoui(
; SSE2-NEXT:    [[TMP1:%.*]] = shufflevector <8 x float> [[A:%.*]], <8 x float> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; SSE2-NEXT:    [[TMP2:%.*]] = fptosi <4 x float> [[TMP1]] to <4 x i32>
; SSE2-NEXT:    [[TMP3:%.*]] = shufflevector <8 x float> [[A]], <8 x float> poison, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
; SSE2-NEXT:    [[TMP4:%.*]] = fptoui <4 x float> [[TMP3]] to <4 x i32>
; SSE2-NEXT:    [[TMP6:%.*]] = shufflevector <4 x i32> [[TMP2]], <4 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
; SSE2-NEXT:    [[TMP5:%.*]] = call <8 x i32> @llvm.vector.insert.v8i32.v4i32(<8 x i32> [[TMP6]], <4 x i32> [[TMP4]], i64 4)
; SSE2-NEXT:    ret <8 x i32> [[TMP5]]
;
; SLM-LABEL: @fptosi_fptoui(
; SLM-NEXT:    [[TMP1:%.*]] = shufflevector <8 x float> [[A:%.*]], <8 x float> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; SLM-NEXT:    [[TMP2:%.*]] = fptosi <4 x float> [[TMP1]] to <4 x i32>
; SLM-NEXT:    [[TMP3:%.*]] = shufflevector <8 x float> [[A]], <8 x float> poison, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
; SLM-NEXT:    [[TMP4:%.*]] = fptoui <4 x float> [[TMP3]] to <4 x i32>
; SLM-NEXT:    [[TMP6:%.*]] = shufflevector <4 x i32> [[TMP2]], <4 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
; SLM-NEXT:    [[TMP5:%.*]] = call <8 x i32> @llvm.vector.insert.v8i32.v4i32(<8 x i32> [[TMP6]], <4 x i32> [[TMP4]], i64 4)
; SLM-NEXT:    ret <8 x i32> [[TMP5]]
;
; AVX-LABEL: @fptosi_fptoui(
; AVX-NEXT:    [[TMP1:%.*]] = fptosi <8 x float> [[A:%.*]] to <8 x i32>
; AVX-NEXT:    [[TMP2:%.*]] = fptoui <8 x float> [[A]] to <8 x i32>
; AVX-NEXT:    [[TMP3:%.*]] = shufflevector <8 x i32> [[TMP1]], <8 x i32> [[TMP2]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15>
; AVX-NEXT:    ret <8 x i32> [[TMP3]]
;
; AVX2-LABEL: @fptosi_fptoui(
; AVX2-NEXT:    [[TMP1:%.*]] = fptosi <8 x float> [[A:%.*]] to <8 x i32>
; AVX2-NEXT:    [[TMP2:%.*]] = fptoui <8 x float> [[A]] to <8 x i32>
; AVX2-NEXT:    [[TMP3:%.*]] = shufflevector <8 x i32> [[TMP1]], <8 x i32> [[TMP2]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15>
; AVX2-NEXT:    ret <8 x i32> [[TMP3]]
;
; AVX512-LABEL: @fptosi_fptoui(
; AVX512-NEXT:    [[TMP1:%.*]] = fptosi <8 x float> [[A:%.*]] to <8 x i32>
; AVX512-NEXT:    [[TMP2:%.*]] = fptoui <8 x float> [[A]] to <8 x i32>
; AVX512-NEXT:    [[TMP3:%.*]] = shufflevector <8 x i32> [[TMP1]], <8 x i32> [[TMP2]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15>
; AVX512-NEXT:    ret <8 x i32> [[TMP3]]
;
  %a0 = extractelement <8 x float> %a, i32 0
  %a1 = extractelement <8 x float> %a, i32 1
  %a2 = extractelement <8 x float> %a, i32 2
  %a3 = extractelement <8 x float> %a, i32 3
  %a4 = extractelement <8 x float> %a, i32 4
  %a5 = extractelement <8 x float> %a, i32 5
  %a6 = extractelement <8 x float> %a, i32 6
  %a7 = extractelement <8 x float> %a, i32 7
  %ab0 = fptosi float %a0 to i32
  %ab1 = fptosi float %a1 to i32
  %ab2 = fptosi float %a2 to i32
  %ab3 = fptosi float %a3 to i32
  %ab4 = fptoui float %a4 to i32
  %ab5 = fptoui float %a5 to i32
  %ab6 = fptoui float %a6 to i32
  %ab7 = fptoui float %a7 to i32
  %r0 = insertelement <8 x i32> undef, i32 %ab0, i32 0
  %r1 = insertelement <8 x i32>   %r0, i32 %ab1, i32 1
  %r2 = insertelement <8 x i32>   %r1, i32 %ab2, i32 2
  %r3 = insertelement <8 x i32>   %r2, i32 %ab3, i32 3
  %r4 = insertelement <8 x i32>   %r3, i32 %ab4, i32 4
  %r5 = insertelement <8 x i32>   %r4, i32 %ab5, i32 5
  %r6 = insertelement <8 x i32>   %r5, i32 %ab6, i32 6
  %r7 = insertelement <8 x i32>   %r6, i32 %ab7, i32 7
  ret <8 x i32> %r7
}

define <8 x float> @fneg_fabs(<8 x float> %a) {
; SSE2-LABEL: @fneg_fabs(
; SSE2-NEXT:    [[TMP1:%.*]] = shufflevector <8 x float> [[A:%.*]], <8 x float> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; SSE2-NEXT:    [[TMP3:%.*]] = bitcast <4 x float> [[TMP1]] to <4 x i32>
; SSE2-NEXT:    [[TMP2:%.*]] = shufflevector <8 x float> [[A]], <8 x float> poison, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
; SSE2-NEXT:    [[TMP4:%.*]] = bitcast <4 x float> [[TMP2]] to <4 x i32>
; SSE2-NEXT:    [[TMP5:%.*]] = xor <4 x i32> [[TMP3]], splat (i32 -2147483648)
; SSE2-NEXT:    [[TMP6:%.*]] = and <4 x i32> [[TMP4]], splat (i32 2147483647)
; SSE2-NEXT:    [[TMP7:%.*]] = shufflevector <4 x i32> [[TMP5]], <4 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
; SSE2-NEXT:    [[TMP8:%.*]] = call <8 x i32> @llvm.vector.insert.v8i32.v4i32(<8 x i32> [[TMP7]], <4 x i32> [[TMP6]], i64 4)
; SSE2-NEXT:    [[DOTUNCASTED:%.*]] = bitcast <8 x i32> [[TMP8]] to <8 x float>
; SSE2-NEXT:    ret <8 x float> [[DOTUNCASTED]]
;
; SLM-LABEL: @fneg_fabs(
; SLM-NEXT:    [[TMP1:%.*]] = shufflevector <8 x float> [[A:%.*]], <8 x float> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; SLM-NEXT:    [[TMP3:%.*]] = bitcast <4 x float> [[TMP1]] to <4 x i32>
; SLM-NEXT:    [[TMP2:%.*]] = shufflevector <8 x float> [[A]], <8 x float> poison, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
; SLM-NEXT:    [[TMP4:%.*]] = bitcast <4 x float> [[TMP2]] to <4 x i32>
; SLM-NEXT:    [[TMP5:%.*]] = xor <4 x i32> [[TMP3]], splat (i32 -2147483648)
; SLM-NEXT:    [[TMP6:%.*]] = and <4 x i32> [[TMP4]], splat (i32 2147483647)
; SLM-NEXT:    [[TMP7:%.*]] = shufflevector <4 x i32> [[TMP5]], <4 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
; SLM-NEXT:    [[TMP8:%.*]] = call <8 x i32> @llvm.vector.insert.v8i32.v4i32(<8 x i32> [[TMP7]], <4 x i32> [[TMP6]], i64 4)
; SLM-NEXT:    [[DOTUNCASTED:%.*]] = bitcast <8 x i32> [[TMP8]] to <8 x float>
; SLM-NEXT:    ret <8 x float> [[DOTUNCASTED]]
;
; AVX-LABEL: @fneg_fabs(
; AVX-NEXT:    [[TMP1:%.*]] = bitcast <8 x float> [[A:%.*]] to <8 x i32>
; AVX-NEXT:    [[TMP2:%.*]] = xor <8 x i32> [[TMP1]], <i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647>
; AVX-NEXT:    [[TMP3:%.*]] = and <8 x i32> [[TMP1]], <i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647>
; AVX-NEXT:    [[TMP4:%.*]] = shufflevector <8 x i32> [[TMP2]], <8 x i32> [[TMP3]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15>
; AVX-NEXT:    [[DOTUNCASTED:%.*]] = bitcast <8 x i32> [[TMP4]] to <8 x float>
; AVX-NEXT:    ret <8 x float> [[DOTUNCASTED]]
;
; AVX2-LABEL: @fneg_fabs(
; AVX2-NEXT:    [[TMP1:%.*]] = bitcast <8 x float> [[A:%.*]] to <8 x i32>
; AVX2-NEXT:    [[TMP2:%.*]] = xor <8 x i32> [[TMP1]], <i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647>
; AVX2-NEXT:    [[TMP3:%.*]] = and <8 x i32> [[TMP1]], <i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647>
; AVX2-NEXT:    [[TMP4:%.*]] = shufflevector <8 x i32> [[TMP2]], <8 x i32> [[TMP3]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15>
; AVX2-NEXT:    [[DOTUNCASTED:%.*]] = bitcast <8 x i32> [[TMP4]] to <8 x float>
; AVX2-NEXT:    ret <8 x float> [[DOTUNCASTED]]
;
; AVX512-LABEL: @fneg_fabs(
; AVX512-NEXT:    [[TMP1:%.*]] = bitcast <8 x float> [[A:%.*]] to <8 x i32>
; AVX512-NEXT:    [[TMP2:%.*]] = xor <8 x i32> [[TMP1]], <i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647>
; AVX512-NEXT:    [[TMP3:%.*]] = and <8 x i32> [[TMP1]], <i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647>
; AVX512-NEXT:    [[TMP4:%.*]] = shufflevector <8 x i32> [[TMP2]], <8 x i32> [[TMP3]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15>
; AVX512-NEXT:    [[DOTUNCASTED:%.*]] = bitcast <8 x i32> [[TMP4]] to <8 x float>
; AVX512-NEXT:    ret <8 x float> [[DOTUNCASTED]]
;
  %a0 = extractelement <8 x float> %a, i32 0
  %a1 = extractelement <8 x float> %a, i32 1
  %a2 = extractelement <8 x float> %a, i32 2
  %a3 = extractelement <8 x float> %a, i32 3
  %a4 = extractelement <8 x float> %a, i32 4
  %a5 = extractelement <8 x float> %a, i32 5
  %a6 = extractelement <8 x float> %a, i32 6
  %a7 = extractelement <8 x float> %a, i32 7
  %aa0 = bitcast float %a0 to i32
  %aa1 = bitcast float %a1 to i32
  %aa2 = bitcast float %a2 to i32
  %aa3 = bitcast float %a3 to i32
  %aa4 = bitcast float %a4 to i32
  %aa5 = bitcast float %a5 to i32
  %aa6 = bitcast float %a6 to i32
  %aa7 = bitcast float %a7 to i32
  %ab0 = xor i32 %aa0, -2147483648
  %ab1 = xor i32 %aa1, -2147483648
  %ab2 = xor i32 %aa2, -2147483648
  %ab3 = xor i32 %aa3, -2147483648
  %ab4 = and i32 %aa4, 2147483647
  %ab5 = and i32 %aa5, 2147483647
  %ab6 = and i32 %aa6, 2147483647
  %ab7 = and i32 %aa7, 2147483647
  %ac0 = bitcast i32 %ab0 to float
  %ac1 = bitcast i32 %ab1 to float
  %ac2 = bitcast i32 %ab2 to float
  %ac3 = bitcast i32 %ab3 to float
  %ac4 = bitcast i32 %ab4 to float
  %ac5 = bitcast i32 %ab5 to float
  %ac6 = bitcast i32 %ab6 to float
  %ac7 = bitcast i32 %ab7 to float
  %r0 = insertelement <8 x float> undef, float %ac0, i32 0
  %r1 = insertelement <8 x float>   %r0, float %ac1, i32 1
  %r2 = insertelement <8 x float>   %r1, float %ac2, i32 2
  %r3 = insertelement <8 x float>   %r2, float %ac3, i32 3
  %r4 = insertelement <8 x float>   %r3, float %ac4, i32 4
  %r5 = insertelement <8 x float>   %r4, float %ac5, i32 5
  %r6 = insertelement <8 x float>   %r5, float %ac6, i32 6
  %r7 = insertelement <8 x float>   %r6, float %ac7, i32 7
  ret <8 x float> %r7
}

define <8 x i32> @sext_zext(<8 x i16> %a) {
; SSE2-LABEL: @sext_zext(
; SSE2-NEXT:    [[TMP1:%.*]] = shufflevector <8 x i16> [[A:%.*]], <8 x i16> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; SSE2-NEXT:    [[TMP2:%.*]] = sext <4 x i16> [[TMP1]] to <4 x i32>
; SSE2-NEXT:    [[TMP3:%.*]] = shufflevector <8 x i16> [[A]], <8 x i16> poison, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
; SSE2-NEXT:    [[TMP4:%.*]] = zext <4 x i16> [[TMP3]] to <4 x i32>
; SSE2-NEXT:    [[TMP6:%.*]] = shufflevector <4 x i32> [[TMP2]], <4 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
; SSE2-NEXT:    [[TMP5:%.*]] = call <8 x i32> @llvm.vector.insert.v8i32.v4i32(<8 x i32> [[TMP6]], <4 x i32> [[TMP4]], i64 4)
; SSE2-NEXT:    ret <8 x i32> [[TMP5]]
;
; SLM-LABEL: @sext_zext(
; SLM-NEXT:    [[TMP1:%.*]] = shufflevector <8 x i16> [[A:%.*]], <8 x i16> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; SLM-NEXT:    [[TMP2:%.*]] = sext <4 x i16> [[TMP1]] to <4 x i32>
; SLM-NEXT:    [[TMP3:%.*]] = shufflevector <8 x i16> [[A]], <8 x i16> poison, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
; SLM-NEXT:    [[TMP4:%.*]] = zext <4 x i16> [[TMP3]] to <4 x i32>
; SLM-NEXT:    [[TMP6:%.*]] = shufflevector <4 x i32> [[TMP2]], <4 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
; SLM-NEXT:    [[TMP5:%.*]] = call <8 x i32> @llvm.vector.insert.v8i32.v4i32(<8 x i32> [[TMP6]], <4 x i32> [[TMP4]], i64 4)
; SLM-NEXT:    ret <8 x i32> [[TMP5]]
;
; AVX-LABEL: @sext_zext(
; AVX-NEXT:    [[TMP1:%.*]] = sext <8 x i16> [[A:%.*]] to <8 x i32>
; AVX-NEXT:    [[TMP2:%.*]] = zext <8 x i16> [[A]] to <8 x i32>
; AVX-NEXT:    [[TMP3:%.*]] = shufflevector <8 x i32> [[TMP1]], <8 x i32> [[TMP2]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15>
; AVX-NEXT:    ret <8 x i32> [[TMP3]]
;
; AVX2-LABEL: @sext_zext(
; AVX2-NEXT:    [[TMP1:%.*]] = sext <8 x i16> [[A:%.*]] to <8 x i32>
; AVX2-NEXT:    [[TMP2:%.*]] = zext <8 x i16> [[A]] to <8 x i32>
; AVX2-NEXT:    [[TMP3:%.*]] = shufflevector <8 x i32> [[TMP1]], <8 x i32> [[TMP2]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15>
; AVX2-NEXT:    ret <8 x i32> [[TMP3]]
;
; AVX512-LABEL: @sext_zext(
; AVX512-NEXT:    [[TMP1:%.*]] = sext <8 x i16> [[A:%.*]] to <8 x i32>
; AVX512-NEXT:    [[TMP2:%.*]] = zext <8 x i16> [[A]] to <8 x i32>
; AVX512-NEXT:    [[TMP3:%.*]] = shufflevector <8 x i32> [[TMP1]], <8 x i32> [[TMP2]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15>
; AVX512-NEXT:    ret <8 x i32> [[TMP3]]
;
  %a0 = extractelement <8 x i16> %a, i32 0
  %a1 = extractelement <8 x i16> %a, i32 1
  %a2 = extractelement <8 x i16> %a, i32 2
  %a3 = extractelement <8 x i16> %a, i32 3
  %a4 = extractelement <8 x i16> %a, i32 4
  %a5 = extractelement <8 x i16> %a, i32 5
  %a6 = extractelement <8 x i16> %a, i32 6
  %a7 = extractelement <8 x i16> %a, i32 7
  %ab0 = sext i16 %a0 to i32
  %ab1 = sext i16 %a1 to i32
  %ab2 = sext i16 %a2 to i32
  %ab3 = sext i16 %a3 to i32
  %ab4 = zext i16 %a4 to i32
  %ab5 = zext i16 %a5 to i32
  %ab6 = zext i16 %a6 to i32
  %ab7 = zext i16 %a7 to i32
  %r0 = insertelement <8 x i32> undef, i32 %ab0, i32 0
  %r1 = insertelement <8 x i32>   %r0, i32 %ab1, i32 1
  %r2 = insertelement <8 x i32>   %r1, i32 %ab2, i32 2
  %r3 = insertelement <8 x i32>   %r2, i32 %ab3, i32 3
  %r4 = insertelement <8 x i32>   %r3, i32 %ab4, i32 4
  %r5 = insertelement <8 x i32>   %r4, i32 %ab5, i32 5
  %r6 = insertelement <8 x i32>   %r5, i32 %ab6, i32 6
  %r7 = insertelement <8 x i32>   %r6, i32 %ab7, i32 7
  ret <8 x i32> %r7
}

define <8 x float> @sitofp_4i32_8i16(<4 x i32> %a, <8 x i16> %b) {
; CHECK-LABEL: @sitofp_4i32_8i16(
; CHECK-NEXT:    [[TMP1:%.*]] = sitofp <4 x i32> [[A:%.*]] to <4 x float>
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <8 x i16> [[B:%.*]], <8 x i16> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[TMP3:%.*]] = sitofp <4 x i16> [[TMP2]] to <4 x float>
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <4 x float> [[TMP1]], <4 x float> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP5:%.*]] = shufflevector <4 x float> [[TMP3]], <4 x float> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[R71:%.*]] = shufflevector <8 x float> [[TMP4]], <8 x float> [[TMP5]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11>
; CHECK-NEXT:    ret <8 x float> [[R71]]
;
  %a0 = extractelement <4 x i32> %a, i32 0
  %a1 = extractelement <4 x i32> %a, i32 1
  %a2 = extractelement <4 x i32> %a, i32 2
  %a3 = extractelement <4 x i32> %a, i32 3
  %b0 = extractelement <8 x i16> %b, i32 0
  %b1 = extractelement <8 x i16> %b, i32 1
  %b2 = extractelement <8 x i16> %b, i32 2
  %b3 = extractelement <8 x i16> %b, i32 3
  %ab0 = sitofp i32 %a0 to float
  %ab1 = sitofp i32 %a1 to float
  %ab2 = sitofp i32 %a2 to float
  %ab3 = sitofp i32 %a3 to float
  %ab4 = sitofp i16 %b0 to float
  %ab5 = sitofp i16 %b1 to float
  %ab6 = sitofp i16 %b2 to float
  %ab7 = sitofp i16 %b3 to float
  %r0 = insertelement <8 x float> undef, float %ab0, i32 0
  %r1 = insertelement <8 x float>   %r0, float %ab1, i32 1
  %r2 = insertelement <8 x float>   %r1, float %ab2, i32 2
  %r3 = insertelement <8 x float>   %r2, float %ab3, i32 3
  %r4 = insertelement <8 x float>   %r3, float %ab4, i32 4
  %r5 = insertelement <8 x float>   %r4, float %ab5, i32 5
  %r6 = insertelement <8 x float>   %r5, float %ab6, i32 6
  %r7 = insertelement <8 x float>   %r6, float %ab7, i32 7
  ret <8 x float> %r7
}

; Inspired by PR38154
define <8 x float> @sitofp_uitofp_4i32_8i16_16i8(<4 x i32> %a, <8 x i16> %b, <16 x i8> %c) {
; CHECK-LABEL: @sitofp_uitofp_4i32_8i16_16i8(
; CHECK-NEXT:    [[TMP1:%.*]] = sitofp <4 x i32> [[A:%.*]] to <4 x float>
; CHECK-NEXT:    [[TMP2:%.*]] = uitofp <4 x i32> [[A]] to <4 x float>
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <4 x float> [[TMP1]], <4 x float> [[TMP2]], <4 x i32> <i32 0, i32 1, i32 6, i32 7>
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <8 x i16> [[B:%.*]], <8 x i16> poison, <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    [[TMP5:%.*]] = sitofp <2 x i16> [[TMP4]] to <2 x float>
; CHECK-NEXT:    [[TMP6:%.*]] = uitofp <2 x i16> [[TMP4]] to <2 x float>
; CHECK-NEXT:    [[TMP7:%.*]] = shufflevector <2 x float> [[TMP5]], <2 x float> [[TMP6]], <2 x i32> <i32 0, i32 3>
; CHECK-NEXT:    [[TMP8:%.*]] = shufflevector <16 x i8> [[C:%.*]], <16 x i8> poison, <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    [[TMP9:%.*]] = sitofp <2 x i8> [[TMP8]] to <2 x float>
; CHECK-NEXT:    [[TMP10:%.*]] = uitofp <2 x i8> [[TMP8]] to <2 x float>
; CHECK-NEXT:    [[TMP11:%.*]] = shufflevector <2 x float> [[TMP9]], <2 x float> [[TMP10]], <2 x i32> <i32 0, i32 3>
; CHECK-NEXT:    [[TMP12:%.*]] = shufflevector <4 x float> [[TMP3]], <4 x float> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP13:%.*]] = shufflevector <2 x float> [[TMP7]], <2 x float> poison, <8 x i32> <i32 0, i32 1, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[R52:%.*]] = shufflevector <8 x float> [[TMP12]], <8 x float> [[TMP13]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 6, i32 7>
; CHECK-NEXT:    [[TMP14:%.*]] = shufflevector <2 x float> [[TMP11]], <2 x float> poison, <8 x i32> <i32 0, i32 1, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[R71:%.*]] = shufflevector <8 x float> [[R52]], <8 x float> [[TMP14]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 8, i32 9>
; CHECK-NEXT:    ret <8 x float> [[R71]]
;
  %a0 = extractelement <4 x i32> %a, i32 0
  %a1 = extractelement <4 x i32> %a, i32 1
  %a2 = extractelement <4 x i32> %a, i32 2
  %a3 = extractelement <4 x i32> %a, i32 3
  %b0 = extractelement <8 x i16> %b, i32 0
  %b1 = extractelement <8 x i16> %b, i32 1
  %c0 = extractelement <16 x i8> %c, i32 0
  %c1 = extractelement <16 x i8> %c, i32 1
  %ab0 = sitofp i32 %a0 to float
  %ab1 = sitofp i32 %a1 to float
  %ab2 = uitofp i32 %a2 to float
  %ab3 = uitofp i32 %a3 to float
  %ab4 = sitofp i16 %b0 to float
  %ab5 = uitofp i16 %b1 to float
  %ab6 = sitofp  i8 %c0 to float
  %ab7 = uitofp  i8 %c1 to float
  %r0 = insertelement <8 x float> undef, float %ab0, i32 0
  %r1 = insertelement <8 x float>   %r0, float %ab1, i32 1
  %r2 = insertelement <8 x float>   %r1, float %ab2, i32 2
  %r3 = insertelement <8 x float>   %r2, float %ab3, i32 3
  %r4 = insertelement <8 x float>   %r3, float %ab4, i32 4
  %r5 = insertelement <8 x float>   %r4, float %ab5, i32 5
  %r6 = insertelement <8 x float>   %r5, float %ab6, i32 6
  %r7 = insertelement <8 x float>   %r6, float %ab7, i32 7
  ret <8 x float> %r7
}

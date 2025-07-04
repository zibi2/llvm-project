! RUN: %python %S/test_errors.py %s %flang_fc1 -pedantic
! Test BLOCK DATA subprogram (14.3)
block data foo
  !ERROR: IMPORT is not allowed in a BLOCK DATA subprogram
  import
  real :: pi = asin(-1.0) ! ok
  !ERROR: An initialized variable in BLOCK DATA must be in a COMMON block
  integer :: notInCommon = 1
  integer :: uninitialized ! ok
  !PORTABILITY: Procedure pointer 'q' should not have an ELEMENTAL intrinsic as its interface [-Wportability]
  !ERROR: 'q' may not appear in a BLOCK DATA subprogram
  procedure(sin), pointer :: q => cos
  !ERROR: 'p' may not be a procedure as it is in a COMMON block
  procedure(sin), pointer :: p => cos
  common /block/ p, pi
  !ERROR: An initialized variable in BLOCK DATA must be in a COMMON block
  integer :: inDataButNotCommon
  data inDataButNotCommon /1/
  integer :: inCommonA, inCommonB
  !ERROR: 'incommona' in COMMON block /a/ must not be storage associated with 'incommonb' in COMMON block /b/ by EQUIVALENCE
  common /a/ inCommonA, /b/ inCommonB
  equivalence(inCommonA, inCommonB)
  integer :: inCommonD, initialized ! ok
  common /d/ inCommonD
  equivalence(inCommonD, initialized)
  data initialized /2/
  integer :: inCommonE, jarr(2)
  equivalence(inCommonE, jarr(2))
  !ERROR: 'incommone' cannot backward-extend COMMON block /e/ via EQUIVALENCE with 'jarr'
  common /e/ inCommonE
  equivalence(inCommonF1, inCommonF2)
  integer :: inCommonF1, inCommonF2
  !ERROR: 'incommonf1' is storage associated with 'incommonf2' by EQUIVALENCE elsewhere in COMMON block /f/
  common /f/ inCommonF1, inCommonF2
  !Regression test for llvm-project/issues/65922 - no error expected
  common /g/ inCommonG1, inCommonG2
  real inCommonG1(-9:10), inCommonG2(10), otherG(11)
  equivalence (inCommonG1(1), otherG), (otherG(11), inCommonG2)
end block data

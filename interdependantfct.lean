
/// the original code before being modified
/- [tutorial::is_even]:
   Source: 'src/lib.rs', lines 74:0-80:1 -/
mutual divergent def is_even (n : I32) : Result Bool :=
  if n = 0#i32
  then Result.ok true
  else do
       let i ← n - 1#i32
       is_odd i

/- [tutorial::is_odd]:
   Source: 'src/lib.rs', lines 82:0-88:1 -/
divergent def is_odd (n : I32) : Result Bool :=
  if n = 0#i32
  then Result.ok false
  else do
       let i ← n - 1#i32
       is_even i

end

/// The code after modification

import Std

open Std

mutual
  /-- Check if a number is even -/
  partial def isEven (n : Int) : Except String Bool :=
    if n < 0 then
      Except.error "Negative numbers are not supported."
    else if n == 0 then
      Except.ok true
    else
      isOdd (n - 1)

  /-- Check if a number is odd -/
  partial def isOdd (n : Int) : Except String Bool :=
    if n < 0 then
      Except.error "Negative numbers are not supported."
    else if n == 0 then
      Except.ok false
    else
      isEven (n - 1)
end
#eval isEven 9
def main : IO Unit :=
  do
    let num := 10
    match isEven num with
    | Except.ok res => IO.println s!"Is {num} even? {res}"
    | Except.error err => IO.println s!"Error: {err}"
    
    match isOdd num with
    | Except.ok res => IO.println s!"Is {num} odd? {res}"
    | Except.error err => IO.println s!"Error: {err}"
#eval main 



//// attempt to prove the code
mutual
  /-- Proves that isEven n returns true if and only if n = 2k for some k -/
  theorem isEven_correct (n : Int) (h : n ≥ 0) :
    isEven n = Except.ok true ↔ ∃ k, n = 2 * k := by
    cases n
    case ofNat n =>
      induction n with
      | zero =>
        apply Iff.intro
        · intro _
          exists 0
        · intro ⟨k, hk⟩
          rfl
      | succ n ih =>
        simp [isEven]
        rw [isOdd]
        apply isOdd_correct
        exact Nat.le_of_succ_le h
    case negSucc n =>
      simp [isEven, h]

  /-- Proves that isOdd n returns true if and only if n = 2k + 1 for some k -/
  theorem isOdd_correct (n : Int) (h : n ≥ 0) :
    isOdd n = Except.ok true ↔ ∃ k, n = 2 * k + 1 := by
    cases n
    case ofNat n =>
      induction n with
      | zero =>
        simp [isOdd]
        constructor
        · intro h
          contradiction
        · intro ⟨k, hk⟩
          rw [hk]
          simp [isOdd]
      | succ n ih =>
        simp [isOdd]
        rw [isEven]
        apply isEven_correct
        exact Nat.le_of_succ_le h
    case negSucc n =>
      simp [isOdd, h]
end

/-- Proves that isEven returns error for negative numbers -/
theorem isEven_neg {n : Int} (h : n < 0) :
  isEven n = Except.error "Negative numbers are not supported." := by
  simp [isEven, h]

/-- Proves that isOdd returns error for negative numbers -/
theorem isOdd_neg {n : Int} (h : n < 0) :
  isOdd n = Except.error "Negative numbers are not supported." := by
  simp [isOdd, h]

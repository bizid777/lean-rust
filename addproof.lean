--Rust code
/-pub fn sumupton (n:u32)-> u32{
    if n == 0{
        0
    }else{
        n + sumupton(n-1)
    }
}-/

--Converted code to lean

import Aeneas
open Aeneas.Std


/- [aeneas_test::sumupton]:
  Source: 'src/main.rs', lines 19:0-25:1 -/
divergent def sumupton (n : U32) : Result U32 :=
  if n = 0#u32
  then Result.ok 0#u32
  else do
       let i ← n - 1#u32
       let i1 ← sumupton i
       n + i1


--[test cases]

#eval sumupton 10#u32
#check sumupton 10#u32
#check 3#u32 + 2#u32
#eval 3#u32 + 2#u32
#check 2#u32.toNat
#check sumupton 10#u32
#check sumupton 100#u32 + sumupton 10#u32

-- Proof of the lean code:
def sumupton_proof : ∀ (n : U32), sumupton n = Result.ok (n * (n + 1) / 2) :=
  fun n =>
    match n with
    | 0 =>
      show sumupton 0 = Result.ok 0 from rfl
    | n + 1 =>
      have ih : sumupton n = Result.ok (n * (n + 1) / 2) := sumupton_proof n
      show sumupton (n + 1) = Result.ok ((n + 1) * (n + 2) / 2) from
        match sumupton n with
        | Result.ok sum_n =>
          calc
            sumupton (n + 1)
                = Result.ok (n + 1 + sum_n) : by simp [ih]
            ... = Result.ok ((n + 1) * (n + 2) / 2) : by ring
        | Result.error e =>
          -- Assuming no error occurs in the recursive call, handle logically
          Result.error e

instance : HAdd (Result U32) (Result U32) (Result U32) where
  hAdd := fun a b =>
    match a, b with
    | Result.ok x, Result.ok y => Result.ok (x + y)
    | Result.error e, _ => Result.error e
    | _, Result.error e => Result.error e

def addU32Results (a : Result U32) (b : Result U32) : U32 :=
  match a, b with
  | Result.ok x, Result.ok y => x + y
  | Result.error _, _ => 0  -- Handle error case with default value
  | _, Result.error _ => 0  -- Handle error case with default value

-- Use the wrapper function to perform addition
-- Example usage:
-- let result : U32 := addU32Results (Result.ok 10) (Result.ok 20)
def sumuptonWrapper (n : U32) : U32 :=
  addU32Results (sumupton n) (Result.ok 0)

#eval sumuptonWrapper 10

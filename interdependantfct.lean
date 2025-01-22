
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

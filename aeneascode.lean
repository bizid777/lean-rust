

--   /- [tutorial::fib]:
--    Source: 'src/lib.rs', lines 18:0-24:1 -/
divergent def fib (n : U32) : Result U32 :=
  match n with
  | 0#u32 => Result.ok 1#u32
  | 1#u32 => Result.ok 1#u32
  | _ =>
    do
    let i ← n - 1#u32
    let i1 ← fib i
    let i2 ← n - 2#u32
    let i3 ← fib i2
    Result.ok (i1 + i3)
-- for the fibonacci fct the AI gave literally the same code
def mul2_add1 (x : U32) : Result U32 :=
  do
  let i ← x + x
  i + 1#u32

/- [tutorial::sequence]: loop 0:
   Source: 'src/lib.rs', lines 11:4-14:5 -/
divergent def sequence_loop (n : U32) (m : U32) : Result U32 :=
  if n > 0#u32
  then
    do
    let i ← 2#u32 * m
    let m1 ← i + 1#u32
    let n1 ← n - 1#u32
    sequence_loop n1 m1
  else Result.ok m

/- [tutorial::forfct]: loop 0:
   Source: 'src/lib.rs', lines 20:4-26:5 -/
divergent def forfct_loop (n : U32) (m : U32) : Result U32 :=
  do
  let i ← 2#u32 * m
  let m1 ← i + 1#u32
  let n1 ← n - 1#u32
  if n1 = 0#u32
  then Result.ok m1
  else forfct_loop n1 m1

--   /- [tutorial::fib]:
--    Source: 'src/lib.rs', lines 18:0-24:1 -/
divergent def fib (n : U32) : Result U32 :=
  match n with
  | 0#scalar => Result.ok 1#u32
  | 1#scalar => Result.ok 1#u32
  | _ =>
    do
    let i ← n - 1#u32
    let i1 ← fib i
    let i2 ← n - 2#u32
    let i3 ← fib i2
    i1 + i3

# Aeneas and Lean 4

## Checklist (for Mac)

All command paths are relative to the root of your repo.

- [ ] `brew install gmake`
- [ ] `git clone https://github.com/AeneasVerif/aeneas` (from the root of your repo)
- [ ] `cd aeneas`
- [ ] `gmake setup-charon`
- [ ] `cd ..`
- [ ] `gmake`
  - [ ] `aeneas` should be at `aeneas/bin/aeneas`. You can use it to generate `.llbc` files that can be 
- [ ] `aeneas/charon/bin/charon --hide-marker-traits`. It will generate a `.llbc` file in the root of your repo, probably named `aeneas_test.llbc`.
- [ ] `aeneas/bin/aeneas -backend lean aeneas_test.llbc`

Put the rust code you want to verify in `src/main.rs`. If you feel like you understand the Rust module system, you can put it in other files and import them into `src/main.rs`.

It should put the generated Lean code in `AeneasTest.lean`. Now you can add proofs to that file.

- [ ] `lake update && lake build`
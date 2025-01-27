# Aeneas and Lean 4

## Checklist (for Mac)

All command paths are relative to the root of your repo.

- [ ] `brew install gmake`
- [ ] `git clone https://github.com/AeneasVerif/aeneas` (from the root of your repo)
- [ ] `cd aeneas`
- [ ] `gmake setup-charon`. `gmake build-dev` if you get some error about `cargo fmt`. The error is because our version of Rust(2024 edition) is newer than the version of Rust that Aeneas is compatible with (2021 edition).
- [ ] `cd charon`
- [ ] `gmake`
  - [ ] `aeneas` should be at `aeneas/bin/aeneas`. You can use it to generate `.llbc` files.
- [ ] `cd` to the root of the repo (`lean-rust`)
- [ ] Run `aeneas/charon/bin/charon --hide-marker-traits`. It takes no file arguments because it runs on the whole Rust project (everything in `src/`). It will generate a `.llbc` file in the root of your repo, probably named `aeneas_test.llbc`.
- [ ] `aeneas/bin/aeneas -backend lean aeneas_test.llbc`

Put the rust code you want to verify in `src/main.rs`. If you feel like you understand the Rust module system, you can put it in other files and import them into `src/main.rs`.

It should put the generated Lean code in `AeneasTest.lean`. Now you can add proofs to that file.

- [ ] `lake update && lake build`

## Updated Checklist (with Makefile)

- [ ] `make verify` - Runs full verification pipeline (Charon → Aeneas → Lean)
- [ ] `make clean` - Removes generated files
- [ ] `make lake` - Updates and rebuilds Lean project

The Makefile handles:
1. Generating LLBC intermediate representation from Rust code
2. Producing Lean verification code from LLBC
3. Cleaning generated artifacts
4. Lean project maintenance

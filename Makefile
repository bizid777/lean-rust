# Paths to verification tools
CHARON := aeneas/charon/bin/charon
AENEAS := aeneas/bin/aeneas

# Source files
RUST_SRC := $(wildcard src/*.rs)
LLBC_FILES := $(wildcard *.llbc src/*.llbc AeneasTest/*.llbc)

.PHONY: all clean verify

all: verify

# Generate LLBC intermediate representation
%.llbc: $(RUST_SRC)
	$(CHARON) --hide-marker-traits

# Generate Lean verification code from LLBC
Aeneas%.lean: %.llbc
	$(AENEAS) -backend lean $<

clean:
	rm $(LLBC_FILES) 

# Helper for Lean development
lake:
	lake update && lake build
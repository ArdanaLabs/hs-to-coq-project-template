##
# hs-to-coq workflow template
#
# @file
# @version 0.1

find-module = $(shell nix-shell --run "ghc-pkg find-module $(1) | grep ghc")
module-path = $(shell nix-shell --run "echo $(call find-module,$(1))/$(ls $(call find-module,$(1)))")

call-hs-to-coq = ./result/bin/hs-to-coq \
					-e result/hs-to-coq/base/edits \
					--iface-dir result/hs-to-coq/base \
					--iface-dir src-coq \
					--import-dir src-haskell/src \
					--import-dir $(call module-path,bytestring) \
					-Ibytestring/include \
					-e src-haskell/edits \
					src-haskell/src/$(1).hs \
					-o src-coq

call-coqc = coqc -R result/hs-to-coq/base \"\" -Q src-coq Src src-coq/$(1).v

install: ./result/bin/hs-to-coq
	nix-build
	echo "hs-to-coq executable ./result/bin/hs-to-coq"
	echo "hs-to-coq codebase compiled at result/hs-to-coq/"

codegen:
	nix-shell --run "$(call call-hs-to-coq,Types)"
	nix-shell --run "$(call call-hs-to-coq,Communication)"
	nix-shell --run "$(call call-hs-to-coq,Main)"

coqc-the-output: codegen
	nix-shell --run "$(call call-coqc,Types)"
	nix-shell --run "$(call call-coqc,Communication)"
	nix-shell --run "$(call call-coqc,Main)"

all: coqc-the-output

clean:
	rm -f src-coq/*.v*
	rm -f src-coq/*.glob
	rm -f src-coq/*.h2ci

# end

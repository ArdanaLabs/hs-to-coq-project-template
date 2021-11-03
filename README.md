# `hs-to-coq` project template (WIP)

[`hs-to-coq` is a tool](https://github.com/plclub/hs-to-coq/) that generates coq from haskell source. 

After you're done with [the Queue tutorial](https://www.cis.upenn.edu/~plclub/blog/2020-10-09-hs-to-coq/) come back here and learn how to do a project! 

## Explore the repo!

This is currently a toy project called `SecureChannel`. It's a proof of concept to build up my familiarity with the tool so I can tackle `plutus` and `Danaswap`. Yes, it's based on an exercise from a cryptography textbook **but it should not be taken seriously as cryptographic code**.

I approached this based on [`nix`](https://nixos.org/download.html). `hs-to-coq` doesn't officially support `nix` yet (in their CI, etc), they recommend using `stack`. `

- Read `Makefile`. 
- Read `src-haskell/edits`
- `theories/` is where your specs, models, and proofs go after you codegen to coq. 
- `src-haskell/` is where your haskell source goes.
- `src-coq/` is the output dir.
- Read `_CoqProject`
- Read `hs-to-coq.nix`, `default.nix`, and `shell.nix`

## Usage

1. Build/install the executable, compile the `.v` files in `hs-to-coq`, call `hs-to-coq` on each of your haskell files, call `coqc` on the generated `.v` files: 
``` bash
make all
```
2. Write your spec and model the behavior you want in coq files in `theories/` and import the codegen'd coq files from `src-coq/`.

### For your own projects
1. Fork this repo
2. `rm -r src-haskell` 
3. Either roll a new `mkdir src-haskell && cd src-haskell && cabal init` or `git clone <yourproject>` 
4. Enumerate your files in the `Makefile` from the root of the import tree on down (if you mess this up the error messages are well written). 

## This writing (10-23):

`coqc` is unable to locate library `Data.ByteString`, which makes sense. 

### TODO: 

Figure out what's going on with dependencies!

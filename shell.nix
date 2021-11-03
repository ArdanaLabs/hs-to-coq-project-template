{ chan ? import ./chan.nix
, pkgs ? import ./pkgs.nix { inherit chan; }
}:
let
  hs-to-coq = import ./hs-to-coq.nix { inherit chan pkgs; };
  srcHaskell = import ./src-haskell/default.nix { inherit chan pkgs; };
in
pkgs.mkShell {
  nativeBuildInputs = hs-to-coq.coqenvironment.nativeBuildInputs;
  inputsFor = [ srcHaskell ];
}

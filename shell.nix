{ chan ? import ./chan.nix
, pkgs ? import ./pkgs.nix { inherit chan; }
}:
let
  fetchgit = import ./fetchgit.nix { inherit chan pkgs; };
  srcHaskell = import ./src-haskell/default.nix { inherit chan pkgs; };
in
pkgs.mkShell {
  nativeBuildInputs = fetchgit.hsToCoq_coqenvironment.nativeBuildInputs;
}

{ chan ? import ../chan.nix
, pkgs ? import ../pkgs.nix { inherit chan; }
, ghcVersion ? "ghc884"  # ideally is the same as one specified in result/hs-to-coq/default.nix
, asShell ? false
, system ? builtins.currentSystem
}:
# partially adapted from https://gitlab.com/platonic/snowball/-/blob/master/default.nix
let
  ghcTools = with pkgs.haskell.packages.${ghcVersion}; [ cabal-install ghcid ];
  SecureChannel = pkgs.haskell.packages.${ghcVersion}.callCabal2nix "SecureChannel" ./. {};
in with pkgs; with lib;
  pkgs.haskell.packages.${ghcVersion}.shellFor {
    packages = _: [ SecureChannel ];
    COMPILER = ghcVersion;
    buildInputs = ghcTools;
    shellHook = ''
      cat ${./intro}
    '';
  }

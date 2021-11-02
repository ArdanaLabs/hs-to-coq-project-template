{ chan ? import ./chan.nix
, pkgs ? import ./pkgs.nix { inherit chan; }
}:
let
  hsToCoq_git = builtins.fetchGit {
    url = "https://github.com/plclub/hs-to-coq.git";
    rev = "a67f4d1ef434a771a2e35786729e1e34a2a8175b";
  };
  hsToCoq_defaultnix = import (hsToCoq_git + /default.nix) {};
  coqenvironment = pkgs.stdenv.mkDerivation {
    src = hsToCoq_git;
    name = "hs-to-coq.git";
    phases = [ "unpackPhase" "buildPhase" "installPhase" ];
    nativeBuildInputs = hsToCoq_defaultnix.coqPackages.hs-to-coq.buildInputs;
    buildPhase = ''
               make all
    '';
    installPhase = ''
                 mkdir -p $out
                 cp -r ./. $out
    '';
  };
in
{
  hsToCoq_defaultnix = hsToCoq_defaultnix;
  hsToCoq_coqenvironment = coqenvironment;
}

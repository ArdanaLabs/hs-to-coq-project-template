{ chan ? import ./chan.nix
, pkgs ? import ./pkgs.nix { inherit chan; }
}:
let
  hs-to-coq = import ./hs-to-coq.nix { inherit chan pkgs; };
in pkgs.runCommand "hs-to-coq-result" {}
    ''
      mkdir -p $out
      cd $out
      cp -r ${hs-to-coq.coqenvironment}/. hs-to-coq
      cp -r ${hs-to-coq.defaultnix.haskellPackages.hs-to-coq}/. .
    ''

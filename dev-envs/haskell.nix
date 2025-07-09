{ pkgs }:

let
  haskellPkgs = pkgs.haskellPackages;
in
pkgs.mkShell {
  name = "haskell";
  packages = with haskellPackages; [
    ghc
    haskell-language-server
    cabal-install
    stack
  ];

  shellHook = ''
    export NIX_DEV_SHELL_NAME=haskell
    export SHELL=${pkgs.zsh}/bin/zsh
    exec ${pkgs.zsh}/bin/zsh --login
  '';
}

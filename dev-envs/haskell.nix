{ pkgs }:

let
  hsPkgs = pkgs.haskellPackages;
in
pkgs.mkShell {
  name = "haskell-dev";

  buildInputs = with hsPkgs; [
    ghc
    cabal-install
    aeson
    websockets
    http-client
    text
    bytestring
  ];

  shellHook = ''
    export NIX_DEV_SHELL_NAME=haskell-dev
    export SHELL=${pkgs.zsh}/bin/zsh
    exec ${pkgs.zsh}/bin/zsh --login
  '';
}
